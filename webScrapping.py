from selenium.webdriver.common.by import By
from selenium import webdriver
from shutil import which
import shortuuid
import json


# this method is for initialization of the browser, it is configured to work in "background" and does not open the browser
def InitWebDriver(): 

    from selenium.webdriver.chrome.options import Options

    CHROMEPATH = which('chromedriver')
    op = webdriver.ChromeOptions()
    op.add_argument('headless')
    driver = webdriver.Chrome(options=op)
    driver = webdriver.Chrome(CHROMEPATH)

    return driver

# This method find an element in the html by partial link text, and returns if it has a link
def GetLinksbyLinkText(link_name):

    return driver.find_element(By.PARTIAL_LINK_TEXT, link_name).get_attribute('href')

# find and returns an element through specific path
def FindElementenbyXpath(xpath):

    return driver.find_element('xpath', xpath)

# Finde a list of elements through specific path
def FindElementsbyXpath(xpath):

    return driver.find_elements('xpath', xpath)

def WebElementInfoToList(webElement):
    finalList = []
    for element in webElement:
        finalList.append(element.text)

    return finalList

# This method is specific to METWiki, it extracts the keywords that belong to a specific category
def KeyWordsExtractor(keywordsList):
    keywordsFinalList = []
    keywordsAuxList = []
    for keyword in keywordsList:
        
        if(keyword.find('Keywords :') != -1):
            keyw = keyword.replace('Keywords :','N/A')
            keywAux = keyw.split(' ')
            keywordsAuxList.append(keywAux)
    
    for keywordAux in keywordsAuxList:
        if(keywordAux == 1):
            keywordsFinalList.append(keywordAux)
        else:
            keywordAux.pop(0)
            if('' in keywordAux):
                keywordAux.pop(keywordAux.index(''))
            keywordsFinalList.append(keywordAux)

    return keywordsFinalList

# This method is specific to METWiki, it extracts the functionality info and the Num of MRs that belong to a specific category and programm 
def FunctionalityNumMRsExtractor(functionalityList):
    
    functionalityFinalList = []
    numMRsFinalList = []
    functionalityAuxList = []
    numMRsAuxList = []

    for i in range(len(functionalityList)):
        if i % 2 == 0:
            functionalityAuxList.append(functionalityList[i])
        else:
            numMRsAuxList.append(functionalityList[i])
    
    for description in functionalityAuxList:
        if(description.find('Functionality : ') != -1):
            description = description.replace('Functionality : ','')
        if(description.find('\n') != -1):
            description = description.replace('\n', ' ')
        if(description.find('  ') != -1):
            description = description.replace('  ', '')
        if(description.find('.') != -1):
            description = description.replace('.', '')
        description = description.rstrip()
        description = description.lstrip()
        functionalityFinalList.append(description)

    for mr in numMRsAuxList:
        if(mr.find(' ') != -1):
            mr = mr.replace(' ', '')
        if(mr.find('MRNum:') != -1):
            mr = mr.replace('MRNum:', '')
        
        if(type(mr) == str):
            numMRsFinalList.append(int(mr))

    return functionalityFinalList, numMRsFinalList

def GetProgramsInfo(link):

    driver.get(link)

    pragramName_xpath = '//ul[@class="repo-list"]/li[@class="repo-list-item"]/h3'

    programNames = FindElementsbyXpath(pragramName_xpath)
    programNamesList = WebElementInfoToList(programNames)

    # print(programNamesList)

    programLinks = []

    for i in programNamesList:

        # There is a misspeling in the html file when the program "Testign of Boyer" is calling
        # this if is only to get the info of that program
        if(i == 'Testing of Boyer Program '):
            i = 'Testing of Boyer '
            link = GetLinksbyLinkText(i)
            programLinks.append(link)
        
        else:
            link = GetLinksbyLinkText(i)
            programLinks.append(link)

    keywords_xpath = '//ul[@class="repo-list"]/li[@class="repo-list-item"]/div[@class="repo-list-all"]/div[@class="repo-list-left"]/div[@class="repo-list-tags"]'
    keywordsElemets = FindElementsbyXpath(keywords_xpath)
    keywordsList = WebElementInfoToList(keywordsElemets)
    keywordsList = KeyWordsExtractor(keywordsList)

    functionalityDesprition_xpath = '//ul[@class="repo-list"]/li[@class="repo-list-item"]/div[@class="repo-list-all"]/div[@class="repo-list-left"]/div[@class="repo-list-description"]'
    functionalityElements = FindElementsbyXpath(functionalityDesprition_xpath)
    functionalityList = WebElementInfoToList(functionalityElements)
    functionalityList, numMRsList = FunctionalityNumMRsExtractor(functionalityList)

    return programNamesList, programLinks, keywordsList, functionalityList, numMRsList

