import UIKit

class Node<T> {
    var value: T
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil){
        self.value = value
        self.next = next
    }
}

struct SinglyLinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    public var count: Int {
        var count = 0
        var current = head
        while current != nil {
            count += 1
            current = current?.next
        }
        return count
    }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public init(first: Node<T>? = nil) {
        self.head = first
    }
    
    mutating func push(_ value: T) {
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    mutating func append(_ value: T) {
        let node = Node(value: value)
        tail?.next = node
        tail = node
    }
    
    func insert(_ value: T, after index: Int) {
        guard let node = node(at: index) else { return }
        node.next = Node(value: value, next: node.next)
    }
    
    func node(at index: Int) -> Node<T>? {
        var currentIndex = 0
        var currentNode = head
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    mutating func pop() -> Node<T>? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head
    }
    
    mutating func removeLast() -> Node<T>? {
        guard let head = head else { return nil}
        guard head.next != nil else { return pop() }
        
        var newTail = head
        var currentNode = head
        
        while let next = currentNode.next {
            newTail = currentNode
            currentNode = next
        }
        
        newTail.next = nil
        tail = newTail
        return currentNode
    }
    
    mutating func removeAt(at index: Int) -> Node<T>? {
        guard index >= 0 else { return nil }
        if index == 0 { return pop() }
        
        var previous: Node<T>?
        var currentNode = head
        var currentIndex = 0
        
        while currentNode?.next != nil && currentIndex < index {
            previous = currentNode
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        if currentNode?.next == nil {
            return removeLast()
        }
        
        previous?.next = currentNode?.next
        
        return currentNode
    }
}

