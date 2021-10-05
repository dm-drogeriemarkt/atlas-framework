import Quick
import Nimble
import UIKit

class ImageMatcherTests: QuickSpec {
    override func spec() {
        describe("The Matcher") {
            var testImage: UIImage?
            var originalImage: UIImage?
            
            beforeEach {
                originalImage = UIImage.loadTestImage(named: "CircleUnselected")
                testImage = UIImage.loadTestImage(named: "CircleUnselected2")
            }
            
            afterEach {
                originalImage = nil
                testImage = nil
            }
            
            context("when comparing similar images") {
                it("evaluates to true") {
                    expect(testImage).to(equalImage(expectedValue: originalImage))
                }
            }
            
            context("when comparing non similar images") {
                it("evaluates to false with two different images") {
                    let testImage2 = UIImage.loadTestImage(named: "CircleSelected")
                    expect(testImage2).notTo(equalImage(expectedValue: originalImage))
                }
                
                it("evaluates to false with the first value being nil") {
                    expect(nil).notTo(equalImage(expectedValue: originalImage))
                }
                
                it("evaluates to false with the second value being nil") {
                    expect(testImage).notTo(equalImage(expectedValue: nil))
                }
            }
        }
    }
}
