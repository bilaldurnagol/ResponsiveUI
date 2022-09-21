//
//  SideBar.swift
//  ResponsiveUI
//
//  Created by Bilal Durnagöl on 21.09.2022.
//

import SwiftUI

struct SideBar: View {
    
    // MARK: - Properties
    
    @Binding var currentMenu: String
    var prop: Properties
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                
                SideBarButton(icon: "tray.and.arrow.down.fill", title: "Inbox")
                    .padding(.top, 40)
                SideBarButton(icon: "paperplane", title: "Send")
                SideBarButton(icon: "doc.fill", title: "Draft")
                SideBarButton(icon: "trash", title: "Deleted")
                
            }//: VStack
            .padding()
            .padding(.top)
            
        } //: ScrollView
        .padding(.horizontal, 10)
        .frame(width: (prop.isLandscape ? prop.size.width : prop.size.height) / 4 > 300 ? 300 : (prop.isLandscape ? prop.size.width : prop.size.height) / 4)
        .background(Color(uiColor: .systemGray4).ignoresSafeArea())
    }
    
    @ViewBuilder
    func SideBarButton(icon: String, title: String) -> some View {
        Button {
            currentMenu = title
        } label: {
            VStack {
                HStack(spacing: 10) {
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.black)
                        .opacity(currentMenu == title ? 1 : 0)
                    
                    Image(systemName: icon)
                        .font(.callout)
                    
                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                } //: HStack
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
            } //: VStack
        } //: Button
        .foregroundColor(currentMenu == title ? .pink : .gray)

    }
}

// MARK: - Preview

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Fixing it by removing the extra space with the help of negative Padding

struct PaddingModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var padding: CGFloat
    var props: Properties
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: PaddingKey.self, value: proxy.frame(in: .global))
                        .onPreferenceChange(PaddingKey.self) { value in
                            self.padding = -(value.minX / 3.3)
                        }
                }
            }
    }
}

struct PaddingKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
