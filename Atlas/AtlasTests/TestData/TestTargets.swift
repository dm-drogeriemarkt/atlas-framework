import Atlas

enum TestTargets: MVVMCNavigationTarget {
    case green
    case blue
    
    func equals(obj: MVVMCNavigationTarget) -> Bool {
        guard let obj = obj as? TestTargets else {
            return false
        }
        
        return self == obj
    }
}
