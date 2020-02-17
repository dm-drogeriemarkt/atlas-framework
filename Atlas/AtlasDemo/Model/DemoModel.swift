import Atlas

class DemoModel {
    var observers: [DemoModelObserverProtocol] = []
    var count = 0
    
    func reset() {
        count = 0
    }
    
    func increase() {
        count += 1
        notifyObservers()
    }
}

// MARK: - Helpers
extension DemoModel {
    func notifyObservers() {
        for observer in observers {
            observer.modelDidChange(self)
        }
    }
}

// MARK: - MVVMModelProtocol
extension DemoModel: MVVMCModelProtocol {
    public func register(observer: DemoModelObserverProtocol) {
        if !observers.contains(where: { $0 === observer }) {
            observers.append(observer)
        }
    }
    
    public func deregister(observer: DemoModelObserverProtocol) {
        observers = observers.filter { $0 !== observer }
    }
}
