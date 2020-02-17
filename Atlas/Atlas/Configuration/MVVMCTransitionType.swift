public enum MVVMCTransitionType {
    case modal(animated: Bool)
    case push(animated: Bool)
}

// MARK: - Equatable
extension MVVMCTransitionType: Equatable {
    public static func == (lhs: MVVMCTransitionType, rhs: MVVMCTransitionType) -> Bool {
        switch (lhs, rhs) {
            case (.modal(let lhsAnimated), .modal(let rhsAnimated)): return lhsAnimated == rhsAnimated
            case (.push(let lhsAnimated), .push(let rhsAnimated)): return lhsAnimated == rhsAnimated
            default: return false
        }
    }
}

