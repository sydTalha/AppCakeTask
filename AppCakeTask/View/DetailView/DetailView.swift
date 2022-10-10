//
//  DetailView.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/9/22.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var characterModel: CharacterRequest.CharacterModel
    var body: some View {
        VStack{
            
            HStack{
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack{
                        Circle()
                            .fill(.purple)
                            .frame(width: 40, height: 40)
                        Image("ic_back")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                }
                Spacer()
                Text(characterModel.name)
                    .foregroundColor(Color(red: 173/255, green: 80/255, blue: 240/255))
                    .font(.system(size: 42))
                    .fontWeight(.heavy)
                Spacer()

            }
            .padding(.trailing, 12)
            
            
            
            ZStack(alignment: .trailing){
                KFAnimatedImage(URL(string: characterModel.thumbnailAnimated))
                    .loadDiskFileSynchronously()
                    .placeholder { progress in
                        Image("example")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 130)
                            .padding(8)
                            .padding(.top, 12)
                    }
                    .scaledToFit()
                    .cornerRadius(28)
                    
                    
                VStack{
                    Spacer()
                    Image("ic_heart")
                        .padding([.bottom, .trailing], 20)
                }
            }
            .padding(8)
            .background(Color(red: 173/255, green: 80/255, blue: 240/255))
            .cornerRadius(28)
            
            
            Spacer()
            Button {
                print("download tapped")
            } label: {
                Spacer()
                Text("DOWNLOAD")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .padding([.top, .bottom], 13)
                Spacer()
            }
            .background(Color(red: 45/255, green: 199/255, blue: 146/255))
            .cornerRadius(20)
            .shadow(color: Color(red: 45/255, green: 199/255, blue: 146/255), radius: 1, y: 5)
            

        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(characterModel: CharacterRequest.CharacterModel(id: "", type: "", description: "", category: "", characterType: "", name: "", thumbnail: "", thumbnailAnimated: "", source: ""))
    }
}
