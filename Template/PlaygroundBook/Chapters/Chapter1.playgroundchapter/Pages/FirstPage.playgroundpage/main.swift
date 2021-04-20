//#-hidden-code
import UIKit
import BookCore
import PlaygroundSupport

let currentPage = SecondViewController()

public func setBedColor(_ color: BedColor) {
    currentPage.bedColor = color
}
//#-end-hidden-code

/*:
 # Hey, how are you!?
 In the last months, most of us are at home all day. In some countries (As mine), most of the commerce and even the schools are closed. Because of that, the parents have to be creative to educate their children, since they have some times to work at home, clean the house, cook the lunch, etc.

 # Let me try to help!
 Thinking about it, I tried to remember my childhood, and what could I have done to help my parents and make their lives easier. So, I'll show you some of the ideas that I have. I hope you enjoy it!
\
\
 First, let's go to where all of us begin our days, get out of bed. If you make your bed still in the morning you'll have a great day, and I'm sure that your parents will be very proud of you.
 
 - Experiment:
 Let your room your way! You can change the variable values to personalize your bed! After that, tap `Run my code`
 \
 **Try:**
 \
 .yellow, .blue, .pink, .green
*/
let bedColor: BedColor = /*#-editable-code difficulty*/.yellow/*#-end-editable-code*/
setBedColor(bedColor)
//#-hidden-code
PlaygroundPage.current.liveView = currentPage
//#-end-hidden-code
/*:
 ## Try it
 Drag your finger on the bed in the indicated direction.
 \
 Or go to the [Next Page](@next)
 */
