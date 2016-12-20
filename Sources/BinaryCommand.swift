import Commander
import Foundation
import Console

class BinaryCommand: CommandType {
    let console: ConsoleProtocol = Terminal(arguments: CommandLine.arguments)
    public enum BinaryType { case on, off }
    
    private var host: String
    private var type: BinaryType
    
    private let OffPayload = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:SetBinaryState xmlns:u=\"urn:Belkin:service:basicevent:1\"><BinaryState>0</BinaryState></u:SetBinaryState></s:Body></s:Envelope>".data(using: String.Encoding.utf8)
    private let OnPayload = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:SetBinaryState xmlns:u=\"urn:Belkin:service:basicevent:1\"><BinaryState>1</BinaryState></u:SetBinaryState></s:Body></s:Envelope>".data(using: String.Encoding.utf8)
    
    init(hostAlias: String, type: BinaryType) {
        self.type = type
        self.host = FileManager.getDeviceHost(forAlias: hostAlias) ?? ""
    }
    
    func run(_ parser: ArgumentParser) throws {
        guard self.host.characters.count > 0 else {
            console.output("There was an error when resolving alias", style: .error, newLine: true)
            throw WemoError.RuntimeError("Host alias was unable to be resolved!")
        }
        
        if let url = URL(string: "http://" + self.host + ":49153/upnp/control/basicevent1") {
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.addValue("text/xml", forHTTPHeaderField: "Content-Type")
            req.addValue("\"urn:Belkin:service:basicevent:1#SetBinaryState\"", forHTTPHeaderField: "SOAPACTION")
            switch self.type {
            case .off:
                req.httpBody = OffPayload
            case .on:
                req.httpBody = OnPayload
            }
            
            let session = URLSession.shared
            session.dataTask(with: req, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("Congrats you have reached a new height of lazyness.")
            }).resume()
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
        }
    }
}

