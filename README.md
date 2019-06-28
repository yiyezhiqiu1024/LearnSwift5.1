# LearnSwift5.1
Swift5.1学习记录

- 开发环境

  - 基于Swift5.1
  - 开发工具：Xcode10.2.1、Xcode11
  - 操作系统：macOS 10.14 Mojave、macOS Catalina 10.15
  - 下载地址：[](https://developer.apple.com/download/)

- 开源

  - Swift完全开源[](https://github.com/apple/swift)，主要采用C++编写

- swiftc

  - **swiftc**存放在Xcode内部

    ```shell
    cd /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault/xctoolchain/usr/bin
    ```

  - 一些操作

    - 生成语法树

      ```shell
      swiftc -dump-ast main.swift
      ```

    - 生成最简洁的**SIL**代码

      ```shell
      swiftc -emit-sil main.swift
      ```

    - 生成**LLVM IR**代码

      ```shell
      swiftc -emit-ir main.swift -o main.ll
      ```

    - 生成汇编代码

      ```shell
      swiftc -emit-assembly main.swift -o main.s	
      ```

    - 对汇编代码进行分析，可以真正掌握编程语言的本质
