# WordPress SVN tag cleaner

This GitHub Action deletes a specified folder tag from your WordPress SVN plugin repository.

## Configuration

### Required secrets
- `SVN_USERNAME`
- `SVN_PASSWORD`

Set these secrets in the repository settings.

### Required inputs
- Tag to remove (`tag-to-remove`): please require this input in your workflow

### Optional environment variables
- `SLUG`: the WordPress repository slug. It defaults to the GitHub repository name

### Example workflow

This example demonstrate a simple manual workflow

```yaml
name: Remove old tags from SVN
on:
  workflow_dispatch:
    inputs:
      tag-to-remove:
        description: 'Tag to remove'
        required: true
jobs:
  remove-tag:
    runs-on: ubuntu-latest
    name: Remove the tag
    steps:
      - uses: dottxado/action-wordpress-svn-tag-cleaner@1.0.0
        with:
          tag-to-remove: ${{ github.event.inputs.tag-to-remove }}
```
