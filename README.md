<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://mapterhorn.github.io/.github/brand/screen/mapterhorn-logo-darkmode.png">
  <source media="(prefers-color-scheme: light)" srcset="https://mapterhorn.github.io/.github/brand/screen/mapterhorn-logo.png">
  <img alt="Logo" src="https://mapterhorn.github.io/.github/brand/screen/mapterhorn-logo.png">
</picture>

Public terrain tiles for interactive web map visualizations

## Viewer

[https://mapterhorn.com/viewer](https://mapterhorn.com/viewer)

## Examples

[https://mapterhorn.com/examples](https://mapterhorn.com/examples)

## Migrate from AWS Elevation Tiles (Tilezen Joerd)

```diff
"hillshadeSource": {
    "type": "raster-dem",
-   "tiles": ["https://elevation-tiles-prod.s3.amazonaws.com/terrarium/{z}/{x}/{y}.png"],
+   "tiles": ["https://tiles.mapterhorn.com/{z}/{x}/{y}.webp"],
    "encoding": "terrarium",
-   "tileSize": 256,
+   "tileSize": 512,
}

```

## Contributing

See [source-catalog/README.md](source-catalog/README.md) and [pipelines/README.md](pipelines/README.md).

## License

Code: BSD-3, see [LICENSE](https://github.com/mapterhorn/mapterhorn/blob/main/LICENSE).

Terrain data: various open-data sources, for a full list see [https://mapterhorn.com/attribution](https://mapterhorn.com/attribution).

## Running
```
mdkir working && cd working
docker run -d \
-v $(pwd)/bundle-store:/pipelines/bundle-store \
-v $(pwd)/pmtiles-store:/pipelines/pmtiles-store \
-v $(pwd)/source-store:/pipelines/source-store \
-v $(pwd)/tar-store:/pipelines/tar-store \
-v $(pwd)/aggregation-store:/pipelines/aggregation-store \
ghcr.io/francisbaileyh/mapterhorn:main
```

### Running the upload
```
docker run -d \
-e AWS_ACCESS_KEY_ID=<some id> \
-e AWS_SECRET_ACCESS_KEY=<some secret> \
-e AWS_S3_ENDPOINT=<some endpoint> \
-e AWS_S3_BUCKET=<some bucket> \
-v $(pwd)/bundle-store:/pipelines/bundle-store \
-v $(pwd)/pmtiles-store:/pipelines/pmtiles-store \
-v $(pwd)/source-store:/pipelines/source-store \
-v $(pwd)/tar-store:/pipelines/tar-store \
-v $(pwd)/aggregation-store:/pipelines/aggregation-store \
ghcr.io/francisbaileyh/mapterhorn:main upload
```

### Using a Custom Justfile
```
docker run -d \
-v $(pwd)/bundle-store:/pipelines/bundle-store \
-v $(pwd)/pmtiles-store:/pipelines/pmtiles-store \
-v $(pwd)/source-store:/pipelines/source-store \
-v $(pwd)/tar-store:/pipelines/tar-store \
-v $(pwd)/aggregation-store:/pipelines/aggregation-store \
ghcr.io/francisbaileyh/mapterhorn:main -f /path/to/Justfile -d ./ default
```
