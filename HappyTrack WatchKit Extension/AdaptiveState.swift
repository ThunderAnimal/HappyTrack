//
//  AdaptiveState.swift
//  HappyTrack
//
//  Created by Martin Weber on 28.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchKit

protocol AdaptiveState: class {
    func tapMiss (adaptiveUI: AdaptivUI) -> AdaptiveState
    func tapHit (adaptiveUI: AdaptivUI) -> AdaptiveState
    func normalPuls (adaptiveUI: AdaptivUI) -> AdaptiveState
    func highPuls (adaptiveUI: AdaptivUI) -> AdaptiveState
    func noFeedback (adaptiveUI: AdaptivUI) -> AdaptiveState
    func tapBack (adaptiveUI: AdaptivUI) -> AdaptiveState
}

class NeutraleState: AdaptiveState {
    func tapBack(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.increaseButtonSize()
        return WrongSelection()
    }

    func tapMiss(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.increaseButtonSize()
        return IncreaseUIObjectSize()
    }
    func tapHit(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.decreaseButtonSize()
        return DecreaseUIObjectSize()
    }
    func normalPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func highPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.doingSport()
        return DoingSport()
    }
    func noFeedback(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.noFeedback()
        return Timeout()
    }
}
class IncreaseUIObjectSize: AdaptiveState {
    func tapBack(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.increaseButtonSize()
        return WrongSelection()
    }

    func tapMiss(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.increaseButtonSize()
        return self
    }
    func tapHit(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return NeutraleState()
    }
    func normalPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func highPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.doingSport()
        return DoingSport()
    }
    func noFeedback(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.noFeedback()
        return Timeout()
    }
}
class DecreaseUIObjectSize: AdaptiveState {
    func tapBack(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.increaseButtonSize()
        return WrongSelection()
    }

    func tapMiss(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return NeutraleState()
    }
    func tapHit(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.decreaseButtonSize()
        return self
    }
    func normalPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func highPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.doingSport()
        return DoingSport()
    }
    func noFeedback(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.noFeedback()
        return Timeout()
    }
}
class Timeout: AdaptiveState {
    func tapBack(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }

    func tapMiss(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func tapHit(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.showNormal()
        return NeutraleState()
    }
    func normalPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func highPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func noFeedback(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
}
class DoingSport: AdaptiveState {
    func tapBack(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.noFeedback()
        return Timeout()
    }

    func tapMiss(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func tapHit(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func normalPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.showNormal()
        return NeutraleState()
    }
    func highPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func noFeedback(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.noFeedback()
        return Timeout()
    }
}
class WrongSelection: AdaptiveState{
    func tapBack(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    
    func tapMiss(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.increaseButtonSize()
        return self
    }
    func tapHit(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return WrongSelectionCorrect()
    }
    func normalPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func highPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.doingSport()
        return DoingSport()
    }
    func noFeedback(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.noFeedback()
        return Timeout()
    }
}

class WrongSelectionCorrect: AdaptiveState{
    func tapBack(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.noFeedback()
        return Timeout()
    }
    
    func tapMiss(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.increaseButtonSize()
        return self
    }
    func tapHit(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return NeutraleState()
    }
    func normalPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        return self
    }
    func highPuls(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.doingSport()
        return DoingSport()
    }
    func noFeedback(adaptiveUI: AdaptivUI) -> AdaptiveState {
        adaptiveUI.noFeedback()
        return Timeout()
    }
}
