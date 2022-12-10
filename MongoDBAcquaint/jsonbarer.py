import json
from randmac import RandMac
import re


def get_json():
    with open('data.json') as file:
        file_data = json.load(file)
    print(file_data)
    return file_data


def get_MAC():
    MAC = re.sub("[:]", "-", str(RandMac()).upper())
    print(MAC)
    return MAC
