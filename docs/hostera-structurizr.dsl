/*
 * Hostera - C4 model (TB1): system context, containers and components.
 * The web application components follow the bounded contexts of the hostera-frontend repository.
 */
workspace "Hostera" "C4 model of Hostera, the hotel operations platform designed by Grafo Verde." {

    model {
        admin = person "Hotel Administrator" "Owner or administrator of an independent hotel who supervises its daily operation."
        ops = person "Operations Manager" "Person responsible for the operation of a small hotel chain with two to five properties."
        staff = person "Hotel Staff" "Front desk, inventory and security operators who run the daily operation of a property."
        rfid = softwareSystem "RFID Lock System" "Door readers and front desk key-card encoder installed in the hotel." {
            tags "External"
        }
        sendgrid = softwareSystem "Twilio SendGrid" "Cloud e-mail delivery service." {
            tags "External"
        }
        hostera = softwareSystem "Hostera" "Lets independent hotels and small hotel chains manage bookings, rooms, inventory and RFID room access from one web platform." {
            landing = container "Landing Page" "Static website that presents the plans to each segment and leads visitors to the web application." "HTML, CSS and JavaScript"
            webapp = container "Web Application" "Single-page application with the overview, bookings, rooms, inventory and access control features." "Vue 3, Pinia and PrimeVue" {
                shell = component "App Shell" "app.vue, router.js and the shared layout with the sidebar and the language switcher." "Vue Router and PrimeVue"
                i18n = component "Localization" "i18n.js and the English and Spanish locale files of every module." "Vue I18n"
                m_overview = component "Overview Module" "Property overview, revenue and occupancy, room status and today's arrivals." "Vue views, Pinia store and API client"
                m_bookings = component "Bookings Module" "Bookings, payments, check-in, check-out and cancellation." "Vue views, Pinia store and API client"
                m_rooms = component "Rooms Module" "Rooms, room types, availability calendar, rate plans and daily rates." "Vue views, Pinia store and API client"
                m_inventory = component "Inventory Module" "Inventory items, storage locations and stock adjustments." "Vue views, Pinia store and API client"
                m_access = component "Access Control Module" "Guest and staff credentials, key-card encoding and access events." "Vue views, Pinia store and API client"
                shared = component "Shared Infrastructure" "base-api.js and base-endpoint.js: build every endpoint from the configured API URL." "Axios"
            }
            demoapi = container "Demo API" "Serves demonstration data with the same resources while the RESTful API is built." "Node.js and json-server"
            api = container "RESTful API" "Provides the hotel operations functionality through a JSON/HTTPS API organised by bounded context." "C# and ASP.NET Core" {
                group "Overview" {
                    overviewController = component "Overview Controller" "Endpoints for the property overview, daily performance, room status and arrivals." "ASP.NET Core Controller"
                    overviewQueries = component "Overview Query Service" "Builds the overview of the active property for a period." "C# Application Service"
                    overviewRepository = component "Overview Read Models" "Read bookings, rooms, inventory and access data of the property." "EF Core Repository"
                }
                group "Bookings" {
                    bookingsController = component "Bookings Controller" "Endpoints for bookings, payments, check-in, check-out and cancellation." "ASP.NET Core Controller"
                    bookingsCommands = component "Booking Command Service" "Creates and cancels bookings, records payments and runs check-in and check-out." "C# Application Service"
                    bookingsQueries = component "Booking Query Service" "Finds bookings by guest, stay period, room and status." "C# Application Service"
                    bookingsRepository = component "Booking Repository" "Persists bookings and payments." "EF Core Repository"
                    bookingsAdapter = component "Context Gateways" "Ask the Rooms context for availability and rates, and the Access Control context for guest key cards." "C# Infrastructure Adapter"
                }
                group "Rooms" {
                    roomsController = component "Rooms Controller" "Endpoints for rooms, room types, rate plans, daily rates and status periods." "ASP.NET Core Controller"
                    roomsCommands = component "Room Command Service" "Creates rooms and room types, sets daily rates and room status." "C# Application Service"
                    roomsQueries = component "Availability Query Service" "Returns room availability and status for a period." "C# Application Service"
                    roomsRepository = component "Room Repositories" "Persist rooms, room types, rate plans, daily rates and status periods." "EF Core Repository"
                }
                group "Inventory" {
                    inventoryController = component "Inventory Controller" "Endpoints for inventory items, storage locations and stock adjustments." "ASP.NET Core Controller"
                    inventoryCommands = component "Inventory Command Service" "Registers items and locations and adjusts stock; detects low stock." "C# Application Service"
                    inventoryQueries = component "Inventory Query Service" "Returns items and their stock condition by storage location." "C# Application Service"
                    inventoryRepository = component "Inventory Repositories" "Persist items, storage locations and stock adjustments." "EF Core Repository"
                    inventoryAdapter = component "Notification Gateway" "Sends low-stock alerts by e-mail." "C# Infrastructure Adapter"
                }
                group "Access Control" {
                    accessController = component "Access Control Controller" "Endpoints for credentials, staff members and access events, including events reported by the readers." "ASP.NET Core Controller"
                    accessCommands = component "Credential Command Service" "Issues guest key cards and staff credentials, and revokes or replaces them." "C# Application Service"
                    accessQueries = component "Access Event Query Service" "Returns access events by room, credential and period." "C# Application Service"
                    accessRepository = component "Access Control Repositories" "Persist credentials, staff members and access events." "EF Core Repository"
                    accessAdapter = component "RFID Encoder Adapter" "Writes credentials through the front desk encoder." "C# Infrastructure Adapter"
                }
            }
            db = container "Database" "Stores properties, bookings, payments, rooms, rates, inventory, credentials and access events." "MySQL" {
                tags "Database"
            }
        }

        admin -> hostera "Supervises bookings, rooms, inventory and room access using"
        ops -> hostera "Monitors every property of the chain using"
        staff -> hostera "Registers bookings, stays, stock movements and key cards using"
        hostera -> rfid "Encodes key cards and updates access rights using"
        rfid -> hostera "Reports door access events to"
        hostera -> sendgrid "Sends low-stock alerts using"
        admin -> landing "Reviews the plans in"
        ops -> landing "Reviews the plans in"
        admin -> webapp "Supervises the operation using"
        ops -> webapp "Monitors every property using"
        staff -> shell "Runs the daily operation using"
        landing -> webapp "Sends visitors to"
        shell -> i18n "Translates the labels with"
        shell -> m_overview "Routes to"
        m_overview -> shared "Uses"
        shell -> m_bookings "Routes to"
        m_bookings -> shared "Uses"
        shell -> m_rooms "Routes to"
        m_rooms -> shared "Uses"
        shell -> m_inventory "Routes to"
        m_inventory -> shared "Uses"
        shell -> m_access "Routes to"
        m_access -> shared "Uses"
        shared -> demoapi "Sends requests to" "JSON/HTTPS"
        shared -> api "Sends requests to" "JSON/HTTPS"
        m_access -> rfid "Encodes key cards through" "Simulated in this version"
        api -> db "Reads from and writes to" "MySQL protocol"
        webapp -> overviewController "Makes API requests to" "JSON/HTTPS"
        overviewController -> overviewQueries "Sends queries to"
        overviewQueries -> overviewRepository "Reads through"
        overviewRepository -> db "Reads from and writes to" "MySQL protocol"
        webapp -> bookingsController "Makes API requests to" "JSON/HTTPS"
        bookingsController -> bookingsCommands "Sends commands to"
        bookingsCommands -> bookingsRepository "Reads and writes through"
        bookingsController -> bookingsQueries "Sends queries to"
        bookingsQueries -> bookingsRepository "Reads through"
        bookingsRepository -> db "Reads from and writes to" "MySQL protocol"
        bookingsCommands -> bookingsAdapter "Uses"
        webapp -> roomsController "Makes API requests to" "JSON/HTTPS"
        roomsController -> roomsCommands "Sends commands to"
        roomsCommands -> roomsRepository "Reads and writes through"
        roomsController -> roomsQueries "Sends queries to"
        roomsQueries -> roomsRepository "Reads through"
        roomsRepository -> db "Reads from and writes to" "MySQL protocol"
        webapp -> inventoryController "Makes API requests to" "JSON/HTTPS"
        inventoryController -> inventoryCommands "Sends commands to"
        inventoryCommands -> inventoryRepository "Reads and writes through"
        inventoryController -> inventoryQueries "Sends queries to"
        inventoryQueries -> inventoryRepository "Reads through"
        inventoryRepository -> db "Reads from and writes to" "MySQL protocol"
        inventoryCommands -> inventoryAdapter "Uses"
        inventoryAdapter -> sendgrid "Calls" "HTTPS"
        webapp -> accessController "Makes API requests to" "JSON/HTTPS"
        accessController -> accessCommands "Sends commands to"
        accessCommands -> accessRepository "Reads and writes through"
        accessController -> accessQueries "Sends queries to"
        accessQueries -> accessRepository "Reads through"
        accessRepository -> db "Reads from and writes to" "MySQL protocol"
        accessCommands -> accessAdapter "Uses"
        accessAdapter -> rfid "Calls" "HTTPS"
        rfid -> accessController "Reports access events to" "HTTPS"
    }

    views {
        systemContext hostera "SystemContext" {
            include *
            autoLayout tb
        }
        container hostera "Containers" {
            include *
            autoLayout tb
        }
        component webapp "WebApplicationComponents" {
            include *
            autoLayout tb
        }
        component api "ApiOverviewComponents" {
            include ->overviewController-> webapp db
            autoLayout tb
        }
        component api "ApiBookingsComponents" {
            include ->bookingsController-> webapp db
            autoLayout tb
        }
        component api "ApiRoomsComponents" {
            include ->roomsController-> webapp db
            autoLayout tb
        }
        component api "ApiInventoryComponents" {
            include ->inventoryController-> webapp db
            autoLayout tb
        }
        component api "ApiAccessControlComponents" {
            include ->accessController-> webapp db
            autoLayout tb
        }
        styles {
            element "Person" {
                shape Person
                background #08427B
                color #ffffff
            }
            element "Software System" {
                background #1168BD
                color #ffffff
            }
            element "External" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438DD5
                color #ffffff
            }
            element "Component" {
                background #85BBF0
                color #000000
            }
            element "Database" {
                shape Cylinder
            }
        }
    }
}
