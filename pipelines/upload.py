import json
import os

import utils

SILENT = False

def upload_local_resource_to_s3(directory, filename, bucket, key, region, endpoint):
    '''
    Requires the following env variables:
    $ export AWS_ACCESS_KEY_ID=MY_KEY
    $ export AWS_SECRET_ACCESS_KEY=MY_SECRET
    '''
    command = f'aws s3 cp {directory}/{filename} s3://{bucket}/{key} --region {region} --endpoint "{endpoint}"'
    _, err = utils.run_command(command, silent=SILENT)
    if err != '':
        print('err:', err)
        raise Exception(err)

if __name__ == '__main__':

    bucket = os.environ['AWS_S3_BUCKET']
    region = 'auto'
    endpoint = os.environ['AWS_S3_ENDPOINT']
    
    # PMTiles

    download_urls = None
    with open('bundle-store/download_urls.json') as f:
        download_urls = json.load(f)

    for item in download_urls['items']:
        print(item['name'])
        filename = item['name']
        directory = f'prod/tiles/{filename.replace(".pmtiles", "")}/'
        key = filename
        upload_local_resource_to_s3(directory, filename, bucket, key, region, endpoint)
    
    # Special files

    directory = 'prod/tiles/'

    filename = 'attribution.json'
    key = filename
    upload_local_resource_to_s3(directory, filename, bucket, key, region, endpoint)

    filename = 'download_urls.json'
    key = filename
    upload_local_resource_to_s3(directory, filename, bucket, key, region, endpoint)

    filename = 'coverage.pmtiles'
    key = filename
    upload_local_resource_to_s3(directory, filename, bucket, key, region, endpoint)

