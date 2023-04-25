import datetime
from random import randint,choice,uniform;
from string import digits, ascii_lowercase
from faker import Faker
fake = Faker()
import json

# UPDATE LICENSES TO BE TEN CHARACTERS LONG

vins = ["1GBJK39U02F121041","2T1BU4EE1DC120460", "3N1BC1AS5AL383513", "4A37L2EF0BE002977", "4S3BNAE62G3020305", "5XYZUDLB1HG390130", "JA4JZ4AX0EZ600236", "KMHCT6AE8FU222364"]

# "HXXXX"
# prevLps = set()

# conditions = ["good", "decent","superb","drivable","works fine"]
# colours= ["White","Black","Orange","Maroon","Red","Yellow","Lime","green","Salmon","Green","Sky","blue","Crimson","Aqua","Grey","Purple","Mustard","Peach","Violet","Magenta","Coral","Saffron","Brown","Pink","Tan","Teal","Navy","Blue","Turquoise","Lavender","Beige","Lemon","yellow","Grape","vine","Indigo","Fuchsia","Amber","Sea","green","Dark","green","Burgundy","Charcoal","Bronze","Cream","Mauve","Olive","Cyan","Silver","Rust","Ruby","Azure","Mint","Pearl","Ivory","Tangerine","Cherry","red","Garnet","Emerald","Sapphire","Rosewood","Lilac","Arctic","blue","Pista","green","Coffee","brown","Umber","Brunette","Mocha","Ash","Jet","black"]

# def gen_number_plate():
#     temp = "H"+ str(randint(0,9999)).rjust(4,str(randint(0,9)))
    
#     while(temp in prevLps or "6"*3 in temp):
#         temp = "H"+ str(randint(111111111,999999999))
#     prevLps.add(temp)
    
#     return temp

# print("insert into vehicles values",end="")
# for i in range(10):
#     print(f"({choice(colours)!r},{choice(colours)!r},{gen_number_plate()!r},{randint(100,100000)},{choice(vins)!r},{choice(conditions)!r}),",end="")


# # ___________________________________________________________
# #       CUSTOMERS
# # ____________________________________________________
# pnums = set()
# numS = [227, 228, 229, 270, 271, 272, 273, 274, 292, 367, 410, 412, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 736, 737, 753, 757, 958,976,230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254,258, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829]

# def get_pnum():
#     temp = choice(numS) + ''.join(choice(digits) for i in range(4))
#     while(temp in pnums or "6"*3 in temp):
#         temp = choice(numS) + ''.join(choice(digits) for i in range(4))
#     pnums.add(temp)
#     return temp


# def getCustRecord():
#     fname = fake.first_name()
#     lname = fake.last_name()  #     ---------------email--------------     ---------------------phone_number-----------------------
#     return f"({fname!r},{lname!r},'{fname}.{lname}@{fake.domain_name()}','{choice(numS)}-{''.join(choice(digits) for i in range(4))}',{''.join(choice(digits) for i in range(14))!r},'Pine East - W Blvd, Bridgetown, St. Michael, Barbados',{fake.date_between(datetime.date(2023,5,1),datetime.date(2024,12,30)).strftime('%Y-%m-%d')!r},{choice(vins)!r},{fake.address()!r},{randint(1,7)!r},{randint(1,7)!r},'{str(randint(1,9))}{''.join(choice(digits) for i in range(18))}','{fname} {lname}',{''.join(choice(digits) for i in range(3))!r},{fake.date_between(datetime.date(2023,4,1),datetime.date(2024,12,30)).strftime('%Y-%m-%d')!r},{fake.address()!r})"


# print('insert into customers(first_name,surname,email,phone_number,drivers_license,license_issue_location,license_expiration_date,preferred_vehicle,address,preferred_dropoff,preferred_pickup,credit_card_number,credit_card_name,cvn,credit_card_expiration_date,billing_address) values')
# for i in range(20):
#     print(getCustRecord(),end=",")


{
    "baby seat": 30
}



# fake.date_between(datetime.date(2023,5,1),datetime.date(2024,12,30)).strftime('%Y-%m-%d')
vehicles = ["H0821","H1301","H1575","H1776","H2273","H2371","H2394","H2733","H2739","H2832","H2849","H3080","H3139","H3704","H5075","H5186","H5314","H5660","H6081","H6110","H6156","H6178","H6793","H6970","H7131","H7278","H7850","H8307","H8427","H8482","H8794","H8831","H8987","H9137","H9242","H9380","H9764"]

condtions = {"H2371":"good good",
"H2273":"right door dented but otherwise good",
"H8427":"brand new",
"H7131":"brand new",
"H1776":"right door dented but otherwise good",
"H7278":"brand new",
"H2849":"not so good",
"H5314":"good good",
"H8987":"brand new",
"H5186":"not so good",
"H3704":"brand new",
"H7850":"needs servicing",
"H8794":"needs repairs",
"H3080":"needs servicing",
"H9764":"scratches on the back",
"H8831":"brand new",
"H8482":"good enough",
"H6156":"left door dented but otherwise good",
"H9137":"left door dented but otherwise good",
"H1301":"good good",
"H9242":"brand new",
"H5075":"good enough",
"H0821":"left door dented but otherwise good",
"H5660":"needs repairs",
"H8307":"scratches on the back",
"H2394":"needs repairs",
"H6110":"needs servicing",
"H2739":"good",
"H1575":"decent",
"H2832":"good",
"H6178":"works fine",
"H2733":"good",
"H6793":"decent",
"H6970":"decent",
"H6081":"superb",
"H9380":"works fine",
"H3139":"drivable"
}



def randReturn(date):
    if date <= datetime.date.today() and randint(1,10) < 6:
        return date + datetime.timedelta(days=1)
    else:
        return 'null'

def getRental():
    cid = randint(1,20)
    pm = choice(["card","cash"])
    lend = fake.date_between(datetime.date(2023,1,1),datetime.date(2023,6,30))
    return_ =  fake.date_between(lend,datetime.date(2023,6,30))
    vid = choice(vehicles)
    rate = round(uniform(15,25),2)
    returned = randReturn(return_)
    lc = condtions[vid]
    addCharges = ""
    
    fee = (return_ - lend).days * rate if returned == 'null' else (returned - lend).days * rate

    if(returned != 'null'):
        rc = lc
    else:
        rc = 'null'

    if datetime.date.today() > return_ or returned!= 'null' and returned > return_:
        addCharges = json.dumps({"late fee": 100})
        fee+= 100

    if(randint(1,10) < 3):
        if addCharges != "":
            addCharges = json.dumps({"late fee": 100,"baby seat":50})
        else:
            addCharges = json.dumps({"baby seat":50})
        fee+=50

    returned = f"{returned.strftime('%Y-%m-%d')!r}" if returned != 'null' else returned
    fee = round(fee,2)
    return f"({cid!r},{vid!r},{rate},{lend.strftime('%Y-%m-%d')!r},{return_.strftime('%Y-%m-%d')!r},{returned},{lc!r},{rc!r},{fee},{pm!r},{addCharges!r}),"


print("insert into rentals(customer_id,vehicle_id,rental_rate,lend_date,return_date,returned_date,lent_condition,return_condition,rental_fee,payment_method,extra_charges) values",end="")
for i in range(50):
    print(getRental(),end="")


