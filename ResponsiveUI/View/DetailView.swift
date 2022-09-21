//
//  DetailView.swift
//  ResponsiveUI
//
//  Created by Bilal Durnagöl on 21.09.2022.
//

import SwiftUI

struct DetailView: View {
    
    // MARK: - Properties
    
    var user: User
    var props: Properties
    @Environment(\.dismiss) var dissmis
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                HStack {
                    Button {
                        dissmis()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    .opacity(props.isLandscape || !props.isSplit ? (props.isiPad ? 0 : 1) : 1)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundColor(.red)
                    }


                }
                
                Divider()
                
                HStack(spacing: 15) {
                    
                    Image(user.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55, alignment: .center)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            Text(user.name)
                                .fontWeight(.semibold)
                            
                            if props.isiPad && !props.isSplit {
                                Text("<bilaldurnagol@gmail.com>")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        if !props.isiPad || props.isSplit {
                            Text("<bilaldurnagol@gmail.com>")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Text(user.title)
                            .font(.title3.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Now")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                }
                
                // Dummy text
                
                Text("""
The standard Lorem Ipsum passage, used since the 1500s

"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC

"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
""")
                .multilineTextAlignment(.leading)
                .padding(.top)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
