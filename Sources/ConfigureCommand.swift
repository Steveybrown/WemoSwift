import Commander
import Foundation
import Console

class ConfigureCommand: CommandType {
    let console: ConsoleProtocol = Terminal(arguments: CommandLine.arguments)
    let fileManager = FileManager.default
    
    // let docsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    private let fileName = "wemoConfig.json"
    private let path = "/Users/stephen/desktop/wemoConfig.json"
    private var devices = ["One": "192.168.0.1", "Two": "192.122.11.1"]

    func run(_ parser: ArgumentParser) throws {
        console.output("👏👏 - Begining setup - 👏👏", style: .info, newLine: true)
        
        if !fileManager.fileExists(atPath: path) {
            fileManager.createFile(atPath: path, contents: nil, attributes: nil)
        }
        
        guard let deviceCount = console.ask("💡- How many devices do you have?", style: .info).int else {
            console.error("😡 Number was not entered 😡", newLine: true)
            return
        }
        
        getDeviceInfo(forNumberOfDevices: deviceCount)
        saveDeviceInfoFor(devices)
        
        // console.output(devices.description , style: .info, newLine: true)
        console.output("😎 Set up finished - Devices Saved! 😎", style: .success, newLine: true)
        console.output("💡💡💡💡 run | wemo \(devices.first?.key) on | to try it out 💡💡💡💡", style: .warning, newLine: true)
    }
    
    private func saveDeviceInfoFor(_ devices: [String: String]) {
        do {
            let json = try JSONSerialization.data(withJSONObject: devices, options: .prettyPrinted)
            guard let fileHandler = FileHandle(forWritingAtPath: path) else {
                console.output("😡 Unable to write to file! 😡", style: .error, newLine: true)
                return
            }
            fileHandler.write(json)
        } catch {
            // JSON serialisation error
            console.output("😡 Unable to flicker lights due to a shortage 😡", style: .error, newLine: true)
        }
    }
    
    private func getDeviceInfo(forNumberOfDevices numberOfDevices: Int) {
        for index in 1...numberOfDevices {
            let deviceName = console.ask("💡- Please enter the name for device \(index)", style: .info)
            let deviceIp = console.ask("💡- Please enter the IP for device \(index)", style: .info)
            devices[deviceName] = deviceIp
        }
    }
}


