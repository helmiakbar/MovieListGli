//
//  HomeAssembly.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Swinject

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkProtocol.self) { r in
            return NetworkProvider()
        }
        
        container.register(HomeDataSource.self) { r in
            guard let dataProvider = r.resolve(NetworkProtocol.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return HomeRepository(remoteData: dataProvider)
        }

        container.register(HomeViewModel.self) { r in
            guard let dataSource = r.resolve(HomeDataSource.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return HomeViewModel(dataSource: dataSource)
        }
    }
}
