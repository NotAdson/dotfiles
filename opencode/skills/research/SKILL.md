---
name: research
description: Make a deep, structured research report on any topic the user names (e.g. "make a research about parallel processing"). Triggers on "make a research", "do research on", "research about", "deep dive into", "investigate". Downloads academic papers to sources/papers and saves the report as a markdown file under sources/. Use ONLY when the user wants multi-angle web research with sources, not quick factual answers or codebase work.
---

# Research Skill

You are conducting research on a topic supplied by the user. The topic is whatever follows the request — it can be academic ("scientific paper writing, coercion"), technical ("parallel processing"), or practical. Treat every topic with the same rigor.

## Workflow

1. **Parse the request**
   - Identify the core topic plus any sub-focus, constraints, audience, or depth hints in the user's wording ("techniques for", "about", "compared to").
   - If the topic is ambiguous between two very different fields (e.g. "coercion" in psychology vs. law), ask ONE targeted clarifying question before burning searches.

2. **Plan the angles** (internally, before searching)
   - Break the topic into 3–5 sub-questions that collectively cover it: definitions/terminology, state of the art / current consensus, methods or techniques, controversies/open problems, and practical applications or tools.
   - Do not search blindly; know what each search is for.

3. **Create the output folder first** (before any downloading or writing)
   - Run `mkdir -p sources/papers` in the project working directory.
   - The final report must be saved as a markdown file inside `sources/`, and downloaded papers go into `sources/papers/`.

4. **Search in passes**
   - Pass 1 (breadth): one broad websearch per sub-question, current year included in queries.
   - Pass 2 (papers): search for academic papers on the topic — use arXiv, Semantic Scholar, Google Scholar, or paper PDFs found via websearch. Collect 3–8 relevant papers for technical/academic topics; skip this pass if the topic is clearly non-academic.
   - Pass 3 (depth): for the most promising sources, use webfetch to read the primary source in full. Prefer primary sources (papers, official docs, standards) over blog summaries.
   - Search in the user's likely output language **and** English when the topic is language-sensitive (e.g. academic writing norms).
   - Stop when new searches return only information you already have — not when you have made every search you could.

5. **Download papers** (when possible)
   - For each relevant paper, find a direct PDF link (arXiv `https://arxiv.org/pdf/<id>`, author homepage, open-access publisher) and download it with bash curl:
     `curl -sL -o "sources/papers/<first-author-surname>-<year>-<short-slug>.pdf" "<pdf-url>"`
   - Verify each download actually succeeded: run `file sources/papers/*.pdf` and confirm output says `PDF document`. If a file comes back HTML (paywall/redirect page), delete it and skip that paper.
   - If a paper has no accessible PDF (paywalled, no preprint), do NOT fail — add it to the Sources section as "not downloadable (paywall)" and proceed.
   - Name files `<first-author-surname>-<year>-<short-slug>.pdf`, e.g. `vaswani-2017-attention-is-all-you-need.pdf`. Never use opaque URLs or version scars like `v3`.

6. **Verify before trusting**
   - Any surprising, load-bearing claim needs at least 2 independent sources.
   - Distinguish hard evidence, expert consensus, and single-author opinion in the report.
   - Note dates: prefer recent sources; flag when information may be outdated.

7. **Deliver the report** — save as `sources/report-<short-topic-slug>.md` (e.g. `sources/report-parallel-processing.md`) using the Write tool, and show the full content to the user in chat. Structure:
   - **Overview** — 2–4 sentences: what the topic is and why it matters.
   - **Key findings** — the meat, organized by sub-question, with inline links to sources.
   - **Techniques / methods** (if applicable) — concrete, actionable, numbered.
   - **Controversies or open questions** — where sources disagree.
   - **Practical takeaways** — what the user should actually do/know.
   - **Sources** — full list of consulted sources with links; for papers denote each either as `sources/papers/<filename>.pdf` or "not downloadable (paywall)".
   - At the end of the md file, list the folder contents: mention how many PDFs were downloaded and point to `sources/papers/`.

## Rules

- Never invent citations or sources. Only cite what you actually read via websearch/webfetch.
- Never invent paper filenames or pretend a download happened — every PDF in `sources/papers/` must have passed the `file` verification. Report actual counts, not intentions.
- If the user names a deliverable format ("as a PDF", "in Portuguese", "bullet summary"), follow it.
- If no sources can be found on some aspect, say so explicitly rather than filling the silence with plausible-sounding content.
- Keep the report in the language the user asked in (or match their request wording).