# This method updates the main dictionary with the program info 
def UpdateMainDic(mainDic, cat, programNamesList, programLinksList, keywordsList, functionalityList, numMRsList):

    for i in range(0, len(programNamesList)):
        prgramID = shortuuid.uuid(name = programNamesList[i])
        if(i == 0):
            auxDic = {'programs': { prgramID: {
                'program_Name' : programNamesList[i],
                'program_Link' :  programLinksList[i],
                'program_Keywords' : keywordsList[i],
                'program_Description' : functionalityList[i],
                'Num_MRs' : numMRsList[i]}
                }
            }
            mainDic[cat].update(auxDic)

        else:
            mainDic[cat]['programs'][prgramID] = {
                'program_Name' : programNamesList[i],
                'program_Link' :  programLinksList[i],
                'program_Keywords' : keywordsList[i],
                'program_Description' : functionalityList[i],
                'Num_MRs' : numMRsList[i]}

    # json_object = json.dumps(mainDic, indent = 4) 
    # print(json_object)    
    return mainDic

driver = InitWebDriver()

driver.get('http://www.metwiki.net/')

categories = ['number', 'machine', 'algorithm', 'geometry', 'opt', 'calculus', 'bio', 'graph']
mainDic = dict()

for cat in categories:

    xpath_CategoryName = '//div[@class="part"]/div[@class="' + cat + '"]/div[@class="zi"]'
    xpath_CategoryLink = '//div[@class="part"]/div[@class="' + cat + '"]/a'
    
    categoryName_aux = FindElementenbyXpath(xpath_CategoryName)
    categoryLink_aux = FindElementenbyXpath(xpath_CategoryLink)

    categoryName = categoryName_aux.text
    categoryLink = categoryLink_aux.get_attribute('href')

    auxDic = { cat: {'name': categoryName, 'link': categoryLink}}
    mainDic.update(auxDic)

### Printing stuff

# print('*** program names ***')
# print(programNamesList, '\n', len(programNamesList))

# print('*** program links ***')
# print(programLinksList, '\n', len(programLinksList))

# print('*** keywords List ***')
# print(keywordsList, '\n',len(keywordsList))

# print('*** program functionalityList ***')
# print(functionalityList, '\n', len(functionalityList))

# print('*** program numMRsList ***')
# print(numMRsList, '\n', len(numMRsList))

###

# mainDic['number'].update({'program': {'program_name': 'asdf', 'key_words': [1,2,3,4,5], 'asdfa': 'dfadf'}})
# # mainDic.update(mainDic2)
# print(mainDic['number'].keys())
# print(mainDic)

# # with open("sample.json", "w") as outfile:
#     # json.dump(mainDic, outfile, indent = 4)

# json_object = json.dumps(mainDic, indent = 4) 
# print(json_object)

# for cat in categories:
#     if(cat == 'machine'):
#         break

#     link = mainDic[cat]['link']
#     programNamesList, programLinksList, keywordsList, functionalityList, numMRsList = GetProgramsInfo(mainDic[cat]['link'])
#     mainDic = UpdateMainDic(mainDic, cat, programNamesList, programLinksList, keywordsList, functionalityList, numMRsList)

# idProgramsList = list(mainDic['number']['programs'].keys())

# linkPrograms = []

# for id in idProgramsList:
#     linkPrograms.append(mainDic['number']['programs'][id]['program_Link'])


# print(linkPrograms)


# print(idProgramsList)
# print(type(idProgramsList))

# with open("sample2.json", "w") as outfile:
#     json.dump(mainDic, outfile, indent = 4)

links = ['http://www.metwiki.net/viewProgramDetail?index=12&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=35&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=36&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=37&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=70&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=83&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=155&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=229&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=297&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=303&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=306&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=308&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=310&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=328&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=386&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=393&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=395&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=440&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=486&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=511&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=514&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=519&userId=&type=view', 'http://www.metwiki.net/viewProgramDetail?index=537&userId=&type=view']


# driver.get('http://www.metwiki.net/viewDomainProgram?domainName=Numerical%20program')
# driver.get('http://www.metwiki.net/')
# driver.get('http://www.metwiki.net/viewProgramDetail?index=537&userId=&type=view')
# driver.find_element(By.XPATH, '//div=[@class="part"]/div=[@class="number"]/a').click()
# driver.find_element(By.LINK_TEXT, 'GetMid').click()



# xpath = '//'

# pragramName_xpath = '//ul[@class="repo-list"]/li[@class="repo-list-item"]/h3'

# xpath_CategoryName = '//div[@class="all"]/div[@class="hero-unit"]/div[@id="editor"]/h3[@class="attr1"]'

# print(driver.find_element('xpath','//div[@class="all"]/div[@class="hero-unit"]/div[@id="editor"]/h3[@class="attr1"]').text)


# print(driver.find_element(By.CSS_SELECTOR, "*[id$='editor']"))

# print(driver.find_element('xpath', xpath_CategoryName).text)
# print(driver.find_element(By.ID, 'editor').text)
# programNames = FindElementsbyXpath(xpath_CategoryName)
# programNames = FindElementenbyXpath(xpath_CategoryName)

# xpath_CategoryLink = '//div[@class="part"]/div[@class="' + cat + '"]/a'
    
# categoryName_aux = FindElementenbyXpath(xpath_CategoryName)

# print(programNames)



'''Try to access with BeautifilSoup :/ it did not work'''
# from bs4 import BeautifulSoup
# from urllib.request import Request, urlopen
# import re

# req = Request("http://www.metwiki.net/viewProgramDetail?index=12&userId=&type=view")
# html_page = urlopen(req)

# soup = BeautifulSoup(html_page, "html.parser")
# print(soup)