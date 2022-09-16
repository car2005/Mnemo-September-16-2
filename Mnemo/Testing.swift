//
//  Testing.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import SwiftUI
import PhotosUI

struct Testing: View {
    
    @GestureState var press = false
    @State var show = false
    @State var shownews = false
    @State var showcalendar = false
    @State var showmedia = false
    @State var shownumbers = false
    @State var showcards = false
    @State var any = PHPickerConfiguration()
    @State var image: [UIImage] = []
    @State private var isPresented = false
    @State var intros: [Intro] =
    
    [Intro(title: "News", color: Color.purple)
     , Intro(title: "Carousel", color: Color.cyan),
     Intro(title: "Calendar", color: Color.yellow),
     Intro(title: "Media", color: Color.green),
     Intro(title: "Numbers game", color: Color.orange),
     Intro(title: "Memory cards", color: Color.pink)]
    
    @GestureState var isDragging: Bool = false
    @State var fakeIndex: Int = 0
    @State var currentIndex: Int = 0
    var body: some View {
        ZStack {
            ForEach(intros.indices.reversed(), id: \.self){index in
                IntroView(intro: intros[index])
                    .clipShape(LiquidShape(offset: intros[index].offset, curvePoint: currentIndex == index ? 50 : 0))
                    .padding(.trailing, fakeIndex == index ? 15 : 0)
                    .ignoresSafeArea()
            }
            HStack(spacing: 8) {
                ForEach(0..<intros.count - 2, id: \.self) {index in
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentIndex == index ? 1.15 : 0.85)
                        .opacity(currentIndex == index ? 1 : 0.25)
                }
                
                    .padding()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
        }
        .overlay(
            Button(action: {
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .updating($isDragging, body: { value, out, _ in
                                out = true
                            })
                            .onChanged({value in
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                                    intros[fakeIndex].offset = value.translation
                                }
                            })
                            .onEnded({value in
                                withAnimation(.spring()){
                                    
                                    if -intros[fakeIndex].offset.width > getRect().width / 2 {
                                        intros[fakeIndex].offset.width = -getRect().height * 1.5
                                        
                                        fakeIndex += 1
                                        
                                        if currentIndex == intros.count - 3 {
                                            currentIndex == 0
                                        }
                                        else {
                                            currentIndex += 1
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            
                                            if fakeIndex == (intros.count - 2) {
                                                for index in 0..<intros.count - 2{
                                                    intros[index].offset = .zero
                                                }
                                                fakeIndex = 0
                                        }
                                        }
                                    }
                                    else {
                                        
                                    }
                                    intros[fakeIndex].offset = .zero
                                }
                            })
                        )
            })
            .offset(y: 53)
            .opacity(isDragging ? 0 : 1)
            .animation(.linear, value: isDragging)
            
            , alignment: .topTrailing
        )
        .onAppear {
            guard let first = intros.first else {
                return
            }
            
            guard var last = intros.last else {
                return
            }
            
            last.offset.width = -getRect().height * 1.5
            
            intros.append(first)
            intros.insert(last, at: 0)
            
            fakeIndex = 1
        }
    }
    }
    
    @ViewBuilder
    func IntroView(intro: Intro) -> some View {
                        
        VStack {
                VStack(alignment: .leading, spacing: 0) {
                    if show {
                        CarouselButton()
                    }
                    if shownews {
                        NewsView()
                    }
                    if showcalendar {
                        CalendarView()
                        }
                    if showmedia {
                        ImagePicker(isShown: $show, image: $image)
                    }
                    if shownumbers {
                        ViewControllerView()
                    }
                    if showcards {
                        ViewController2View()
                    }
                        else {
                        Button(action: {
                            if currentIndex == 0 {
                                self.shownews = true
                            }
                            if currentIndex == 1 {
                                self.show = true
                            }
                            if currentIndex == 2 {
                                self.showcalendar = true
                            }
                            if currentIndex == 3 {
                                self.showmedia = true
                            }
                            if currentIndex == 4 {
                                self.shownumbers = true
                            }
                            if currentIndex == 5 {
                                self.showcards = true
                            }
                                else {
                                
                            }
                        } , label: {
                            Text(intro.title)
                                .font(.system(size: 45))
                                .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding([.trailing, .top])
                        })
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(intro.color).ignoresSafeArea()
    }

}

}

    struct LiquidShape: Shape {
        var offset: CGSize
        var curvePoint: CGFloat
        
        var animatableData: AnimatablePair<CGSize.AnimatableData,CGFloat> {
            get {return AnimatablePair(offset.animatableData, curvePoint)}
            set {offset.animatableData = newValue.first
                curvePoint = newValue.second
            }
        }
        
        func path(in rect: CGRect) -> Path {
            return Path{path in
                let width = rect.width + (-offset.width > 0 ? offset.width : 0)
                
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                
                let from = 90 + (offset.width)
                path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
                
                var to = 180 + (offset.height) + (-offset.width)
                to = to < 180 ? 180 : to
                
                let mid : CGFloat = 80 + ((to - 80) / 2)
                
                path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - curvePoint, y: mid), control2: CGPoint(x: width - curvePoint, y: mid))
            }
        }
    }

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

struct Testing_Previews: PreviewProvider {
        static var previews: some View{
            Testing()
        }
    }
