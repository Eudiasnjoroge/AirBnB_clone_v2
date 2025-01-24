#!/usr/bin/env python3
from fabric.api import local
from datetime import datetime
import os

def do_pack():
    """
    Generates a .tgz archive from the contents of the web_static folder.
    Returns:
        str: The archive path if successful, None otherwise.
    """
    versions_dir = "versions"
    if not os.path.exists(versions_dir):
        os.makedirs(versions_dir)

    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
    archive_path = f"{versions_dir}/web_static_{timestamp}.tgz"

    print(f"Packing web_static to {archive_path}")

    result = local(f"tar -cvzf {archive_path} web_static")

    if result.failed:
        return None
    return archive_path
