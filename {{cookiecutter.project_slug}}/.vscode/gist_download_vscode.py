#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
git_label.py
---------------------------------------------------------------------------------------
Author: Trieu Phat Luu
Contact: tpluu2207@gmail.com
Created on: 06/17/2020 03:36:18
"""

#%%
# =====================================IMPORT PACKAGES=================================
# Standard Packages
import argparse
import os
import shutil

# FileIO Packages
import json

# Web pages and URL Related
import requests

# Utilities
import time


# =====================================DEFINES=================================
OWNER = "luutp"
GIT_AUTH = os.environ.get("GIT_AUTH")
script_dir = os.path.abspath(os.path.dirname(__file__))
VSCODE_DIR = os.path.join(script_dir)
# =====================================START=========================================

# Web pages and URL Related
# ======================================================================================
# MAIN


def load_json(json_filepath):
    output = None
    if not os.path.isfile(json_filepath):
        print(f"{json_filepath} is not a file")
        return output

    print(f"START-Loading json file: {json_filepath}")
    start_time = time.time()
    with open(json_filepath, "r") as fid:
        output = json.load(fid)

    elapsed_time = time.time() - start_time
    hours, rem = divmod(elapsed_time, 3600)
    minutes, seconds = divmod(rem, 60)
    msg = "DONE-" "Elapsed Time: {hours:0>2}:{mins:0>2}:{secs:0>2}\t".format(
        hours=int(hours),
        mins=int(minutes),
        secs=int(seconds),
    )
    print(msg)
    return output


def save_json(json_data, json_filepath):
    with open(json_filepath, "w") as fid:
        json.dump(json_data, fid)


def makedir(inputDir, remove=False):
    """Summary:
    --------
    Make directory
    Inputs:
    -------
    inputDir (str): fullpath to directory to be created
    remove (bool): option to remove current existing folder
    """
    if remove is True and os.path.exists(inputDir):
        print("Remove existing folder")
        shutil.rmtree(inputDir)

    if not os.path.exists(inputDir):
        print(f"Making directory: {inputDir}")
        os.makedirs(inputDir)
    else:
        print(f"mkdir: Directory already exist: {inputDir}")


def list_gist():
    url = f"https://api.github.com/users/{OWNER}/gists"
    token = {
        "Authorization": f"token {GIT_AUTH}",
        "Accept": "application/vnd.github.inertia-preview+json",
    }

    print("List gist")
    data_dict = {"per_page": 30, "page": 1}
    outputs = None
    try:
        r = requests.get(url, data=json.dumps(data_dict), headers=token, timeout=10)
        if r.status_code == 422:
            print("FAILED. Status: 422 Unprocessable Entity")
            print(f"{r.text}")

        elif r.status_code == 200:
            outputs = r.json()
            print(f"Status code: {r.status_code}")
            print("SUCCESSFUL!")

        else:
            pass

    except Exception as e:
        print(e)
    return outputs


def get_vscode_gist():
    outputs = list_gist()
    vscode_gist_url = []
    for output in outputs:
        if ".vscode" in output.get("description"):
            for key, val in output.get("files").items():
                vscode_gist_url.append(val.get("raw_url"))

    return vscode_gist_url


def download_gist_file(url, output_dir=VSCODE_DIR):
    makedir(output_dir)
    output_filename = os.path.basename(url)
    try:
        r = requests.get(url, timeout=10)
        if r.status_code == 200:
            print(f"Status code: {r.status_code}")
            print("SUCCESSFUL!")
            output_filepath = os.path.join(output_dir, output_filename)
            with open(output_filepath, "wb") as fid:
                fid.write(r.content)
            print(f"DONE: file save to: {output_filepath}")

    except Exception as e:
        print(e)


def main():
    vscode_gist_urls = get_vscode_gist()
    for url in vscode_gist_urls:
        download_gist_file(url)


# =====================================DEBUG===================================

if __name__ == "__main__":
    main()
