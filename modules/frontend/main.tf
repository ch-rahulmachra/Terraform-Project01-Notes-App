resource "aws_s3_bucket" "frontend" {
  bucket = var.bucket_name

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Project     = "Notes-App"
    Environment = var.env
  }
}

resource "aws_s3_bucket_object" "frontend_files" {
  for_each = fileset("${path.root}/frontend", "**")

  bucket = aws_s3_bucket.frontend.id
  key    = each.value
  source = "${path.root}/frontend/${each.value}"
  etag   = filemd5("${path.root}/frontend/${each.value}")

  content_type = lookup(
    {
      "html" = "text/html"
      "js"   = "application/javascript"
      "css"  = "text/css"
      "png"  = "image/png"
      "jpg"  = "image/jpeg"
      "svg"  = "image/svg+xml"
    },
    regex("\\.([^.]+)$", each.value)[0],
    "text/plain"
  )
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.frontend.arn}/*"
      }
    ]
  })
}