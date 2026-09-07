# Pandoc Academic Manuscript Template

This is a small Pandoc-based template to produce .docx files from a source Markdown file and a reference BibTex file.
The advantage of this approach is that the DOCX file will have the styles, formatting and references based on separate files, making the Markdown file easier to manage.
**Markdown is the source. DOCX is a compiled artifact.**

Workflow:
```
                    ┌───────────────┐
                    │ manuscript.md │
                    └───────┬───────┘
                            │
                            │
             ┌──────────────┼──────────────┐
             │              │              │
             ▼              ▼              ▼
       references.bib   journal.csl   reference.docx
             │              │              │
             └──────────────┼──────────────┘
                            │
                            ▼
                         Pandoc
                            │
                            ▼
                    ┌────────────────┐
                    │ manuscript.docx│
                    └────────────────┘
```

Another advantage is that you can easily do manuscript version control with `git`.
And because you are keeping your manuscript progress in git, you can easily branch for versioning:
```
main
├── reviewer-1
├── reviewer-2
└── coauthor-edits
```

**DISCLAIMER:** This is not the right approach for heavily collaborative Word documents.
You should not be using this template for collaboration, unless your collaborators also want to work directly on Markdown.

The Markdown source is not designed to be round-tripped from DOCX.
Treat generated DOCX files as **outputs**, not source files.

## Dependencies
```
Pandoc
Git
A text editor
```
##  Getting started

Clone the repository with:
```
git clone git@github.com:AnttonLA/pandoc-academic-manuscript-template.git report-x
cd report-x
rm -rf .git
git init
```

Alternatively, use GitHub's "Use this template" functionality so the new project gets its own repository

## Build Configuration

By default, `build.sh` uses explicit command-line flags (`--bibliography`, `--csl`, `--reference-doc`, `--lua-filter`) to specify build parameters:

```bash
pandoc manuscript.md \
  --metadata-file=metadata.yaml \
  --bibliography=references.bib \
  --csl=styles/nature.csl \
  --reference-doc=templates/template.docx \
  --lua-filter=pagebreak-main/pagebreak.lua \
  --citeproc \
  --output=output/manuscript.docx
```

> **Note**: Defining configuration options via CLI flags in `build.sh` is the primary method used in this template. However, Pandoc also fully supports specifying these parameters inside `metadata.yaml` (e.g. `bibliography: references.bib`, `csl: styles/nature.csl`, `reference-doc: templates/template.docx`). Both approaches are valid based on project workflow preference.

## Lua Filters & Extensions

- **`pagebreak-main/`**: Contains the [Pandoc pagebreak Lua filter](https://github.com/pandoc/lua-filters/tree/master/pagebreak). This filter converts raw LaTeX page break commands (such as `\newpage` or `\pagebreak`) into native OpenXML page breaks when compiling to `.docx` format. It is invoked in `build.sh` via `--lua-filter=pagebreak-main/pagebreak.lua`.

## Project structure

```
pandoc-academic-manuscript-template/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── manuscript.md
├── references.bib
├── metadata.yaml
├── build.sh
│
├── pagebreak-main/
│   └── pagebreak.lua
│
├── styles/
│   └── journal.csl
│
├── templates/
│   └── template.docx
│
├── figures/
│   └── .gitkeep
│
└── output/
    └── .gitkeep
    └── manuscript.docx
```

