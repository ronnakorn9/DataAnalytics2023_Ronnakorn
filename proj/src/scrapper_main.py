### credits: https://brightdata.com/blog/web-data/how-to-scrape-reddit-python
### two argument have to be changed 
### the URL of the target page to scrape
# url_main = 'https://www.reddit.com/'
### the URL of subreddit
# branch = 'r/technology/hot/'

### will scrape the reddit data (in "hot") then save it in subreddit_<sub_name>_hot.json

from selenium import webdriver
from selenium.common import NoSuchElementException
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains 
from selenium.webdriver.common.keys import Keys

import time
import json

# enable the headless mode
options = Options()
options.add_argument('--headless=new')

# initialize a web driver to control Chrome
driver = webdriver.Chrome(
    service=ChromeService(ChromeDriverManager().install()),
    options=options
)
action = ActionChains(driver) 

# maxime the controlled browser window
driver.fullscreen_window()

# the URL of the target page to scrape
url_main = 'https://www.reddit.com/'
# branch = 'r/technology/top/?t=week'
branch = 'r/technology/hot/'
url = url_main + branch
# connect to the target URL in Selenium
driver.get(url)

# initialize the dictionary that will contain
# the subreddit scraped data
subreddit = {}

# subreddit scraping logic
name = driver \
    .find_element(By.TAG_NAME, 'h1') \
    .text

description = driver \
    .find_element(By.CSS_SELECTOR, '[data-testid="no-edit-description-block"]') \
    .get_attribute('innerText')

creation_date = driver \
    .find_element(By.CSS_SELECTOR, '.icon-cake') \
    .find_element(By.XPATH, "following-sibling::*[1]") \
    .get_attribute('innerText') \
    .replace('Created ', '')

members = driver \
    .find_element(By.CSS_SELECTOR, '[id^="IdCard--Subscribers"]') \
    .find_element(By.XPATH, "preceding-sibling::*[1]") \
    .get_attribute('innerText')

# add the scraped data to the dictionary
subreddit['name'] = name
subreddit['description'] = description
subreddit['creation_date'] = creation_date
subreddit['members'] = members

print(subreddit)
# to store the post scraped data
posts = []

WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, '[data-testid="post-container"]'))
)

# retrieve the list of post HTML elements
post_html_elements = driver.find_elements(By.CSS_SELECTOR, '[data-testid="post-container"]')

### loop for more post
### more post
SCROLL_PAUSE_TIME = 0.5
last_height = driver.execute_script("return document.body.scrollHeight")

while len(post_html_elements) < 50:
    try:
    # Scroll down to bottom
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

        # Wait to load page
        time.sleep(SCROLL_PAUSE_TIME)

        # Calculate new scroll height and compare with last scroll height
        new_height = driver.execute_script("return document.body.scrollHeight")
        sleep_count = 0
        if new_height == last_height or sleep_count > 5:
            time.sleep(SCROLL_PAUSE_TIME)
            sleep_count += 1
        last_height = new_height

        post_html_elements = driver.find_elements(By.CSS_SELECTOR, '[data-testid="post-container"]')
        print(len(post_html_elements))
    except KeyboardInterrupt:
        print("interrupted")
        break
        # exit(1)

time.sleep(1)
driver.execute_script("window.scrollTo(0, 0);")

for post_html_element in post_html_elements:
    # to store the data scraped from the
    # post HTML element
    post = {}

    # subreddit post scraping logic
    upvotes = post_html_element \
        .find_element(By.CSS_SELECTOR, '[data-click-id="upvote"]') \
        .find_element(By.XPATH, "following-sibling::*[1]") \
        .get_attribute('innerText')

    author = post_html_element \
        .find_element(By.CSS_SELECTOR, '[data-testid="post_author_link"]') \
        .text

    title = post_html_element \
        .find_element(By.TAG_NAME, 'h3') \
        .text
    
    post_link = post_html_element.find_element(By.CSS_SELECTOR, 'a[data-click-id="body"]').get_attribute('href')

    try:
        outbound_link = post_html_element \
            .find_element(By.CSS_SELECTOR, '[data-testid="outbound-link"]') \
            .get_attribute('href')
    except NoSuchElementException:
        outbound_link = None

    comments = post_html_element \
        .find_element(By.CSS_SELECTOR, '[data-click-id="comments"]') \
        .get_attribute('innerText') \
        .replace(' Comments', '')

    # populate the dictionary with the retrieved data
    post['upvotes'] = upvotes
    post['title'] = title
    post['outbound_link'] = outbound_link
    post['comments'] = comments
    post['post_link'] = post_link

    # to avoid adding ad posts 
    # to the list of scraped posts
    # time.sleep(0.1)
    # posts.append(post)
    if title:
        posts.append(post)
    else:
        # action.move_to_element(post_html_element).perform()
        # Scroll down to bottom
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        # Wait to load page
        time.sleep(SCROLL_PAUSE_TIME)
        # Calculate new scroll height and compare with last scroll height
        new_height = driver.execute_script("return document.body.scrollHeight")

        driver.execute_script("return arguments[0].scrollIntoView(true);", post_html_element)
        time.sleep(SCROLL_PAUSE_TIME)
        # WebDriverWait(driver, 10).until(
            # EC.presence_of_element_located((By.TAG_NAME, 'h3'))
            # EC.presence_of_element_located(post_html_element)
        # )
        title = post_html_element \
            .find_element(By.TAG_NAME, 'h3') \
            .text
        post['title'] = title
        posts.append(post)
        

subreddit['post_count'] = len(posts)
subreddit['posts'] = posts

# close the browser and free up the Selenium resources
driver.quit()

print(f"saving total of {len(post_html_elements)}")
print(f"to {'subreddit_' + branch.replace('/', '_') + '.json'}")
# export the scraped data to a JSON file
with open('subreddit_' + branch.replace('/', '_') + '.json', 'w', encoding='utf-8') as file:
    json.dump(subreddit, file, indent=4, ensure_ascii=False)