import SwiftUI
import UIKit
import MobileCoreServices

// MARK: - WelcomeView
public struct WelcomeView: View {
    @State private var isPresented: Bool = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Welcome to Chameleon Me! 🙌")
                        .font(Font.custom("Sora-SemiBold", size: 34))
                        .padding(.bottom, 60)
                    
                    Text("In this app, you will experience what I feel about myself.")
                        .font(Font.custom("Sora-Regular", size: 17))
                        .padding(.bottom)
                    
                    Text("There are 4 main buttons ready to be pressed and 1 hidden button to reset everything that you've done back to a pure, clean color. White.")
                        .font(Font.custom("Sora-Regular", size: 17))
                        .lineSpacing(2.5)
                        .padding(.bottom)
                }
                
                Spacer()
                
                Group {
                    Text("Are you ready?")
                        .font(Font.custom("Sora-Regular", size: 17))
                        .padding(.bottom)
                    
                    Button(action: {
                        // Fullscreen modal to MainView
                        isPresented = true
                    }, label: {
                        Text("Go for it! 😎")
                            .font(Font.custom("Sora-Regular", size: 17))
                    })
                    .fullScreenCover(isPresented: $isPresented, content: {
                        MainView()
                    })
                }
                .offset(y: -20)
                
                Spacer()
                
                Text("PS: Don't forget to tap the hidden button, you’ll see something hidden! 👀")
                    .font(Font.custom("Sora-Regular", size: 13))
            }
            .padding()
        }
        .environmentObject(IndexStore(activeIndex: 0))
    }
}


// MARK: - MainView
struct MainView: View {
    private var colors: [Color] = [Color.rgb(r: 230, g: 0, b: 0),
                                   Color.rgb(r: 0, g: 153, b: 0),
                                   Color.rgb(r: 0, g: 0, b: 255),
                                   Color.rgb(r: 230, g: 230, b: 0),
                                   .white]
    @State private var index: Int = 4
    @State private var progress: CGFloat = 0.0
    @State private var xPosition: CGFloat = 0.0
    @State private var yPosition: CGFloat = 0.0
    @State private var isPresented: Bool = false
    @State private var isShowingInfoButton: Bool = false
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Hello there!")
                                .font(Font.custom("Sora-SemiBold", size: 34))
                            
                            Spacer()
                            
                            if isShowingInfoButton {
                                Button {
                                    // Modal to InfoView
                                    isPresented = true
                                } label: {
                                    Image(systemName: "info.circle")
                                }
                                .sheet(isPresented: $isPresented) {
                                    InfoView()
                                }
                                .animation(.easeIn)
                            }
                        }
                        .padding(.bottom, 0)
                        
                        Text("Give it a try!")
                            .font(Font.custom("Sora-Medium", size: 20))
                    }
                    .padding(.bottom)
                    
                    VStack {
                        Button {
                            // Set color to red
                            self.index = 0
                        } label: {
                            Circle()
                                .fill(Color.red)
                                .shadow(radius: 5)
                                .frame(width: 120, height: 120)
                                .padding()
                        }

                        Button {
                            // Set color to green
                            self.index = 1
                        } label: {
                            Circle()
                                .fill(Color.green)
                                .shadow(radius: 5)
                                .frame(width: 120, height: 120)
                                .padding()
                        }
                        
                        Button {
                            // Set color to blue
                            self.index = 2
                        } label: {
                            Circle()
                                .fill(Color.blue)
                                .shadow(radius: 5)
                                .frame(width: 120, height: 120)
                                .padding()
                        }
                        
                        Button {
                            // Set color to yellow
                            self.index = 3
                        } label: {
                            Circle()
                                .fill(Color.yellow)
                                .shadow(radius: 5)
                                .frame(width: 120, height: 120)
                                .padding()
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Set color to white
                        index = 4
                        withAnimation {
                            // Show info button
                            isShowingInfoButton = true
                        }
                    }, label: {
                        Text("WWDC21 – Rayhan Martiza Faluda")
                            .font(Font.custom("Sora-Regular", size: 13))
                            .foregroundColor(.black)
                    })
                    .anchorPreference(key: ButtonAnchorPreferenceKey.self, value: .bounds, transform: { anchor in
                        ButtonAnchorData(anchor: anchor)
                    })
                    .onPreferenceChange(ButtonAnchorPreferenceKey.self, perform: { value in
                        self.xPosition = geometryProxy[value.anchor!].origin.x + 202
                        self.yPosition = geometryProxy[value.anchor!].origin.y + 8
                    }) // Set white color-fill animation starting position
                }
                .padding()
            }
            .background(SplashView(index: index, position: CGPoint(x: xPosition, y: yPosition), color: self.colors[self.index])
                            .aspectRatio(contentMode: .fill)) // Color-fill animation
            .ignoresSafeArea()
        }
    }
}


