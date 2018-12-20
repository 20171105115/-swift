//
//  ViewController.swift
//  堆栈——swift
//
//  Created by 朱博宇 on 2018/11/1.
//  Copyright © 2018 朱博宇. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var number: UITextField!
    
    var Flag = 0//判断前边是否为运算符 1是0不是
    var Temp = ""//用于存储每个运算数
    @IBAction func NumberOne(_ sender: Any) {
        number.text! += "1"
    }
    
    @IBAction func NumberTwo(_ sender: Any) {
        number.text! += "2"
    }
    
    @IBAction func numberThree(_ sender: Any) {
        number.text! += "3"
    }
    
    @IBAction func NumberFour(_ sender: Any) {
        number.text! += "4"
    }
    
    @IBAction func NumberFive(_ sender: Any) {
        number.text! += "5"
    }
    
    @IBAction func NumberSix(_ sender: Any) {
        number.text! += "6"
    }
    
    @IBAction func NumberSeven(_ sender: Any) {
        number.text! += "7"
    }
    
    @IBAction func NumberEight(_ sender: Any) {
        number.text! += "8"
    }
    
    @IBAction func NumberNine(_ sender: Any) {
        number.text! += "9"
    }
    
    @IBAction func NumberZero(_ sender: Any) {
        number.text! += "0"
    }
    
    @IBAction func NumberPlus(_ sender: Any) {
        number.text! += "+"
    }
    
    @IBAction func Numbersub(_ sender: Any) {
        number.text! += "-"
    }
    
    @IBAction func NumberRide(_ sender: Any) {
        number.text! += "*"
    }
    
    @IBAction func NumberDivide(_ sender: Any) {
        number.text! += "/"
    }
    
    @IBAction func NumberPower(_ sender: Any) {
        number.text! += "^"
    }
    
    public struct NumberStack<Int> {
        fileprivate var array = [Int]()
        
        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public var count: Int {
            return array.count as! Int
        }
        
        public mutating func push(_ element: Int) {
            array.append(element)
        }
        
        public mutating func pop() -> Int? {
            return array.popLast()
        }
        
        public func peek() -> Int? {
            return array.last
        }
    }
    
    public struct Queue<Character> {
        // 数组用来存储数据元素
        fileprivate var data = [Character]()
        // 构造方法，用于构建一个空的队列
        public init() {}

        // 将类型为T的数据元素添加到队列的末尾
        public mutating func enqueue(element: Character) {
            data.append(element)
        }
        // 移除并返回队列中第一个元素
        // 如果队列不为空，则返回队列中第一个类型为T的元素；否则，返回nil。
        public mutating func dequeue() -> Character? {
            return data.removeFirst()
        }
        // 返回队列中的第一个元素，但是这个元素不会从队列中删除
        // 如果队列不为空，则返回队列中第一个类型为T的元素；否则，返回nil。
        public func peek() -> Character? {
            return data.first
        }
        // 清空队列中的数据元素
        public mutating func clear() {
            data.removeAll()
        }
        // 返回队列中数据元素的个数
        public var count: Int {
            return data.count
        }
        // 返回或者设置队列的存储空间
        public var capacity: Int {
            get {
                return data.capacity
            }
            set {
                data.reserveCapacity(newValue)
            }
        }
        // 检查队列是否已满
        // 如果队列已满，则返回true；否则，返回false
        public func isFull() -> Bool {
            return count == data.capacity
        }
        // 检查队列是否为空
        // 如果队列为空，则返回true；否则，返回false
        public func isEmpty() -> Bool {
            return data.isEmpty
        }
    }
    
    
    
    public struct orderStack<Character> {
        fileprivate var array = [Character]()
        
        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public var count: Int {
            return array.count
        }
        
        public mutating func push(_ element: Character) {
            array.append(element)
        }
        
        public mutating func pop() -> Character? {
            return array.popLast()
        }
        
        public func peek() -> Character? {
            return array.last
        }
    }
    
   
    //不包含后几个字符串的方法

    

    var nst = NumberStack<Int>()//存放数字的堆栈
    var st = orderStack<Character>()//存放运算数的堆栈
    var TheSuffix = Queue<Character>()  //存放后缀表达式的队列
    
    
    func priority(ch:Character) -> Int {
        switch ch {
        case "(":
            return 0
        case "+":
            return 1
        case "-":
            return 1
        case "*":
            return 2
        case "/":
            return 2
        case "^":
            return 2
        default:
            return 0
        }
    }
    
    func isnumber(ch:Character) -> Bool {
        if "0"<=ch && ch<="9" {
            return true
        }else{
            return false
        }
    }
    
    @IBAction func equal(_ sender: Any) {
        if (number.text?.isEmpty)! {
            print("无运算式，请重新输入\n")
        }else{
            for i in 0...(number.text)!.count-1{
                let index = number.text!.index(number.text!.startIndex, offsetBy: i)
                let temp = number.text![index]
                if "0"<=number.text![index]&&number.text![index]<="9"{
                    TheSuffix.enqueue(element: temp)
                }else{
                    if(temp=="("||st.isEmpty){
                        st.push(temp)
                        continue
                    }
                    if(temp==")"){
                        while(st.peek() != "("){
                            TheSuffix.enqueue(element: st.pop()!)
                        }
                        st.pop()
                        continue
                    }
                    while(!st.isEmpty&&st.peek() != "("&&priority(ch: temp) <= priority(ch :st.peek()!)){
                        TheSuffix.enqueue(element: st.pop()!)
                    }
                    st.push(temp)
                }
            }
        }
        var temp1 = 0  //记录临时的运算数
        while !st.isEmpty {
            TheSuffix.enqueue(element: st.pop()!)
        }
        for _ in 0...TheSuffix.count-1 {
            if(isnumber(ch: TheSuffix.peek()!)){
                nst.push(Int(String(TheSuffix.dequeue()!))!)
                continue
            }else if(TheSuffix.peek() == "+"){
                TheSuffix.dequeue()
                temp1 = nst.pop()!
                temp1 = nst.pop()! + temp1
                nst.push(temp1)
            }else if(TheSuffix.peek() == "-"){
                TheSuffix.dequeue()
                temp1 = nst.pop()!
                temp1 = nst.pop()! - temp1
                nst.push(temp1)
            }else if(TheSuffix.peek() == "*"){
                TheSuffix.dequeue()
                temp1 = nst.pop()!
                temp1 = nst.pop()! * temp1
                nst.push(temp1)
            }else if(TheSuffix.peek() == "/"){
                TheSuffix.dequeue()
                temp1 = nst.pop()!
                temp1 = nst.pop()! / temp1
                nst.push(temp1)
            }
            /*else if(out[i]=="^"){
                temp1 = nst.pop()!
                temp1 = pow(nst.pop()!,temp1)
                nst.push(temp1)
            }*/
            
        }
        number.text = "\(TheSuffix.dequeue()!)"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    

}

