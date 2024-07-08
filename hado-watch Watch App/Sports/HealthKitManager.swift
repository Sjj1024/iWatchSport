//
//  ContentView.swift
//  witwatch Watch App
//
//  Created by Jonathan on 2024/5/28.
//

import HealthKit


class HealthKitManager: NSObject, ObservableObject {
    let healthStore = HKHealthStore()
    
    func requestAuthorization() {
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKQuantityType.quantityType(forIdentifier: .appleStandTime)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.activitySummaryType()
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead, completion: { (success, error) in
            
        })
    }
    
    // ACTIVITY RING
    @Published var energyBurnedValue: Int = 0
    @Published var exercisevalue: Int = 0
    @Published var standValue: Int = 0
    
    func startEnergyQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let energyType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalEnergyBurned = sumQuantity.doubleValue(for: HKUnit.kilocalorie())
                
                DispatchQueue.main.async {
                    self.energyBurnedValue = Int(totalEnergyBurned)
                }
            } else {
                print("Failed to fetch total energy burned: \(error?.localizedDescription ?? "")")
            }
        }
        
        healthStore.execute(query)
    }
    
    func startExerciseQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let energyType = HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalExerciseTime = sumQuantity.doubleValue(for: HKUnit.minute())
                
                DispatchQueue.main.async {
                    print("exercise time: \(totalExerciseTime)")
                    self.exercisevalue = Int(totalExerciseTime)
                }
            } else {
                print("Failed to fetch total exercise time: \(error?.localizedDescription ?? "")")
            }
        }
        
        healthStore.execute(query)
    }
    
    func startStandQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let energyType = HKObjectType.quantityType(forIdentifier: .appleStandTime)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalStandTime = sumQuantity.doubleValue(for: HKUnit.minute())
                
                DispatchQueue.main.async {
                    self.standValue = Int(totalStandTime)
                }
            } else {
                print("Failed to fetch total stand time: \(error?.localizedDescription ?? "")")
            }
        }
        
        healthStore.execute(query)
    }
    
    // HEART RATE
    @Published var heartRateValue: Int = 0
    let heartRateQuantity = HKUnit(from: "count/min")
    
    func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = { query, samples, deletedObjects, queryAnchor, error in
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            self.processHeartRate(samples, type: quantityTypeIdentifier)
        }
        
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        healthStore.execute(query)
    }
    
    func processHeartRate(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        var lastHeartRate = 0.0
        
        for sample in samples {
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
            }
            
            DispatchQueue.main.async {
                self.heartRateValue = Int(lastHeartRate)
                
            }
        }
    }
    
    func getHeartRate() -> Int {
            return self.heartRateValue
    }
    // STEPS
    @Published var stepsValue = 0
    
    func startStepQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalSteps = sumQuantity.doubleValue(for: HKUnit.count())
                
                DispatchQueue.main.async {
                    self.stepsValue = Int(totalSteps)
                }
            } else {
                print("Failed to fetch step count: \(error?.localizedDescription ?? "")")
            }
        }
        
        healthStore.execute(query)
    }
    
    // WORKOUT
    var selectedWorkout: HKWorkoutActivityType? {
        didSet {
            guard let selectedWorkout = selectedWorkout else { return }
            startWorkout(workoutType: selectedWorkout)
        }
    }
    
    @Published var showingSummaryView: Bool = false {
        didSet {
            if showingSummaryView == false {
                resetWorkout()
            }
        }
    }
    
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    func startWorkout(workoutType: HKWorkoutActivityType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
        } catch {
            return
        }
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        
        session?.delegate = self
        builder?.delegate = self
        
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate, completion: { (success, error) in
            
        })
    }
    
    @Published var running = false
    
    func pause() {
        session?.pause()
    }
    
    func resume() {
        session?.resume()
    }
    
    func togglePause() {
        if running == true {
            pause()
        } else {
            resume()
        }
    }
    
    func endWorkout() {
        session?.end()
        showingSummaryView = true
    }
    
    @Published var averageHeartRate: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var distance: Double = 0
    @Published var workout: HKWorkout?
    
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }
        
        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let energyUnit = HKUnit.kilocalorie()
                self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning), HKQuantityType.quantityType(forIdentifier: .distanceCycling):
                let meterUnit = HKUnit.meter()
                self.distance = statistics.sumQuantity()?.doubleValue(for: meterUnit) ?? 0
            default:
                return
            }
        }
    }
    
    func resetWorkout() {
        selectedWorkout = nil
        builder = nil
        session = nil
        workout = nil
        activeEnergy = 0
        averageHeartRate = 0
        heartRate = 0
        distance = 0
    }
    
}

extension HealthKitManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession,
                        didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState,
                        date: Date) {
        DispatchQueue.main.async {
            self.running = toState == .running
        }
        
        if toState == .ended {
            builder?.endCollection(withEnd: date, completion: { (success, error) in
                self.builder?.finishWorkout(completion: { (workout, error) in
                    DispatchQueue.main.async {
                        self.workout = workout
                    }
                })
            })
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
}

extension HealthKitManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else { return }
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            updateForStatistics(statistics)
        }
    }
}

