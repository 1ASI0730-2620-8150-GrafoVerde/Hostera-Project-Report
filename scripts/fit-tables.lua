-- Fits Markdown tables inside the PDF page width.
--
-- 1. Adds invisible line-break opportunities inside long tokens of table
--    cells, such as API paths, branch names, camelCase identifiers and URLs.
-- 2. Gives each column a width proportional to its content, never narrower
--    than its longest unbreakable word, and marks the table as "fitted" so
--    the stylesheet applies a fixed layout. Tables with five or more columns
--    are also marked as "dense" to use a smaller font.

local ZWSP = "\u{200B}"
local MIN_TOKEN_LENGTH = 12

-- Approximate layout constants for A4 with 2 cm margins.
local CONTENT_WIDTH = 482 -- points
local CELL_PADDING = 10   -- points per cell (left and right padding)
local CHAR_WIDTH = { normal = 6.2, dense = 5.6 } -- points per character

local function add_breaks(text)
  local length = utf8.len(text)
  if length == nil or length < MIN_TOKEN_LENGTH then
    return text
  end
  text = text:gsub("([/%-_%.%?&=])(%S)", "%1" .. ZWSP .. "%2")
  text = text:gsub("([%l%d])(%u)", "%1" .. ZWSP .. "%2")
  -- Keep a leading slash attached to the first segment of a path.
  text = text:gsub("^/" .. ZWSP, "/")
  return text
end

local break_filter = {
  Str = function(element)
    element.text = add_breaks(element.text)
    return element
  end,
  Code = function(element)
    element.text = add_breaks(element.text)
    return element
  end,
}

local function text_length(text)
  return utf8.len(text) or #text
end

local function longest_word(text)
  local longest = 0
  for word in text:gsub(ZWSP, " "):gmatch("%S+") do
    longest = math.max(longest, text_length(word))
  end
  return longest
end

local function measure_rows(rows, stats)
  for _, row in ipairs(rows) do
    for index, cell in ipairs(row.cells) do
      local text = pandoc.utils.stringify(cell.contents)
      local column = stats[index]
      if column then
        local length = text_length(text:gsub(ZWSP, ""))
        column.total = column.total + length
        column.count = column.count + 1
        column.max = math.max(column.max, length)
        column.word = math.max(column.word, longest_word(text))
      end
    end
  end
end

function Table(table)
  table = table:walk(break_filter)

  local columns = #table.colspecs
  local stats = {}
  for index = 1, columns do
    stats[index] = { total = 0, count = 0, max = 0, word = 0 }
  end

  measure_rows(table.head.rows, stats)
  for _, body in ipairs(table.bodies) do
    measure_rows(body.body, stats)
  end

  local dense = columns >= 5
  local char_width = dense and CHAR_WIDTH.dense or CHAR_WIDTH.normal

  local minimums, weights = {}, {}
  local minimum_total, weight_total = 0, 0
  for index, column in ipairs(stats) do
    local average = column.count > 0 and column.total / column.count or 0
    local minimum = (column.word * char_width + CELL_PADDING) / CONTENT_WIDTH
    local weight = 0.5 * average + 0.5 * math.min(column.max, 3 * average)
    minimums[index] = minimum
    weights[index] = math.max(weight, 1)
    minimum_total = minimum_total + minimum
    weight_total = weight_total + weights[index]
  end

  local widths = {}
  if minimum_total >= 1 then
    for index = 1, columns do
      widths[index] = minimums[index] / minimum_total
    end
  else
    -- Start from the content-proportional width and raise any column that
    -- falls below its minimum, taking the space from the wider columns.
    local fixed, free = {}, 1
    local changed = true
    while changed do
      changed = false
      local free_weight = 0
      for index = 1, columns do
        if not fixed[index] then
          free_weight = free_weight + weights[index]
        end
      end
      for index = 1, columns do
        if not fixed[index] then
          local width = free * weights[index] / free_weight
          if width < minimums[index] then
            fixed[index] = true
            widths[index] = minimums[index]
            free = free - minimums[index]
            changed = true
          end
        end
      end
    end
    local free_weight = 0
    for index = 1, columns do
      if not fixed[index] then
        free_weight = free_weight + weights[index]
      end
    end
    for index = 1, columns do
      if not fixed[index] then
        widths[index] = free * weights[index] / free_weight
      end
    end
  end

  for index = 1, columns do
    table.colspecs[index] = { table.colspecs[index][1], widths[index] }
  end

  table.attr.classes:insert("fitted")
  if dense then
    table.attr.classes:insert("dense")
  end
  return table
end

-- Raw HTML tables keep their own column widths; only their inline code
-- receives the line-break opportunities.
function RawBlock(block)
  if block.format == "html" and block.text:find("<table") then
    block.text = block.text:gsub("<code>(.-)</code>", function(code)
      return "<code>" .. add_breaks(code) .. "</code>"
    end)
    return block
  end
end
