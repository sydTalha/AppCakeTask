//
//  ListViewItem.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/8/22.
//

import SwiftUI
import Kingfisher

struct ListViewItem: View {
    var characterModel: CharacterRequest.CharacterModel
    
    @State var saveIcon: String = "ic_heart"
    var saveTapped: ((CharacterRequest.CharacterModel)->Void)?
    var body: some View {
        VStack{
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
                //.resizable()
                //.aspectRatio(contentMode: .fit)
                .frame(height: 130)
                .cornerRadius(22)
                .padding(.top, 8)


            HStack{
                Text(characterModel.name)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Spacer()

                Image(saveIcon)
                    .onTapGesture {
                        //set default
                        saveIcon = "ic_heart_fill"
                        saveTapped?(characterModel)
                        
                    }
            }
            .padding([.top, .bottom], 12)
            .padding([.leading, .trailing], 8)
        }
        .background(Color(red: 168/255, green: 74/255, blue: 237/255))
        .padding([.leading, .trailing], 6)
    }
}

struct ListViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ListViewItem(characterModel: CharacterRequest.CharacterModel(id: "", type: "", description: "", category: "", characterType: "", name: "", thumbnail: "", thumbnailAnimated: "", source: ""))
    }
}
