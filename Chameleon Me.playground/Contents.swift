import PlaygroundSupport
import SwiftUI

let soraBold = Bundle.main.url(forResource: "Sora-Bold", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(soraBold, CTFontManagerScope.process, nil)

let soraLight = Bundle.main.url(forResource: "Sora-Light", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(soraLight, CTFontManagerScope.process, nil)

let soraMedium = Bundle.main.url(forResource: "Sora-Medium", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(soraMedium, CTFontManagerScope.process, nil)

let soraRegular = Bundle.main.url(forResource: "Sora-Regular", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(soraRegular, CTFontManagerScope.process, nil)

let soraSemiBold = Bundle.main.url(forResource: "Sora-SemiBold", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(soraSemiBold, CTFontManagerScope.process, nil)

PlaygroundPage.current.setLiveView(
    WelcomeView()
        .frame(width: 600, height: 800) // provide a custom width and height
)
PlaygroundPage.current.needsIndefiniteExecution = true
