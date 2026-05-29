# ⚡ Lightning Gacha

A 3D-printed gacha (capsule toy) machine that dispenses a capsule when you
pay over the Bitcoin Lightning Network. Built for **Japan RepRap Festival
2026**.

```
Bitcoin Wallet → LNbits → Raspberry Pi → Stepper Motor → Capsule
```

Scan a QR, send a Lightning payment, the Raspberry Pi sees it arrive
over a WebSocket from LNbits, and steps a NEMA-17 motor to release one
capsule.

## Repository layout

| Path        | What's in it                                                     |
| ----------- | ---------------------------------------------------------------- |
| `model/`    | 3D models (OpenSCAD sources, generated STL/3MF assets).          |
| `handout/`  | One-page A4 handout in English and Japanese (Typst → PDF).       |
| `software/` | Raspberry Pi software: LNbits WebSocket monitor + motor driver.  |
| `flake.nix` | Root Nix flake providing the dev shell for building the handout. |

## Building the handout

```sh
nix develop          # one-time: enter the dev shell with typst + tools
handout/build.sh     # regenerates assets and compiles both PDFs in place
```

If you have [direnv](https://direnv.net/) installed, `direnv allow` once
and the shell auto-activates on `cd`.

## Running on the Raspberry Pi

The `software/` directory holds the runtime that listens for Lightning
payments and drives the stepper motor:

- `lnbits-monitor.py` — opens a WebSocket to LNbits and watches for
  matching payments.
- `motor.py` — steps a NEMA-17 motor (55° forward, pause, 55° back) over
  GPIO when a payment lands. Pin assignments (`STEP_PIN=17`, `DIR_PIN=27`,
  `EN_PIN=22`) are at the top of the file.

Install the Python dependencies on the Pi:

```sh
pip install websockets rpi-gpio
```

Wire the TMC2209 stepper driver to the GPIO pins above, then point the
monitor at your LNbits server and Lightning Address:

```sh
export LNBITS_URL=https://your-lnbits-server
export LNBITS_API_KEY=your-invoice-read-key
export LNBITS_LN_ADDRESS=your-address@example.com
export LNBITS_MIN_SATS=500
python lnbits-monitor.py
```

The monitor watches for payments to `LNBITS_LN_ADDRESS` of at least
`LNBITS_MIN_SATS` and runs `motor.py` once per matching payment.

## License

The code, OpenSCAD models, Typst sources, and other original work in this
repository are licensed under the [MIT License](LICENSE).

Third-party assets bundled in the repository keep their own licenses:

| Asset                                    | License                   | Source / attribution                                                                                                                                                    |
| ---------------------------------------- | ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `handout/_assets/icons/*.svg` (most)     | ISC                       | [Lucide](https://lucide.dev/) — license note inline in each SVG.                                                                                                        |
| `handout/_assets/icons/raspberry-pi.svg` | Trademark                 | [Raspberry Pi Ltd.](https://www.raspberrypi.com/trademark-rules/) Used descriptively to identify the Raspberry Pi hardware.                                             |
| `model/sign/mdi/*.svg`                   | Apache 2.0                | [Material Design Icons](https://pictogrammers.com/library/mdi/) by Pictogrammers. See `model/sign/mdi/README.md`.                                                       |
| `model/opengrid/*.3mf`                   | CC BY 4.0                 | [OpenGrid wall/desk framework](https://www.printables.com/model/1214361-opengrid-walldesk-mounting-framework-and-ecosystem) by David D. See `model/opengrid/README.md`. |
| `model/lid/Bitcoin_lightning_bolt.svg`   | Public domain (community) | Lightning Network bolt symbol.                                                                                                                                          |

The handout build also pulls Typst packages
([fletcher](https://typst.app/universe/package/fletcher),
[cetz](https://typst.app/universe/package/cetz),
[oxifmt](https://typst.app/universe/package/oxifmt)) and the
fonts Source Han Sans (SIL OFL), Roboto (Apache 2.0), and Hack Nerd Font
(MIT) — each under their respective upstream licenses.
