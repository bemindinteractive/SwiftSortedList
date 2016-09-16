//
//  SortedList.swift
//  Pods
//
//  Created by Alessandro Miliucci on 18/04/16.
//
//

enum SortedListError: Error {
    case invalidIndex
}

public struct SortedList<T: Comparable> {
    
    fileprivate var slist = [T]()
    fileprivate let lazy: Bool
    
    // TODO: test thread safe and add a lock or a sync mode
    
    // TODO: add a lazy mode that sort the list only when the user need to read it
    // this mode, keep a sorting status (a Bool?) that's invalidated when an add/remove is made
    public init (lazy: Bool = false, startingValues: [T] = []) {
        self.lazy = lazy
        for sv in startingValues {
            self.addElement(sv)
        }
    }
    
    
    /**
     Add an element to the list and re-sort the list using Swift `sortInPlace` function
     
     - Parameter el:   The element to add.
     */
    public mutating func addElementSwiftSort(_ el: T) {
        slist.append(el)
        slist.sort()
    }
    
    
    /**
     Add an array of elements to the list and re-sort the list using Swift `sortInPlace` function
     
     - Parameter [el]:    Elements to add.
     */
    public mutating func addElements(_ els: [T]) {
        slist.append(contentsOf: els)
        slist.sort()
    }

    
    /**
     Add an element to the list and re-sort the list using a interna function
     
     - Parameter el:   The element to add.
     
     - Complexity: O(n), it uses a bubble-sort like algorithm moving up
        only the added element
     */
    public mutating func addElement(_ el: T) {
        slist.append(el)
        
        //
        // SORT ADDED ELEMENT
        //
        
        // nothing to order
        if (self.slist.count == 1 || self.slist.count == 0) { return }
        
        // otherwise sort, preconditions:
        // - slist elements 0->n-1 are already sorted
        // - only the last element (n) ins't sorted
        
        let index = slist.count-1
        for idx in Array(stride(from: 1, through: index, by: 1).reversed()) {
            if self.slist[idx] == self.slist[idx-1] {
                break // fast exit
            } else if self.slist[idx] < self.slist[idx-1] {
                swap(&self.slist[idx], &self.slist[idx-1])
            }
        }
    }
    
    
    /**
     Remove an `element` from the list.
     
     - Parameter el:   The element to remove.
     
     - Returns: The removed element or nil if it is not present in the list.
     */
    public mutating func removeElement(_ el: T) -> T? {
        var indexToRemove = -1
        for (index, element) in slist.enumerated() {
            if element == el {
                indexToRemove = index
            }
        }
        if indexToRemove != -1 {
            // no need to compact the array, swift arrays do this automatically
            return slist.remove(at: indexToRemove)
        } else {
            return nil
        }
    }
    
    /**
     Remove the current element `at` given index and insert the specified `element`.
     
     - Parameter at: The index of the element to remove.
     - Parameter element: The element to insert.
     */
    public mutating func replace(at index: Int, with element: T) {
        slist.remove(at: index)
        self.addElement(element)
    }
    
    
    /**
     Get the element at `index` from the list.
     
     - Parameter indexl:   The index of the element.
     
     - Throws: `SortedListError.InvalidIndex` if the `index` parameter
     is out of range.
     
     - Returns: The element at `index` position.
     */
    public func getAt(_ index: Int) throws -> T? {
        if slist.count >= index+1 {
            return slist[index]
        } else {
            throw SortedListError.invalidIndex
        }
    }
    
    
    public var count: Int { return slist.count }
    public var array: [T] { return slist }
    
}

//
// TODO: test all extensions
//

// MARK: - CollectionType
extension SortedList: Collection {
    
    public typealias Index = Int
    
    public var startIndex: Int { return slist.startIndex }
    public var endIndex: Int { return slist.endIndex }
    
    public subscript(i: Int) -> T { return slist[i] }
    
    // IndexableBase fix with swift 3.0
    public func index(after i: Int) -> Int {
        return i+1
    }
}

// MARK: - CustomStringConvertible, CustomDebugStringConvertible
extension SortedList: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String { return slist.description }
    public var debugDescription: String { return slist.debugDescription }
}
