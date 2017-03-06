import jenkins.model.*


// Take the string and echo it.
def transformIntoStep(jobFullName) {
    // We need to wrap what we return in a Groovy closure, or else it's invoked
    // when this method is called, not when we pass it to parallel.
    // To do this, you need to wrap the code below in { }, and either return
    // that explicitly, or use { -> } syntax.
    return {
       // Job parameters can be added to this step
       build jobFullName
    }
}

// While you can't use Groovy's .collect or similar methods currently, you can
// still transform a list into a set of actual build steps to be executed in
// parallel.
def stepsForParallel = [:]
stepsForParallel['deployIDEA'] = transformIntoStep('Galen_IDE/deployIDEA')
stepsForParallel['deployEclipse'] = transformIntoStep('Galen_IDE/deployEclipse')
stepsForParallel['deployWeb'] = transformIntoStep('Galen_IDE/deployWeb')

node {
    env.JAVA_HOME = tool 'JDK8'
    def mvnHome   = tool 'Maven'
    env.PATH="${env.JAVA_HOME}/bin:${mvnHome}/bin:${env.PATH}"

   stage 'Checkout'
   git url: 'https://github.com/hypery2k/galen_ide.git'

   stage 'Build'
   sh "cd com.galenframework.specs.parent && ${mvnHome}/bin/mvn clean package -U"
   sh "cd com.galenframework.specs.parent && ./gradlew clean build"
   
   stage 'Test'
   wrap([$class: 'Xvfb']) {
       sh "metacity --sm-disable --replace & cd com.galenframework.specs.parent && ${mvnHome}/bin/mvn verify"
       sh "metacity --sm-disable --replace & cd com.galenframework.specs.parent && ./gradlew test"
       step([$class: 'ArtifactArchiver', artifacts: '**/target/*.jar', fingerprint: true])
       step([$class: 'JUnitResultArchiver', testResults: 'com.galenframework.specs.parent/*/target/surefire-reports/TEST*.xml'])
   }
   stage 'Deploy'
   // Actually run the steps in parallel - parallel takes a map as an argument,
   // hence the above.
   parallel stepsForParallel
   
}

