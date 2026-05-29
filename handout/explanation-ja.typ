#import "_layout.typ": handout

#handout(
  body-font: "Source Han Sans",
  cjk-font: "Source Han Sans",
  lang: "ja",
  title: [ライトニング#linebreak()ガチャガチャ],

  lead: [
    QRコードをスキャンして
    #text(weight: "black", fill: rgb("#f7931a"))[ライトニングで支払う]と、
    カプセルが1つ落ちてきます。
  ],
  qr-caption: [`gacha@ostan.in`],
  exploded-caption: [3Dプリント部品],

  flow-labels: (
    wallet: [ウォレット],
    lnbits: [LNbits],
    rpi: [Raspberry#linebreak()Pi],
    motor: [ステッピング#linebreak()モーター],
    capsule: [景品],
    lightning-edge: [ライトニング],
    ws-edge: [WebSocket],
    gpio-edge: [GPIO],
    label-size: 8.5pt,
  ),

  works-heading: [仕組み],
  works-items: (
    [*ウォレット* — お手持ちのライトニング対応ウォレット（Phoenix、Wallet of Satoshi、Zeusなど）。],
    [*LNbits* — オープンソースのライトニング決済サーバー。WebSocket APIで通知。],
    [*Raspberry Pi* — 入金イベントを購読し、モーターを駆動。],
    [*ステッピングモーター* — ガチャ内のパドルを回転させ、カプセルを1つ排出。],
  ),

  hw-heading: [ハードウェア],
  hw-items: (
    [*本体* — 3Dプリント・3分割。OpenSCADで設計。],
    [*排出機構* — ⌀75 mmのカプセル室とモーター駆動のパドル。],
    [*コントローラー* — Raspberry Pi Zero 2。],
    [*モーター* — NEMA-17 17HS4401、1.8°/step、42 N·cm。],
    [*モータードライバー* — TMC2209（静音1/8マイクロステップ → 1600 steps/rev）。],
    [*電源* — USB-C PDトリガー（12~V）→ LM2596降圧。],
  ),

  source-heading: [オープンソース],
  source-body: [
    3DモデルとソフトウェアはGitHubで公開しています。
  ],

  footer: [
    制作: Andrei Ostanin · Japan RepRap Festival 2026
  ],
)
