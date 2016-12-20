import Commander
import Foundation

enum WemoError : Error {
    case RuntimeError(String)
    case SerializationError(String)
}

let allActions = Group {    
    $0.command("setup") {
        let configCommand = ConfigureCommand()
        configCommand.run()
    }
    
    $0.command("on") { (name:String) in
        let offCommand = BinaryCommand(hostAlias: name, type: .on)
        offCommand.run()
    }
    
    $0.command("off") { (name:String) in
        let offCommand = BinaryCommand(hostAlias: name, type: .off)
        offCommand.run()
    }
}

allActions.run()
