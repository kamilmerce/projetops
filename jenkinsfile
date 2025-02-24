pipeline {
    agent any

    environment {
        IMAGE_NAME = "sum-calculator"
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    echo "Récupération du code source..."
                    checkout scm
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Construction de l'image Docker..."
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo "Exécution du conteneur Docker..."
                    def output = sh(script: "docker run --rm ${IMAGE_NAME} 3 7", returnStdout: true).trim()
                    echo "Résultat du script: ${output}"
                }
            }
        }

        stage('Test Script') {
            steps {
                script {
                    echo "Lancement des tests..."
                    def testValues = [
                        [5, 10, 15],
                        [3.5, 7.2, 10.7],
                        [-2, 4, 2],
                        [0, 0, 0],
                        [-3, -7, -10]
                    ]

                    testValues.each { values ->
                        def output = sh(script: "docker run --rm ${IMAGE_NAME} ${values[0]} ${values[1]}", returnStdout: true).trim()
                        if (output.toFloat() == values[2]) {
                            echo "Test réussi : ${values[0]} + ${values[1]} = ${output}"
                        } else {
                            error "Test échoué : attendu ${values[2]}, obtenu ${output}"
                        }
                    }
                }
            }
        }
    }
}
