import SwiftUI
import PlaygroundSupport

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Welcome to My Playground!")
                            .font(Font.custom("HelveticaNeue-Bold", size: 38))
                            .padding(.bottom, 60)
                        
                        Text("In this app, you will experience what I feel about myself.")
                            .font(Font.custom("HelveticaNeue", size: 17))
                            .padding(.bottom)
                        
                        Text("There are 3 main buttons ready to be pressed and 1 hidden button to reset everything that you've done. The reset button will have the same colour as the background colour.")
                            .font(Font.custom("HelveticaNeue", size: 17))
                            .padding(.bottom)
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("Are you ready?")
                            .font(Font.custom("HelveticaNeue", size: 17))
                            .padding(.bottom)
                        
                        NavigationLink(destination: MainView()) {
                            Text("Go for it!")
                                .font(Font.custom("HelveticaNeue", size: 17))
                        }
                    }
                    .offset(y: -20)
                    
                    Spacer()
                    
                    Text("PS: Don't forget to tap the reset button, you’ll see something hidden!")
                        .font(Font.custom("HelveticaNeue", size: 13))
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct MainView: View {
    var colors: [Color] = [.red, .green, .blue, .white]
    @State var index: Int = 3
    @State var progress: CGFloat = 0.0
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Hello there!")
                            .font(Font.custom("HelveticaNeue-Bold", size: 38))
                        
                        Spacer()
                        
                        Button {
                            isPresented = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                        .sheet(isPresented: $isPresented) {
                            InfoView()
                        }
                    }
                    .padding(.bottom, 8)
                    
                    Text("Give it a try!")
                        .font(Font.custom("HelveticaNeue-Medium", size: 20))
                }
                .padding(.bottom)
                
                VStack {
                    Button {
                        self.index = 0
                    } label: {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 120, height: 120)
                            .padding()
                    }

                    Button {
                        self.index = 1
                    } label: {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 120, height: 120)
                            .padding()
                    }
                    
                    Button {
                        self.index = 2
                    } label: {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 120, height: 120)
                            .padding()
                    }
                    
                    Button {
                        self.index = 3
                    } label: {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 120, height: 120)
                            .padding()
                    }
                }
                
                Spacer()
                
                Text("WWDC21 © 2021 Rayhan Faluda")
                    .font(Font.custom("HelveticaNeue", size: 13))
            }
            .padding()
        }
        .background(SplashView(animationType: .circle, color: self.colors[self.index])
                        .aspectRatio(contentMode: .fill))
        .navigationBarHidden(true)
    }
}

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Close")
                        .font(Font.custom("HelveticaNeue", size: 17))
                }
                .padding(.bottom)
                
                Text("Welcome to the hidden menu!")
                    .font(Font.custom("HelveticaNeue-Bold", size: 38))
                    .padding(.bottom)
                
                Text("Oh, hi! You’ve finally found the hidden menu. Nothing fancy here. It’s just me, explaining the meaning of my app. You’re probably wondering, “what is this?”, “what does this mean?”, “just 3 colours, filling up the screen without any explanation, what??” Well, here comes the explanation!")
                    .font(Font.custom("HelveticaNeue", size: 17))
                    .padding(.bottom)

                Text("So, this is my very personal app, but maybe you can relate to this too. I created this app because I’m highly adaptive to my surroundings and I’m analogise myself as a chameleon. As you’re probably already know, chameleons adapt themselves to their surroundings by changing its colours.")
                    .font(Font.custom("HelveticaNeue", size: 17))
                    .padding(.bottom)

                Text("Why the button’s colour has different kind of colour? Well, I want to show that even though I’m able to adapt to my surroundings rather quickly, I still have my own colours that differentiate myself from my surroundings. I still have my own principal that can’t be changed.")
                    .font(Font.custom("HelveticaNeue", size: 17))
                    .padding(.bottom)

                Text("That’s it!")
                    .font(Font.custom("HelveticaNeue", size: 17))
                    .padding(.bottom)

                Text("Still confused? Please, please, read it again. 'Cause I don’t have anything left to say 😭.")
                    .font(Font.custom("HelveticaNeue", size: 17))
                    .padding(.bottom)
                
                Spacer()

                Text("Got any questions or suggestions? Reach me at")
                    .font(Font.custom("HelveticaNeue", size: 13))
                
                Button {
                    
                } label: {
                    Text("rayhanfaluda@gmail.com")
                        .font(Font.custom("HelveticaNeue", size: 13))
                }
                .padding(.bottom)
            }
            .padding()
        }
    }
}

PlaygroundPage.current.setLiveView(
    MainView()
        .frame(width: 600, height: 800)
        //provide a width and hight of your choice
)
PlaygroundPage.current.needsIndefiniteExecution = true
