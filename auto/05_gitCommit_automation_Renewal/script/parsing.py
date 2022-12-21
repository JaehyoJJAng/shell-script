import requests as rq
import os
import csv
from bs4 import BeautifulSoup as bs

def get_soup_obj(res):
    """ Soup 객체 리턴 """
    return bs(res.text,'html.parser')

def parser()-> list:
    """ soup 파싱 """
    URL = "https://waytothem.com/blog/"
    save_data = list()
    with rq.Session() as session:
        with session.get(url=URL) as response:
            if response.ok:
                soup=get_soup_obj(res=response)

                content_length = len(soup.select('li.list_horizontal_item',limit=5))
                for idx in range(content_length):
                    dataDic = dict()
                    contents = soup.select('li.list_horizontal_item',limit=5)

                    # 제목
                    title = contents[idx].select_one('strong.title_post').text.strip()

                    # 날짜
                    dated = contents[idx].select_one('.date').text.strip().split(' ')[0].replace('.','-')

                    # 링크
                    link = "(" + "https://www.waytothem.com" + contents[idx].select_one('.link_article').attrs['href'] + ")"

                    dataDic['text'] = f"[{title}]({link}) -"
                    dataDic['dated'] = dated
                    save_data.append(dataDic)
                return save_data

def main()-> None:
    results : list = parser()

    download_csv(results=results)

def download_csv(results: list)-> None:
    savePath = os.path.abspath('../csv')
    fileName = os.path.join(savePath,'parsing.csv')

    if not os.path.exists(savePath):
        os.mkdir(savePath)

    leng = [v for v in range(len(results))]
    leng.reverse()

    with open(fileName,'w',newline='') as fp:
        writer = csv.writer(fp)
        for r_idx in leng :
            writer.writerow([results[r_idx]['text'],results[r_idx]['dated']])
            print(f"{results[r_idx]}\n데이터 삽입 완료!\n")

if __name__ == '__main__':
    main()