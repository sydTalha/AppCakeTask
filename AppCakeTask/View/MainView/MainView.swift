//
//  ContentView.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/8/22.
//

import SwiftUI


struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @State var title: String = "Characters"
    
    @State private var selectedTab: Int = 0
    @State var characterSelected: Bool = true
    @State var animationSelected: Bool = false
    @State var savedSelected: Bool = false
    var tabs = ["Characters", "Animations", "Saved"]
    let selectedStartGradient = Color(red: 45/255, green: 199/255,  blue: 146/255)
    let selectedEndGradient = Color(red: 62/255, green: 220/255, blue: 176/255)
    
    @State var block: Int = 4
    
    var body: some View {
        NavigationView {
            VStack{
                Text(title)
                    .foregroundColor(Color(red: 173/255, green: 80/255, blue: 240/255))
                    .font(.system(size: 42))
                    .fontWeight(.bold)
                    .padding(.top, 12)
                
                HStack{
                    Button {
                        characterSelected = true
                        animationSelected = false
                        savedSelected = false
                        self.title = tabs[0]
                        
                        viewModel.requestCharacters(limit: 4)
                        
                    } label: {
                        
                        Text("Characters")
                            .foregroundColor(characterSelected ? .white :
                                                Color(red: 173/255, green: 80/255, blue: 240/255))
                            .padding()
                            .background(characterSelected ? LinearGradient(gradient: Gradient(colors: [selectedStartGradient, selectedEndGradient]), startPoint: .top, endPoint: .bottom) :
                                            LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(20)
                            .shadow(color: Color(red: 210/255, green: 214/255, blue: 233/255), radius: 4, y: 10)
                            .font(.system(size: 18, weight: .bold))
                    }
                    
                    Button {
                        characterSelected = false
                        animationSelected = true
                        savedSelected = false
                        self.title = tabs[1]
                        viewModel.requestAnimations(limit: block)

                    } label: {
                        
                        Text("Animations")
                            .foregroundColor(animationSelected ? .white :
                                                Color(red: 173/255, green: 80/255, blue: 240/255))
                            .padding()
                            .background(animationSelected ? LinearGradient(gradient: Gradient(colors: [selectedStartGradient, selectedEndGradient]), startPoint: .top, endPoint: .bottom) :
                                            LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(20)
                            .shadow(color: Color(red: 210/255, green: 214/255, blue: 233/255), radius: 4, y: 10)
                            .font(.system(size: 18, weight: .bold))
                    }
                    
                    Button {
                        characterSelected = false
                        animationSelected = false
                        savedSelected = true
                        self.title = tabs[2]
                        
                        //load saved
                        viewModel.loadSaved()

                    } label: {
                        
                        Text("Saved")
                            .foregroundColor(savedSelected ? .white :
                                                Color(red: 173/255, green: 80/255, blue: 240/255))
                            .padding()
                            .background(savedSelected ? LinearGradient(gradient: Gradient(colors: [selectedStartGradient, selectedEndGradient]), startPoint: .top, endPoint: .bottom) :
                                            LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(20)
                            .shadow(color: Color(red: 210/255, green: 214/255, blue: 233/255), radius: 4, y: 10)
                            .font(.system(size: 18, weight: .bold))
                    }
                    
                }
                .padding([.leading, .trailing], 8)
                
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20, content: {
                        ForEach(viewModel.charactersList.indices, id: \.self) { i in
                            Button {
                                self.viewModel.selectedCharacter = viewModel.charactersList[i]
                                self.viewModel.navToDetailView()
                            } label: {
                                ListViewItem(characterModel: viewModel.charactersList[i], saveTapped: { characterModel in
                                    
                                    viewModel.saveAction(character: characterModel)
                                })
                                    .cornerRadius(26)
                                    .shadow(color: Color(red: 210/255, green: 214/255, blue: 233/255), radius: 2, y: 6)
                                    .onAppear{
                                        if viewModel.charactersList.indices.last == i && i < viewModel.charactersList.count{
                                            print("last item appearing")
                                            let next = viewModel.charactersList.count - i
                                            if characterSelected{
                                                block = block + 4
                                                viewModel.requestCharacters(limit: block)
                                                
                                            }
                                            if animationSelected{
                                                block = block + 4
                                                viewModel.requestAnimations(limit: block)
                                            }
                                        }
                                    }
                                    
                            }
                        }
                        
                    })
                }
                .padding(12)
                
                navigationLinks
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 248/255, green: 248/255, blue: 248/255), Color(red: 240/255, green: 240/255, blue: 240/255)]), startPoint: .top, endPoint: .bottom))
        }
        
    }
}

extension MainView{
    private var navigationLinks: some View {
        VStack {
            NavigationLink(destination: DetailView(characterModel: self.viewModel.selectedCharacter ?? CharacterRequest.CharacterModel(id: "", type: "", description: "", category: "", characterType: "", name: "", thumbnail: "", thumbnailAnimated: "", source: "")), tag: 0, selection: $viewModel.navSelection) {
                EmptyView()
            }.hidden()
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
