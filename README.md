# OpenSSL-Integration

OpenSSL in 4D using System Workers  
By Al Mahdi Bakkali, Technical Support Engineer, 4D Inc.  
Translated from [Technical Note 26-02](https://kb.4d.com/assetid=79941)

## Japanese translation

The original PDF (`document/26-02_OpenSSL.pdf`) has been disassembled into
editable plain-text parts. Edit the Japanese files, then run `make` to reassemble the PDF.
Repeat as often as needed.

```
document/26-02_OpenSSL.pdf            original (English)
src/en.md                             English body text (reference, from the PDF)
src/ja.md                             Japanese body text            <- edit
figures/fig-NN.png                    original figure images (screenshots)
figures/fig-NN-ja.png                 Japanese screenshots          <- replace
figures/fig-NN.en.txt                 English text in each figure (one line per label)
figures/layout/fig-NN.json            figure settings ("replace" selects the Japanese screenshot)
glossary.md                           terminology and style decisions
style/style.css                       page layout and typography
demo/OpenSSL-Integration/             4D demo project (English and Japanese UI)
build/26-02_OpenSSL_ja.pdf            output (not committed)
```

### Build

Requires macOS (Hiragino fonts), Python 3, and Google Chrome (or Edge/Chromium) for PDF printing.

```sh
make          # check + render figures + build/26-02_OpenSSL_ja.pdf
make check    # only verify that code blocks and figure references are intact
make figures  # only re-render build/figures/*.png
```

### Editing the body text (`src/ja.md`)

- Markdown: `##`/`###`/`####` headings, `-` lists, `**bold**`, tables, `>` notes.
- 4D code blocks and shell commands must stay byte-identical to `src/en.md`; the build refuses to run otherwise.
  ```` ```text ```` blocks hold sample values (the OpenSSL configuration file) and may differ.
- `![caption](fig-NN)` places a figure; translate the caption, keep `fig-NN`.
- Paragraphs are in the same order as `src/en.md`, so the two files can be compared side by side.
- The table of contents and its page numbers are generated automatically.

### Figures

All four figures (`fig-01` to `fig-04`) are full-screen screenshots of the demo on Windows. Instead of
overlaying text, the layout's `"replace": "fig-NN-ja.png"` swaps in the Japanese screenshot
`figures/fig-NN-ja.png`, taken from the localised demo and cropped to the 4D window
(the original `fig-NN.png` is kept for reference).

### Demo (`demo/OpenSSL-Integration/`)

The demo runs in English or Japanese, following the system language (4D 21 or later):

- Form labels, window titles, the menu and alert messages are in XLIFF files:
  `Resources/en.lproj/*EN.xlf` and `Resources/ja.lproj/*JA.xlf`.
  Messages with values (paths, seconds, error text) use `{placeholder}` templates filled by `Replace string`.
- Form and method names, OpenSSL commands, file names and certificate field codes (C, ST, O, OU, CN) are not translated.
- Labels were resized to fit the Japanese text.
- On Windows, ARM processors are detected (OpenSSL-Win64-ARM path) and the architecture is shown in the startup window.
- Compilation errors in the original project were fixed (variable declarations in `_startupForm`, a condition in `signXML`).

OpenSSL must be installed separately (`winget install openssl` on Windows, `brew install openssl@3` on macOS).

### Re-extracting

`make extract` disassembles the PDF again but never overwrites existing files.
`.venv/bin/python tools/extract.py --force` starts over from scratch (discards layout tweaks
and `en` corrections; `ja` files are not touched).
