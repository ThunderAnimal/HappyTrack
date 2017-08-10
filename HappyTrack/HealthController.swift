//
//  HealthController.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import HealthKit

class HealthController {
    private let healthStore = HKHealthStore()
    
    public func getHealStore() -> HKHealthStore{
        return healthStore
    }
    
    public func enableHealthKit(completion: ((_ success:Bool, _ error:Error?) -> Void)!) -> Void{
        
        // 1. Type read from HK
        var readTypes = Set<HKObjectType>()
        readTypes.insert(HKObjectType.workoutType()) //Workout
        readTypes.insert(HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!) //HeartRate
        readTypes.insert(HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!) //Steps
        
        // 2. Types write to HK
        var shareTypes = Set<HKSampleType>()
        shareTypes.insert(HKSampleType.workoutType())
        
        // 3. Check if HK Store is available
        if !HKHealthStore.isHealthDataAvailable()
        {
            let error = NSError(domain: Constants.bundle(), code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if( completion != nil )
            {
                completion(false, error)
            }
            return;
        }
        
        // 4. Rewuest authorization
        healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (success, error) -> Void in
            if let error = error {
                print(error)
            }
            if( completion != nil )
            {
                
                completion(success,error)
            }
        }
    }
    
    public func getDummyWorkoutConfiguration() -> HKWorkoutConfiguration{
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        configuration.locationType = .outdoor
        
        return configuration
    }

}
