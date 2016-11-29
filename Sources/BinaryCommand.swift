import Commander
import Foundation

let OffPayload = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:SetBinaryState xmlns:u=\"urn:Belkin:service:basicevent:1\"><BinaryState>0</BinaryState></u:SetBinaryState></s:Body></s:Envelope>"

let OnPayload = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:SetBinaryState xmlns:u=\"urn:Belkin:service:basicevent:1\"><BinaryState>1</BinaryState></u:SetBinaryState></s:Body></s:Envelope>"

class BinaryCommand: CommandType {
    public enum BinaryType { case on, off }
    
    private var host: String
    private var type: BinaryType
    
    init(host: String, type: BinaryType) {
        self.host = host
        self.type = type
    }
    
    func run(_ parser: ArgumentParser) throws {
        print("Turning off light")
        if let url = URL(string: "http://" + self.host + ":49153/upnp/control/basicevent1") {
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.addValue("text/xml", forHTTPHeaderField: "Content-Type")
            req.addValue("\"urn:Belkin:service:basicevent:1#SetBinaryState\"", forHTTPHeaderField: "SOAPACTION")
            switch self.type {
            case .off:
                req.httpBody = OffPayload.data(using: String.Encoding.utf8, allowLossyConversion: false)
            case .on:
                req.httpBody = OnPayload.data(using: String.Encoding.utf8, allowLossyConversion: false)
            }
            
            let session = URLSession.shared
            session.dataTask(with: req, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("Congrats you have reached a new height of lazyness.")
            }).resume()
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
        }
    }
}

