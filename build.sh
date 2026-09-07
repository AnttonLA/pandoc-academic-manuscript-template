#!/bin/bash

set -euo pipefail

mkdir -p output

pandoc manuscript.md \
  --metadata-file=metadata.yaml \
  --bibliography=references.bib \
  --csl=styles/nature.csl \
  --reference-doc=templates/template.docx \
  --lua-filter=pagebreak-main/pagebreak.lua \
  --citeproc \
  --output=output/manuscript.docx