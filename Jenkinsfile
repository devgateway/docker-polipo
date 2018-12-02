#!/usr/bin/env groovy
// Copyright 2018, Development Gateway, see COPYING
pipeline {
  agent any

  environment {
    HTTP_PROXY  = 'http://proxy.devgateway.org:3128/'
    HTTPS_PROXY = 'http://proxy.devgateway.org:3128/'
    APP_NAME = 'polipo'
    VERSION = '1.1.2'
    IMAGE = "devgateway/$APP_NAME:$VERSION"
  }

  stages {

    stage('Build') {
      steps {
        script {
          docker.build(env.IMAGE, "--build-arg=VERSION=$VERSION .")
        }
      }
    } // stage

    stage('Publish') {
      steps {
        script {
          docker.withRegistry('', 'dockerhub-ssemenukha') {
            docker.image(env.IMAGE).push()
          }
        }
      }
    } // stage

  } // stages

  post {
    success {
      script {
        def msg = sh(
          returnStdout: true,
          script: 'git log --oneline --format=%B -n 1 HEAD | head -n 1'
        )
        slackSend(
          message: "Built <$BUILD_URL|$JOB_NAME $BUILD_NUMBER>: $msg",
          color: "good"
        )
      }
    }
  }
}
