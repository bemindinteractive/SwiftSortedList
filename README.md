# SwiftSortedList

[![Version](https://img.shields.io/cocoapods/v/SwiftSortedList.svg?style=flat)](http://cocoapods.org/pods/SwiftSortedList)
[![License](https://img.shields.io/cocoapods/l/SwiftSortedList.svg?style=flat)](http://cocoapods.org/pods/SwiftSortedList)
[![Platform](https://img.shields.io/cocoapods/p/SwiftSortedList.svg?style=flat)](http://cocoapods.org/pods/SwiftSortedList)

## Usage

All you need is a Comparable object:

```
import SwiftSortedList

struct MyObj : Comparable {
    var id: Int
}

func ==(x: MyObj, y: MyObj) -> Bool {
    return x.id == y.id
}
func <(x: MyObj, y: MyObj) -> Bool {
    return x.id < y.id
}
```

Then you can use the SortedList:

```
// create a new sorted list

var sl = SortedList<MyObj>()


// add an object

let mo = MyObj(id: 1)
sl.addElement(mo)


// get an object

let mo2 = sl.getAt(0)
let mo2s = sl[0]
print(mo2 == mo2s)


// helpers functions

let size: Int = sl.count
let elements: [MyObj] = sl.array


// remove an object

sl.removeElement(mo)


// replace an object
let mo3 = MyObj(id: 3)
sl.replace(at: 0, with: mo3)
print(mo2 == sl[0]) // false
print(mo3 == sl[0]) // true

// loop

for el in sl.array {
    // do something with el
}

```

### 

## Installation

SwiftSortedList is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftSortedList"
```

## Author

[Alessandro Miliucci](https://github.com/lifeisfoo)

## License

SwiftSortedList is available under the MIT license. See the LICENSE file for more info.
