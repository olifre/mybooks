#!/bin/bash

BASE=https://olifre.github.io/mybooks

cat > sitemap.xml <<EOD
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
EOD

NOW_DATE=$(date +%Y-%m-%d)

while IFS= read -r -d '' CUR_FILE; do
	echo "  <url>" >> sitemap.xml
	# Canonicalize URLs.
	CUR_FILE=$(echo ${CUR_FILE} | sed 's:index.html$::')
	echo "    <loc>${BASE}/${CUR_FILE}</loc>" >> sitemap.xml
	LAST_MODIFIED=${NOW_DATE}
	if [[ ${CUR_FILE} == *.html ]]; then
		# It's an HTML file, try to deduce last modified time.
		grep -q "http-equiv=.last-modified" "${CUR_FILE}" && \
			LAST_MODIFIED=$(cat "${CUR_FILE}" | grep "http-equiv=.last-modified" | \
					grep -Po "<meta.*content='\K[[:digit:]]+-[[:digit:]]+-[[:digit:]]+")
	fi
	echo "    <lastmod>${LAST_MODIFIED}</lastmod>" >> sitemap.xml
	echo "  </url>" >> sitemap.xml
done < <(find . -type f \( -iname "*.html" -o -iname "*.pdf" \) -printf '%P\0')

echo "</urlset>" >> sitemap.xml
