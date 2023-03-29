# otl_v1
Postprocessing command "otl_v1"
## Description
Command runs otl query on old platform. 


### Arguments
- code - positional argument, text, required. Code to run on the old platform
- timeout - keyword argument, integer, not required, default is `default_job_timeout` value from command config file.
- cache_ttl - keyword argument, integer, not required, default is `default_request_cache_ttl` value from command config file.

### Usage example
```
query: otl_v1 <# makeresults count=4 | eval a=3 #>, timeout=15, cache_ttl=10

            _time  a
Index               
0      1680009770  3
1      1680009770  3
2      1680009770  3
3      1680009770  3

```

# datalines
Postprocessing command "datalines"
## Description
Command accepts csv as first argument and create dataframe from it.

### Arguments
- data - positional argument, string, required, csv as string.
- sep - keyword argument, string, not required, default is `,`. Separator in csv

### Usage example
```
query: datalines "a,b,c\n1.2,2,3\n2.3,4,5", sep=","

     a  b  c
0  1.2  2  3
1  2.3  4  5

```

# ensure
Postprocessing command "ensure"
## Description
Command adds columns with specified names if columns not exist

### Arguments
- columns - positional infinite argument, text. Columns names 

### Usage example
```
query: readFile a.csv
          a         b         c
0  0.438921  0.118680  0.863670
1  0.138138  0.577363  0.686602
2  0.595307  0.564592  0.520630
3  0.913052  0.926075  0.616184
```
```
query: readFile a.csv | ensure c,d,f
          a         b         c   d   f
0  0.438921  0.118680  0.863670 NaN NaN
1  0.138138  0.577363  0.686602 NaN NaN
2  0.595307  0.564592  0.520630 NaN NaN
3  0.913052  0.926075  0.616184 NaN NaN

```

# fields
Postprocessing command "fields"
## Description
Returns dataframe with given column names

### Arguments
- fields - positional infinite argument, text. Column names 

### Usage example
```
query: readFile a.csv
          a         b         c
0  0.438921  0.118680  0.863670
1  0.138138  0.577363  0.686602
2  0.595307  0.564592  0.520630
3  0.913052  0.926075  0.616184
4  0.078718  0.854477  0.898725
5  0.076404  0.523211  0.591538
6  0.792342  0.216974  0.564056
7  0.397890  0.454131  0.915716
8  0.074315  0.437913  0.019794
9  0.559209  0.502065  0.026437
```
```
query: readFile a.csv | fields a,b
          a         b
0  0.438921  0.118680
1  0.138138  0.577363
2  0.595307  0.564592
3  0.913052  0.926075
4  0.078718  0.854477
5  0.076404  0.523211
6  0.792342  0.216974
7  0.397890  0.454131
8  0.074315  0.437913
9  0.559209  0.502065

```

# head
Postprocessing command "head"
## Description
Return the first n rows.

### Arguments
- number - positional argument, integer, not required, default is 10. Number of rows to return.

### Usage example
```
query: read a.csv
          a         b         c
0  0.438921  0.118680  0.863670
1  0.138138  0.577363  0.686602
2  0.595307  0.564592  0.520630
3  0.913052  0.926075  0.616184
4  0.078718  0.854477  0.898725
5  0.076404  0.523211  0.591538
6  0.792342  0.216974  0.564056
7  0.397890  0.454131  0.915716
8  0.074315  0.437913  0.019794
9  0.559209  0.502065  0.026437
```
```
query: read a.csv | head 3
          a         b         c
0  0.438921  0.118680  0.863670
1  0.138138  0.577363  0.686602
2  0.595307  0.564592  0.520630
```

# head
Postprocessing command "head"
## Description
Return the first n rows.

### Arguments
- number - positional argument, integer, not required, default is 10. Number of rows to return.

### Usage example
```
query: read a.csv
          a         b         c
0  0.438921  0.118680  0.863670
1  0.138138  0.577363  0.686602
2  0.595307  0.564592  0.520630
3  0.913052  0.926075  0.616184
4  0.078718  0.854477  0.898725
5  0.076404  0.523211  0.591538
6  0.792342  0.216974  0.564056
7  0.397890  0.454131  0.915716
8  0.074315  0.437913  0.019794
9  0.559209  0.502065  0.026437
```
```
query: read a.csv | head 3
          a         b         c
0  0.438921  0.118680  0.863670
1  0.138138  0.577363  0.686602
2  0.595307  0.564592  0.520630
```

