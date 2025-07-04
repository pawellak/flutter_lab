//
//  FLNativeView.swift
//  Runner
//
//  Created by Paweł Łąk on 03/07/2025.
//

import Flutter
import SwiftUI
import UIKit


//native boilerplate code
class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
   
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> any FlutterPlatformView {
        return FLNativeView(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

}


class FLNativeView: NSObject, FlutterPlatformView {
  
    private var _view : UIView
    
    init(
        frame: CGRect,
        viewIdentifier vievId: Int64,
        arguments args : Any?,
        binaryMessenger messenger : FlutterBinaryMessenger?
    )
    {
        _view = UIView()
        super.init()
        createNativeView(view: _view, arguments: args)
        
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createNativeView(view _view : UIView, arguments args: Any?) {
        
        let keyWindows = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) ?? UIApplication.shared.windows.first
        let topController = keyWindows?.rootViewController
        
        let vc = UIHostingController(rootView: SwiftUIView())
        let swiftUIView = vc.view!
        
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
        topController!.addChild(vc)
        
        _view.addSubview(swiftUIView)
        
        NSLayoutConstraint.activate([
            swiftUIView.leadingAnchor.constraint(equalTo: _view.leadingAnchor),
            swiftUIView.trailingAnchor.constraint(equalTo: _view.trailingAnchor),
            swiftUIView.topAnchor.constraint(equalTo: _view.topAnchor),
            swiftUIView.bottomAnchor.constraint(equalTo: _view.bottomAnchor)
        ])
        
        
        vc.didMove(toParent: topController)
        
    }
}
