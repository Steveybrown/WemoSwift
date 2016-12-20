import Foundation
import Console

extension FileManager {
    
    public static var wemoConfigFileName: String { return "wemoConfig.json" }
    public static var wemoConfigPath: String { return "/Users/stephen/desktop/wemoConfig.json" }
    private static var console: ConsoleProtocol { return Terminal(arguments: CommandLine.arguments) }

    public static func saveDeviceInfoFor(_ devices: [String: String]) {
        self.createConfigFileIfDoesNotExist()
        do {
            let json = try JSONSerialization.data(withJSONObject: devices, options: .prettyPrinted)
            guard let fileHandler = FileHandle(forWritingAtPath: wemoConfigPath) else {
                console.output("😡 - Unable to write to file! - 😡", style: .error, newLine: true)
                return
            }
            fileHandler.write(json)
        } catch {
            // JSON serialisation error
            console.output("😡 - Unable to flicker lights due to a shortage - 😡", style: .error, newLine: true)
        }
    }
    
    public static func getDeviceHost(forAlias alias: String) -> String? {
        do {
            guard let data = FileHandle(forReadingAtPath: wemoConfigPath)?.readDataToEndOfFile(),
                let deviceInfos = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String],
                let deviceHost = deviceInfos[alias] else {
                    console.output("😡 - Error getting IP for alias - 😡", style: .error, newLine: true)
                    return nil
            }
            return deviceHost
        } catch {
            return nil
        }
    }
    
    private static func createConfigFileIfDoesNotExist() {
        if !FileManager.default.fileExists(atPath: FileManager.wemoConfigPath) {
            FileManager.default.createFile(atPath: FileManager.wemoConfigPath, contents: nil, attributes: nil)
        }
    }
    
}

