import pytest
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options

URL = "http://localhost:8080"

@pytest.fixture(scope="module")
def driver():
    service = Service('C:/Users/48606/Desktop/chromedriver-win64/chromedriver-win64/chromedriver.exe')
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    driver = webdriver.Chrome(service=service, options=options)
    driver.implicitly_wait(3)
    yield driver
    driver.quit()

def test_product_details_page(driver):
    driver.get(f"{URL}/products/A32EEC0B-3D06-4028-9E6B-9D8BA5C2EF4B")

    h1 = driver.find_element(By.TAG_NAME, "h1")
    p_tags = driver.find_elements(By.TAG_NAME, "p")
    edit_link = driver.find_element(By.LINK_TEXT, "Edytuj")
    delete_form = driver.find_element(By.TAG_NAME, "form")
    delete_button = delete_form.find_element(By.TAG_NAME, "button")
    back_link = driver.find_element(By.LINK_TEXT, "Powrót")

    assert h1 is not None
    assert len(h1.text) > 0

    assert len(p_tags) >= 3
    labels = ["Opis:", "Cena:", "Ilość:"]
    for i, label in enumerate(labels):
        assert label in p_tags[i].text

    for i in range(3):
        content = p_tags[i].text.split(":")[1].strip()
        assert len(content) > 0

    assert edit_link is not None

    assert "/products/A32EEC0B-3D06-4028-9E6B-9D8BA5C2EF4B/edit" in edit_link.get_attribute("href")

    assert "btn-warning" in edit_link.get_attribute("class")

    assert delete_form is not None

    assert "/products/A32EEC0B-3D06-4028-9E6B-9D8BA5C2EF4B/delete" in delete_form.get_attribute("action")

    assert delete_form.get_attribute("method").lower() == "post"

    assert delete_button is not None

    assert delete_button.text == "Usuń"

    assert "btn-danger" in delete_button.get_attribute("class")

    assert back_link is not None

    assert back_link.get_attribute("href").endswith("/products")

    assert back_link.text == "Powrót"

    assert "btn-secondary" in back_link.get_attribute("class")
