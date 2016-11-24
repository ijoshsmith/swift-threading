swift-threading
===============
swift v3.0.1


Simplified thread marshaling with a custom Swift operator function

For a review of this project, see:

http://ijoshsmith.com/2014/07/05/custom-threading-operator-in-swift/

Custom threading operator serial queue:
 ```
 { /* do some task */ } ~> { /* update some UI */}
 ```

Custom threading operator concurrent queue:
 ```
 { /* do some task */ } ≠> { /* update some UI */}
 ```
 

