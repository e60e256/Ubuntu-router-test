## general - tunnel テスト用

- docker-compose.yaml: general リンクのテスト
- netshoot: generalリンクなどのテスト用
- netshoot-client: クライアント用コンテナ
- netshoot-router: NUC ルータ用コンテナ
- nwcfg/network_config_cliet.sh: IPv6 有効化の設定のみ
- nwcfg/network_config_router.sh: NUC ルータに設定すべき設定が書かれている。起動時に実行



## 使用法
```
docker build . -f netshoot -t netshoot:e60e256
docker compose up -d
```
