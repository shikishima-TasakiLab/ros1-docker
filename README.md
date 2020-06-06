# ROS1-Docker

ROS1 melodic (Desktop-Full) 用のDockerイメージを作成する．また，コンテナの起動を行う．

## インストール

```bash
#!/bin/bash
git clone https://github.com/shikishima-TasakiLab/ros1-docker.git
```

## 使い方

### Dockerイメージの作成

次のコマンドでDockerイメージを作成する．

```bash
#!/bin/bash
./docker/build-docker.sh
```

### Dockerコンテナの起動

1. 次のコマンドでDockerコンテナを起動する．

    ```bash
    #!/bin/bash
    ./docker/run-docker.sh
    ```

    "./catkin_ws" と "./shared_dir" がコンテナ内のホームディレクトリにマウントされる．

1. 起動中のコンテナで複数のターミナルを使用する際は，次のコマンドを別のターミナルで実行する．

    ```bash
    #!/bin/bash
    ./docker/exec-docker.sh
    ```
