//
//  AdaptiveUI.swift
//  HappyTrack
//
//  Created by Martin Weber on 28.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchKit

class AdaptivUI{
    public static let shared = AdaptivUI()
    
    private let defaultIconButtonSize = 34
    private let maxIconButtonSize = 45
    private let buttonChangeSize = 4
    
    private let pulsChangeView = 90
    
    private let seceondToTimeout = 5.0
    
    private let colorGreen =  UIColor.init(red: 56.0/255.0, green: 190.0/255.0, blue: 55.0/255.0, alpha: 1.0)
    private let colorBlue = UIColor.init(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)
    private let colorOrange = UIColor.init(red: 225.0/255.0, green: 152.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    private var currentIconButtonSize: Int
    private var actionAfterTap: Bool
    
    private var currentAdaptiveUIState: AdaptiveState!
    
    private var listIconButtons = [WKInterfaceObject]()
    private var listGroupQuestions = [WKInterfaceObject]()
    private var listGroupIcons = [WKInterfaceObject]()
    private var listGroupListButtos = [WKInterfaceObject]()
    
    private var timeout:DispatchWorkItem!
    
    private var trackInterface: WKInterfaceController!
    
    public init(){
        self.currentIconButtonSize = defaultIconButtonSize
        self.actionAfterTap = false
    }
    
    public func startTrack(trackInterface: WKInterfaceController){
        self.trackInterface = trackInterface
        
        currentAdaptiveUIState = NeutraleState()
        
        timeout = DispatchWorkItem(block: {
             self.currentAdaptiveUIState = self.currentAdaptiveUIState.noFeedback(adaptiveUI: self)
        })
        
        self.showNormal()
        self.restStartTimeoutTimer()
    }
    
    public func tapOnView(){
        DispatchQueue.init(label: "TAPVIEW").asyncAfter(wallDeadline: .now() + .milliseconds(50)) {
            if !(self.actionAfterTap){
                self.currentAdaptiveUIState = self.currentAdaptiveUIState.tapMiss(adaptiveUI: self)
            }else{
                self.actionAfterTap = false
            }
        }
    }
    
    public func tapWithAction(){
        actionAfterTap = true
        self.restStartTimeoutTimer()
        self.currentAdaptiveUIState = self.currentAdaptiveUIState.tapHit(adaptiveUI: self)
    }
    
    public func tapWithActionBack(){
        actionAfterTap = true
        self.restStartTimeoutTimer()
        self.currentAdaptiveUIState = self.currentAdaptiveUIState.tapBack(adaptiveUI: self)
    }
    
    public func newHeartRate(puls: Int){
        if(puls > self.pulsChangeView){
            self.currentAdaptiveUIState = self.currentAdaptiveUIState.highPuls(adaptiveUI: self)
        }else{
            self.currentAdaptiveUIState = self.currentAdaptiveUIState.normalPuls(adaptiveUI: self)
        }
    }
    
    public func trackConfused(){
        trackInterface.presentController(withName: "Confused_View", context: nil)
        self.setBackgroundColor(color: colorGreen)
        
        self.openModalOnTrack()
    }
    public func trackUnhappyOrSad(){
        trackInterface.presentController(withName: "Sad_View", context: nil)
        self.setBackgroundColor(color: colorOrange)
        
        self.openModalOnTrack()
    }
    public func trackAnger(){
        trackInterface.presentController(withName: "Mad_View", context: nil)
        self.setBackgroundColor(color: colorBlue)
        
        self.openModalOnTrack()
    }
    public func openModalOnTrack(){
        timeout.cancel()
    }
    public func closeModalOnTrack(){
        restStartTimeoutTimer()
    }
    public func addGroupQuestion(group: WKInterfaceGroup){
        self.addItemToList(list: &self.listGroupQuestions, item: group)
    }
    public func addGroupIcon(group: WKInterfaceGroup){
        self.addItemToList(list: &self.listGroupIcons, item: group)
    }
    public func addGroupList(group: WKInterfaceGroup){
        self.addItemToList(list: &self.listGroupListButtos, item: group)
    }
    public func removeGroupQuestion(group: WKInterfaceGroup){
        self.removeItemFromList(list: &self.listGroupQuestions, item: group)
    }
    public func removeGroupIcon(group: WKInterfaceGroup){
        self.removeItemFromList(list: &self.listGroupIcons, item: group)
    }
    public func removeGroupList(group: WKInterfaceGroup){
        self.removeItemFromList(list: &self.listGroupListButtos, item: group)
    }
    
    public func addIconButton(button :WKInterfaceObject){
        self.addItemToList(list: &self.listIconButtons, item: button)
        button.setWidth(CGFloat(currentIconButtonSize))
        button.setHeight(CGFloat(currentIconButtonSize))
    }
    
    public func removeIconButton(button: WKInterfaceObject){
        self.removeItemFromList(list: &self.listIconButtons, item: button)
    }
    
    
    public func increaseButtonSize(){
        print("increase Button Size")
        if(self.currentIconButtonSize + self.buttonChangeSize > self.maxIconButtonSize){
            self.currentIconButtonSize = self.maxIconButtonSize
            
        }else{
            self.currentIconButtonSize = self.currentIconButtonSize + self.buttonChangeSize
        }
        setIconButtonsSize(size: CGFloat(currentIconButtonSize))
    }
    
    public func decreaseButtonSize(){
        print("decrease Button size")
        if(self.currentIconButtonSize - self.buttonChangeSize < self.defaultIconButtonSize){
            self.currentIconButtonSize = self.defaultIconButtonSize
        }else{
            self.currentIconButtonSize = self.currentIconButtonSize - self.buttonChangeSize
        }
        setIconButtonsSize(size: CGFloat(currentIconButtonSize))
    }
    
    public func noFeedback(){
        print("noFeedBack - SHOW LIST")
        self.hideGroupIcons()
        self.showGroupListButtons()
    }
    
    public func showNormal(){
        print("showNormal - Show ICONS WITH CURRENT SIZE")
        self.hideGroupListButtons()
        self.showGroupIcons()
        setIconButtonsSize(size: CGFloat(currentIconButtonSize))
    }
    
    public func doingSport(){
        print("doingSport - SHOW LIST")
        self.hideGroupIcons()
        self.showGroupListButtons()
    }
    private func restStartTimeoutTimer(){
        timeout.cancel()
        
        //FEATURE ON SWIFT, will cancel all pending DispatchWorkItem events and prevent future.. so init every time new on
        timeout = DispatchWorkItem(block: { 
            self.currentAdaptiveUIState = self.currentAdaptiveUIState.noFeedback(adaptiveUI: self)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + self.seceondToTimeout, execute: timeout)
    }
    private func addItemToList(list: inout [WKInterfaceObject], item: WKInterfaceObject){
        list.append(item)
    }
    private func removeItemFromList(list: inout [WKInterfaceObject], item: WKInterfaceObject){
        for i in list.indices {
            if list[i] === item{
                list.remove(at: i)
                return
            }
        }
    }
    private func hideGroupIcons(){
        self.setVisibleGroups(groupList: self.listGroupIcons, hidden: true)
    }
    private func hideGroupListButtons(){
        self.setVisibleGroups(groupList: self.listGroupListButtos, hidden: true)
    }
    private func showGroupIcons(){
        self.setVisibleGroups(groupList: self.listGroupIcons, hidden: false)
    }
    private func showGroupListButtons(){
        self.setVisibleGroups(groupList: self.listGroupListButtos, hidden: false)
    }
    private func setVisibleGroups(groupList: [WKInterfaceObject], hidden: Bool){
        for i in groupList.indices{
            groupList[i].setHidden(hidden)
        }
    }
    private func setBackgroundColor(color: UIColor){
        for i in listGroupQuestions.indices{
            (listGroupQuestions[i] as? WKInterfaceGroup)?.setBackgroundColor(color)
        }
    }
    private func setIconButtonsSize(size: CGFloat){
        for i in listIconButtons.indices {
            listIconButtons[i].setWidth(size)
            listIconButtons[i].setHeight(size)
        }
    }
}
