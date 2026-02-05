//
//  LoadingOverlay.swift
//  AppleScan
//
//  Created by Artyom on 05.02.2026.
//

import SwiftUI

struct LoadingOverlay: View {
    let progress: Double

    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                LottieView(name: "loading", loop: true)
                    .frame(width: 160, height: 160)

                ProgressView(value: progress)
                    .progressViewStyle(.linear)
                    .tint(.white)
                    .padding(.horizontal, 32)

                Text("Сканирование сети…")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(32)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.3), radius: 20, y: 10)
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.25), value: progress)
    }
}
