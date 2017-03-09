# ブラウザ拡張機能でEpisoPassを使う

![EpisoPass](https://gyazo.com/02708212f9a3b9cf75b7f53c560abde2.png)

* ChromeやFirefoxの**拡張機能**を使って[EpisoPass](http://EpisoPass.com/)がログイン画面で動くようにしたもの
* FacebookやAmazonのログイン画面で***メールアドレスを入力してからパスワード入力枠をクリックする***と上のようにEpisoPass問題が表示され、すべてに回答するとパスワードが計算されて入力される
* たとえばAmazonアカウントのメールアドレスとして```masui@pitecan.com```を使用する場合は[http://EpisoPass.com/masui@pitecan.com](http://EpisoPass.com/masui@pitecan.com)に問題を用意しておき、正答を選択したとき生成されるパスワードをAmazonに登録しておく
* Amazonのログイン画面上ですべての回答に正しく回答すると
登録したパスワードが生成されてログインに成功する

### 対応サービス

* Amazon (Seedは```Amazon123456```固定)
* Facebook (Seedは```Facebook123456```固定)
* Twitter (Seedは```Twitter123456```固定)

### ダウンロード / インストール

* Firefox
  * [Mozillaアドオンサイト](https://addons.mozilla.org/ja/firefox/addon/episopass/)からインストール
* Chrome
  * [Chromeウェブストア](https://chrome.google.com/webstore/detail/episopassextension/gempcojpejfhobcccooiifdoddlmokgj)からインストール

### 実装

* ```EpisoPass.com/(ID).json``` からなぞなぞ問題のJSONデータを取得し、それをもとにして問題をユーザに提示し、回答からパスワード生成する
* 問題の編集は```EpisoPass.com/(ID)```で行なう
* e.g. [http://EpisoPass.com/masui@pitecan.com](http://EpisoPass.com/masui@pitecan.com)

### 注意点

* FirefoxとChromeで同じJSが使えるのだが制限が微妙に違う
* Firefoxでは[http://EpisoPass.com]()からgetJSON()できるのだがChromeではできない
* Chromeでは、[https://EpisoPass.com](https://EpisoPasscom/)から```XMLHttpRequest()```しなければ動かない
* このためにEpisoPass.comをhttps化しなければならなかった...
* EpisoPass.com側はCORS対応しておく必要があった

### 拡張機能パッケージの生成

* ```make xpi``` でFirefoxの拡張機能ファイルができる
  * ユーザIDとか秘密文字列とかを環境変数にセットが必要
* Chromeの拡張機能ファイルは```chrome://extensions/```で「拡張機能のパッケージ化」を指定して人力で作成する

### 公開

* [Chrome機能拡張開発センタ](https://chrome.google.com/webstore/developer/edit/gempcojpejfhobcccooiifdoddlmokgj)
* [Firefox機能拡張開発センタ](https://addons.mozilla.org/ja/developers/addon/episopassextension/)

### 問題 / 感想

* AmazonとFacebookでしか使えません
* シードが決め打ちになっている
  * ユーザがシードを自由に決められるようにするにはどうすればいいだろう?
* **全くパスワードを見ることも打つこともなくパスワード利用システムにログインできるのは便利すぎる**
* こういうシステムは昔はGreasemonkeyで作ってたが、拡張機能で作る方がよさげである




