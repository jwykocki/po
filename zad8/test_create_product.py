import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service

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

def test_form_elements_presence(driver):
    driver.get(f"{URL}/products/create")
    assert driver.find_element(By.TAG_NAME, "h1").text == "Dodaj nowy produkt"

    form = driver.find_element(By.TAG_NAME, "form")
    assert form.get_attribute("method").lower() == "post"

    name_input = driver.find_element(By.ID, "name")
    assert name_input.get_attribute("required") is not None
    assert name_input.get_attribute("type") == "text"

    description_input = driver.find_element(By.ID, "description")
    assert description_input.tag_name == "textarea"
    assert description_input.get_attribute("required") is not None

    price_input = driver.find_element(By.ID, "price")
    assert price_input.get_attribute("type") == "number"
    assert price_input.get_attribute("step") == "0.01"
    assert price_input.get_attribute("required") is not None

    quantity_input = driver.find_element(By.ID, "quantity")
    assert quantity_input.get_attribute("type") == "number"
    assert quantity_input.get_attribute("required") is not None

    submit_btn = driver.find_element(By.CSS_SELECTOR, "button[type='submit']")
    assert submit_btn.text == "Zapisz"

    cancel_btn = driver.find_element(By.LINK_TEXT, "Anuluj")
    assert cancel_btn.get_attribute("href").endswith("/products")

    labels = driver.find_elements(By.CLASS_NAME, "form-label")
    assert len(labels) == 4
    label_texts = [label.text for label in labels]
    assert "Nazwa" in label_texts
    assert "Opis" in label_texts
    assert "Cena" in label_texts
    assert "Ilość" in label_texts

    assert driver.find_element(By.CLASS_NAME, "form-control") is not None
