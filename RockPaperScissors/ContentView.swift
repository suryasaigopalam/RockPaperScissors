//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by surya sai on 03/01/24.
//

import SwiftUI

struct ContentView: View {
    var colors:[Color] = [.red,.green,.blue,.gray,.orange,.yellow]
    @State  var array = ["Rock 🪨", "Paper 📃", "Scissors ✂"].shuffled()
    @State var Message = ""
    @State var showScore:Bool = false
    @State var alertTitle = ""
    @State var score = 0
    @State var Turns = 0
    @State var userChoiceTurns:Int = 1
    @State var FinalScore = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue,.white,.green,.red], startPoint: .top, endPoint: .bottom)
            
            VStack {
                Text("RockPaperScissors")
                    .foregroundStyle(.green)
                    .padding()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                HStack {
                    Text("Score: \(score)")
                    Spacer()
                   Stepper("Turns \(userChoiceTurns)", value: $userChoiceTurns)
                    
                    }
              //  .padding(.trailing,100)
                    
                
                VStack(spacing:30) {
                    Text("Select Option")
                    ForEach(array,id:\.self) { item in
                        Button(action: {
                                ButtonPressed(item)
                            
                        }, label: {
                            Text("\(item)")
                                .foregroundStyle(.white)
                        })
                        .frame(width: 200)
                        .padding()
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .alert(alertTitle,isPresented: $showScore, actions: {
                
                    Button("Continue"){
                        
                        continuePressed()
                    }
                },message: {
                    
                Text(Message)
                    
                })
                .alert("Final Score", isPresented:$FinalScore , actions: {Button("Replay"){Replay()}},message: {
                    Text("Your Total Score: \(score)")
                })
                
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    func ButtonPressed(_ answer:String) {
        let randomPick = array.randomElement()
        if answer == randomPick {
            alertTitle = "Tie"
        }
        else if answer == "Rock 🪨" && randomPick == "Paper 📃" {
            alertTitle = "Lost"
        }
        else if answer == "Paper 📃" && randomPick == "Rock 🪨" {
            alertTitle = "Win"
        }
        else if answer == "Scissors ✂" && randomPick == "Rock 🪨" {
            alertTitle = "Lost"
        }
        else if answer == "Rock 🪨" && randomPick == "Scissors ✂" {
            alertTitle = "Win"
        }
        else if answer == "Scissors ✂" && randomPick == "Paper 📃" {
            alertTitle = "Win"
        }
        else {
            alertTitle = "Lost"
        }
        
        
        score += alertTitle == "Win" ? 1:0
        Message = """
        You got a \(alertTitle)
         Your Pick: \(answer) 🆚 Computer Pick: \(String(describing: randomPick))
       """
        showScore = true
        Turns += 1
    }
    func continuePressed() {
        if Turns >= userChoiceTurns {
            FinalScore = true
        }
        array.shuffle()
    }
    func Replay() {
            Turns = 0
            score = 0
        
    }
}

#Preview {
    ContentView()
}

