# WordPress SVN tag cleaner

This GitHub Action deletes a specified folder tag from your WordPress SVN plugin repository.

## Configuration

### Required secrets
- `SVN_USERNAME`
- `SVN_PASSWORD`
Set these secrets in the repository settings

### Required inputs
- Tag to remove (`tag-to-remove`): please require this input in your workflow

### Optional environment variables
- `SLUG`: the WordPress repository slug. It defaults to the GitHub repository name
