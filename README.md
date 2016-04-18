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
var sl = SortedList<MyObj>()
let mo = MyObj(id: 1)

sl.addElement(mo)

let mo2 = sl.getAt(0)
let mo2s = sl[0]
print(mo2 == mo2s)

let size: Int = sl.count
let elements: [MyObj] = sl.array
sl.removeElement(mo)

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
