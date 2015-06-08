//
//  SecondViewController.swift
//  QQTransition
//
//  Created by 臧其龙 on 15/6/8.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UINavigationControllerDelegate {

    var interactivePopTransition:UIPercentDrivenInteractiveTransition?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var popGesture:UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handlePopGesture:")
        popGesture.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(popGesture)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if (self.navigationController?.delegate != nil){
            self.navigationController?.delegate = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var transition:ZQLTransition = ZQLTransition()
        transition.isReverse = true
        return transition
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactivePopTransition
    }
    
    func handlePopGesture(gesture:UIScreenEdgePanGestureRecognizer){
        var progress:CGFloat = gesture.translationInView(self.view).x / self.view.bounds.size.width
        
        if gesture.state == .Began{
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        if gesture.state == .Changed{
            interactivePopTransition?.updateInteractiveTransition(progress)
        }
        
        if gesture.state == .Ended || gesture.state == .Cancelled{
            if progress > 0.5{
                interactivePopTransition?.finishInteractiveTransition()
            }else
            {
                interactivePopTransition?.cancelInteractiveTransition()
            }
            
            interactivePopTransition = nil
        }
    }
    
    @IBAction func popToLast(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
