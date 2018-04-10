properties properties: [
  [$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '30', numToKeepStr: '10']],
  disableConcurrentBuilds()
]

import jenkins.model.*

 // Take the string and echo it.
 def transformIntoStep(jobFullName, branchName) {
  // We need to wrap what we return in a Groovy closure, or else it's invoked
  // when this method is called, not when we pass it to parallel.
  // To do this, you need to wrap the code below in { }, and either return
  // that explicitly, or use { -> } syntax.
  return {
   // Job parameters can be added to this step
   build job: jobFullName, parameters: [booleanParam(name: 'release', value: false), [$class: 'GitParameterValue', name: 'branchName', value: branchName]]
  }
 }

@Library('mare-build-library')
def git = new de.mare.ci.jenkins.Git()

node {
  def buildUrl = env.BUILD_URL
  def buildNumber = env.BUILD_NUMBER
  def branchName = env.BRANCH_NAME
  def workspace = env.WORKSPACE

  // While you can't use Groovy's .collect or similar methods currently, you can
  // still transform a list into a set of actual build steps to be executed in
  // parallel.
  def stepsForParallel = [: ]
  stepsForParallel['deployIDEA'] = transformIntoStep('Galen_IDE/deployIDEA', branchName)
  stepsForParallel['deployEclipse'] = transformIntoStep('Galen_IDE/deployEclipse', branchName)
  stepsForParallel['deployWeb'] = transformIntoStep('Galen_IDE/deployWeb', branchName)

  // PRINT ENVIRONMENT TO JOB
  echo "workspace directory is $workspace"
  echo "build URL is $buildUrl"
  echo "build Number is $buildNumber"
  echo "PATH is $env.PATH"

  try {
    stage('Clean workspace') {
      deleteDir()
    }

    stage('Checkout') {
      checkout scm
    }

    dir('com.galenframework.specs.parent') {

      stage('Build') {
        sh "./mvnw clean package -U"
        sh "./gradlew clean build"
        sh "cd com.galenframework.specs.idea && ./gradlew clean build"
      }

      stage('Test') {
        wrap([$class: 'Xvfb']) {
        sh "metacity --sm-disable --replace & ./mvnw verify"
        sh "metacity --sm-disable --replace & ./gradlew test"
        step([$class: 'ArtifactArchiver', artifacts: '**/target/*.jar', fingerprint: true])
        step([$class: 'JUnitResultArchiver', testResults: '*/target/surefire-reports/TEST*.xml'])
        }
      }

    }

    if (git.isDevelopBranch()){
      stage('Deploy') {
        // Actually run the steps in parallel - parallel takes a map as an argument,
        // hence the above.
        parallel stepsForParallel
      }
    }

  } catch (e) {
    mail subject: "${env.JOB_NAME} (${env.BUILD_NUMBER}): Error on build", to: 'github@martinreinhardt-online.de', body: "Please go to ${env.BUILD_URL}."
    throw e
  }
}
