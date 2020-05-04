//
//  ContentView.swift
//  BullsEye
//
//  Created by Adam S on 2020-03-16.
//  Copyright © 2020 Adam S. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    //Declare variables
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var roundTotal = 1
    
    
    //Styler for Score, Round, And Insutrction
    struct LabelStyler: ViewModifier{
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.white)
                .font(.custom("Arial Bold", size: 18))
                .shadow(color: .black, radius: 4, x: 2, y: 2)
            
        }
    }
    
    //Number Styler
    struct ValueStyler: ViewModifier{
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.yellow)
                .font(.custom("Arial Bold", size: 22))
                .shadow(color: .black, radius: 4, x: 2, y: 2)
        }
    }
    
    
    //this is a closure
    var body: some View {
        
        //create object called Vertical Stack
        VStack {
            Spacer()
            HStack {
                Text("Put the Bullseye as close as you can to:").modifier(LabelStyler())
                Text("\(self.targetValue)").modifier(ValueStyler())
            }
            Spacer()
            
            HStack {
                Text("1").modifier(LabelStyler())
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100").modifier(LabelStyler())
            }
            Spacer()
            
            
            Button(action: {
                self.alertIsVisible = true
                self.roundTotal += 1
            }) {
                Text("Hit Me")
            }
                //this is a closure and an anonymous function
                .alert(isPresented: $alertIsVisible) { () -> Alert in
                    
                    //a lot of this is new and doesnt make sense
                    return Alert(title: Text(alertTitle()), message: Text("The slider value is: \(sliderRoundedValue()) \n" +
                        "You scored: \(calculateScore())"), dismissButton: .default(Text("Click me to leave")){
                            self.totalScore += self.calculateScore()
                            self.targetValue = Int.random(in: 1...100)//this has to go here and in this order!!
                        })
            }
                .background(Image("Button")) //check this out
            
            
            Spacer()
            
            HStack{
                Button(action: {
                    self.startOver()
                }) {
                    
                    HStack{
                        Image("StartOverIcon")
                        Text("Start Over").font(.custom("Arial", size: 14))
                    }
                }.background(Image("Button")) 
                
                Spacer()
                
                Text("Score:").modifier(LabelStyler())
                Text("\(self.totalScore)").modifier(ValueStyler())
                
                Spacer()
                
                Text("Round:").modifier(LabelStyler())
                Text("\(self.roundTotal)").modifier(ValueStyler())
                
                Spacer()
                
            
                NavigationLink (destination: AboutPage()){
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                    }
                }.background(Image("Button")) //make this more efficient
        }.padding(.bottom, 20)
    }.background(Image("Background"), alignment: .center)
    .accentColor(.blue)
    .navigationBarTitle("BullsEye 🎯")
}


//this works because the target value is set at the beginning and the sliderRounded value can be found
//based on the state variable which changes upon user input
func alertTitle() -> String{
    let difference = abs(targetValue - sliderRoundedValue())
    let title: String
    if (difference == 0){
        title = "Perfect!"
    } else if (difference < 5){
        title = "So close!"
    } else if (difference <= 10){
        title = "Nice job!"
    } else {
        title = "Are you even trying?"
    }
    return title
    
}

//return rounded slider value
func sliderRoundedValue() -> Int{
    return Int(self.sliderValue.rounded())
}

//Function to calculate score
func calculateScore() -> Int {
    let maximumScore = 100
    let difference = abs(targetValue - sliderRoundedValue())
    let bonus: Int
    if difference == 0 {
        bonus = 100
    } else if difference == 1{
        bonus = 50
    } else {
        bonus = 0
    }
    return maximumScore - difference + bonus
}
    
    //Function to reset values
    func startOver() -> () {
        self.alertIsVisible = false
        self.roundTotal = 1
        self.totalScore = 0
        self.sliderValue = 50.0
        self.targetValue = Int.random(in: 1...100)
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
}
