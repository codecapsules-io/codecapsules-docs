---
icon: hand-wave
---

# Code Capsules Documentation Site

## Setup

1. Clone this repository and the mkdocs repository available at https://github.com/codecapsules-io/mkdocs-material-insiders to your local machine.
2. Make sure you have Docker installed and runnning
3. Change into the mkdocs-material-insiders repository and build the Docker container, e.g.

```
docker build . -t cc-docs-builder
```

## Previewing the site and any changes locally

All content is created in markdown files in the 'docs' sub directory. Navigation is defined in the mkdocs.yml file. To make any changes, edit\
the relevant files or create new markdown files.

From the root of this repository, start a local dev server with

```
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs cc-docs-builder
```

This will watch the `docs/` folder for changes and preview the docs site on localhost:8000.

## Building the static site and pushing to git

We commit both the source (markdown) versions and the built (html) version of the site to this repo. The built version lives in "site". This is\
automatically handled by the mkdocs Docker builder.

Once you're happy with the changes in your local preview, build the site with

```
docker run --rm -it -v ${PWD}:/docs cc-docs-builder build
```

Check with `git diff` or similar that the files modified are what you expect and then add and commit the `site` subdirectory to git and push.

```
git add site
git commit -m "static build"
git push origin main
```

You should also push any changes to the markdown version. We usually use a descriptive commit message for the markdown changes but just "static build" to push the built version.

```
git add docs
git commit -m "added a new tutorial about foobar
git push origin main # or be cool and use branches
```

## Testing and deploying

Test the final container (including Caddy etc) with:

```
docker run -p 5555:5555 -d eu.gcr.io/appstrax/code-capsules-docs:1.0.51
```

and deploy with

```
docker build -t eu.gcr.io/appstrax/code-capsules-docs:1.0.51 .
```

```
docker push eu.gcr.io/appstrax/code-capsules-docs:1.0.51
```