// MARK: - InfoView
struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var activeIndex: IndexStore
    
    init() {
        //Use this if NavigationBarTitle is with displaymode = .large
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Sora-SemiBold", size: 34)!]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Sora-SemiBold", size: 17)!]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        InfoDescView(label: "Oh, hi 👋! You’ve finally found the hidden menu. Nothing fancy here. It’s just me, explaining the meaning of my playground. You’re probably wondering 🤔, “what is this?”, “what does this mean?”, “just 4 colors, filling up the screen without any explanation, what??” Well, here comes the explanation!", index: 0)
                        
                        InfoDescView(label: "So, this is my very personal playground, but maybe you can relate to this too. I created this playground because I’m highly adaptive to my surroundings and I analogise myself as a chameleon. As you’re probably already know, chameleons adapt themselves to their surroundings by changing its colors.", index: 1)
                        
                        InfoDescView(label: "Why the button’s color has different kind of color? Well, I want to show that even though I’m able to adapt to my surroundings rather quickly, I still have my own colors that differentiate myself from my surroundings. I still have my own principle that can’t be changed. And everytime you tap on the not-so-hidden-anymore reset button after mixing 2 colors, you can see a flash of the last tapped color in it's original color. This shows that even though my original colors have been mixed over the course of my life, becoming secondary or even tertiary colors, I'm still keeping my original colors. I'm still who I am at the core. There's one more thing. Sometimes, the 'color-fill' animation isn't smooth. This shows that life isn't always smooth like we want it to be. And that's the art of life.", index: 2)
                        
                        InfoDescView(label: "A smooth sea never made a skilled sailor ⛵️.", index: 3)
                        
                        InfoDescView(label: "I hope you enjoy my playground and satisfied with the color mixing. Oh, and I wish I can win this year's Swift Student Challenge 😉🤲.", index: 4)
                        
                        Spacer()

                        InfoContactView(label: "Got any questions or suggestions? Or maybe want to inform that I win this year's Swift Student Challenge 😁? Reach me at", index: 5)
                            .padding(.top, 48)
                        
                        Button {
                            UIPasteboard.general.setValue("rayhanfaluda@gmail.com", forPasteboardType: kUTTypePlainText as String)
                            print("Text copied to Clipboard")
                        } label: {
                            InfoContactView(label: "rayhanfaluda@gmail.com", index: 5)
                        }
                        .hidden(activeIndex.activeIndex < 6)
                    }
                    .padding()
                    .overlayPreferenceValue(TextPreferenceKey.self) { preferences in
                        GeometryReader { geometry in
                            // Create overlay button based on InfoDescView index and position
                            self.createButton(geometry, preferences)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Welcome to the hidden menu!"))
            .navigationBarItems(leading: Button {
                // Dismiss modal back to MainView
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Close")
                    .font(Font.custom("Sora-Regular", size: 17))
            })
        }
    }
    
    func createButton(_ geometry: GeometryProxy, _ preferences: [TextPreferenceData]) -> some View {
        let p = preferences.first(where: { $0.viewIndex == self.activeIndex.activeIndex })
        let bounds = p != nil ? geometry[p!.bounds] : .zero
        
        return Button(action: {
            withAnimation(.easeIn(duration: 1.0)) {
                activeIndex.activeIndex += 1
            }
        }, label: {
            ZStack {
                Capsule()
                    .frame(width: 88, height: 44)
                    .foregroundColor(.blue)
                
                Group {
                    if activeIndex.activeIndex == 0 {
                        Text("Start")
                    } else if activeIndex.activeIndex > 0 && activeIndex.activeIndex < 5 {
                        Text("Next")
                    } else {
                        Text("Finish")
                    }
                }
                .font(Font.custom("Sora-Regular", size: 17))
                .foregroundColor(.white)
            }
        })
        .frame(width: 600, height: bounds.size.height) // Set button position based on current InfoDescView index and position
        .offset(y: bounds.minY)
        .hidden(withAnimation(.easeOut(duration: 1.0), {
            activeIndex.activeIndex == 6
        }))
    }
}


// MARK: - InfoDescView
struct InfoDescView: View {
    @EnvironmentObject var activeInfoDesc: IndexStore
    let label: String
    let index: Int
    
