import Foundation

// Constants
let NUM_INPUT = 10
let NUM_HIDDEN = 20
let NUM_OUTPUT = 1
let MAX_EPOCHS = 1000
let ERROR_THRESHOLD = 0.01

// Neural Network Structure
class NeuralNetwork {
    var weightsInputHidden: [[Double]]
    var weightsHiddenOutput: [[Double]]
    var hiddenLayer: [Double]
    var outputLayer: [Double]
    var learningRate: Double

    init(learningRate: Double) {
        weightsInputHidden = Array(repeating: Array(repeating: 0.0, count: NUM_HIDDEN), count: NUM_INPUT)
        weightsHiddenOutput = Array(repeating: Array(repeating: 0.0, count: NUM_OUTPUT), count: NUM_HIDDEN)
        hiddenLayer = Array(repeating: 0.0, count: NUM_HIDDEN)
        outputLayer = Array(repeating: 0.0, count: NUM_OUTPUT)
        self.learningRate = learningRate
        initializeNetwork()
    }

    // Sigmoid Function
    func sigmoid(_ x: Double) -> Double {
        return 1.0 / (1.0 + exp(-x))
    }

    // Derivative of Sigmoid
    func sigmoidDerivative(_ x: Double) -> Double {
        return x * (1.0 - x)
    }

    // Initialize Weights Randomly
    func initializeNetwork() {
        for i in 0..<NUM_INPUT {
            for j in 0..<NUM_HIDDEN {
                weightsInputHidden[i][j] = Double.random(in: -1.0...1.0)
            }
        }
        for j in 0..<NUM_HIDDEN {
            for k in 0..<NUM_OUTPUT {
                weightsHiddenOutput[j][k] = Double.random(in: -1.0...1.0)
            }
        }
    }

    // Training Function
    func train(input: [[Double]], output: [[Double]], numSamples: Int) {
        for epoch in 0..<MAX_EPOCHS {
            var totalError = 0.0
            for s in 0..<numSamples {
                // Feedforward
                for j in 0..<NUM_HIDDEN {
                    var activation = 0.0
                    for i in 0..<NUM_INPUT {
                        activation += input[s][i] * weightsInputHidden[i][j]
                    }
                    hiddenLayer[j] = sigmoid(activation)
                }

                for k in 0..<NUM_OUTPUT {
                    var activation = 0.0
                    for j in 0..<NUM_HIDDEN {
                        activation += hiddenLayer[j] * weightsHiddenOutput[j][k]
                    }
                    outputLayer[k] = sigmoid(activation)
                }

                // Calculate Error
                let error = output[s][0] - outputLayer[0]
                totalError += error * error

                // Backpropagation
                let outputDelta = error * sigmoidDerivative(outputLayer[0])
                for j in 0..<NUM_HIDDEN {
                    weightsHiddenOutput[j][0] += learningRate * outputDelta * hiddenLayer[j]
                }

                for j in 0..<NUM_HIDDEN {
                    let hiddenDelta = outputDelta * weightsHiddenOutput[j][0] * sigmoidDerivative(hiddenLayer[j])
                    for i in 0..<NUM_INPUT {
                        weightsInputHidden[i][j] += learningRate * hiddenDelta * input[s][i]
                    }
                }
            }

            totalError /= Double(numSamples)
            if totalError < ERROR_THRESHOLD {
                print("Training stopped early at epoch \(epoch)")
                break
            }
        }
    }

    // Prediction Function
    func predict(input: [Double]) {
        for j in 0..<NUM_HIDDEN {
            var activation = 0.0
            for i in 0..<NUM_INPUT {
                activation += input[i] * weightsInputHidden[i][j]
            }
            hiddenLayer[j] = sigmoid(activation)
        }

        for k in 0..<NUM_OUTPUT {
            var activation = 0.0
            for j in 0..<NUM_HIDDEN {
                activation += hiddenLayer[j] * weightsHiddenOutput[j][k]
            }
            outputLayer[k] = sigmoid(activation)
        }

        print("Prediction: \(outputLayer[0])")
    }
}

// Example Usage
let nn = NeuralNetwork(learningRate: 0.01)

// Sample Training Data
let inputData = [
    [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
]
let outputData = [
    [1.0],
    [1.0]
]

// Training the Neural Network
nn.train(input: inputData, output: outputData, numSamples: 2)

// Making a Prediction
let newInput = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
nn.predict(input: newInput)
