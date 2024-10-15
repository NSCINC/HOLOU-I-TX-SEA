import Foundation
import SQLite3

class InvestmentManager {
    var db: OpaquePointer?

    init() {
        initializeDatabase()
    }

    // Initializes the database
    private func initializeDatabase() {
        let dbName = "investments.db"
        if sqlite3_open(dbName, &db) != SQLITE_OK {
            print("Error opening database.")
            return
        }

        // Create tables
        createTable(query: """
            CREATE TABLE IF NOT EXISTS Investors (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                email TEXT NOT NULL,
                phone_number TEXT NOT NULL);
            """)
        
        createTable(query: """
            CREATE TABLE IF NOT EXISTS Assets (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                asset_name TEXT NOT NULL,
                asset_type TEXT NOT NULL,
                total_slots INTEGER NOT NULL,
                annual_return REAL NOT NULL);
            """)

        createTable(query: """
            CREATE TABLE IF NOT EXISTS Investments (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                investor_id INTEGER,
                asset_id INTEGER,
                invested_amount REAL,
                FOREIGN KEY(investor_id) REFERENCES Investors(id),
                FOREIGN KEY(asset_id) REFERENCES Assets(id));
            """)

        // Initialize default assets
        initializeAssets()
    }

    // Creates a table using the provided SQL query
    private func createTable(query: String) {
        executeSQL(query)
    }

    // Executes an SQL command
    private func executeSQL(_ sql: String) {
        var errorMessage: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(db, sql, nil, nil, &errorMessage) != SQLITE_OK {
            let error = String(cString: errorMessage!)
            print("SQL error: \(error)")
        } else {
            print("SQL executed successfully: \(sql)")
        }
    }

    // Initializes default assets in the database
    private func initializeAssets() {
        let assets = [
            ("Ação XYZ", "Ação", 100, 12.0),
            ("Fundo Imobiliário ABC", "Fundo", 50, 8.0)
        ]
        
        for asset in assets {
            insertAsset(assetName: asset.0, assetType: asset.1, totalSlots: Int32(asset.2), annualReturn: asset.3)
        }
    }

    // Inserts an asset into the database
    private func insertAsset(assetName: String, assetType: String, totalSlots: Int32, annualReturn: Double) {
        var stmt: OpaquePointer?
        let insertSQL = "INSERT INTO Assets (asset_name, asset_type, total_slots, annual_return) VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare_v2(db, insertSQL, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (assetName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (assetType as NSString).utf8String, -1, nil)
            sqlite3_bind_int(stmt, 3, totalSlots)
            sqlite3_bind_double(stmt, 4, annualReturn)
            
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Asset inserted successfully: \(assetName)")
            } else {
                print("Error inserting asset.")
            }
        } else {
            print("Error preparing statement.")
        }

        sqlite3_finalize(stmt)
    }

    // Cleanup database connection
    deinit {
        sqlite3_close(db)
    }
}

// Initializes the investment manager
let investmentManager = InvestmentManager()
