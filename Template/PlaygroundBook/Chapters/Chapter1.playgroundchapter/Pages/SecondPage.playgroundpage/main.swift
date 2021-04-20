//#-hidden-code
import UIKit
import BookCore
import PlaygroundSupport

UserDefaults.standard.setValue(false, forKey: "isPlaying")

let currentPage = FirstViewController()

public func setupDifficulty(_ difficulty: Difficulty) {
    currentPage.difficulty = difficulty.rawValue
}
//#-end-hidden-code

/*:
 # What about the toys?!
I know that every child likes to play with toys a lot. But it's important to store them after, that way, you can prevent an accident, or to break or even to lose your precious toys!
 If you do that every day, your mom will be very grateful!
 # What you have to do?
 Let's try to store all the toys as fastest as we can! There will be a timer on the screen and you have to put all of them on the chest before it finishes.
 
 - Experiment:
Select the difficult and tap `Run my code`
 \
 **Try:**
 \
 .easy, .medium, .hard
*/
let difficulty: Difficulty = /*#-editable-code difficulty*/.easy/*#-end-editable-code*/
setupDifficulty(difficulty)
//#-hidden-code
PlaygroundPage.current.liveView = currentPage
//#-end-hidden-code
/*:
## Let's Try it
Drag the toys to the chest to store them.
\
Or go to the [Next Page](@next)
*/
