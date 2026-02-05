//
//  MainView.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var coordinator = AppCoordinator()
    
    var body: some View {
        RootTabView(coordinator: coordinator)
    }
}
