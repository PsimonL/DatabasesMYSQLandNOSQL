from pymongo import *
import bson
import json
import re

from jsonbarer import get_json
from jsonbarer import get_MAC


def main(choice):
    if choice == 'INSERT SINGLE VALUE':
        # INSER SINGLE VALUE
        # _id <- MUST BE DICT KEY
        post = {"_id": 0, "client_name": "username", "MAC": get_MAC()}
        # print(post)
        collection.insert_one(post)
    elif choice == 'INSERT MULTIPLE VALUES':
        # INSERT MANY VALUES
        n = 7
        keyID, keyClientName, keyMAC = ['_id'] * n, ['client_name'] * n, ['MAC'] * n
        valueID, valueClientName, valueMAC = [], [], []
        for i in range(1, n):
            id = i
            name = "username" + str(id)
            num = get_MAC()
            valueID.append(id)
            valueClientName.append(name)
            valueMAC.append(num)

        InpuDataList = [{kI: vI, kCN: vCN, kMAC: vMAC} for kI, vI, kCN, vCN, kMAC, vMAC in
                        zip(keyID, valueID, keyClientName, valueClientName, keyMAC, valueMAC)]
        # print(InpuDataList)
        collection.insert_many(InpuDataList)
    elif choice == 'FIND':
        # FIND
        results = collection.find({'_id': 3})
        # SEARCH BY MULTIPLE FIELDS: .find({'_id': 3, '': '', '': })
        # GET ALL: .find({})
        # results = collection.find_one({'_id': 3})

        print(results)
        for each in results:
            print()
            print(each)
            print(each['_id'])
            print(each['client_name'])
            print(each['MAC'])
            print()

        print()

        # https://www.w3schools.com/python/python_regex.asp
        regx = re.compile("^test", re.IGNORECASE)
        results = collection.find({'client_name': regx})
        for each in results:
            print()
            print(each)
            print()
    elif choice == 'DELETE':
        # DELETE
        # collection.insert_one({'_id': 0, 'client_name': 'test', 'MAC': get_MAC()})
        # collection.delete_one({'_id': 0})  # same as results = collection.delete_one({'_id': 0})
        collection.delete_many({})  # DELETE ALL
    elif choice == 'UPDATE':
        # UPDATE
        collection.update_one({'_id': 1}, {'$set': {'client_name': 'Jack Smith'}})
    elif choice == 'ADD FIELD':
        # ADD NEW FIELD
        collection.update_one({'_id': 5}, {'$set': {'NEWFIELD1': 'NEWFIELD1val', 'NEWFIELD2': 100}})
        collection.update_one({'_id': 6}, {'$inc': {'MAC': str(5000)}})
    elif choice == 'UPDATE MANY':
        # UPDATE MANY DOCUMENTS
        regx = re.compile("^test", re.IGNORECASE)
        collection.update_many({'name': regx}, {'$inc': {'MAC': str(1000)}})
    elif choice == 'DELETE FIELD':
        # DELETE FIELD
        collection.update_one({'_id': 5}, {'$unset': {'NEWFIELD2': 100}})
    elif choice == 'COUNT':
        # COUNT ALL DOCUMENTS
        counter = collection.count_documents({})
        print(counter)
    elif choice == 'INSERT JSON':
        collection.insert_many(get_json())
    else:
        raise Exception('No option found.')


if __name__ == "__main__":
    # DOCUMENTATIONS
    # https://www.mongodb.com/docs/manual/reference/method/db.collection.update/

    # USER PASSWORD IS !NOT! ACCOUNT PASSWORD
    # You can configure couple users for one account, while setting up connection security.
    # To change, check, reset user password (on MongoDB website):
    # Connect -> Go Back -> IP Access List tab  MongoDB Users tab

    # You can connect to DB only be assigned before IP address, ITS EXTERNEL NOT INTERNAL one.
    # To check internal IP (local IP address) you can type into CMD:
    # ipconfig
    # To check external IP (external IP address (from some DHCP server) you can type into CMD:
    # nslookup myip.opendns.com resolver1.opends.com

    # If you have any issues with connecting to mongoDB just firstly check credentials mentioned above.

    print('START')
    cluster = MongoClient("Connection String from Mongo Database - with username password NOT account password")
    database = cluster["name of cluster"]
    collection = database["name of collection"]

    main(choice='DELETE')

    print('FINISH')


