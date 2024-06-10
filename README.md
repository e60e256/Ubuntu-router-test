## general - tunnel テスト用

- docker-compose.yaml: general リンクのテスト
- netshoot: generalリンクなどのテスト用
- netshoot_2: これに NUC ルータとしての機能を追加したバージョン
- network_config_router.sh: NUC ルータに設定すべき設定が書かれている。起動時に実行
- network_config_router_1.sh: Ubuntu bridge の使用テスト、関係ない


## 使用法
```
docker build . -f netshoot -t netshoot:e60e256
docker build . -f netshoot_2 -t netshoot_router:e60e256
docker compose up
```
