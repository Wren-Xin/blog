# WrenXin.com

Personal portfolio for Wren Xin — a single static page listing selected works and contact information.

## What this is

- Pure static HTML + CSS. No build step, no runtime, no dependencies.
- Deployed at <https://wrenxin.com/> as static files behind nginx.
- Source of truth for page content is `index.html` itself.

## Structure

```
index.html          page structure and content
assets/style.css    all styling (light/dark, responsive)
scripts/deploy.sh   parameterized deploy helper (no credentials)
```

## Adding a work entry

1. Copy an `<article class="work">` block in `index.html`.
2. Fill in: title + link, a `tag` label, a one-line description.
3. If the project exposes public badges, add them under `<p class="badges">` using the provider's badge URL — the numbers then update themselves.
4. Mark unfinished projects with `<span class="tag draft">in progress</span>`. Do not present a draft as a finished product.
5. Add a line to `CHANGELOG.md`.
6. Check the safety list below before committing.

## Before committing

- [ ] No internal paths, hostnames, IP addresses, or private project names.
- [ ] No sensitive values or account-state notes.
- [ ] Public name is consistently `Wren-Xin`.
- [ ] Work descriptions match what the public repository actually contains.
- [ ] The ICP number in the footer is correct and links to <https://beian.miit.gov.cn/>.

## Deploy

`scripts/deploy.sh` reads the target host and path from environment variables. Set `DEPLOY_HOST` and `DEPLOY_PATH` (and optionally `DEPLOY_PORT`), then run the script. Credentials are never stored in this repository.

## License

The site content is personal portfolio material. Code in this repository is released under MIT (see LICENSE).
