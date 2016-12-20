import Commander
import Foundation
import Console

class ConfigureCommand: CommandType {
    let console: ConsoleProtocol = Terminal(arguments: CommandLine.arguments)
    private var devices: [String: String] = [:]

    func run(_ parser: ArgumentParser) throws {
        console.output("👏👏 - Begining setup - 👏👏", style: .info, newLine: true)
        guard let deviceCount = console.ask("💡- How many devices do you have? - 💡", style: .info).int else {
            console.error("😡 Number was not entered 😡", newLine: true)
            return
        }
        
        getDeviceInfo(forNumberOfDevices: deviceCount)
        FileManager.saveDeviceInfoFor(devices)
        
        // console.output(devices.description , style: .info, newLine: true)
        console.output("😎 Set up finished - Devices Saved! 😎", style: .success, newLine: true)
        console.output("💡💡💡💡 run | wemo \(devices.first?.key) on | to try it out 💡💡💡💡", style: .warning, newLine: true)
    }
        
    private func getDeviceInfo(forNumberOfDevices numberOfDevices: Int) {
        for index in 1...numberOfDevices {
            let deviceName = console.ask("💡- Please enter the name for device \(index)", style: .info)
            let deviceIp = console.ask("💡- Please enter the IP for device \(index)", style: .info)
            devices[deviceName] = deviceIp
        }
    }
}