    var body: some View {
        Text(label)
            .font(Font.custom("Sora-Regular", size: 17))
            .lineSpacing(2.5)
            .padding(.bottom)
            .hidden(activeInfoDesc.activeIndex <= index)
            .anchorPreference(key: TextPreferenceKey.self, value: .bounds, transform: { anchor in
                [TextPreferenceData(viewIndex: self.index, bounds: anchor)]
            })
    }
}


// MARK: - InfoContactView
struct InfoContactView: View {
    @EnvironmentObject var activeInfoDesc: IndexStore
    let label: String
    let index: Int
    
    var body: some View {
        Text(label)
            .font(Font.custom("Sora-Regular", size: 13))
            .hidden(activeInfoDesc.activeIndex <= index)
            .anchorPreference(key: TextPreferenceKey.self, value: .bounds, transform: { anchor in
                [TextPreferenceData(viewIndex: self.index, bounds: anchor)]
            })
    }
}


// MARK: - SplashShape
struct SplashShape: Shape {

    enum SplashAnimation {
        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
        case angle(Angle)
        case circle(CGPoint)
    }

    var progress: CGFloat
    var animationType: SplashAnimation

    var animatableData: CGFloat {
        get { return progress }
        set { self.progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        switch animationType {
        case .leftToRight:
            return leftToRight(rect: rect)

        case .rightToLeft:
            return rightToLeft(rect: rect)
            
        case .topToBottom:
            return topToBottom(rect: rect)
        
        case .bottomToTop:
            return bottomToTop(rect: rect)
        
        case .angle(let splashAngle):
            return angle(rect: rect, angle: splashAngle)
        
        case .circle(let point):
            return circle(rect: rect, point: point)
        }
    }

    func leftToRight(rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0)) // Top Left
        path.addLine(to: CGPoint(x: rect.width * progress, y: 0)) // Top Right
        path.addLine(to: CGPoint(x: rect.width * progress, y: rect.height)) // Bottom Right
        path.addLine(to: CGPoint(x: 0, y: rect.height)) // Bottom Left
        path.closeSubpath() // Close The Path
        return path
    }

    func rightToLeft(rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width, y: 0)) // Top Right
        path.addLine(to: CGPoint(x: rect.width - (rect.width * progress), y: 0)) // Top Left
        path.addLine(to: CGPoint(x: rect.width - (rect.width * progress), y: rect.height)) // Bottom Left
        path.addLine(to: CGPoint(x: rect.width, y: rect.height)) // Bottom Right
        path.closeSubpath()
        return path
    }
    
    func topToBottom(rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * progress))
        path.addLine(to: CGPoint(x: 0, y: rect.height * progress))
        path.closeSubpath()
        return path
    }
    
    func bottomToTop(rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - (rect.height * progress)))
        path.addLine(to: CGPoint(x: 0, y: rect.height - (rect.height * progress)))
        path.closeSubpath()
        return path
    }
    
    func circle(rect: CGRect, point: CGPoint) -> Path {
        let a: CGFloat = rect.height / 2.0
        let b: CGFloat = rect.width / 2.0
        
        let c = pow(pow(a, 2) + pow(b, 2), 0.5) // a^2 + b^2 = c^2 --> Solved for 'c'
        // c = radius of final circle
        
        let radius = c * progress
        let fullViewValue = radius * 2
        
        // Build Circle Path
        var path = Path()
        path.addArc(center: point, radius: fullViewValue, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        return path
    }
    
    func angle(rect: CGRect, angle: Angle) -> Path {
        let cAngle = Angle(degrees: angle.degrees.truncatingRemainder(dividingBy: 90))
        
        // Return Path Using Other Animations (topToBottom, leftToRight, etc) if angle is 0, 90, 180, 270
        if angle.degrees == 0 || cAngle.degrees == 0 { return leftToRight(rect: rect)}
        else if angle.degrees == 90 || cAngle.degrees == 90 { return topToBottom(rect: rect)}
        else if angle.degrees == 180 || cAngle.degrees == 180 { return rightToLeft(rect: rect)}
        else if angle.degrees == 270 || cAngle.degrees == 270 { return bottomToTop(rect: rect)}
        
        
        // Calculate Slope of Line and inverse slope
        let m = CGFloat(tan(cAngle.radians))
        let m_1 = pow(m, -1) * -1
        let h = rect.height
        let w = rect.width
        
        // tan (angle) = slope of line
        // y = mx + b ---> b = y - mx   ~ 'b' = y intercept
        let b = h - (m_1 * w) // b = y - (m * x)
        
        // X and Y coordinate calculation
        var x = b * m * progress
        var y = b * progress
        
        // Triangle Offset Calculation
        let xOffset = (angle.degrees > 90 && angle.degrees < 270) ? rect.width : 0
        let yOffset = (angle.degrees > 180 && angle.degrees < 360) ? rect.height : 0
        
        // Modify which side the triangle is drawn from depending on the angle
        if angle.degrees > 90 && angle.degrees < 180 { x *= -1 }
        else if angle.degrees > 180 && angle.degrees < 270 { x *= -1; y *= -1 }
        else if angle.degrees > 270 && angle.degrees < 360 { y *= -1 }
        
        // Build Triangle Path
        var path = Path()
        path.move(to: CGPoint(x: xOffset, y: yOffset))
        path.addLine(to: CGPoint(x: xOffset + x, y: yOffset))
        path.addLine(to: CGPoint(x: xOffset, y: yOffset + y))
        path.closeSubpath()
        return path
    }
}


