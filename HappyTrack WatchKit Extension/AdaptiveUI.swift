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
    
    private let pulsChangeView = 80
    
    private var currentIconButtonSize: Int
    private var actionAfterTap: Bool
    
    private var currentAdaptiveUIState: AdaptiveState
    
    private var listIconButtons = [WKInterfaceObject]()
    private var listGroupIcons = [WKInterfaceObject]()
    private var listGroupListButtos = [WKInterfaceObject]()
    
    public init(){
        self.currentIconButtonSize = defaultIconButtonSize
        self.actionAfterTap = false
        
        currentAdaptiveUIState = NeutraleState()
    }
    
    public func startTrack(){
        currentAdaptiveUIState = NeutraleState()
        self.showNormal()
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
        self.currentAdaptiveUIState = self.currentAdaptiveUIState.tapHit(adaptiveUI: self)
    }
    
    public func tapWithActionBack(){
        actionAfterTap = true
        self.currentAdaptiveUIState = self.currentAdaptiveUIState.tapBack(adaptiveUI: self)
    }
    
    public func newHeartRate(puls: Int){
        if(puls > self.pulsChangeView){
            self.currentAdaptiveUIState = self.currentAdaptiveUIState.highPuls(adaptiveUI: self)
        }else{
            self.currentAdaptiveUIState = self.currentAdaptiveUIState.normalPuls(adaptiveUI: self)
        }
    }
    
    public func addGroupIcon(group: WKInterfaceGroup){
        self.addItemToList(list: &self.listGroupIcons, item: group)
    }
    public func addGroupList(group: WKInterfaceGroup){
        self.addItemToList(list: &self.listGroupListButtos, item: group)
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
    private func setIconButtonsSize(size: CGFloat){
        for i in listIconButtons.indices {
            listIconButtons[i].setWidth(size)
            listIconButtons[i].setHeight(size)
        }
    }
}
