Aws.config.update(
  endpoint:  ENV['S3_ENDPOINT'],
  access_key_id: ENV['S3_KEY_ID'],
  secret_access_key: ENV['S3_SECRET_KEY'],
  force_path_style: true,
  region: ENV['S3_REGION']
)