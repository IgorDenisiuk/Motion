//
//  ContentView.swift
//  Motion
//
//  Created by Igor Denisiuk on 13.07.22.
//

import SwiftUI

struct ContentView: View {
    @State private var particleSystem = ParticleSystem()
    @State private var motionHandler = MotionManager()
    
    let options: [(flipX: Bool, flipY: Bool)] = [
        (false, false),
        (true, false),
        (false, true),
        (true, true)
    ]
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { contex, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                contex.blendMode = .plusLighter
                
                particleSystem.center = UnitPoint(x: 0.5 + motionHandler.roll, y: 0.5 + motionHandler.pitch)
                
                for particle in particleSystem.particles {
                    var contexCopy = contex
                    contexCopy.addFilter(.colorMultiply(Color(hue: particle.hue, saturation: 1, brightness: 1)))
                    contexCopy.opacity = 1 - (timelineDate - particle.creationDate)
                    
                    for option in options {
                        var xPos = particle.x * size.width
                        var yPos = particle.y * size.height
                        
                        if option.flipX {
                            xPos = size.width - xPos
                        }
                        
                        if option.flipY {
                            yPos = size.height - yPos
                        }
                        
                        contexCopy.draw(particleSystem.image, at: CGPoint(x: xPos, y: yPos))
                    }
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { drag in
                    particleSystem.center.x = drag.location.x / UIScreen.main.bounds.width
                    particleSystem.center.y = drag.location.y / UIScreen.main.bounds.height
                }
        )
        .ignoresSafeArea()
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
