import Commander
import Foundation

let allActions = Group {    
    $0.command("on") { (ip:String) in
        let offCommand = BinaryCommand(host: ip, type: .on)
        offCommand.run()
    }
    
    $0.command("off") { (ip:String) in
        let offCommand = BinaryCommand(host: ip, type: .off)
        offCommand.run()
    }
}

allActions.run()
