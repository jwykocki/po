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

def test_edit_form_layout_and_prefilled_data(driver):

    driver.get(f"{URL}/products/A32EEC0B-3D06-4028-9E6B-9D8BA5C2EF4B/edit")

    header = driver.find_element(By.TAG_NAME, "h1")
    assert header.text == "Edytuj produkt"

    form = driver.find_element(By.TAG_NAME, "form")
    assert form.get_attribute("method").lower() == "post"
    assert "/products/A32EEC0B-3D06-4028-9E6B-9D8BA5C2EF4B" in form.get_attribute("action")

    name_input = driver.find_element(By.ID, "name")
    assert name_input.get_attribute("type") == "text"
    assert name_input.get_attribute("required") is not None
    name_value = name_input.get_attribute("value")
    assert name_value is not None and name_value.strip() != ""
    assert name_input.is_displayed()

    description_input = driver.find_element(By.ID, "description")
    assert description_input.tag_name == "textarea"
    assert description_input.get_attribute("required") is not None
    desc_value = description_input.get_attribute("value") or description_input.text
    assert desc_value.strip() != ""
    assert description_input.is_displayed()

    price_input = driver.find_element(By.ID, "price")
    assert price_input.get_attribute("type") == "number"
    assert price_input.get_attribute("step") == "0.01"
    assert price_input.get_attribute("required") is not None
    assert float(price_input.get_attribute("value")) > 0
    assert price_input.is_displayed()


    quantity_input = driver.find_element(By.ID, "quantity")
    assert quantity_input.get_attribute("type") == "number"
    assert quantity_input.get_attribute("required") is not None
    assert int(quantity_input.get_attribute("value")) >= 0
    assert quantity_input.is_displayed()

    submit_button = driver.find_element(By.CSS_SELECTOR, "button[type='submit']")
    assert submit_button.text.strip() == "Zapisz zmiany"
    assert submit_button.is_displayed()
    assert "btn-primary" in submit_button.get_attribute("class")


    cancel_link = driver.find_element(By.LINK_TEXT, "Anuluj")
    assert cancel_link.get_attribute("href").endswith("/products")
    assert cancel_link.is_displayed()
    assert "btn-secondary" in cancel_link.get_attribute("class")


    labels = driver.find_elements(By.CLASS_NAME, "form-label")
    assert len(labels) == 4
    label_texts = [l.text for l in labels]
    assert "Nazwa" in label_texts
    assert "Opis" in label_texts
    assert "Cena" in label_texts
    assert "Ilość" in label_texts

    form_groups = driver.find_elements(By.CLASS_NAME, "mb-3")
    assert len(form_groups) == 4
    for div in form_groups:
        assert div.find_element(By.CLASS_NAME, "form-label")
        assert div.find_element(By.CLASS_NAME, "form-control")

    assert name_input.get_attribute("name") == "name"
    assert description_input.get_attribute("name") == "description"
    assert price_input.get_attribute("name") == "price"
    assert quantity_input.get_attribute("name") == "quantity"

    assert name_input.get_attribute("id") == "name"
    assert description_input.get_attribute("id") == "description"
