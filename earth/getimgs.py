import urllib, urllib2
from random import randint 
import csv

def parseFile():

    metaprefix = 'https://maps.googleapis.com/maps/api/streetview/metadata?size=270x270&location='

    imgprefix = 'https://maps.googleapis.com/maps/api/streetview?size=270x270&location='

    apiKey = 'AIzaSyB8qeQ9wMT51oL7n79CNVJeqQcZe-Gd1zE'

    with open("popcities-r2.tsv") as tsv:
        count = 1

        for line in csv.reader(tsv, dialect="excel-tab"): 
            if count > 500:
                break

            city = line[0]
            cityspaces = city.split(" ")

            city2 = ""

            for elem in cityspaces:
                city2 += elem + "%20"

            country = line[1]
            countryspaces = country.split(" ")

            country2 = ""

            for elem in countryspaces:
                country2 += elem + "%20"

            heading = randint(0,360)
            
            metaurl = metaprefix+city2+','+country2+'&fov=360&heading='+str(heading)+'&pitch=10&key='+apiKey

            req = urllib2.Request(metaurl)
            response = urllib2.urlopen(req)
            the_page = response.read()

            # if it doesn't work, go to the next city
            if the_page.count('\n') <= 3:
                continue
                
            else:
                imgurl = imgprefix+city2+','+country2+'&fov=360&heading='+str(heading)+'&pitch=10&key='+apiKey

                urllib.urlretrieve(imgurl, "imgs/"+city+"~"+country+".jpg")

                count+=1

parseFile() 

