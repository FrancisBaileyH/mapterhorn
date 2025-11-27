#!/bin/bash

#uv run python source_download.py debug-glo30
#uv run python source_download.py debug-swissalti3d
uv run python source_bounds.py debug-glo30
uv run python source_bounds.py debug-swissalti3d

uv run python source_set_crs.py debug-glo30 EPSG:3979
uv run python source_set_crs.py debug-swissalti3d EPSG:3979

uv run python source_set_nodata.py debug-glo30 -32767
uv run python source_set_nodata.py debug-swissalti3d -32767

uv run python aggregation_covering.py
uv run python aggregation_run.py

uv run python downsampling_covering.py
uv run python downsampling_run.py

uv run python remove_dangling_pmtiles.py

TMPDIR=/tmp uv run python bundle.py 0.0.0

uv run python download_urls.py 0.0.0
uv run python attribution.py
