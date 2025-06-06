# Selenium Tests

Selenium tests to zad7 [Swift Project](https://github.com/jwykocki/po/tree/main/zad7)

Usage:
```bash
pytest test_create_product.py 
pytest test_edit_product.py 
pytest test_product_index.py
pytest test_show_product.py
```

Result:
```
PS C:\Users\48606\IdeaProjects\po\zad8> pytest test_create_product.py 
======================================================================================================= test session starts ======================================================================================================= 
platform win32 -- Python 3.11.9, pytest-8.3.5, pluggy-1.5.0
rootdir: C:\Users\48606\IdeaProjects\po\zad8

test_create_product.py
DevTools listening on ws://127.0.0.1:57873/devtools/browser/a2b94778-46e7-4283-8c65-0b955f9e5570
.                                                                                                                                                                                                     [100%]

======================================================================================================== 1 passed in 4.08s ======================================================================================================== 
PS C:\Users\48606\IdeaProjects\po\zad8> pytest test_edit_product.py
======================================================================================================= test session starts ======================================================================================================= 
platform win32 -- Python 3.11.9, pytest-8.3.5, pluggy-1.5.0
rootdir: C:\Users\48606\IdeaProjects\po\zad8
collected 1 item

test_edit_product.py
DevTools listening on ws://127.0.0.1:57897/devtools/browser/f636c4c1-8d8c-4de4-a06b-284b084e7e35
.                                                                                                                                                                                                       [100%]

======================================================================================================== 1 passed in 4.14s ======================================================================================================== 
PS C:\Users\48606\IdeaProjects\po\zad8> pytest test_product_index.py
======================================================================================================= test session starts ======================================================================================================= 
platform win32 -- Python 3.11.9, pytest-8.3.5, pluggy-1.5.0
rootdir: C:\Users\48606\IdeaProjects\po\zad8
collected 1 item                                                                                                                                                                                                                    

test_product_index.py
DevTools listening on ws://127.0.0.1:57922/devtools/browser/e04e3b50-601a-478a-8812-09cd3b02df36
.                                                                                                                                                                                                      [100%]

======================================================================================================== 1 passed in 4.17s ======================================================================================================== 
PS C:\Users\48606\IdeaProjects\po\zad8> pytest test_show_product.py
======================================================================================================= test session starts =======================================================================================================
platform win32 -- Python 3.11.9, pytest-8.3.5, pluggy-1.5.0
rootdir: C:\Users\48606\IdeaProjects\po\zad8
collected 1 item

test_show_product.py
DevTools listening on ws://127.0.0.1:57945/devtools/browser/6c42aa52-1d45-447d-adb0-6ec2c0d0af9f
.                                                                                                                                                                                                       [100%]

======================================================================================================== 1 passed in 4.00s ======================================================================================================== 
PS C:\Users\48606\IdeaProjects\po\zad8> 

```