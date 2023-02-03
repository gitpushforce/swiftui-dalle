//
//  ContentView.swift
//  DalleImageSwiftui
//
//  Created by masaki on 2023/02/04.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = ""
    @State private var image: UIImage? = nil
    @State private var loader = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Description", text: $text)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    loader = true
                    image = nil
                } label: {
                    Text("generate")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 400, height: 400)
                    
                    Button("Save Image") {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    }
                } else {
                    if loader {
                        ProgressView()
                    }
                }
                Spacer()
            }.padding(.all)
            .navigationTitle(("DallE"))
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
