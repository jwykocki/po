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

def test_product_list_page(driver):
    driver.get(f"{URL}/products")

    header = driver.find_element(By.TAG_NAME, "h1")
    assert header.text.strip() == "Produkty"

    add_button = driver.find_element(By.LINK_TEXT, "Dodaj nowy produkt")
    assert add_button.get_attribute("href").endswith("/products/create")
    assert "btn-primary" in add_button.get_attribute("class")
    assert add_button.is_displayed()

    table = driver.find_element(By.TAG_NAME, "table")
    assert table.get_attribute("class") == "table"

    thead = table.find_element(By.TAG_NAME, "thead")
    headers = [th.text.strip() for th in thead.find_elements(By.TAG_NAME, "th")]
    assert headers == ["Nazwa", "Opis", "Cena", "Ilość", "Akcje"]

    tbody = table.find_element(By.TAG_NAME, "tbody")
    rows = tbody.find_elements(By.TAG_NAME, "tr")
    assert len(rows) > 0

    for row in rows:
        cols = row.find_elements(By.TAG_NAME, "td")
        assert len(cols) == 5

        assert cols[0].text.strip() != ""
        assert cols[0].is_displayed()


        assert cols[1].text.strip() != ""

        price = float(cols[2].text.strip())
        assert price >= 0

        quantity = int(cols[3].text.strip())
        assert quantity >= 0

        action_buttons = cols[4].find_elements(By.TAG_NAME, "a")
        assert len(action_buttons) >= 2

        show_btn = action_buttons[0]
        assert show_btn.text.strip() == "Pokaż"
        assert "btn-info" in show_btn.get_attribute("class")
        assert "/products/" in show_btn.get_attribute("href")

        edit_btn = action_buttons[1]
        assert edit_btn.text.strip() == "Edytuj"
        assert "btn-warning" in edit_btn.get_attribute("class")
        assert "/edit" in edit_btn.get_attribute("href")

        delete_forms = cols[4].find_elements(By.TAG_NAME, "form")
        assert len(delete_forms) == 1
        delete_form = delete_forms[0]
        assert delete_form.get_attribute("method").lower() == "post"
        assert "/delete" in delete_form.get_attribute("action")

        delete_button = delete_form.find_element(By.TAG_NAME, "button")
        assert delete_button.text.strip() == "Usuń"
        assert "btn-danger" in delete_button.get_attribute("class")
        assert delete_button.get_attribute("type") == "submit"

        assert show_btn.is_displayed()
        assert edit_btn.is_displayed()
        assert delete_button.is_displayed()

        assert "btn-sm" in show_btn.get_attribute("class")
