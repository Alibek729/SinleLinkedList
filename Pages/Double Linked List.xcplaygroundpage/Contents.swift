//: [Previous](@previous)

import Foundation

class Node<T> {
    var value: T
    var previous: Node<T>?
    var next: Node<T>?
    
    init(value: T, previous: Node<T>? = nil, next: Node<T>? = nil) {
        self.value = value
        self.previous = previous
        self.next = next
    }
}

struct DoublyLinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    //MARK: - Операции, проверяющие список на пустоту и сообщающие его размерность;
    
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
    
    //MARK: - Три операции добавления объекта в список (в начало, конец или внутрь после любого (n-го) элемента списка);
    
    mutating func push(_ value: T) {
        let newNode = Node(value: value, previous: nil, next: head)
        head?.previous = newNode
        head = newNode
        
        if tail == nil {
            tail = head
        }
    }
    
    mutating func append(_ value: T) {
        let newNode = Node(value: value)
        if let tail = tail {
            tail.next = newNode
            newNode.previous = tail
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    func insert(_ value: T, at index: Int) {
        guard let node = node(at: index) else { return }
        node.next = Node(value: value, previous: node,next: node.next)
    }
    
    //MARK: - Операция поиска элемента в списке;
    
    func node(at index: Int) -> Node<T>? {
        var currentIndex = 0
        var currentNode = head
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    //MARK: - Три операции удаления элемента из списка (первого, последнего и указанного, если он был найден).
    
    mutating func pop() -> Node<T>? {
        defer {
            head = head?.next
            head?.previous = nil
            
            if isEmpty {
                tail = nil
            }
        }
        return head
    }
    
    mutating func removeLast() -> Node<T>? {
        guard let head = head else { return nil }
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
        
        var previousNode = head
        var currentNode = head
        var nextNode = currentNode?.next
        var currentIndex = 0
        
        while currentNode?.next != nil && currentIndex < index {
            previousNode = currentNode
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        if currentNode?.next == nil {
            return removeLast()
        }
        
        previousNode?.next = currentNode?.next
        nextNode?.previous = previousNode
        
        return currentNode
    }
}

//: [Next](@next)
