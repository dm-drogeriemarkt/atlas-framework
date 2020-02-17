import Atlas

enum NavigationTargets: MVVMCNavigationTarget, Equatable {
    case yellow
    case red(parameter: String)
    
    func equals(obj: MVVMCNavigationTarget) -> Bool {
        guard let obj = obj as? NavigationTargets else {
            return false
        }
        
        return self == obj
    }
}
