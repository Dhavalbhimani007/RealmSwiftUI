//
//  LottieAnimationView.swift
//  RealmSwiftUI
//
//  Created by DREAMWORLD on 19/04/24.
//

import SwiftUI
import Lottie

struct LAnimationView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .loop
    
    var animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LAnimationView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LAnimationView>) {
        animationView.play()
    }
}
