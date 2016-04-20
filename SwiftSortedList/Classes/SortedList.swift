//
//  SortedList.swift
//  Pods
//
//  Created by Alessandro Miliucci on 18/04/16.
//
//

enum SortedListError: ErrorType {
    case InvalidIndex
}

public struct SortedList<T: Comparable> {
    
    private var slist = [T]()
    private let lazy: Bool
    
    // TODO: test thread safe and add a lock or a sync mode
    
    // TODO: add a lazy mode that sort the list only when the user need to read it
    // this mode, keep a sorting status (a Bool?) that's invalidated when an add/remove is made
    public init (lazy: Bool = false, startingValues: [T] = []) {
        self.lazy = lazy
        for sv in startingValues {
            self.addElement(sv)
        }
    }
    
    public mutating func addElementSwiftSort(el: T) {
        slist.append(el)
        slist.sortInPlace()
    }
    
    public mutating func addElements(els: [T]) {
        slist.appendContentsOf(els)
        slist.sortInPlace()
    }

    
    public mutating func addElement(el: T) {
        slist.append(el)
        
        //
        // SORT ADDED ELEMENT
        //
        
        // nothing to order
        if (self.slist.count == 1 || self.slist.count == 0) { return }
        
        // otherwise sort, preconditions:
        // - slist elements 0->n-1 are already sorted
        // - only the last element (n) ins't sorted
        
        var index = slist.count-1
        for idx in Array(1.stride(through: index, by: 1).reverse()) {
            if self.slist[idx] == self.slist[idx-1] {
                break // fast exit
            } else if self.slist[idx] < self.slist[idx-1] {
                swap(&self.slist[idx], &self.slist[idx-1])
            }
        }
    }
    
    public mutating func removeElement(el: T) -> T? {
        var indexToRemove = -1
        for (index, element) in slist.enumerate() {
            if element == el {
                indexToRemove = index
            }
        }
        if indexToRemove != -1 {
            // no need to compact the array, swift arrays do this automatically
            return slist.removeAtIndex(indexToRemove)
        } else {
            return nil
        }
    }
    
    public mutating func getAt(index: Int) throws -> T? {
        if slist.count >= index+1 {
            return slist[index]
        } else {
            throw SortedListError.InvalidIndex
        }
    }
    
    
    public var count: Int { return slist.count }
    public var array: [T] { return slist }
    
}

//
// TODO: test all extensions
//

// MARK: - GeneratorType
extension SortedList: GeneratorType {
    
    public typealias Element = T
    mutating public func next() -> Element? { return self.next() }
}

// MARK: - SequenceType
extension SortedList: SequenceType {
    
    public typealias Generator = SortedList
    public func generate() -> Generator { return self }
}

// MARK: - CollectionType
extension SortedList: CollectionType {
    
    public typealias Index = Int
    
    public var startIndex: Int { return slist.startIndex }
    public var endIndex: Int { return slist.endIndex }
    
    public subscript(i: Int) -> T { return slist[i] }
}

// MARK: - CustomStringConvertible, CustomDebugStringConvertible
extension SortedList: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String { return slist.description }
    public var debugDescription: String { return slist.debugDescription }
}
