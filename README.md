# ComputerCraft（Minecraft）で使用するプログラムを開発するリポジトリ
（自分用リポジトリ）
マルチのサーバー（not サーバー管理者）で使用するプログラムを外部ツールで書きたかったのでpublicリポジトリで公開し、
ゲーム内からhttpリクエストでソースを取得して保存できるようにした。
ファイル内でマルチバイト文字を使ってると取得時にエラーになるので注意。

取得のソースは src/retrieveProgram.lua だが、これはゲーム内で手打ちする必要がある。

## 導入MOD
- ComputerCraft v1.75
- More Turtles v2.0.2
