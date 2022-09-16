//
//  CarouselViewController.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import UIKit
import iCarousel
import SwiftUI
import PhotosUI
import AVFoundation
import FirebaseStorage

class CarouselViewController: UIViewController, iCarouselDataSource {
    
    @State var image: [UIImage] = []
    @State var show = false
    
    let myCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .coverFlow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myCarousel)
        myCarousel.dataSource = self
        
        myCarousel.frame = CGRect(x: 0, y: 200,
                                  width: view.frame.size.width,
                                  height: 400)
        playSound()
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return image.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/1.4, height: 300))
        let newimage = Coordinator.init(phot1: ImagePicker(isShown: $show, image: $image)).phot.image[image.count]
        view.backgroundColor = .black
        
            let imageview = UIImageView(frame: view.bounds)
            view.addSubview(imageview)
            imageview.contentMode = .scaleAspectFit
            imageview.image = newimage
            return view
    }
    
    func completecarousel() {
        var assets = image.count
        for _ in image {
            assets -= 1
        }
    }
    
}
