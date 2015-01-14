//
//  ViewController.swift
//  Udemy12 Images
//
//  Created by Pei Sun on 2015-01-01.
//  Copyright (c) 2015 psun. All rights reserved.
//
//  A character walks across a screen.
//  Click "walk faster!" to display the next 
//  image in an animation of the walking character.
//  Portrait mode only.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var creature: UIImageView!
    
    var animationArray: [UIImage] = [] //***1
    var timer = NSTimer()
    
    var frame = 0
    var position: CGFloat = 0.0
    
    var screenWidth = UIScreen.mainScreen().applicationFrame.size.width;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
        
        //***2---------- Place all .pngs in an array
        for i in 1...16 {
            animationArray.append(UIImage(named: "walk\(i).png")!)
        }
        //***2----------
        
        //timer runs displayWalk() every 0.07 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(0.07, target: self, selector: Selector("displayWalk"), userInfo: nil, repeats: true)
        println("viewDidLoad")

    }
    
    // -----------------
    // Upon loading of app,
    // creature moves from top to center
    // fades in from being completely transparent
    // goes from small to big and also moves from point A to B using CGRectMake(x, y, width, height)
        //(these 2 lines don't do anything since the 1st lines are in use),
        //so 3rd lines are commented out.
    
    // viewDidLayoutSubview is before view is displayed on screen (i.e. Before viewDidAppear)
    
    //CREATURE BEFORE
    override func viewDidLayoutSubviews() {
        creature.center = CGPointMake(creature.center.x, creature.center.y-300)
        creature.alpha = 0
        //creature.frame = CGRectMake(200, 10, 0, 0)
        println("viewDidLayoutSubviews")
    }
    
    //CREATURE AFTER
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(3, animations:{
            self.creature.center = CGPointMake(self.creature.center.x, self.creature.center.y+300)
            self.creature.alpha = 1
            //self.creature.frame = CGRectMake(10, 50, 300, 300)
        })
        println("viewDidAppear")
    }
    // -----------------
    
    //The "walk faster!" button updates the image
    @IBAction func updateButton(sender: AnyObject) {
        displayWalk()
    }
    
    //displayWalk() is called every 0.07 of a second, and also by each press of the button
    func displayWalk() {
        
        UIView.animateWithDuration(0.1, animations:{
            
            //***3----- Access the frames of UIImages from an array
            //Since we're using animationArray.append, we count from 0...15 of the array
            //We start from 0 b/c we get an error if we assign animationArray[1]
            //  without putting anything in animationArray[0] first
            self.frame = (self.frame + 1) % 16 //0 to 15
            self.creature.image = self.animationArray[self.frame]
            //***3------
            
            //move creature 7 pixels to the right
            self.creature.center = CGPointMake(self.creature.center.x+7, self.creature.center.y)
            
        })
        
        //if creature walks off screen, reset the creature's x position to -25
        if creature.center.x > screenWidth+30 {
            creature.center = CGPointMake(-25, creature.center.y)
        }

        //-----
        //A less-code-way-to-display-image creates a new image each time the view is refreshed.
        //However if we place all the images in an array first, like in the 3 sections marked with *** used here, it'll use 2% less CPU!!
        //        creature.image = UIImage(named: "walkLayer-\(frame+1).png")
        //-----
        
        //---- learning how to format ---
        ///If your images are named with 3 digit numbers, i.e. 001, 002, 011, 035, etc... do
        //        let newFrame = String(format: "%03d", frame)
        //        println("newFrame: \(newFrame)")
        //-------------------------------
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//About colours
// http://makeapppie.com/2014/10/02/swift-swift-using-color-and-uicolor-in-swift-part-1-rgb/

//gif from
//http://giphy.com/gifs/animation-animated-gif-B7iLARxSBCH96