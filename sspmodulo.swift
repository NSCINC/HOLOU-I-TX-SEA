import Foundation
import CryptoKit

// MARK: - SSP Module 3: Sea Secure Protocol

class SeaSecureProtocol {
    
    // MARK: - Properties
    
    private let symmetricKey: SymmetricKey // Chave simétrica para criptografia
    
    // MARK: - Initialization
    
    init() {
        // Gerar uma chave simétrica aleatória para criptografia
        self.symmetricKey = SymmetricKey(size: .bits256)
        print("SSP Module 3 initialized with a secure symmetric key.")
    }
    
    // MARK: - Encryption and Decryption Functions
    
    // Função para criptografar dados (texto ou binário)
    func encrypt(data: Data) -> Data? {
        do {
            let sealedBox = try AES.GCM.seal(data, using: symmetricKey)
            print("Data successfully encrypted.")
            return sealedBox.combined
        } catch {
            print("Encryption failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Função para descriptografar dados
    func decrypt(encryptedData: Data) -> Data? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            print
