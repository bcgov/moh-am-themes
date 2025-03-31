#!/usr/bin/env node
import * as esbuild from 'esbuild'

await esbuild.build({
  entryPoints: [],
  bundle: true,
  format: "esm",
  packages: "external",
  loader: { '.tsx': 'tsx' },
  outdir: '../resources/content/moh-app-realm-account-v3',
})