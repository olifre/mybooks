#!/bin/bash
sed -i \
	-e 's#\[i\]#\\emph{#g' \
	-e 's#\[/i\]#}#g' \
	-e 's#\[b\]#\\textbf{#g' \
	-e 's#\[/b\]#}#g' \
	-e 's# - # --- #g' \
	$1
