# Template Scripts System

This directory contains shared JavaScript files that are injected into all NetNewsWire theme templates.

## Directory Structure

```
scripts/
├── template-scripts/          # Shared JS files (single source of truth)
│   ├── youtube-link-rewrite.js
│   └── linker.js
└── inject-template-scripts.sh # Script to inject JS into templates
```

## How It Works

1. **Source Files**: All JavaScript code lives in `scripts/template-scripts/`
2. **Injection Markers**: Each `*.nnwtheme/template.html` file contains markers:

   ```html
   <!-- INJECT_SCRIPTS_BEGIN -->
   <script src="youtube-link-rewrite.js"></script>
   <script src="linker.js"></script>
   <!-- INJECT_SCRIPTS_END -->
   ```

3. **Build Process**: Running `./scripts/inject-template-scripts.sh` replaces the marker content with inline `<script>` tags containing the actual JavaScript

## Usage

### Pre-Commit Hook

A Git pre-commit hook automatically injects scripts when you commit changes to:

- Any `*.nnwtheme/template.html` file
- Any file in `scripts/template-scripts/`

The hook runs `./scripts/inject-template-scripts.sh` and stages the updated templates automatically.

### During Development

**Edit the source files:**

```bash
# Edit the shared scripts
vim scripts/template-scripts/linker.js
vim scripts/template-scripts/youtube-link-rewrite.js
```

**Inject changes manually (optional):**

```bash
./scripts/inject-template-scripts.sh
```

**Test locally:**
Open any `test/*.html` file in a browser. Test files reference the source scripts directly, so no build step is needed for testing.

### Adding a New Script

1. Create your script in `scripts/template-scripts/yourscript.js`
2. Add a reference in each template's marker section:

   ```html
   <!-- INJECT_SCRIPTS_BEGIN -->
   <script src="youtube-link-rewrite.js"></script>
   <script src="linker.js"></script>
   <script src="yourscript.js"></script>
   <!-- INJECT_SCRIPTS_END -->
   ```

3. Run the injection script: `./scripts/inject-template-scripts.sh`

### Why This Approach?

- **Single Source of Truth**: Edit once in `scripts/template-scripts/`, apply everywhere
- **NNW Compatibility**: Templates get inline scripts (NNW doesn't support external JS)
- **Easy Testing**: Test files reference source scripts directly
- **No Duplication**: Avoid maintaining the same code in 5+ template files
- **Automated**: Pre-commit hook keeps templates up-to-date

## Files

- `youtube-link-rewrite.js` - Embeds YouTube videos inline
- `linker.js` - Extracts URLs and creates reference-style citations
- `inject-template-scripts.sh` - Injection automation script

## Notes

- Pre-commit hook automatically injects scripts when committing
- The injection script is idempotent (safe to run multiple times)
- Test files (`test/*.html`) use relative paths to source scripts
- Template files (`*.nnwtheme/template.html`) have inline scripts
