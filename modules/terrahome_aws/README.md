## Terrahome AWS

```tf
module "home_dizzy" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    bucket_name = "${var.dizzy.project_folder}-three-kings"
    content_version = var.dizzy.content_version
    project_folder = var.dizzy.project_folder
    website_root_filepath = var.website_root_filepath
}
```

The public directory expects the following:
- index.html
- error.html
- assets

But if there are more files html files they will be copied over as well

If there is a .css file that will also be copied over over with the correct file type of text/css

All top level files in assets will be copied, but not any subdirectories.