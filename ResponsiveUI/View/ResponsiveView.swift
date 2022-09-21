//
//  ResponsiveView.swift
//  ResponsiveUI
//
//  Created by Bilal Durnagöl on 21.09.2022.
//

import SwiftUI

/// Custom view which will return the properties of the view
struct ResponsiveView<Content: View>: View {
    
    // MARK: - Properties
    
    var content: (Properties) -> Content
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let isLandscape = (size.width > size.height)
            let isiPad = UIDevice.current.userInterfaceIdiom == .pad
            
            content(Properties(isLandscape: isLandscape, isiPad: isiPad, isSplit: isSplit(), size: size))
                .frame(width: size.width, height: size.height, alignment: .center)
                .onAppear {
                    // Update fraction on intial
                    updateFraction(fraction: isLandscape && !isSplit() ? 0.3 : 0.5)
                }
                .onChange(of: isSplit(), perform: { newValue in
                    updateFraction(fraction: isLandscape ? 0.3 : 0.5)
                })
                .onChange(of: isLandscape) { newValue in
                    updateFraction(fraction: newValue && !isSplit() ? 0.3 : 0.5)
                }
        }
    }
    
    // Solving UI for Split Apps
    
    func isSplit() -> Bool {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return false
        }
        
        return screen.windows.first?.frame.size != UIScreen.main.bounds.size
    }
    
    func updateFraction(fraction: Double) {
        NotificationCenter.default.post(name: Notification.Name("UPDATEFRACTION"), object: nil, userInfo: ["fraction" : fraction])
    }
}

struct Properties {
    var isLandscape: Bool
    var isiPad: Bool
    var isSplit: Bool
    var size: CGSize
}
