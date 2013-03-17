Problem 1
 Config returns Nil object that behaves like nil but it can not react on `||`, `&&`, `or` and `and`.
 So you cannot do something like database.test.host || "127.0.0.1"