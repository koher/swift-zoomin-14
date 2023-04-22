import SwiftUI

struct DirectionInputView: View {
    let output: (Vector4D<Int>) -> Void

    var body: some View {
        VStack {
            HStack {
                yButton(title: "arrow.up", direction: Vector4D(x: 0, y: -1, z: 0, w: 0))
                Spacer()
                wButton(title: "arrow.up", direction: Vector4D(x: 0, y: 0, z: 0, w: -1))
            }

            HStack {
                xButton(title: "arrow.left", direction: Vector4D(x: -1, y: 0, z: 0, w: 0))
                Spacer()
                zButton(title: "arrow.left", direction: Vector4D(x: 0, y: 0, z: -1, w: 0))
                Spacer()
                zButton(title: "arrow.right", direction: Vector4D(x: 0, y: 0, z: 1, w: 0))
                Spacer()
                xButton(title: "arrow.right", direction: Vector4D(x: 1, y: 0, z: 0, w: 0))
            }

            HStack {
                yButton(title: "arrow.down", direction: Vector4D(x: 0, y: 1, z: 0, w: 0))
                Spacer()
                wButton(title: "arrow.down", direction: Vector4D(x: 0, y: 0, z: 0, w: 1))
            }
        }
        .padding()
    }

    private func xButton(title: String, direction: Vector4D<Int>) -> some View {
        Button(action: {
            output(direction)
        }) {
            Image(systemName: title)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }

    private func yButton(title: String, direction: Vector4D<Int>) -> some View {
        Button(action: {
            output(direction)
        }) {
            Image(systemName: title)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }

    private func zButton(title: String, direction: Vector4D<Int>) -> some View {
        Button(action: {
            output(direction)
        }) {
            Image(systemName: title)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }

    private func wButton(title: String, direction: Vector4D<Int>) -> some View {
        Button(action: {
            output(direction)
        }) {
            Image(systemName: title)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }
}
