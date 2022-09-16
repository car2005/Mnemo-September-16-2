//
//  HomeView.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import SwiftUI
import FirebaseAuth
import Combine
import ShimmerSwift

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var loggedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    func logIn(username: String, password: String) {
        auth.signIn(withEmail: username, password: password) {
            result, error in
            guard result != nil, error == nil else {
                return
            }
        }
    }
    func signUp(username: String, password: String) {
        auth.createUser(withEmail: username, password: password) {
            result, error in guard result != nil, error == nil else {
                return
            }
        }
    }
}
    
class HomeViewClass: UIViewController {
    
    struct HomeView: View {
        @EnvironmentObject var appState: AppState
        var body: some View {
            NavigationView {
                VStack(spacing: 16) {
                    NavigationLink(destination: LogInView()) {
                        Text("Log in")
                    }
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up")
                }
            }
        }
            }
        }
    
    struct LogInView: View {
        
        @State private var username: String = ""
        @State private var password: String = ""
        @EnvironmentObject var viewModel: AppViewModel
        @State var multiColor = true
        
        var body: some View {
            VStack(alignment: .center, spacing: 16) {
                TextShimmer(text: "Welcome back!", multiColors: $multiColor)
                    .font(.custom("okemo", size: 30.0))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)

                TextField("Username", text: $username).padding(.leading)
                    .disableAutocorrection(true).autocapitalization(.none)
                
                SecureField("Password", text: $password).padding(.leading) .disableAutocorrection(true).autocapitalization(.none)
                
                Button("Submit") {
                    
                    guard !username.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.logIn(username: username, password: password)
                }
                .navigationTitle("Log In Screen")
                    }
    }
    }
    struct SignUpView: View {
        
        @State private var username: String = ""
        @State private var password: String = ""
        @State var multiColor = true

        
        var body: some View {
            VStack(alignment: .center, spacing: 16) {
                TextShimmer(text: "Welcome!", multiColors: $multiColor)
                    .font(.custom("okemo", size: 40.0))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                TextField("Username", text: $username).padding(.leading) .disableAutocorrection(true).autocapitalization(.none)
                
                SecureField("Password", text: $password).padding(.leading) .disableAutocorrection(true).autocapitalization(.none)
                    
                
                Button("Submit") {
                    guard !username.isEmpty, !password.isEmpty else {
                        return
                    }}
                .navigationTitle("Sign Up Screen")
        }
    }
        
    }

    // TextShimmer....

    struct TextShimmer: View {
        
        var text: String
        @State var animation = false
        @Binding var multiColors: Bool
        
        var body: some View{
            
            ZStack{
                
                Text(text)
                    .font(.system(size: 75, weight: .bold))
                    .foregroundColor(Color.white.opacity(0.25))
                
                // MultiColor Text....
                
                HStack(spacing: 0){
                    
                    ForEach(0..<text.count,id: \.self){index in
                        
                        Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                            .font(.system(size: 75, weight: .bold))
                            .foregroundColor(multiColors ? randomColor() : Color.white)
                    }
                }
                // Masking For Shimmer Effect...
                .mask(
                
                    Rectangle()
                        // For Some More Nice Effect Were Going to use Gradient...
                        .fill(
                        
                            // You can use any Color Here...
                            LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5),Color.white,Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                        )
                        .rotationEffect(.init(degrees: 70))
                        .padding(20)
                    // Moving View Continously...
                    // so it will create Shimmer Effect...
                        .offset(x: -250)
                        .offset(x: animation ? 500 : 0)
                    
                    .onAppear(perform: {
                    
                        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)){
                            
                            animation.toggle()
                        }
                    })
                )
            }
        }
        
        // Random Color....
        
        // It's Your Wish yOu can change anything here...
        // or you can also use Array of colors to pick random One....
        
        func randomColor()->Color{
            
            let color = UIColor(red: 1, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
            
            return Color(color)
        }
    }

                                  
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
            LogInView()
            SignUpView()
        }
    }

}

extension View {
    func multicolorGlow() -> some View {
        ZStack {
            ForEach(0..<2) { i in
                Rectangle()
                    .fill(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center))
                    .frame(width: 400, height: 300)
                    .mask(self.blur(radius: 20))
                    .overlay(self.blur(radius: 5 - CGFloat(i * 5)))
            }
        }
    }
}

