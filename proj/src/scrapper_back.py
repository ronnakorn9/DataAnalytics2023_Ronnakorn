from selenium import webdriver
from selenium.common import NoSuchElementException
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from selenium.webdriver.remote.shadowroot import ShadowRoot
import json
import time
def select_shadow_element_by_css_selector(selector) -> ShadowRoot:
  running_script = 'return document.querySelector("%s").shadowRoot' % selector
  element = driver.execute_script(running_script)
  return element


# enable the headless mode
options = Options()
options.add_argument('--headless=new')

# initialize a web driver to control Chrome
driver = webdriver.Chrome(
    service=ChromeService(ChromeDriverManager().install()),
    options=options
)

# driver = webdriver.Chrome()
# maxime the controlled browser window
driver.fullscreen_window()


# the URL of the target page to scrape
url = 'https://www.reddit.com/r/technology/top/?t=week'
# connect to the target URL in Selenium
driver.get(url)

title = driver.title

print(f"title: {title}")
# initialize the dictionary that will contain
# the subreddit scraped data
subreddit = {}

# Wait for the shadow root wrapper element to be present
shadow_root_wrapper = WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, "shreddit-subreddit-header"))
)

# Get the shadow root
shadow_root = shadow_root_wrapper.shadow_root

# title = shadow_section.find_element(By.ID, "title")
name = shadow_root.find_element(By.CSS_SELECTOR, "h2#title")
print(f"shadow title: {name.text}")

description = shadow_root.find_element(By.CSS_SELECTOR, "#description")
print(f"description: {description.text}")
print(f"description: {description.get_attribute('innerText')}")

member_count = shadow_root.find_element(By.CSS_SELECTOR, "#subscribers > faceplate-number")
print(f"member_count: {member_count.get_attribute('innerText')}")

subreddit['name'] = name.text
subreddit['description'] = description.text
subreddit['members'] = member_count.text

print(subreddit)

# to store the post scraped data
posts = []

post_wrapper = WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, "report-flow-provider"))
)
# Get the shadow root
post_list = post_wrapper.find_elements(By.CSS_SELECTOR, "shreddit-post")
print(len(post_list))
for post_html_element in post_list:
    post_stat = {}
    ### get title
    post_title_element = post_html_element.find_element(By.CSS_SELECTOR, 'div[slot="title"]')
    post_stat["post_title"] = post_title_element.text

    ### get link
    post_link_element = post_html_element.find_element(By.CSS_SELECTOR, 'a')
    post_stat["post_link"] = post_link_element.get_attribute('href')
    # print(post_stat)
    if title:
        posts.append(post_stat)

### more post
SCROLL_PAUSE_TIME = 0.5
extend_post_list = []
last_height = driver.execute_script("return document.body.scrollHeight")
while len(extend_post_list) < 1000:
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

    extend_post_list = post_wrapper.find_elements(By.CSS_SELECTOR, "faceplate-batch > shreddit-post")
    print(len(extend_post_list))

extend_post_list = post_wrapper.find_elements(By.CSS_SELECTOR, "faceplate-batch > shreddit-post")
for post_html_element in extend_post_list:
    post_stat = {}
    ### get title
    post_title_element = post_html_element.find_element(By.CSS_SELECTOR, 'div[slot="title"]')
    post_stat["post_title"] = post_title_element.text

    ### get link
    post_link_element = post_html_element.find_element(By.CSS_SELECTOR, 'a')
    post_stat["post_link"] = post_link_element.get_attribute('href')
    # print(post_stat)
    if title:
        posts.append(post_stat)

# print(posts)
# for post_html_element in post_html_elements:
#     # to store the data scraped from the
#     # post HTML element
#     post = {}

#     # subreddit post scraping logic
#     upvotes = post_html_element \
#         .find_element(By.CSS_SELECTOR, '[data-click-id="upvote"]') \
#         .find_element(By.XPATH, "following-sibling::*[1]") \
#         .get_attribute('innerText')

#     author = post_html_element \
#         .find_element(By.CSS_SELECTOR, '[data-testid="post_author_link"]') \
#         .text

#     title = post_html_element \
#         .find_element(By.TAG_NAME, 'h3') \
#         .text

#     try:
#         outbound_link = post_html_element \
#             .find_element(By.CSS_SELECTOR, '[data-testid="outbound-link"]') \
#             .get_attribute('href')
#     except NoSuchElementException:
#         outbound_link = None

#     comments = post_html_element \
#         .find_element(By.CSS_SELECTOR, '[data-click-id="comments"]') \
#         .get_attribute('innerText') \
#         .replace(' Comments', '')

#     # populate the dictionary with the retrieved data
#     post['upvotes'] = upvotes
#     post['title'] = title
#     post['outbound_link'] = outbound_link
#     post['comments'] = comments

#     # to avoid adding ad posts 
#     # to the list of scraped posts
#     if title:
#         posts.append(post)
subreddit['post_count'] = len(posts)
subreddit['posts'] = posts

# # close the browser and free up the Selenium resources
driver.quit()

# export the scraped data to a JSON file
with open('subreddit.json', 'w', encoding='utf-8') as file:
    json.dump(subreddit, file, indent=4, ensure_ascii=False)

