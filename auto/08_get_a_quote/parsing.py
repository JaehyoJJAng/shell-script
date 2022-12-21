import requests as rq
from bs4 import BeautifulSoup as bs 
import os
import re
from datetime import datetime

def get_soup_obj(html)->any:
    with open(html,'r',encoding='UTF-8') as fp:
        soup = bs(fp.read(),'html.parser')
    return soup

def parsing(soup)-> dict:
    data = dict()

    # 명언 생성된 날짜
    head = str(soup.select_one('div.qotdhead').text.strip()).split('-')[-1].strip()
    
    # 명언
    quotes = ''.join([_.text.strip() for _ in soup.select('dl > dt.quote')])
    
    # Author
    author = soup.select_one('td#content dl > dd > b').text.strip()
    
    # Text
    TEXT = f"{'=' * 10} Daily Quote - {head} {'=' * 10 }\n\n{quotes}\n\t\tAuthor : {author}"

    data['author'] = author.split('(')[0].strip()
    data['text'] = TEXT

    return data

def new_quote_file(data :dict)-> None:
    # 오늘 날짜
    today = datetime.today().strftime('%Y%m%d')
    
    # DIR 생성
    DIR = f'/tmp/daily_quote/{today}'
    os.makedirs(DIR,exist_ok=True)
    
    # 파일명
    fileName = os.path.join(DIR,data['author'] + '.txt')
    
    # 파일 쓰기
    with open(fileName,'w') as fp:
        fp.write(data['text'])

    print(f'파일이 정상적으로 쓰였습니다!\n{fileName}')

def main():
    # HTML FILE
    html = '/tmp/quote/quote.html'

    # get Soup
    soup = get_soup_obj(html=html)
    
    # Staring Parsing
    data : dict = parsing(soup=soup)

    # Create New File
    new_quote_file(data=data)

if __name__ == '__main__':
    main()

