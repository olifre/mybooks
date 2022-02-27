#!/bin/bash

BASE=https://olifre.github.io/mybooks

cat > sitemap.xml <<EOD
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
EOD

while IFS= read -r -d '' HTMLFILE; do
	echo "<url>" >> sitemap.xml
	# Canonicalize URLs.
	HTMLFILE=$(echo ${HTMLFILE} | sed 's:index.html$::')
	echo "<loc>${BASE}/${HTMLFILE}</loc>" >> sitemap.xml
	echo "</url>" >> sitemap.xml
done < <(find . -type f -iname "*.html" -printf '%P\0')

echo "</urlset>" >> sitemap.xml
