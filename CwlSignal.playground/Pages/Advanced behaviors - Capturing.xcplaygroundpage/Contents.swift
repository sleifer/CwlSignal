/*:
# Advanced behaviors 3

> **This playground requires the CwlSignal.framework built by the CwlSignal_macOS scheme.** If you're seeing the error: "no such module 'CwlSignal'" follow the Build Instructions on the [Introduction](Introduction) page.

## Capturing

*This example writes to the "Debug Area". If it is not visible, show it from the menubar: "View" → "Debug Area" → "Show Debug Area".*

SignalCapture allows activation values to be pulled synchronously from a signal. This provides potential solutions to scenarios where code cannot proceed without being able to obtain an immediate value. Simply put: activation in CwlSignal provides pull-based synchronous behaviors, whereas typical reactive programming is push-based and potentially asynchronous.

---
*/
import CwlSignal

// Create an input/output pair, transforming the output before returning
let (input, output) = Signal<Int>.createPair { signal in signal.continuous() }

// Send values before a subscriber exists
input.send(value: 1)
input.send(value: 2)

// Capture the activation value cached by the `continuous` signal
let capture = output.capture()
let (values, error) = capture.activation()
print("Activation values: \(values)")

// Capturing blocks the signal so this will be queued for later
input.send(value: 3)

// Subscribing to the capture unblocks the signal so the "3" will now be sent through.
let ep = capture.subscribeValues { value in print("Regular value: \(value)") }

// You'd normally store the endpoint in a parent and let ARC automatically control its lifetime.
ep.cancel()
/*:
---

[Next page: App scenario - threadsafe key-value storage](@next)

[Previous page: Advanced behaviors - lazy generation](@previous)
*/