import json
from randmac import RandMac
import re


def get_json():
    with open('data.json') as file:
        jsonFile = json.load(file)
    print(jsonFile)
    return jsonFile


def get_MAC():
    MAC = re.sub("[:]", "-", str(RandMac()).upper())
    print(MAC)
    return MAC
