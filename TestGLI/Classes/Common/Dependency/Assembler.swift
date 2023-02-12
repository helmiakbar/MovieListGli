//
//  Assembler.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            HomeAssembly(),
            VideoDetailAssembly()
        ], container: container)
        return assembler
    }()
    
}