# mapcolumns
Postprocessing command "mapcolumns"
## Description
Command renames columns in dataframe using subsearch with column names mapping

### Arguments
- mapping_df - subsearch argument, required. Subseach must return dataframe with column mapping
- source - keyword argument, not required, default is `metric_name`. Column name in subsearch, column with old names.
- target - keyword argument, not required, default is `metric_long_name`. Column name in subsearch, column with new names.


### Usage example
```
... | mapcolumns source=sourceColumn target=targetedColumn [ otl_v1 <# | inputlookup mymaplookup.csv #>]
```
```
query: readFile map.csv
  old_names    new_names
0         A   A_new_name
1         B   B_new_name
```
```
query: readFile d.csv
         date         A         B         C         D
0  2013-01-01  1.075770 -0.109050  1.643563 -1.469388
1  2013-01-02  0.357021 -0.674600 -1.776904 -0.968914
2  2013-01-03 -1.294524  0.413738  0.276662 -0.472035
3  2013-01-04 -0.013960 -0.362543 -0.006154 -0.923061
4  2013-01-05  0.895717  0.805244 -1.206412  2.565646
```
```
query:  readFile d.csv | mapcolumns source=old_names, target=new_names [readFile map.csv]
         date   A_new_name   B_new_name         C         D
0  2013-01-01     1.075770    -0.109050  1.643563 -1.469388
1  2013-01-02     0.357021    -0.674600 -1.776904 -0.968914
2  2013-01-03    -1.294524     0.413738  0.276662 -0.472035
3  2013-01-04    -0.013960    -0.362543 -0.006154 -0.923061
4  2013-01-05     0.895717     0.805244 -1.206412  2.565646
```

# orderby
Postprocessing command "orderby"
## Description
Command sorts rows by given columns 

### Arguments
- columns - positional infinite argument, text, not required. The names of the columns to sort by.
- asc - keyword argument, boolean, not required, default True. Sort ascending vs. descending

### Usage example
```
... | orderBy _time,money,"average effort"
```

```
query: readFile d.csv
         date         A         B         C         D
0  2013-01-01  1.075770 -0.109050  1.643563 -1.469388
1  2013-01-02  0.357021 -0.674600 -1.776904 -0.968914
2  2013-01-03 -1.294524  0.413738  0.276662 -0.472035
3  2013-01-04 -0.013960 -0.362543 -0.006154 -0.923061
4  2013-01-05  0.895717  0.805244 -1.206412  2.565646
```
```
query: readFile d.csv | orderby A, asc=False
         date         A         B         C         D
0  2013-01-01  1.075770 -0.109050  1.643563 -1.469388
4  2013-01-05  0.895717  0.805244 -1.206412  2.565646
1  2013-01-02  0.357021 -0.674600 -1.776904 -0.968914
3  2013-01-04 -0.013960 -0.362543 -0.006154 -0.923061
2  2013-01-03 -1.294524  0.413738  0.276662 -0.472035
```
```
query: readFile d.csv | orderby A
         date         A         B         C         D
2  2013-01-03 -1.294524  0.413738  0.276662 -0.472035
3  2013-01-04 -0.013960 -0.362543 -0.006154 -0.923061
1  2013-01-02  0.357021 -0.674600 -1.776904 -0.968914
4  2013-01-05  0.895717  0.805244 -1.206412  2.565646
0  2013-01-01  1.075770 -0.109050  1.643563 -1.469388

```

# pd_merge
Postprocessing command "pd_merge"
## Description
Command uses [pandas merge function](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.merge.html) of input dataframe to merge it with subsearch query

### Arguments:
- right - subsearch, subsearch to merge
- how - keyword argument, text, not required, default value is `inner`, type of merge to be performed: left, right, inner, outer, cross
- on - keyword argument, string, required, comma separated fields list

### Usage example:
`... | pd_merge [subsearch query], how='inner', on='field1,field2,field3' `

