//
//  NewsView.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import SwiftUI

struct NewsView: View {
    
    @Environment (\.openURL) var openUrl
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        Group {
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                VStack(alignment: .leading) {
                    SearchBar(searchText: $searchText, searching: $searching)
                        .toolbar {
                                     if searching {
                                         Button("Cancel") {
                                             searchText = ""
                                             withAnimation {
                                                 searching = false
                                                 UIApplication.shared.dismissKeyboard()
                                             }
                                         }
                                     }
                                 }
                NavigationView {
                    List(articles) {
                        item in ArticleView(isLoading: true, article: item)
                            .onTapGesture {
                                load(url: item.url)
                            }
                    }
                    .navigationTitle("News")
                }}
            }
        }.onAppear(perform: viewModel.getArticles)
    }
    
    func load(url: String?) {
        guard let link = url,
              let url = URL(string: link) else {return}
        
        openUrl(url)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool


    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
            Rectangle()
                .foregroundColor(Color("LightGray"))
        }
        .frame(height:40)
        .cornerRadius(13)
        .padding()

    }
}

extension UIApplication {
      func dismissKeyboard() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  }