// MARK: - SplashView
struct SplashView: View {
    var animationType: SplashShape.SplashAnimation
    var position: CGPoint
    @State private var prevColor: Color // Stores background color
    @ObservedObject var colorStore: ColorStore // Send new color updates
    @State var layers: [(Color, CGFloat)] = [] // New Color and Progress

    init(index: Int, position: CGPoint, color: Color) {
        switch index {
        case 0:
            self.animationType = .leftToRight
            
        case 1:
            self.animationType = .rightToLeft
            
        case 2:
            self.animationType = .angle(Angle(degrees: 45))
            
        case 3:
            self.animationType = .angle(Angle(degrees: 225))
            
        case 4:
            self.animationType = .circle(position)
            
        default:
            self.animationType = .leftToRight
        }
        
        self.position = position
        self._prevColor = State<Color>(initialValue: color)
        self.colorStore = ColorStore(color: color)
    }

    var body: some View {
        Rectangle()
            .foregroundColor(self.prevColor) // Current Color
            .overlay(
                ZStack {
                    ForEach(layers.indices, id: \.self) { x in
                        if x > 0 && self.layers[self.layers.count - 1].0 != Color.white {
                            SplashShape(progress: self.layers[x].1, animationType: self.animationType)
                                .foregroundColor(DynamicColor(self.layers[x].0).mixed(withColor: DynamicColor(self.layers[x - 1].0)).toColor())
                        } else if self.layers[self.layers.count - 1].0 == Color.white {
                            SplashShape(progress: self.layers[x].1, animationType: self.animationType)
                                .foregroundColor(self.layers[x].0)
                        }
                    }
                }, alignment: .leading)
            .onReceive(self.colorStore.$color) { color in
                // Animate Color Update Here
                self.layers.append((color, 0))
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.layers[self.layers.count - 1].1 = 1.0
                    if self.layers.count > 1 && self.layers[self.layers.count - 1].0 == .white {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.prevColor = self.layers[self.layers.count - 1].0 // Finalizes background color of SplashView
                            self.layers.removeFirst(self.layers.count - 1) // Removes itself from layers array
                        }
                    }
                }
            }
    }
}


// MARK: - ButtonAnchorData
struct ButtonAnchorData: Equatable {
    var anchor: Anchor<CGRect>? = nil
    static func == (lhs: ButtonAnchorData, rhs: ButtonAnchorData) -> Bool {
        return false
    }
}


// MARK: - ButtonAnchorPreferenceKey
struct ButtonAnchorPreferenceKey: PreferenceKey {
    static let defaultValue = ButtonAnchorData()
    static func reduce(value: inout ButtonAnchorData, nextValue: () -> ButtonAnchorData) {
        value.anchor = nextValue().anchor ?? value.anchor
    }
}


// MARK: - TextPreferenceData
struct TextPreferenceData {
    let viewIndex: Int
    let bounds: Anchor<CGRect>
}


// MARK: - TextPreferenceKey
struct TextPreferenceKey: PreferenceKey {
    typealias Value = [TextPreferenceData]
    
    static var defaultValue: [TextPreferenceData] = []
    static func reduce(value: inout [TextPreferenceData], nextValue: () -> [TextPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}


// MARK: - IndexStore Class
class IndexStore: ObservableObject {
    @Published var activeIndex: Int
    
    init(activeIndex: Int) {
        self.activeIndex = activeIndex
    }
}


// MARK: - ColorStore Class
class ColorStore: ObservableObject {
    @Published var color: Color
    
    init(color: Color) {
        self.color = color
    }
}


// MARK: - Custom Color Function
extension Color {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> Color {
        let color = Color.init(UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1))
        return color
    }
}


// MARK: - Custom Hidden Function
extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}


// MARK: - Dynamic Color
public typealias DynamicColor = UIColor

