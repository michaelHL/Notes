## [Working with Excel Files in Python][0]

This site contains pointers to the best information available about working with [Excel][18] files in the [Python][19] programming language.

### The Packages

There are python packages available to work with Excel files that will run on any Python platform and that do not require either Windows or Excel to be used. They are fast, reliable and open source:

### openpyxl

The recommended package for reading and writing Excel 2010 files (ie: .xlsx)

[Download][1] | [Documentation][2] | [Bitbucket][3]

### xlsxwriter

An alternative package for writing data, formatting information and, in particular, charts in the Excel 2010 format (ie: .xlsx)

[Download][4] | [Documentation][5] | [GitHub][6]

### xlrd

This package is for reading data and formatting information from older Excel files (ie: .xls)

[Download][7] | [Documentation][8] | [GitHub][9]

### xlwt

This package is for writing data and formatting information to older Excel files (ie: .xls)

[Download][10] | [Documentation][11] | [Examples][12] | [GitHub][13]

### xlutils

This package collects utilities that require both xlrd and xlwt, including the ability to copy and modify or filter existing excel files. _**NB: **In general, these use cases are now covered by openpyxl!_

[Download][14] | [Documentation][15] | [GitHub][16]

### The Mailing List / Discussion Group

There is a [Google Group][17] dedicated to working with Excel files in Python, including the libraries listed above along with manipulating the Excel application via COM.


[0]:http://www.python-excel.org/
[1]:http://pypi.python.org/pypi/openpyxl
[2]:https://openpyxl.readthedocs.org/
[3]:https://bitbucket.org/openpyxl/openpyxl
[4]:https://pypi.python.org/pypi/XlsxWriter
[5]:https://xlsxwriter.readthedocs.org/
[6]:https://github.com/jmcnamara/XlsxWriter
[7]:http://pypi.python.org/pypi/xlrd
[8]:http://xlrd.readthedocs.io/en/latest/
[9]:https://github.com/python-excel/xlrd
[10]:http://pypi.python.org/pypi/xlwt
[11]:http://xlwt.readthedocs.io/en/latest/
[12]:https://github.com/python-excel/xlwt/tree/master/examples
[13]:https://github.com/python-excel/xlwt
[14]:http://pypi.python.org/pypi/xlutils
[15]:http://xlutils.readthedocs.io/en/latest/
[16]:https://github.com/python-excel/xlutils
[17]:http://groups.google.com/group/python-excel
[18]:https://products.office.com/en-us/excel
[19]:http://www.python.org/
