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
    
    @StateObject var dalle = DalleViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Description", text: $text)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    loader = true
                    image = nil
                    
                    Task {
                        do {
                            let response = try await dalle.generateImage(text: text)
                            if let url = response.data.map(\.url).first {
                                let (data, _) = try await URLSession.shared.data(from: url)
                                image = UIImage(data: data)
                                loader = false
                            }
                        } catch {
                            print(error)
                        }
                    }
                    
                    
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