```
query: readFile a.csv
   a   b
0  1  10
1  2  20
2  3  30
3  4  40
4  5  50

```
```
query: readFile b.csv
   a    c
0  1  100
1  2  200
2  3  300
3  6  600

```
```
query: readFile a.csv | pd_merge [readFile b.csv] on="a", how=inner
1 out of 2 command. Command pd_merge.  Start pd_merge command
   a   b    c
0  1  10  100
1  2  20  200
2  3  30  300
```
```
query: readFile a.csv | pd_merge [readFile b.csv] on="a", how=right
   a     b    c
0  1  10.0  100
1  2  20.0  200
2  3  30.0  300
3  6   NaN  600

```
```
query: readFile a.csv | pd_merge [readFile b.csv] on="a", how=left
1 out of 2 command. Command pd_merge.  Start pd_merge command
   a   b      c
0  1  10  100.0
1  2  20  200.0
2  3  30  300.0
3  4  40    NaN
4  5  50    NaN

```

# pddf
Postprocessing command "pddf"
## Description
Commands invoke any pandas dataframe [functions](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html) (except `eval`)


### Arguments
- function - positional argument, text, required, pandas function name.
- columns - positional infinite argument, text, not required. The names of the columns to be passed to the function. If not specified, the whole dataframe is used
- kwargs - infinite keyword arguments, any type, not required. Any keyword arguments to be passed to the function.
- subsearch_to_positional_list - keyword argument, not required, boolean. Makes all subsearches to a list and pass it to the function as first argument.
- subsearch_key - keyword argument, boolean, not required. If the pandas function accepts a dataframe as a keyword argument, it points to the name of the argument
- subsearches - subsearch, infinite argument. Pass subsearch dataframe as first argument to pandas function.

### Usage example
Using pandas `compare` function with subsearch:  
```
query: readFile a.csv 
   a   b   c
0  1   2   3
1  4   5   6
```
```
query: readFile b.csv
   a   b   c
0  1   2   3
1  4   5   7
```
```
readFile a.csv | pddf compare [readFile b.csv]
     c      
  self other
1  6.0   7.0
```
Using pandas `query` function:  
```
query: readFile a.csv  | pddf query, expr="a==1"
```
```
   a   b   c
0  1   2   3
```
Using `round` function:  
```
query: readFile d.csv 
         date         A          B           C           D
0  2013-01-01  1.075770  -0.109050    1.643563   -1.469388
1  2013-01-02  0.357021  -0.674600   -1.776904   -0.968914
2  2013-01-03 -1.294524   0.413738    0.276662   -0.472035
3  2013-01-04 -0.013960  -0.362543   -0.006154   -0.923061
4  2013-01-05  0.895717   0.805244   -1.206412    2.565646
```
```
readFile d.csv | pddf round, decimals=3
         date     A          B           C           D
0  2013-01-01  1.08      -0.11        1.64       -1.47
1  2013-01-02  0.36      -0.67       -1.78       -0.97
2  2013-01-03 -1.29       0.41        0.28       -0.47
3  2013-01-04 -0.01      -0.36       -0.01       -0.92
4  2013-01-05  0.90       0.81       -1.21        2.57

```
Use only selected columns:  
```
readFile d.csv | pddf round,A,B decimals=2
```
```
      A     B
0  1.08 -0.11
1  0.36 -0.67
2 -1.29  0.41
3 -0.01 -0.36
4  0.90  0.81

```

# rand
Postprocessing command "rand"
## Description
Adds column with random integers from 0 to 1000

### Arguments
- column - positional argument, text, required, new column name
- count - positional argument, integer, not required, default 10, number of rows to add. Ignored if input dataframe passed.

### Usage example
```
query: rand new_col, 4
```
```
   new_col
0      444
1       57
2      515
3      742

```
```
query: otl_v1 <# makeresults count=5#> | rand new_col, 2
```
```
            _time  new_col
Index                     
0      1679975374      353
1      1679975374      618
2      1679975374      738
3      1679975374      372
4      1679975374       36

```

