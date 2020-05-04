//
//  AboutPage.swift
//  BullsEye
//
//  Created by Adam S on 2020-03-17.
//  Copyright © 2020 Adam S. All rights reserved.
//

import SwiftUI

struct AboutPage: View {
    
    let biegeColor = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct HeaderStyler: ViewModifier{
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Bold", size: 30))
                .padding(.bottom, 20)
                .padding(.top, 20)
            
        }
    }
    
    struct InstructionStyler: ViewModifier{
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Bold", size: 16))
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        
        Group{
            VStack {
                Text("Bullseye Instructions 🎯").modifier(HeaderStyler())
                Text("For this game, you want to adjust the slider as close as you think to the target number!").modifier(InstructionStyler()).multilineTextAlignment(.center)
                Text("The closer you get to the actual value location, the more points you will earn!").modifier(InstructionStyler())
                Text("The largest award will be given if you get perfect, so good luck!").modifier(InstructionStyler())
                
            }.navigationBarTitle("About BullsEye")
                .background(biegeColor)
        }.background(Image("Background"))
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage().previewLayout(.fixed(width: 896, height: 414))
    }
}
