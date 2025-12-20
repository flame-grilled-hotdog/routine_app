# routine_app


## 2025/12
アーキテクチャ構成決め
```project
routine_app
├─ lib
│  ├─ screen
│  │  └─ common_main.dart（共通部品含め）：トリ
│  │  └─ routine.dart（メイン画面（達成状況））：福島
│  │  └─ set_goal.dart（目標設定画面）：トリ
│  │  └─ goal_detail.dart（達成状況詳細画面）：福島
│  │  └─ goals.dart（目標一覧画面）：福島
│  ├─ app
│  │  └─ notification.dart（通知）：トリ
│  │  └─ unity.dart（リワード）：福島
│  └─ repository
│       └─ XXXX.dart（目標Tbl）：
│       └─ YYYY.dart（達成状況Tbl）：
└─ README.md

目標Tbl
|目標番号|目標名|実施頻度（分子）|実施頻度分母（d/w/m）|期間|開始日時|終了日時|
|---|---|---|---|---|---|
|R000001|朝7時に起きる|1|d|7|20251220141200000|20251227141200000|
|R000002|朝7時に起きる|1|d|7|20251220141200000|20251227141200000|
|R000003|朝7時に起きる|1|d|7|20251220141200000|20251227141200000|

達成状況Tbl
|達成番号|目標番号|日時|達成フラグ|
|---|---|---|---|
|G000001|R000001|20251220141200000|true|
|G000002|R000001|20251221201500000|false|
|G000003|R000001|20251223084500000|true|
|G000004|R000001|20251225084500000|true|
|G000005|R000001|20251226084500000|true|

```
## 2025/11
A new Flutter project.

Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
