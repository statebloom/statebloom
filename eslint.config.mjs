import js from "@eslint/js";

// NOTE: RAVEN scaffolds this file with `typescript-eslint` wired in as well. It is
// deliberately omitted for now, because this repository currently contains no
// TypeScript at all — only two config files, JSON, and Markdown.
//
// Restoring it is not just an import: typescript-eslint@8 declares `typescript` as a
// REQUIRED peer pinned to ">=4.8.4 <6.1.0", while this project targets TypeScript 7.
// Adding it today would silently pull a TypeScript 5.x into the lockfile. Re-add it
// when the framework packages land here, and check the peer range against the
// TypeScript version they actually use at that point.

export default [
  {
    ignores: [
      "build/**",
      "coverage/**",
      "dist/**",
      "node_modules/**",
      // Vendored / tool-managed trees. Linting or reformatting these produces
      // conflicts on every `raven upgrade` for no benefit.
      ".agents/**",
      ".claude/**",
      ".codex/**",
      ".raven/**",
    ],
  },
  js.configs.recommended,
];
