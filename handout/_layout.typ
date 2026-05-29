// Shared layout for the Lightning Gacha handout.
// One A4 page: orange header (with QR), full-width horizontal flow as a
// hero, then a 2-column hardware/exploded-view block.

#import "@preview/fletcher:0.5.5" as fletcher: diagram, node, edge

#let orange    = rgb("#f7931a")
#let ink       = rgb("#1a1a1a")
#let muted     = rgb("#6b6b6b")
#let rule-grey = rgb("#d8d8d8")
#let chip-bg   = rgb("#fff4e3")

#let section-header(label) = text(
  size: 9pt, weight: "black", fill: orange, tracking: 1.2pt,
)[#upper(label)]

// Tint a Lucide stroke-only SVG by swapping `currentColor` for a hex value.
#let tinted-icon(path, color, size: 14pt) = {
  let data = read(path)
  let recolored = data.replace("currentColor", color.to-hex())
  box(width: size, height: size, image(bytes(recolored), format: "svg", height: size))
}

#let stacked-node(content, label, label-size: 10pt) = box(
  stroke: 0.9pt + ink,
  fill: white,
  radius: 7pt,
  inset: (x: 10pt, y: 8pt),
  stack(dir: ttb, spacing: 5pt,
    align(center, content),
    align(center, text(weight: "medium", size: label-size)[#label]),
  )
)

#let make-flow-diagram(
  wallet: [Bitcoin#linebreak()Wallet],
  lnbits: "LNbits",
  rpi: [Raspberry#linebreak()Pi],
  motor: [Stepper#linebreak()Motor],
  capsule: [Capsule#linebreak()Drops],
  lightning-edge: [Lightning],
  ws-edge: [WebSocket],
  gpio-edge: [GPIO],
  label-size: 10pt,
) = {
  let lucide-node(path, label) = stacked-node(
    tinted-icon(path, orange, size: 22pt), label, label-size: label-size,
  )
  let rpi-node(label) = stacked-node(
    image("_assets/icons/raspberry-pi.svg", height: 24pt), label, label-size: label-size,
  )
  let edge-label(label) = text(size: 8pt, fill: muted, weight: "medium")[#label]

  diagram(
    spacing: (16mm, 0mm),
    node-stroke: none,
    edge-stroke: 1pt + muted,

    node((0,0), lucide-node("_assets/icons/wallet.svg", wallet)),
    node((1,0), lucide-node("_assets/icons/zap.svg", lnbits)),
    node((2,0), rpi-node(rpi)),
    node((3,0), lucide-node("_assets/icons/cog.svg", motor)),
    node((4,0), lucide-node("_assets/icons/pill.svg", capsule)),

    edge((0,0), (1,0), "->", edge-label(lightning-edge), label-side: left),
    edge((1,0), (2,0), "->", edge-label(ws-edge),        label-side: left),
    edge((2,0), (3,0), "->", edge-label(gpio-edge),      label-side: left),
    edge((3,0), (4,0), "->", edge-label[ ],              label-side: left),
  )
}

#let handout(
  body-font: "Roboto",
  cjk-font: none,
  lang: "en",
  title: "LIGHTNING GACHA",
  lead: [],
  qr-caption: [],
  exploded-caption: [],
  works-heading: [],
  works-items: (),
  hw-heading: [],
  hw-items: (),
  source-heading: [],
  source-body: [],
  flow-labels: (:),
  footer: [],
) = {
  set document(title: title)
  set page(paper: "a4", margin: 0pt)
  let fonts = if cjk-font == none { (body-font,) } else { (body-font, cjk-font) }
  set text(font: fonts, size: 10.5pt, fill: ink, lang: lang)
  set par(leading: 0.65em, justify: false)

  // ── Header band: bolt + title + QR ──────────────────────────────────────
  block(width: 100%, fill: orange, inset: (x: 1.6cm, y: 1.1cm))[
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: 0.7cm,
      align: (center + horizon, left + horizon, center + horizon),
      image("_assets/bolt-white.svg", width: 3.6cm),
      align(horizon, text(fill: white, weight: "black", size: 36pt, tracking: -0.3pt)[#title]),
      stack(dir: ttb, spacing: 4pt,
        box(fill: white, inset: 3pt, radius: 2pt)[
          #image("../model/sign/qr.svg", width: 2.7cm)
        ],
        align(center, text(fill: white, size: 9pt, weight: "medium")[#qr-caption]),
      ),
    )
  ]

  // ── Body ────────────────────────────────────────────────────────────────
  block(width: 100%, inset: (x: 1.6cm, y: 0.9cm))[
    // Lead text (full width)
    #set par(leading: 0.72em)
    #text(size: 12pt)[#lead]
    #set par(leading: 0.65em)

    #v(14pt)

    // Horizontal flow diagram (centered)
    #align(center, make-flow-diagram(..flow-labels))

    #v(14pt)

    // Shared bullet renderer for Works + Hardware sections.
    #let bullet(item) = grid(
      columns: (0.45cm, 1fr),
      align: (left + top, left + top),
      text(fill: orange, weight: "bold")[▸],
      item,
    )
    #let bullets-2col(items) = {
      let half = calc.floor(items.len() / 2)
      grid(
        columns: (1fr, 1fr),
        column-gutter: 0.7cm,
        [#for item in items.slice(0, half) [#bullet(item)]],
        [#for item in items.slice(half) [#bullet(item)]],
      )
    }

    // How it works — bulleted component descriptions.
    #section-header[#works-heading]
    #v(4pt)
    #bullets-2col(works-items)

    #v(12pt)
    #line(length: 100%, stroke: 0.6pt + rule-grey)
    #v(10pt)

    // Bottom: hardware bullets (left, single column) + larger exploded view (right)
    #grid(
      columns: (1fr, 6.5cm),
      column-gutter: 1cm,
      align: (left + top, center + top),
      [
        #section-header[#hw-heading]
        #v(4pt)
        #for item in hw-items [#bullet(item)]

        #v(14pt)
        #section-header[#source-heading]
        #v(6pt)
        #grid(
          columns: (auto, 1fr),
          column-gutter: 0.5cm,
          align: (center + horizon, left + horizon),
          box(stroke: 0.7pt + ink, fill: white, inset: 3pt, radius: 2pt)[
            #image("_assets/github-qr.svg", width: 2.2cm)
          ],
          [
            #source-body
            #v(3pt)
            #text(font: "Hack Nerd Font Mono", size: 8pt, fill: muted)[https://github.com/aostanin/jrrf-gacha]
          ],
        )
      ],
      stack(dir: ttb, spacing: 2pt,
        image("_assets/exploded.png", width: 100%),
        align(center, text(size: 8pt, fill: muted, weight: "medium", style: "italic")[#exploded-caption]),
      ),
    )
  ]

  // ── Footer (pinned to bottom of page) ───────────────────────────────────
  place(
    bottom + left,
    dx: 1.6cm,
    dy: -0.9cm,
    block(width: 100% - 3.2cm)[
      #line(length: 100%, stroke: 0.6pt + rule-grey)
      #v(6pt)
      #text(size: 8.5pt, fill: muted)[#footer]
    ],
  )
}
