//
//  Home.swift
//  ResponsiveUI
//
//  Created by Bilal Durnagöl on 21.09.2022.
//

import SwiftUI

struct Home: View {
    
    // MARK: - Properties
    
    @State var currentMenu: String = "Inbox"
    @State var isShowMenu: Bool = false
    @State var excessPadding: CGFloat = 0
    // Optinal color highlighting current color
    @State var navigationTag: String?
    
    // MARK: - Body
    
    var body: some View {
        ResponsiveView { prop in
            HStack(spacing: 0) {
                if prop.isLandscape && !prop.isSplit {
                    SideBar(currentMenu: $currentMenu, prop: prop)
                }
                
                // MARK: - Main View
                NavigationView {
                    MainView(prop: prop)
                        .navigationBarHidden(true)
                        .padding(.leading, prop.isiPad && prop.isLandscape ? excessPadding : 0)
                }
                .modifier(PaddingModifier(padding: $excessPadding, props: prop))
              
            } //: HStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                ZStack(alignment: .leading) {
                    if !prop.isLandscape || prop.isSplit {
                        Color.black
                            .opacity(isShowMenu ? 0.25 : 0.0)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    isShowMenu.toggle()
                                }
                            }
                        SideBar(currentMenu: $currentMenu, prop: prop)
                            .offset(x: isShowMenu ? 0 : -300)
                    }
                }
            }
        }
    }
    
    // MARK: - Main View
    
    @ViewBuilder
    func MainView(prop: Properties) -> some View {
        
        VStack {
            
            // MARK: - Search bar
            
            HStack(spacing: 20) {
                if !prop.isLandscape {
                    Button {
                        withAnimation {
                            isShowMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
                
                TextField("Search", text: .constant(""))
                
                Image(systemName: "magnifyingglass")
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(.white)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(users) { user in
                        
                        NavigationLink(tag: user.id, selection: $navigationTag) {
                            DetailView(user: user, props: prop)
                        } label: {
                            UserCardView(user: user, prop: prop)
                        }
                    }
                }
                .padding(.top)
            }
            
        } //: VStack
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(uiColor: .systemGray5).ignoresSafeArea(.all))
    }
    
    // MARK: - User Card View
    
    @ViewBuilder
    func UserCardView(user: User, prop: Properties) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(user.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(user.name)
                        .fontWeight(.bold)
                    Text(user.title)
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Now")
                    .font(.caption)
                    .foregroundColor(navigationTag == user.id && prop.isiPad ? .white : .gray)
            }
            .foregroundColor( navigationTag == user.id && prop.isiPad ? .white : .black)
            
            
            // Dummy text
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                .font(.caption)
                .foregroundColor(navigationTag == user.id && prop.isiPad ? .white : .gray)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(navigationTag == user.id && prop.isiPad ? .blue : Color(uiColor: .systemGray4))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
