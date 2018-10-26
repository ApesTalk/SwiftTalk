//: Playground - noun: a place where people can play

import UIKit

//注意空格：某一行的空格超过“”“的范围才算，”“”之前的空格将自动忽略
let quotation = """
   The white rabbit put on his spectacles. "Where shall i begin,
   please your Majesty?" he asked.
      "Begin at the beginning," the King said gravely, "and go on
      till you come to the end; then stop."
   """

print(quotation)

var emptyStr = ""
var anotherEmptyStr = String()
if emptyStr.isEmpty {
    print("Nothing to see here")
}


