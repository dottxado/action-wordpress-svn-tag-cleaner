#!/bin/bash

TAG=$1

if [[ -z "$SVN_USERNAME" ]]; then
	echo "Set the SVN_USERNAME secret"
	exit 1
fi

if [[ -z "$SVN_PASSWORD" ]]; then
	echo "Set the SVN_PASSWORD secret"
	exit 1
fi

if [[ -z "$SLUG" ]]; then
	SLUG=${GITHUB_REPOSITORY#*/}
fi
echo "ℹ︎ SLUG is $SLUG"

SVN_URL="https://plugins.svn.wordpress.org/${SLUG}/"
SVN_DIR="/github/svn-${SLUG}"

#svn list "$SVN_URL" << EOF
#p
#EOF
#if [ $? -ne 0 ]; then
#  echo "ℹ︎ Error on SVN list, exiting"
#  exit 1
#fi

echo "➤ Checking out .org repository..."
svn checkout --depth immediates "$SVN_URL" "$SVN_DIR" --trust-server-cert
if [ $? -ne 0 ]; then
  echo "ℹ︎ Error on SVN checkout, exiting"
  exit 1
fi
cd "$SVN_DIR"
svn update --set-depth infinity tags

echo "➤ Removing tag $TAG"
cd "${SVN_DIR}/tags"
svn delete $TAG
if [ $? -ne 0 ]; then
  echo "ℹ︎ Cannot remove the tag. Are you sure it exists?"
  exit 1
fi

svn commit -m "Removed tag" --no-auth-cache --non-interactive --username "$SVN_USERNAME" --password "$SVN_PASSWORD"

echo "✓ Tag removed!"
