# 用語集 / Glossary

Keep terminology consistent across `src/<target>.md` and `figures/*.<target>.txt`.
Change an entry here first, then search and replace in both places.

Style (ja): です・ます調. Half-width alphanumerics, no space between Japanese and Latin text (e.g. `4D.Vector型`).
Full-width `（）` and `：` in prose. First occurrence of a technical term: 日本語（English）.

## 4D terms (from the official 4D Japanese documentation)

| English | 日本語 | Notes |
|---|---|---|
| entity / entity selection | エンティティ / エンティティセレクション | |
| datastore | データストア | |
| dataclass | データクラス | |
| attribute | 属性 | |
| computed attribute | 計算属性 | |
| collection | コレクション | |
| object | オブジェクト | |
| method | メソッド | |
| project method | プロジェクトメソッド | |
| function | 関数 | |
| class | クラス | |
| parameter | 引数 | |
| form | フォーム | |
| form object | フォームオブジェクト | |
| list box | リストボックス | |
| web area | Webエリア | |
| 4D Web Server | 4D Webサーバー | |
| worker | ワーカー | |
| process | プロセス | |
| query | クエリ | |
| formula | フォーミュラ | |
| component | コンポーネント | |

## Document-specific terms

| English | 日本語 | Notes |
|---|---|---|
| System Worker / 4D.SystemWorker class | System Worker / 4D.SystemWorkerクラス | Class and product names kept in Latin script |
| callback (function) | コールバック（関数） | |
| completion callback / function | 完了コールバック / 完了関数 | |
| worker process | ワーカープロセス | |
| asynchronous / synchronous | 非同期 / 同期 | |
| non-blocking / blocking | ノンブロッキング / ブロッキング | |
| constructor | コンストラクター | |
| property | プロパティ | |
| File / Folder object | Fileオブジェクト / Folderオブジェクト | |
| project folder | プロジェクトフォルダー | 4D docs use the long vowel: フォルダー, サーバー, パラメーター, ブラウザー |
| Resources folder | Resourcesフォルダー | |
| (OpenSSL command-line) parameter | パラメーター | Not 引数, which is for 4D method/function parameters |
| flag / option | フラグ / オプション | Follows the English wording of each sentence |
| subcommand | サブコマンド | |
| cryptographic asset(s) | 暗号関連リソース | Not 暗号資産, which means cryptocurrency in Japanese |
| cryptographic operation | 暗号処理 | |
| private key / public key | 秘密鍵 / 公開鍵 | |
| key pair | 鍵ペア | |
| Certificate Signing Request (CSR) | 証明書署名要求（CSR） | First occurrence: 証明書署名要求（CSR：Certificate Signing Request） |
| self-signed certificate | 自己署名証明書 | |
| Certificate Authority (CA) | 認証局（CA） | |
| Distinguished Name (DN) | 識別名（DN） | |
| Common Name (CN) | コモンネーム（CN） | DN fields: 国（C）、都道府県（ST）、市区町村（L）、組織（O）、部門（OU） |
| serial number | シリアル番号 | |
| configuration file | 設定ファイル | |
| directive | ディレクティブ | |
| root of trust | 信頼の起点（root of trust） | |
| digital signature | デジタル署名 | |
| e-invoicing | 電子インボイス | First occurrence: 電子インボイス（e-invoicing） |
| authenticity / integrity | 真正性 / 完全性 | |
| line ending | 改行コード | |
| trust store | トラストストア | |
| extended validation certificate | EV（Extended Validation）証明書 | |
| headless execution | ヘッドレス実行 | |
| OpenSSL system check form | OpenSSLシステムチェックフォーム | Must match the localised form title (Phase 5) |
| demonstration application | デモアプリケーション | |
| technical note | テクニカルノート | |

## Proper nouns in examples

| English | 日本語 | Notes |
|---|---|---|
| Al Mahdi Bakkali | Al Mahdi Bakkali | Author name kept in Latin script |
| Finder / File Explorer | Finder / エクスプローラー | |
| Homebrew, winget, PowerShell, Let's Encrypt | (unchanged) | |
| US / California / San Francisco / My Company Inc. | (unchanged for now) | openssl.cnf sample; to be decided in Phase 4 |
