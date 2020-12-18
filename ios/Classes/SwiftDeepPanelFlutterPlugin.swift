import Flutter
import UIKit
import DeepPanel

public class SwiftDeepPanelFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "deeppanel", binaryMessenger: registrar.messenger())
    let instance = SwiftDeepPanelFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "extractPanelsInfo") {
        guard let args = call.arguments as? Dictionary<String, String> else {
            result("I can't parse the arguments")
            return
        }
        let path: String = args["file"] ?? ""
        let file = UIImage.init(contentsOfFile: path)
        
        if let file = file {
            let deepPanel = DeepPanel()
            let info = deepPanel.extractPanelsInfo(from: file)
            
            do {
                let json = try JSONEncoder().encode(toFlPanels(panels: info.panels))
                result(String(data: json, encoding: .utf8))
            } catch {
                result("Can't encode panels")
            }
        }
        
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
}

public typealias FlPrediction = [[Int]]

func toFlPanels(panels: Panels) -> FlPanels {
    var infos: [FlPanel] = []
    panels.panelsInfo.forEach { panel in
        infos.append(FlPanel(
            panelNumberInPage: panel.panelNumberInPage,
            left: panel.left,
            top: panel.top,
            right: panel.right,
            bottom: panel.bottom
        ))
    }
    
    return FlPanels(panelsInfo: infos)
}

public struct FlPanels : Codable {
    public let panelsInfo: [FlPanel]
}

public struct FlPanel : Codable {
    public let panelNumberInPage: Int
    public let left: Int
    public let top: Int
    public let right: Int
    public let bottom: Int
    
    public var width: Int {
        return right - left
    }
    
    public var height: Int {
        return bottom - top
    }
}
