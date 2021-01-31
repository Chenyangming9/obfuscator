//
// Created by tom on 2021/1/31.
//

#ifndef LLVM_ENCODEFUNCTIONNAME_H
#define LLVM_ENCODEFUNCTIONNAME_H

#include <llvm/Pass.h>

namespace llvm{
    Pass* createEncodeFunctionName();
}

#endif //LLVM_ENCODEFUNCTIONNAME_H
