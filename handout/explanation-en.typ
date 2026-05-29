#import "_layout.typ": handout

#handout(
  body-font: "Roboto",
  lang: "en",
  title: "LIGHTNING GACHA",

  lead: [
    Scan the QR, send a #text(weight: "black", fill: rgb("#f7931a"))[Lightning payment],
    and a capsule drops out.
  ],
  qr-caption: [`gacha@ostan.in`],
  exploded-caption: [Printed Parts],

  works-heading: [How it works],
  works-items: (
    [*Bitcoin Wallet* — any Lightning wallet on your phone (Phoenix, Wallet of Satoshi, Zeus…).],
    [*LNbits* — open-source Lightning payment server with a WebSocket API.],
    [*Raspberry Pi* — subscribes to payment events and drives the motor.],
    [*Stepper Motor* — rotates a paddle inside the gacha to release one capsule per turn.],
  ),

  hw-heading: [Hardware],
  hw-items: (
    [*Body* — 3D-printed in three parts, modeled in OpenSCAD.],
    [*Dispenser* — ⌀75 mm capsule chamber with a stepper-driven paddle.],
    [*Controller* — Raspberry Pi Zero 2.],
    [*Motor* — NEMA-17 17HS4401, 1.8°/step, 42 N·cm.],
    [*Motor Driver* — TMC2209 (silent 1/8 microstepping → 1600 steps/rev).],
    [*Power* — USB-C PD trigger (12~V) → LM2596 step-down.],
  ),

  source-heading: [Open Source],
  source-body: [
    All 3D models and software are on GitHub.
  ],

  footer: [
    Designed & built by Andrei Ostanin · Japan RepRap Festival 2026
  ],
)
