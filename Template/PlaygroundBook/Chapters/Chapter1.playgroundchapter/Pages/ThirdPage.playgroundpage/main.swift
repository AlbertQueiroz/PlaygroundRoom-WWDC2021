//#-hidden-code
import UIKit
import BookCore
import PlaygroundSupport

UserDefaults.standard.setValue(false, forKey: "isPlaying")

let currentPage = ThirdViewController()

public func setupPencilColor(_ color: PencilColor) {
    currentPage.pencilColor = color
}

//public func setupDottedLine(_ length: Int) {
//    currentPage.dottedLineLenght = lenght
//    currentPage.dottedLineInterval = interval
//}
//#-end-hidden-code

/*:
 # Let's do your homework!
 Now that your room is clean, you can focus on your school activities better. An iPad is a great way to study and make your annotations or just draw for fun, especially if you have the apple pencil! So, have a try, take your iPad on the table and begin your homework.
\
\
This specific homework is focused on working your fine motor skill.
 - Experiment:
Change your pencil and tap `Run my code`
\
Try different colors to see what looks better for you!
*/
let pencilColor: PencilColor = /*#-editable-code difficulty*/.red/*#-end-editable-code*/

setupPencilColor(pencilColor)
//#-hidden-code
PlaygroundPage.current.liveView = currentPage
//#-end-hidden-code
/*:
## Let's Try it
Take the iPad and draw the path on the Screen.
\
Or go to the [Next Page](@next)
*/
