import Foundation
import SQLite3

class InvestmentManager {
    var db: OpaquePointer?
    
    init() {
        initializeDatabase()
    }
    
    // Inicializa o banco de dados
    func initializeDatabase() {
        let dbName = "investments.db"
        if sqlite3_open(dbName, &db) != SQLITE_OK {
            print("Erro ao abrir o banco de dados.")
            return
        }
        
        let createInvestorsTable = """
        CREATE TABLE IF NOT EXISTS Investors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            phone_number TEXT NOT NULL);
        """
        
        let createAssetsTable = """
        CREATE TABLE IF NOT EXISTS Assets (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            asset_name TEXT NOT NULL,
            asset_type TEXT NOT NULL,
            total_slots INTEGER NOT NULL,
            annual_return REAL NOT NULL);
        """
        
        let createInvestmentsTable = """
        CREATE TABLE IF NOT EXISTS Investments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            investor_id INTEGER,
            asset_id INTEGER,
            invested_amount REAL,
            FOREIGN KEY(investor_id) REFERENCES Investors(id),
            FOREIGN KEY(asset_id) REFERENCES Assets(id));
        """
        
        executeSQL(createInvestorsTable)
        executeSQL(createAssetsTable)
        executeSQL(createInvestmentsTable)
        initializeAssets()
    }
    
    // Executa um comando SQL
    func executeSQL(_ sql: String) {
        var errorMessage: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(db, sql, nil, nil, &errorMessage) != SQLITE_OK {
            let error = String(cString: errorMessage!)
            print("Erro de SQL: \(error)")
        } else {
            print("SQL executado com sucesso: \(sql)")
        }
    }
    
    // Inicializa dados de ativos
    func initializeAssets() {
        insertAsset(assetName: "Ação XYZ", assetType: "Ação", totalSlots: 100, annualReturn: 12.0)
        insertAsset(assetName: "Fundo Imobiliário ABC", assetType: "Fundo", totalSlots: 50, annualReturn: 8.0)
    }
    
    // Insere ativos no banco de dados
    func insertAsset(assetName: String, assetType: String, totalSlots: Int32, annualReturn: Double) {
        var stmt: OpaquePointer?
        let insertSQL = "INSERT INTO Assets (asset_name, asset_type, total_slots, annual_return) VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare_v2(db, insertSQL, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (assetName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (assetType as NSString).utf8String, -1, nil)
            sqlite3_bind_int(stmt, 3, totalSlots)
            sqlite3_bind_double(stmt, 4, annualReturn)
            
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Ativo inserido com sucesso: \(assetName)")
            } else {
                print("Erro ao inserir ativo.")
            }
        }
        
        sqlite3_finalize(stmt)
    }
}

// Inicializa o gerenciador de investimentos
let investmentManager = InvestmentManager()