public extension DynamicColor {
    // MARK: Mixing Colors
    /**
     Mixes the given color object with the receiver.
     Specifically, takes the average of each of the RGB components, optionally weighted by the given percentage.
     - Parameter color: A color object to mix with the receiver.
     - Parameter weight: The weight specifies the amount of the given color object (between 0 and 1).
     The default value is 0.5, which means that half the given color and half the receiver color object should be used.
     0.25 means that a quarter of the given color object and three quarters of the receiver color object should be used.
     - Parameter colorspace: The color space used to mix the colors. By default it uses the RBG color space.
     - Returns: A color object corresponding to the two colors object mixed together.
     */
    final func mixed(withColor color: DynamicColor, weight: CGFloat = 0.5, inColorSpace colorspace: DynamicColorSpace = .rgb) -> DynamicColor {
        let normalizedWeight = clip(weight, 0.0, 1.0)
        
        switch colorspace {
        case .rgb:
            return mixedRGB(withColor: color, weight: normalizedWeight)
        }
    }
    
    func mixedRGB(withColor color: DynamicColor, weight: CGFloat) -> DynamicColor {
        let c1 = toRGBAComponents()
        let c2 = color.toRGBAComponents()
        
        let red   = c1.r + (weight * (c2.r - c1.r))
        let green = c1.g + (weight * (c2.g - c1.g))
        let blue  = c1.b + (weight * (c2.b - c1.b))
        let alpha = alphaComponent + (weight * (color.alphaComponent - alphaComponent))
        
        return DynamicColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    // MARK: RGBA Color Space
    /**
     Initializes and returns a color object using the specified opacity and RGB component values.
     Notes that values out of range are clipped.
     - Parameter r: The red component of the color object, specified as a value from 0.0 to 255.0.
     - Parameter g: The green component of the color object, specified as a value from 0.0 to 255.0.
     - Parameter b: The blue component of the color object, specified as a value from 0.0 to 255.0.
     - Parameter a: The opacity value of the color object, specified as a value from 0.0 to 255.0. The default value is 255.
     */
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 255) {
        self.init(red: clip(r, 0, 255) / 255, green: clip(g, 0, 255) / 255, blue: clip(b, 0, 255) / 255, alpha: clip(a, 0, 255) / 255)
    }
    
    // MARK: - Getting the RGBA Components
    /**
     Returns the RGBA (red, green, blue, alpha) components.
     - returns: The RGBA components as a tuple (r, g, b, a).
     */
    final func toRGBAComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (r, g, b, a)
    }
    
    /**
     The red component as CGFloat between 0.0 to 1.0.
     */
    final var redComponent: CGFloat {
        return toRGBAComponents().r
    }
    
    /**
     The green component as CGFloat between 0.0 to 1.0.
     */
    final var greenComponent: CGFloat {
        return toRGBAComponents().g
    }
    
    /**
     The blue component as CGFloat between 0.0 to 1.0.
     */
    final var blueComponent: CGFloat {
        return toRGBAComponents().b
    }
    
    /**
     The alpha component as CGFloat between 0.0 to 1.0.
     */
    final var alphaComponent: CGFloat {
        return toRGBAComponents().a
    }
    
    
    // MARK: - Setting the RGBA Components
    /**
     Creates and returns a color object with the alpha increased by the given amount.
     - parameter amount: CGFloat between 0.0 and 1.0.
     - returns: A color object with its alpha channel modified.
     */
    final func adjustedAlpha(amount: CGFloat) -> DynamicColor {
        let components      = toRGBAComponents()
        let normalizedAlpha = clip(components.a + amount, 0.0, 1.0)
        
        return DynamicColor(red: components.r, green: components.g, blue: components.b, alpha: normalizedAlpha)
    }
    
    
    // MARK: - Convert a DynamicColor to a SwiftUI color
    /**
     Returns the Color from  an Dynamic Color.
     
     - returns: A Color (SwiftUI).
     */
    func toColor() -> Color {
        return Color(self)
    }
}

/**
 Defines the supported color spaces.
 */
public enum DynamicColorSpace {
    /// The RGB color space
    case rgb
}

/**
 Clips the values in an interval.
 Given an interval, values outside the interval are clipped to the interval
 edges. For example, if an interval of [0, 1] is specified, values smaller than
 0 become 0, and values larger than 1 become 1.
 - Parameter v: The value to clipped.
 - Parameter minimum: The minimum edge value.
 - Parameter maximum: The maximum edgevalue.
 */
internal func clip<T: Comparable>(_ v: T, _ minimum: T, _ maximum: T) -> T {
    return max(min(v, maximum), minimum)
}
