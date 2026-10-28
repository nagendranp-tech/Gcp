resource "google_storage_bucket" "task_bucket" {
  name                        = var.bucket_name
  location                    = var.bucket_location
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.task_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_object" "index" {
  name         = "index.html"
  bucket       = google_storage_bucket.task_bucket.name
  content_type = "text/html"

  content = <<-EOF
    <!DOCTYPE html>
    <html>
    <head>
      <title>Task 4</title>
    </head>
    <body>
      <h1>Welcome to Task 4</h1>
      <p>This website is hosted on Google Cloud Storage and served through Cloud CDN.</p>
    </body>
    </html>
  EOF
}

resource "google_storage_bucket_object" "not_found" {
  name         = "404.html"
  bucket       = google_storage_bucket.task_bucket.name
  content_type = "text/html"

  content = <<-EOF
    <!DOCTYPE html>
    <html>
    <head>
      <title>404</title>
    </head>
    <body>
      <h1>404 - Page Not Found</h1>
    </body>
    </html>
  EOF
}