import UIKit
import XCTest
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

class Tests: XCTestCase {
    
    func createRandomObj() -> MyObj {
        let id = Int(arc4random_uniform(UInt32(100000)))
        
        return MyObj(id: id)
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListAdd() {
        var pq = SortedList<MyObj>()
        let mo = createRandomObj()
        pq.addElement(mo)
        XCTAssertEqual(pq.count, 1)
    }
    
    func testListRemove() {
        var pq = SortedList<MyObj>()
        XCTAssertEqual(pq.count, 0)
        let mo = createRandomObj()
        pq.addElement(mo)
        XCTAssertEqual(pq.count, 1)
        pq.removeElement(mo)
        XCTAssertEqual(pq.count, 0)
    }
    
    func testListGetAt() {
        var pq = SortedList<MyObj>()
        let mo = createRandomObj()
        pq.addElement(mo)
        do {
            let g = try pq.getAt(0)
            XCTAssertEqual(g!.id, mo.id)
        } catch _ {
            XCTAssertTrue(true == false, "Exception not expected here")
        }
    }
    
    func testListCompact() {
        var pq = SortedList<MyObj>()
        XCTAssertEqual(pq.count, 0)
        let mo = createRandomObj()
        pq.addElement(mo)
        XCTAssertEqual(pq.count, 1)
        pq.removeElement(mo)
        XCTAssertEqual(pq.count, 0)
        XCTAssertThrowsError(try pq.getAt(0))
    }
    
    func testListCompact2() {
        var pq = SortedList<MyObj>()
        XCTAssertEqual(pq.count, 0)
        pq.addElement(createRandomObj())
        pq.addElement(createRandomObj())
        pq.addElement(createRandomObj())
        pq.addElement(createRandomObj())
        pq.addElement(createRandomObj())
        pq.addElement(createRandomObj())
        XCTAssertEqual(pq.count, 6)
        do {
            let goal = try pq.getAt(2)
            pq.removeElement(goal!)
            XCTAssertEqual(pq.count, 5)
            XCTAssertThrowsError(try pq.getAt(5))
            do {
                let g = try pq.getAt(2)
                XCTAssertNotNil(g)
                XCTAssertNotEqual(g!.id, goal!.id)
            } catch _ {
                XCTAssertTrue(true == false, "Exception not expected here")
            }
        } catch _ {
            XCTAssertTrue(true == false, "Exception not expected here")
        }
        
    }
    
    func testListInternalSorting1() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        pq.addElement(o1)
    }
    
    func testListInternalSorting2() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        pq.addElement(o1)
        pq.addElement(o2)
        XCTAssertLessThan(pq[0].id, pq[1].id)
    }
    
    func testListInternalSorting2Reverse() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        pq.addElement(o2)
        pq.addElement(o1)
        XCTAssertLessThan(pq[0].id, pq[1].id)
    }
    
    func testListInternalSorting3() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        let o3 = MyObj(id: 300)
        pq.addElement(o1)
        pq.addElement(o2)
        pq.addElement(o3)
        XCTAssertLessThan(pq[0].id, pq[1].id)
        XCTAssertLessThan(pq[1].id, pq[2].id)
    }
    
    func testListInternalSorting3Reverse() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        let o3 = MyObj(id: 300)
        pq.addElement(o3)
        pq.addElement(o2)
        pq.addElement(o1)
        XCTAssertLessThan(pq[0].id, pq[1].id)
        XCTAssertLessThan(pq[1].id, pq[2].id)
    }
    
    func testListInternalSorting4() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        let o3 = MyObj(id: 300)
        let o4 = MyObj(id: 400)
        pq.addElement(o1)
        pq.addElement(o2)
        pq.addElement(o3)
        pq.addElement(o4)
        XCTAssertLessThan(pq[0].id, pq[1].id)
        XCTAssertLessThan(pq[1].id, pq[2].id)
        XCTAssertLessThan(pq[2].id, pq[3].id)
    }
    
    func testListInternalSorting4Reverse() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        let o3 = MyObj(id: 300)
        let o4 = MyObj(id: 400)
        pq.addElement(o4)
        pq.addElement(o3)
        pq.addElement(o2)
        pq.addElement(o1)
        XCTAssertLessThan(pq[0].id, pq[1].id)
        XCTAssertLessThan(pq[1].id, pq[2].id)
        XCTAssertLessThan(pq[2].id, pq[3].id)
    }
    
    func testListInternalSorting5() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        let o3 = MyObj(id: 300)
        let o4 = MyObj(id: 400)
        let o5 = MyObj(id: 500)
        pq.addElement(o1)
        pq.addElement(o2)
        pq.addElement(o3)
        pq.addElement(o4)
        pq.addElement(o5)
        XCTAssertLessThan(pq[0].id, pq[1].id)
        XCTAssertLessThan(pq[1].id, pq[2].id)
        XCTAssertLessThan(pq[2].id, pq[3].id)
        XCTAssertLessThan(pq[3].id, pq[4].id)
    }
    
    func testListInternalSorting5Reverse() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        let o3 = MyObj(id: 300)
        let o4 = MyObj(id: 400)
        let o5 = MyObj(id: 500)
        pq.addElement(o5)
        pq.addElement(o4)
        pq.addElement(o3)
        pq.addElement(o2)
        pq.addElement(o1)
        XCTAssertLessThan(pq[0].id, pq[1].id)
        XCTAssertLessThan(pq[1].id, pq[2].id)
        XCTAssertLessThan(pq[2].id, pq[3].id)
        XCTAssertLessThan(pq[3].id, pq[4].id)
    }
    
    func testListInternalSorting5Random() {
        var pq = SortedList<MyObj>()
        let o1 = MyObj(id: 100)
        let o2 = MyObj(id: 200)
        let o3 = MyObj(id: 300)
        let o4 = MyObj(id: 400)
        let o5 = MyObj(id: 500)
        pq.addElement(o3)
        pq.addElement(o1)
        pq.addElement(o5)
        pq.addElement(o2)
        pq.addElement(o4)
        XCTAssertLessThan(pq[0].id, pq[1].id)
        XCTAssertLessThan(pq[1].id, pq[2].id)
        XCTAssertLessThan(pq[2].id, pq[3].id)
        XCTAssertLessThan(pq[3].id, pq[4].id)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
