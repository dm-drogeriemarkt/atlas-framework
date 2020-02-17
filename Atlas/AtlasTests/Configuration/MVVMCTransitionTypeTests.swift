import Quick
import Nimble
import Atlas

class MVVMCTransitionTypeTests: QuickSpec {
    override func spec() {
        describe("The MVVMCTransitionType") {
            context("comparing with an instance that has same type but different animated flag") {
                it("returns false") {
                    expect(MVVMCTransitionType.modal(animated: true) == MVVMCTransitionType.modal(animated: false)).to(beFalse())
                    expect(MVVMCTransitionType.push(animated: true) == MVVMCTransitionType.push(animated: false)).to(beFalse())
                }
            }

            context("comparing with an instance that has different type and same animated flag") {
                it("returns false") {
                    expect(MVVMCTransitionType.modal(animated: true) == MVVMCTransitionType.push(animated: true)).to(beFalse())
                    expect(MVVMCTransitionType.modal(animated: false) == MVVMCTransitionType.push(animated: false)).to(beFalse())
                }
            }

            context("comparing with an instance that has same type and same animated flag") {
                it("returns true") {
                    expect(MVVMCTransitionType.modal(animated: true) == MVVMCTransitionType.modal(animated: true)).to(beTrue())
                    expect(MVVMCTransitionType.push(animated: true) == MVVMCTransitionType.push(animated: true)).to(beTrue())
                }
            }
        }
    }
}