# range
Postprocessing command "range"
## Description
Command adds column to dataframe (or create a new one if it is first command), fills columns with values from `a` to `b`.  
Depending on the arguments, it uses one of two numpy functions to fill the column:    
- (numpy.linspace)[ https://numpy.org/doc/stable/reference/generated/numpy.linspace.html ]
- (numpy.arrange)[ https://numpy.org/doc/stable/reference/generated/numpy.arange.html ]

**Length of input dataframe must be equal number of values**

### Arguments
- column - positional argument, text, column name for values
- a - positional argument, number, start of interval. The interval includes this value. 
- b - positional argument, number, end of interval. The interval does not include this value, except in some cases where step is not an integer and floating point round-off affects the length of out
- step - keyword argument, number, not required, default vaule is `1`, for arrange function. Spacing between values. For any output out, this is the distance between two adjacent values.
- number - keyword argument, number, not required, for linspace function. Number of samples to generate. 
- dtype - keyword argument, text, not required. The type of the output array. If dtype is not given, the data type is inferred from `a` and `b`

### Usage example

```
| range "column_name", 10, 30, step=5
```
```
   column_name
0           10
1           15
2           20
3           25

```
```
range "column_name", 2,3, step=0.3
```
```
   column_name
0          2.0
1          2.3
2          2.6
3          2.9

```
```
query: range "column_name", 2,3, number=7
```
```
   column_name
0     2.000000
1     2.166667
2     2.333333
3     2.500000
4     2.666667
5     2.833333
6     3.000000
```
```
otl_v1 <# makeresults count=2 #> | range "new_col", 2, 7, step=3
```
```
            _time  new_col
Index                     
0      1679906285        2
1      1679906285        5

```
When length of input dataframe not equal the number of values  
```
otl_v1 <# makeresults count=3 #> | range "new_col", 2, 7, step=3 
```
```
ValueError: Length of values (2) does not match length of index (3)
```

# readFile and writeFile
Postprocessing commands "readFile" and "writeFile"

## Description
`readFile` reads file from storage  
`writeFile` writes file to storage  
Storages configured in `config.ini` in `storages` section  


### Arguments
- filename - first positional argument. Relative filename in storage. May include path, example: "path1/path2/file_name.csv"
- type - keyword argument, file type. Supported types: csv, json, parquet
- storage - keyword argument, storage to save(read), default is `lookups`.
- private - keyword argument, save to (read from) user directory in storage. 
- mode - keyword argument, write mode for writeFile command, default is `overwrite`.  
    Possible values are:  
    * overwrite - overwrite file in storage  
    * append - append dataframe to file  
    * ignore - ignores write operation when the file already exists  
  
### Usage example
`... | readFile books.csv, type=csv`
#### Using paths in storage
`... | readFile "some_folder_in_storage/books.csv, type=csv"`
#### Using another storage
`... | readFile "some_folder_in_storage/books.csv, type=csv, storage=pp_shared"`
#### Using private user folder
`... | readFile "some_folder_in_storage/books.csv, type=csv, storage=pp_shared", private=true`  
In that case absolute path to file is `<storage_path>/<user_guid>/<file_path_in_storage>`
#### Using append mode in `writeFile`
`... | writeFile books.csv, mode=append`

### Important
**Make sure that in append mode dataframe has the same columns as a target file, otherwise result file will be corrupted or exception wil be raised**

# rename
Postprocessing command "rename"
## Description
Command renames dataframe columns

### Arguments
- col - positional infinite argument with "as" syntax, where left value is column name, right value is new column name

### Usage example
```
`... | rename _time AS Time, p50 AS Median, p25 AS Quartile `
```

# str_match
Postprocessing command `str_match`

## Description
`str_match` finds strings or regular expression in columns. If several columns are passed then result dataframe include all matches for all columns

### Arguments
- vals - infinite keyword argument, where key is column name and value is string (character sequence or regular expression)

### Usage example
Input dataframe:  
```
        a          b           c
0   ab11c       dfag  bbbl33asdd
1     zdf  fffa22fff     znowaty
2  zd111f  fffa22fff   zno33waty
```
Row at index `2` has `c` value that starts with `zno33`:  
```
query: readFile test.csv | str_match  c="zno33"
        a          b          c
2  zd111f  fffa22fff  zno33waty
```
Rows at index `0` and `2` has values matched by regular expression:  
```
query: readFile test.csv | str_match a=".*11.*"
        a          b           c
0   ab11c       dfag  bbbl33asdd
2  zd111f  fffa22fff   zno33waty
```
Row at index 0 matched by first regular expression and row at index 2 matched by second:  
```

query: readFile test.csv | str_match a=".*c", c="^zno3"
        a          b           c
0   ab11c       dfag  bbbl33asdd
2  zd111f  fffa22fff   zno33waty
```
