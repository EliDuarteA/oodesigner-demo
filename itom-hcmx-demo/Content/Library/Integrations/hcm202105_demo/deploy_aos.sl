namespace: Integrations.hcm202105_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: demo.hcmx.local
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_username}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_java:
        x: 243
        'y': 89
      install_aos_application:
        x: 600
        'y': 78
        navigate:
          67420eab-f68b-e54a-be0a-34ab09aa5b60:
            targetId: fcf5aa8a-c960-dec8-cdd3-dbac102ad9fe
            port: SUCCESS
      install_tomcat:
        x: 407
        'y': 84
      install_postgres:
        x: 73
        'y': 90
    results:
      SUCCESS:
        fcf5aa8a-c960-dec8-cdd3-dbac102ad9fe:
          x: 771
          'y': 82
