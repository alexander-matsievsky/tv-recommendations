# TV Recommendations (Using IMDb Dataset)

## Setup

1. Install `conda` (see the [installation guide](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html))
2. Run

    ```shell
    conda env create -f environment.yml
    conda activate tv-recommendations
    jupyter lab
    ```
    &nbsp;

3. Update [README.md](README.md)

    ```shell
    jupyter nbconvert --to markdown README.ipynb
    ```

## Extract, Transform, Load

### Extract


```python
!wget -xP'/tmp' --accept '.tsv.gz' --no-parent --recursive 'https://datasets.imdbws.com/'
!tree -h '/tmp/datasets.imdbws.com'
```

    --2022-01-02 14:35:57--  https://datasets.imdbws.com/
    Resolving datasets.imdbws.com (datasets.imdbws.com)... 143.204.98.32, 143.204.98.111, 143.204.98.41, ...
    Connecting to datasets.imdbws.com (datasets.imdbws.com)|143.204.98.32|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 945 [text/html]
    Saving to: ‘/tmp/datasets.imdbws.com/index.html.tmp’
    
    datasets.imdbws.com 100%[===================>]     945  --.-KB/s    in 0s      
    
    2022-01-02 14:35:57 (6.23 MB/s) - ‘/tmp/datasets.imdbws.com/index.html.tmp’ saved [945/945]
    
    Loading robots.txt; please ignore errors.
    --2022-01-02 14:35:57--  https://datasets.imdbws.com/robots.txt
    Reusing existing connection to datasets.imdbws.com:443.
    HTTP request sent, awaiting response... 200 OK
    Length: 945 [text/html]
    Saving to: ‘/tmp/datasets.imdbws.com/robots.txt.tmp’
    
    datasets.imdbws.com 100%[===================>]     945  --.-KB/s    in 0s      
    
    2022-01-02 14:35:58 (19.7 MB/s) - ‘/tmp/datasets.imdbws.com/robots.txt.tmp’ saved [945/945]
    
    Removing /tmp/datasets.imdbws.com/index.html.tmp since it should be rejected.
    
    --2022-01-02 14:35:58--  https://datasets.imdbws.com/name.basics.tsv.gz
    Reusing existing connection to datasets.imdbws.com:443.
    HTTP request sent, awaiting response... 200 OK
    Length: 221263899 (211M) [binary/octet-stream]
    Saving to: ‘/tmp/datasets.imdbws.com/name.basics.tsv.gz’
    
    datasets.imdbws.com 100%[===================>] 211.01M  9.61MB/s    in 21s     
    
    2022-01-02 14:36:21 (10.0 MB/s) - ‘/tmp/datasets.imdbws.com/name.basics.tsv.gz’ saved [221263899/221263899]
    
    --2022-01-02 14:36:21--  https://datasets.imdbws.com/title.akas.tsv.gz
    Reusing existing connection to datasets.imdbws.com:443.
    HTTP request sent, awaiting response... 200 OK
    Length: 258943798 (247M) [binary/octet-stream]
    Saving to: ‘/tmp/datasets.imdbws.com/title.akas.tsv.gz’
    
    datasets.imdbws.com 100%[===================>] 246.95M  10.3MB/s    in 24s     
    
    2022-01-02 14:36:49 (10.1 MB/s) - ‘/tmp/datasets.imdbws.com/title.akas.tsv.gz’ saved [258943798/258943798]
    
    --2022-01-02 14:36:49--  https://datasets.imdbws.com/title.basics.tsv.gz
    Reusing existing connection to datasets.imdbws.com:443.
    HTTP request sent, awaiting response... 200 OK
    Length: 150032645 (143M) [binary/octet-stream]
    Saving to: ‘/tmp/datasets.imdbws.com/title.basics.tsv.gz’
    
    datasets.imdbws.com 100%[===================>] 143.08M  10.3MB/s    in 14s     
    
    2022-01-02 14:37:05 (10.0 MB/s) - ‘/tmp/datasets.imdbws.com/title.basics.tsv.gz’ saved [150032645/150032645]
    
    --2022-01-02 14:37:05--  https://datasets.imdbws.com/title.crew.tsv.gz
    Reusing existing connection to datasets.imdbws.com:443.
    HTTP request sent, awaiting response... 200 OK
    Length: 58444351 (56M) [binary/octet-stream]
    Saving to: ‘/tmp/datasets.imdbws.com/title.crew.tsv.gz’
    
    datasets.imdbws.com 100%[===================>]  55.74M  9.72MB/s    in 5.6s    
    
    2022-01-02 14:37:11 (9.95 MB/s) - ‘/tmp/datasets.imdbws.com/title.crew.tsv.gz’ saved [58444351/58444351]
    
    --2022-01-02 14:37:11--  https://datasets.imdbws.com/title.episode.tsv.gz
    Reusing existing connection to datasets.imdbws.com:443.
    HTTP request sent, awaiting response... 200 OK
    Length: 34630107 (33M) [binary/octet-stream]
    Saving to: ‘/tmp/datasets.imdbws.com/title.episode.tsv.gz’
    
    datasets.imdbws.com 100%[===================>]  33.03M  10.3MB/s    in 3.2s    
    
    2022-01-02 14:37:15 (10.3 MB/s) - ‘/tmp/datasets.imdbws.com/title.episode.tsv.gz’ saved [34630107/34630107]
    
    --2022-01-02 14:37:15--  https://datasets.imdbws.com/title.principals.tsv.gz
    Reusing existing connection to datasets.imdbws.com:443.
    HTTP request sent, awaiting response... 200 OK
    Length: 383673006 (366M) [binary/octet-stream]
    Saving to: ‘/tmp/datasets.imdbws.com/title.principals.tsv.gz’
    
    datasets.imdbws.com 100%[===================>] 365.90M  9.62MB/s    in 36s     
    
    2022-01-02 14:37:52 (10.1 MB/s) - ‘/tmp/datasets.imdbws.com/title.principals.tsv.gz’ saved [383673006/383673006]
    
    --2022-01-02 14:37:52--  https://datasets.imdbws.com/title.ratings.tsv.gz
    Reusing existing connection to datasets.imdbws.com:443.
    HTTP request sent, awaiting response... 200 OK
    Length: 5989985 (5.7M) [binary/octet-stream]
    Saving to: ‘/tmp/datasets.imdbws.com/title.ratings.tsv.gz’
    
    datasets.imdbws.com 100%[===================>]   5.71M  10.0MB/s    in 0.6s    
    
    2022-01-02 14:37:53 (10.0 MB/s) - ‘/tmp/datasets.imdbws.com/title.ratings.tsv.gz’ saved [5989985/5989985]
    
    FINISHED --2022-01-02 14:37:53--
    Total wall clock time: 1m 56s
    Downloaded: 9 files, 1.0G in 1m 45s (10.1 MB/s)
    wget -xP'/tmp' --accept '.tsv.gz' --no-parent --recursive   3.73s user 8.09s system 10% cpu 1:56.19 total
    [4.0K]  /tmp/datasets.imdbws.com
    ├── [211M]  name.basics.tsv.gz
    ├── [ 945]  robots.txt.tmp
    ├── [247M]  title.akas.tsv.gz
    ├── [143M]  title.basics.tsv.gz
    ├── [ 56M]  title.crew.tsv.gz
    ├── [ 33M]  title.episode.tsv.gz
    ├── [366M]  title.principals.tsv.gz
    └── [5.7M]  title.ratings.tsv.gz
    
    0 directories, 8 files



```python
neo4j_staging = "/tmp/neo4j_staging/datasets.imdbws.com"
!rm -fr {neo4j_staging}
!mkdir -p '{neo4j_staging}/data' '{neo4j_staging}/import' '{neo4j_staging}/logs'
!tree {neo4j_staging}
```

    /tmp/neo4j_staging/datasets.imdbws.com
    ├── data
    ├── import
    └── logs
    
    3 directories, 0 files


### Transform


```python
%load_ext lab_black

import pyspark
from IPython.display import Markdown

kwargs_read_csv = dict(header=True, nullValue=r"\N", sep="\t", quote="")
kwargs_write_csv = dict(compression="gzip", escape='"', header=True, mode="overwrite")

spark = pyspark.sql.SparkSession.builder.master("local[*]").getOrCreate()
```

#### https://datasets.imdbws.com/name.basics.tsv.gz

**name.basics.tsv.gz** – Contains the following information for names:
- nconst (string) - alphanumeric unique identifier of the name/person
- primaryName (string)– name by which the person is most often credited
- birthYear – in YYYY format
- deathYear – in YYYY format if applicable, else '\N'
- primaryProfession (array of strings)– the top-3 professions of the person
- knownForTitles (array of tconsts) – titles the person is known for


```python
spark.read.csv(
    "/tmp/datasets.imdbws.com/name.basics.tsv.gz",
    schema="""
        nconst string,
        primaryName string,
        birthYear integer,
        deathYear integer,
        primaryProfession string,
        knownForTitles string
    """,
    **kwargs_read_csv
).createOrReplaceTempView("`name.basics`")
spark.table("`name.basics`").limit(10).toPandas().T
```




<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>nconst</th>
      <td>nm0000001</td>
      <td>nm0000002</td>
      <td>nm0000003</td>
      <td>nm0000004</td>
      <td>nm0000005</td>
      <td>nm0000006</td>
      <td>nm0000007</td>
      <td>nm0000008</td>
      <td>nm0000009</td>
      <td>nm0000010</td>
    </tr>
    <tr>
      <th>primaryName</th>
      <td>Fred Astaire</td>
      <td>Lauren Bacall</td>
      <td>Brigitte Bardot</td>
      <td>John Belushi</td>
      <td>Ingmar Bergman</td>
      <td>Ingrid Bergman</td>
      <td>Humphrey Bogart</td>
      <td>Marlon Brando</td>
      <td>Richard Burton</td>
      <td>James Cagney</td>
    </tr>
    <tr>
      <th>birthYear</th>
      <td>1899</td>
      <td>1924</td>
      <td>1934</td>
      <td>1949</td>
      <td>1918</td>
      <td>1915</td>
      <td>1899</td>
      <td>1924</td>
      <td>1925</td>
      <td>1899</td>
    </tr>
    <tr>
      <th>deathYear</th>
      <td>1987.0</td>
      <td>2014.0</td>
      <td>NaN</td>
      <td>1982.0</td>
      <td>2007.0</td>
      <td>1982.0</td>
      <td>1957.0</td>
      <td>2004.0</td>
      <td>1984.0</td>
      <td>1986.0</td>
    </tr>
    <tr>
      <th>primaryProfession</th>
      <td>soundtrack,actor,miscellaneous</td>
      <td>actress,soundtrack</td>
      <td>actress,soundtrack,music_department</td>
      <td>actor,soundtrack,writer</td>
      <td>writer,director,actor</td>
      <td>actress,soundtrack,producer</td>
      <td>actor,soundtrack,producer</td>
      <td>actor,soundtrack,director</td>
      <td>actor,soundtrack,producer</td>
      <td>actor,soundtrack,director</td>
    </tr>
    <tr>
      <th>knownForTitles</th>
      <td>tt0050419,tt0072308,tt0053137,tt0031983</td>
      <td>tt0075213,tt0038355,tt0117057,tt0037382</td>
      <td>tt0054452,tt0049189,tt0057345,tt0056404</td>
      <td>tt0072562,tt0077975,tt0080455,tt0078723</td>
      <td>tt0083922,tt0060827,tt0050986,tt0050976</td>
      <td>tt0077711,tt0038109,tt0036855,tt0034583</td>
      <td>tt0033870,tt0034583,tt0037382,tt0043265</td>
      <td>tt0078788,tt0047296,tt0070849,tt0068646</td>
      <td>tt0087803,tt0057877,tt0059749,tt0061184</td>
      <td>tt0035575,tt0031867,tt0029870,tt0042041</td>
    </tr>
  </tbody>
</table>




```python
spark.sql(
    """
    select nconst          as `nconst:ID(Name)`,
           primaryName     as `primaryName`,
           birthYear       as `birthYear:long`,
           deathYear       as `deathYear:long`,
           array_join(array('Name') ||
                      ifnull(transform(split(primaryProfession, ','), `_` -> 'primaryProfession=' || `_`),
                             array()),
                      ';') as `:LABEL`
    from `name.basics`
    """
).coalesce(1).write.csv(f"{neo4j_staging}/import/name.basics", **kwargs_write_csv)
```


```python
spark.sql(
    """
    select nconst                              as `:START_ID(Name)`,
           'knownForTitles'                    as `:TYPE`,
           explode(split(knownForTitles, ',')) as `:END_ID(Title)`
    from `name.basics`
    """
).coalesce(1).write.csv(
    f"{neo4j_staging}/import/name.basics.knownForTitles", **kwargs_write_csv
)
```

#### https://datasets.imdbws.com/title.akas.tsv.gz

**title.akas.tsv.gz** - Contains the following information for titles:

- titleId (string) - a tconst, an alphanumeric unique identifier of the title
- ordering (integer) – a number to uniquely identify rows for a given titleId
- title (string) – the localized title
- region (string) - the region for this version of the title
- language (string) - the language of the title
- types (array) - Enumerated set of attributes for this alternative title. One or more of the following: "alternative", "dvd", "festival", "tv", "video", "working", "original", "imdbDisplay". New values may be added in the future without warning
- attributes (array) - Additional terms to describe this alternative title, not enumerated
- isOriginalTitle (boolean) – 0: not original title; 1: original title


```python
spark.read.csv(
    "/tmp/datasets.imdbws.com/title.akas.tsv.gz",
    schema="""
        titleId string,
        ordering integer,
        title string,
        region string,
        language string,
        types string,
        attributes string,
        isOriginalTitle integer
    """,
    **kwargs_read_csv
).createOrReplaceTempView("`title.akas`")
spark.table("`title.akas`").limit(10).toPandas().T
```




<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>titleId</th>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000002</td>
      <td>tt0000002</td>
    </tr>
    <tr>
      <th>ordering</th>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>title</th>
      <td>Карменсіта</td>
      <td>Carmencita</td>
      <td>Carmencita - spanyol tánc</td>
      <td>Καρμενσίτα</td>
      <td>Карменсита</td>
      <td>Carmencita</td>
      <td>Carmencita</td>
      <td>カルメンチータ</td>
      <td>Le clown et ses chiens</td>
      <td>Le clown et ses chiens</td>
    </tr>
    <tr>
      <th>region</th>
      <td>UA</td>
      <td>DE</td>
      <td>HU</td>
      <td>GR</td>
      <td>RU</td>
      <td>US</td>
      <td>None</td>
      <td>JP</td>
      <td>None</td>
      <td>FR</td>
    </tr>
    <tr>
      <th>language</th>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>ja</td>
      <td>None</td>
      <td>None</td>
    </tr>
    <tr>
      <th>types</th>
      <td>imdbDisplay</td>
      <td>None</td>
      <td>imdbDisplay</td>
      <td>imdbDisplay</td>
      <td>imdbDisplay</td>
      <td>imdbDisplay</td>
      <td>original</td>
      <td>imdbDisplay</td>
      <td>original</td>
      <td>imdbDisplay</td>
    </tr>
    <tr>
      <th>attributes</th>
      <td>None</td>
      <td>literal title</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
    </tr>
    <tr>
      <th>isOriginalTitle</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
  </tbody>
</table>




```python
spark.sql(
    """
    select titleId || '#' || ordering as `tconst:ID(TitleAka)`,
           title                      as `title`,
           region                     as `region`,
           language                   as `language`,
           boolean(isOriginalTitle)   as `isOriginalTitle:boolean`,
           array_join(array('TitleAka') ||
                      ifnull(transform(split(attributes, ','), `_` -> 'attributes=' || `_`),
                             array()) ||
                      ifnull(transform(split(types, ','), `_` -> 'types=' || `_`),
                             array()),
                      ';')            as `:LABEL`
    from `title.akas`
    """
).coalesce(1).write.csv(f"{neo4j_staging}/import/title.akas", **kwargs_write_csv)
```


```python
spark.sql(
    """
    select titleId                    as `:START_ID(Title)`,
           'akas'                     as `:TYPE`,
           titleId || '#' || ordering as `:END_ID(TitleAka)`,
           ordering                   as `ordering:long`
    from `title.akas`
    """
).coalesce(1).write.csv(f"{neo4j_staging}/import/title.akas.akas", **kwargs_write_csv)
```

#### https://datasets.imdbws.com/title.basics.tsv.gz + https://datasets.imdbws.com/title.ratings.tsv.gz

**title.basics.tsv.gz** - Contains the following information for titles:
- tconst (string) - alphanumeric unique identifier of the title
- titleType (string) – the type/format of the title (e.g. movie, short, tvseries, tvepisode, video, etc)
- primaryTitle (string) – the more popular title / the title used by the filmmakers on promotional materials at the point of release
- originalTitle (string) - original title, in the original language
- isAdult (boolean) - 0: non-adult title; 1: adult title
- startYear (YYYY) – represents the release year of a title. In the case of TV Series, it is the series start year
- endYear (YYYY) – TV Series end year. ‘\N’ for all other title types
- runtimeMinutes – primary runtime of the title, in minutes
- genres (string array) – includes up to three genres associated with the title


```python
spark.read.csv(
    "/tmp/datasets.imdbws.com/title.basics.tsv.gz",
    schema="""
        tconst string,
        titleType string,
        primaryTitle string,
        originalTitle string,
        isAdult integer,
        startYear integer,
        endYear integer,
        runtimeMinutes integer,
        genres string
    """,
    **kwargs_read_csv
).createOrReplaceTempView("`title.basics`")
spark.table("`title.basics`").limit(10).toPandas().T
```




<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>tconst</th>
      <td>tt0000001</td>
      <td>tt0000002</td>
      <td>tt0000003</td>
      <td>tt0000004</td>
      <td>tt0000005</td>
      <td>tt0000006</td>
      <td>tt0000007</td>
      <td>tt0000008</td>
      <td>tt0000009</td>
      <td>tt0000010</td>
    </tr>
    <tr>
      <th>titleType</th>
      <td>short</td>
      <td>short</td>
      <td>short</td>
      <td>short</td>
      <td>short</td>
      <td>short</td>
      <td>short</td>
      <td>short</td>
      <td>short</td>
      <td>short</td>
    </tr>
    <tr>
      <th>primaryTitle</th>
      <td>Carmencita</td>
      <td>Le clown et ses chiens</td>
      <td>Pauvre Pierrot</td>
      <td>Un bon bock</td>
      <td>Blacksmith Scene</td>
      <td>Chinese Opium Den</td>
      <td>Corbett and Courtney Before the Kinetograph</td>
      <td>Edison Kinetoscopic Record of a Sneeze</td>
      <td>Miss Jerry</td>
      <td>Leaving the Factory</td>
    </tr>
    <tr>
      <th>originalTitle</th>
      <td>Carmencita</td>
      <td>Le clown et ses chiens</td>
      <td>Pauvre Pierrot</td>
      <td>Un bon bock</td>
      <td>Blacksmith Scene</td>
      <td>Chinese Opium Den</td>
      <td>Corbett and Courtney Before the Kinetograph</td>
      <td>Edison Kinetoscopic Record of a Sneeze</td>
      <td>Miss Jerry</td>
      <td>La sortie de l'usine Lumière à Lyon</td>
    </tr>
    <tr>
      <th>isAdult</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>startYear</th>
      <td>1894</td>
      <td>1892</td>
      <td>1892</td>
      <td>1892</td>
      <td>1893</td>
      <td>1894</td>
      <td>1894</td>
      <td>1894</td>
      <td>1894</td>
      <td>1895</td>
    </tr>
    <tr>
      <th>endYear</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>runtimeMinutes</th>
      <td>1</td>
      <td>5</td>
      <td>4</td>
      <td>12</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>40</td>
      <td>1</td>
    </tr>
    <tr>
      <th>genres</th>
      <td>Documentary,Short</td>
      <td>Animation,Short</td>
      <td>Animation,Comedy,Romance</td>
      <td>Animation,Short</td>
      <td>Comedy,Short</td>
      <td>Short</td>
      <td>Short,Sport</td>
      <td>Documentary,Short</td>
      <td>Romance,Short</td>
      <td>Documentary,Short</td>
    </tr>
  </tbody>
</table>



**title.ratings.tsv.gz** – Contains the IMDb rating and votes information for titles
- tconst (string) - alphanumeric unique identifier of the title
- averageRating – weighted average of all the individual user ratings
- numVotes - number of votes the title has received


```python
spark.read.csv(
    "/tmp/datasets.imdbws.com/title.ratings.tsv.gz",
    schema="""
        tconst string,
        averageRating float,
        numVotes integer
    """,
    **kwargs_read_csv
).createOrReplaceTempView("`title.ratings`")
spark.table("`title.ratings`").limit(10).toPandas().T
```




<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>tconst</th>
      <td>tt0000001</td>
      <td>tt0000002</td>
      <td>tt0000003</td>
      <td>tt0000004</td>
      <td>tt0000005</td>
      <td>tt0000006</td>
      <td>tt0000007</td>
      <td>tt0000008</td>
      <td>tt0000009</td>
      <td>tt0000010</td>
    </tr>
    <tr>
      <th>averageRating</th>
      <td>5.7</td>
      <td>6.0</td>
      <td>6.5</td>
      <td>6.1</td>
      <td>6.2</td>
      <td>5.2</td>
      <td>5.4</td>
      <td>5.5</td>
      <td>5.9</td>
      <td>6.9</td>
    </tr>
    <tr>
      <th>numVotes</th>
      <td>1847</td>
      <td>237</td>
      <td>1609</td>
      <td>154</td>
      <td>2432</td>
      <td>160</td>
      <td>760</td>
      <td>1992</td>
      <td>192</td>
      <td>6651</td>
    </tr>
  </tbody>
</table>




```python
spark.sql(
    """
    select tconst           as `tconst:ID(Title)`,
           primaryTitle     as `primaryTitle`,
           originalTitle    as `originalTitle`,
           boolean(isAdult) as `isAdult:boolean`,
           startYear        as `startYear:long`,
           endYear          as `endYear:long`,
           runtimeMinutes   as `runtimeMinutes:long`,
           averageRating    as `averageRating:double`,
           numVotes         as `numVotes:long`,
           array_join(array('Title') ||
                      ifnull(transform(array(titleType), `_` -> 'titleType=' || `_`), array()) ||
                      ifnull(transform(split(genres, ','), `_` -> 'genres=' || `_`), array()),
                      ';')  as `:LABEL`
    from `title.basics`
             left join `title.ratings` using (tconst)
    """
).coalesce(1).write.csv(f"{neo4j_staging}/import/title.basics", **kwargs_write_csv)
```

#### https://datasets.imdbws.com/title.crew.tsv.gz

**title.crew.tsv.gz** – Contains the director and writer information for all the titles in IMDb. Fields include:
- tconst (string) - alphanumeric unique identifier of the title
- directors (array of nconsts) - director(s) of the given title
- writers (array of nconsts) – writer(s) of the given title


```python
spark.read.csv(
    "/tmp/datasets.imdbws.com/title.crew.tsv.gz",
    schema="""
        tconst string,
        directors string,
        writers string
    """,
    **kwargs_read_csv
).createOrReplaceTempView("`title.crew`")
spark.table("`title.crew`").limit(10).toPandas().T
```




<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>tconst</th>
      <td>tt0000001</td>
      <td>tt0000002</td>
      <td>tt0000003</td>
      <td>tt0000004</td>
      <td>tt0000005</td>
      <td>tt0000006</td>
      <td>tt0000007</td>
      <td>tt0000008</td>
      <td>tt0000009</td>
      <td>tt0000010</td>
    </tr>
    <tr>
      <th>directors</th>
      <td>nm0005690</td>
      <td>nm0721526</td>
      <td>nm0721526</td>
      <td>nm0721526</td>
      <td>nm0005690</td>
      <td>nm0005690</td>
      <td>nm0005690,nm0374658</td>
      <td>nm0005690</td>
      <td>nm0085156</td>
      <td>nm0525910</td>
    </tr>
    <tr>
      <th>writers</th>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>nm0085156</td>
      <td>None</td>
    </tr>
  </tbody>
</table>




```python
spark.sql(
    """
    select tconst                         as `:START_ID(Title)`,
           'directors'                    as `:TYPE`,
           explode(split(directors, ',')) as `:END_ID(Name)`
    from `title.crew`
    union
    select tconst                       as `:START_ID(Title)`,
           'writers'                    as `:TYPE`,
           explode(split(writers, ',')) as `:END_ID(Name)`
    from `title.crew`
    """
).coalesce(1).write.csv(f"{neo4j_staging}/import/title.crew", **kwargs_write_csv)
```

#### https://datasets.imdbws.com/title.episode.tsv.gz

**title.episode.tsv.gz** – Contains the tv episode information. Fields include:
- tconst (string) - alphanumeric identifier of episode
- parentTconst (string) - alphanumeric identifier of the parent TV Series
- seasonNumber (integer) – season number the episode belongs to
- episodeNumber (integer) – episode number of the tconst in the TV series


```python
spark.read.csv(
    "/tmp/datasets.imdbws.com/title.episode.tsv.gz",
    schema="""
        tconst string,
        parentTconst string,
        seasonNumber integer,
        episodeNumber integer
    """,
    **kwargs_read_csv
).createOrReplaceTempView("`title.episode`")
spark.table("`title.episode`").limit(10).toPandas().T
```




<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>tconst</th>
      <td>tt0020666</td>
      <td>tt0020829</td>
      <td>tt0021166</td>
      <td>tt0021612</td>
      <td>tt0021655</td>
      <td>tt0021663</td>
      <td>tt0021664</td>
      <td>tt0021701</td>
      <td>tt0021802</td>
      <td>tt0022009</td>
    </tr>
    <tr>
      <th>parentTconst</th>
      <td>tt15180956</td>
      <td>tt15180956</td>
      <td>tt15180956</td>
      <td>tt15180956</td>
      <td>tt15180956</td>
      <td>tt15180956</td>
      <td>tt15180956</td>
      <td>tt15180956</td>
      <td>tt15180956</td>
      <td>tt15180956</td>
    </tr>
    <tr>
      <th>seasonNumber</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>episodeNumber</th>
      <td>2</td>
      <td>1</td>
      <td>3</td>
      <td>2</td>
      <td>5</td>
      <td>6</td>
      <td>4</td>
      <td>1</td>
      <td>11</td>
      <td>10</td>
    </tr>
  </tbody>
</table>




```python
spark.sql(
    """
    select parentTconst  as `:START_ID(Title)`,
           'episodes'    as `:TYPE`,
           tconst        as `:END_ID(Title)`,
           seasonNumber  as `seasonNumber:long`,
           episodeNumber as `episodeNumber:long`
    from `title.episode`
    """
).coalesce(1).write.csv(f"{neo4j_staging}/import/title.episode", **kwargs_write_csv)
```

#### https://datasets.imdbws.com/title.principals.tsv.gz

**title.principals.tsv.gz** – Contains the principal cast/crew for titles
- tconst (string) - alphanumeric unique identifier of the title
- ordering (integer) – a number to uniquely identify rows for a given titleId
- nconst (string) - alphanumeric unique identifier of the name/person
- category (string) - the category of job that person was in
- job (string) - the specific job title if applicable, else '\N'
- characters (string) - the name of the character played if applicable, else '\N'


```python
spark.read.csv(
    "/tmp/datasets.imdbws.com/title.principals.tsv.gz",
    schema="""
        tconst string,
        ordering integer,
        nconst string,
        category string,
        job string,
        characters string
    """,
    **kwargs_read_csv
).createOrReplaceTempView("`title.principals`")
spark.table("`title.principals`").limit(10).toPandas().T
```




<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>tconst</th>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000001</td>
      <td>tt0000002</td>
      <td>tt0000002</td>
      <td>tt0000003</td>
      <td>tt0000003</td>
      <td>tt0000003</td>
      <td>tt0000003</td>
      <td>tt0000004</td>
    </tr>
    <tr>
      <th>ordering</th>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>1</td>
      <td>2</td>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>nconst</th>
      <td>nm1588970</td>
      <td>nm0005690</td>
      <td>nm0374658</td>
      <td>nm0721526</td>
      <td>nm1335271</td>
      <td>nm0721526</td>
      <td>nm1770680</td>
      <td>nm1335271</td>
      <td>nm5442200</td>
      <td>nm0721526</td>
    </tr>
    <tr>
      <th>category</th>
      <td>self</td>
      <td>director</td>
      <td>cinematographer</td>
      <td>director</td>
      <td>composer</td>
      <td>director</td>
      <td>producer</td>
      <td>composer</td>
      <td>editor</td>
      <td>director</td>
    </tr>
    <tr>
      <th>job</th>
      <td>None</td>
      <td>None</td>
      <td>director of photography</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>producer</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
    </tr>
    <tr>
      <th>characters</th>
      <td>["Self"]</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
    </tr>
  </tbody>
</table>




```python
spark.sql(
    """
    select tconst          as `:START_ID(Title)`,
           'principals'    as `:TYPE`,
           nconst          as `:END_ID(Name)`,
           ordering        as `ordering:long`,
           category        as `category`,
           job             as `job`,
           array_join(from_json(characters, 'array<string>'),
                      ';') as `characters`
    from `title.principals`
    """
).coalesce(1).write.csv(f"{neo4j_staging}/import/title.principals", **kwargs_write_csv)
```

### Load


```python
!tree -h '{neo4j_staging}/import'
```

    [4.0K]  /tmp/neo4j_staging/datasets.imdbws.com/import
    ├── [4.0K]  name.basics
    │   ├── [148M]  part-00000-4adc0db8-e1be-42b1-8009-093744e4c1a9-c000.csv.gz
    │   └── [   0]  _SUCCESS
    ├── [4.0K]  name.basics.knownForTitles
    │   ├── [ 98M]  part-00000-0fc6773a-b8ea-472d-afe7-843875c4197b-c000.csv.gz
    │   └── [   0]  _SUCCESS
    ├── [4.0K]  title.akas
    │   ├── [252M]  part-00000-c812541e-2d10-4815-91e7-7facc74186e5-c000.csv.gz
    │   └── [   0]  _SUCCESS
    ├── [4.0K]  title.akas.akas
    │   ├── [ 89M]  part-00000-d57d1d81-5587-4717-98ed-f1af47f10328-c000.csv.gz
    │   └── [   0]  _SUCCESS
    ├── [4.0K]  title.basics
    │   ├── [153M]  part-00000-2a4fa35f-fdc7-4596-b2b1-3b9c52bd1ead-c000.csv.gz
    │   └── [   0]  _SUCCESS
    ├── [4.0K]  title.crew
    │   ├── [117M]  part-00000-ddc7238b-bd6c-41e4-875a-c110a35cc530-c000.csv.gz
    │   └── [   0]  _SUCCESS
    ├── [4.0K]  title.episode
    │   ├── [ 35M]  part-00000-c3653084-841d-4972-a927-66d263d57cec-c000.csv.gz
    │   └── [   0]  _SUCCESS
    └── [4.0K]  title.principals
        ├── [373M]  part-00000-65eb0487-4aa4-4d26-b3f9-a3e89e919142-c000.csv.gz
        └── [   0]  _SUCCESS
    
    8 directories, 16 files


Run the following command to ingest data into Neo4j:


```python
Markdown(
    fr"""
```shell
docker pull neo4j:4.1.4-community

docker run \
   --rm \
   -e NEO4J_AUTH=none \
   -p 7474:7474 \
   -p 7687:7687 \
   -v {neo4j_staging}/data:/data \
   -v {neo4j_staging}/logs:/logs \
   -v {neo4j_staging}/import:/var/lib/neo4j/import \
 neo4j:4.1.4-community bin/neo4j-admin import \
   --database=imdb \
   --high-io=true \
   --max-memory=2G \
   --nodes='import/name.basics/.+.csv.gz' \
   --nodes='import/title.akas/.+.csv.gz' \
   --nodes='import/title.basics/.+.csv.gz' \
   --relationships='import/name.basics.knownForTitles/.+.csv.gz' \
   --relationships='import/title.akas.akas/.+.csv.gz' \
   --relationships='import/title.crew/.+.csv.gz' \
   --relationships='import/title.episode/.+.csv.gz' \
   --relationships='import/title.principals/.+.csv.gz' \
   --skip-bad-relationships=true \
   --skip-duplicate-nodes=true
```"""
)
```





```shell
docker pull neo4j:4.1.4-community

docker run \
   --rm \
   -e NEO4J_AUTH=none \
   -p 7474:7474 \
   -p 7687:7687 \
   -v /tmp/neo4j_staging/datasets.imdbws.com/data:/data \
   -v /tmp/neo4j_staging/datasets.imdbws.com/logs:/logs \
   -v /tmp/neo4j_staging/datasets.imdbws.com/import:/var/lib/neo4j/import \
 neo4j:4.1.4-community bin/neo4j-admin import \
   --database=imdb \
   --high-io=true \
   --max-memory=2G \
   --nodes='import/name.basics/.+.csv.gz' \
   --nodes='import/title.akas/.+.csv.gz' \
   --nodes='import/title.basics/.+.csv.gz' \
   --relationships='import/name.basics.knownForTitles/.+.csv.gz' \
   --relationships='import/title.akas.akas/.+.csv.gz' \
   --relationships='import/title.crew/.+.csv.gz' \
   --relationships='import/title.episode/.+.csv.gz' \
   --relationships='import/title.principals/.+.csv.gz' \
   --skip-bad-relationships=true \
   --skip-duplicate-nodes=true
```
   



```
IMPORT DONE in 9m 34s 920ms. 
Imported:
  50354453 nodes
  119199226 relationships
  455432935 properties
Peak memory usage: 748.0MiB
```

Run the following command to boot up Neo4j:


```python
Markdown(
    fr"""
```shell
docker run \
    --rm \
    -e NEO4J_AUTH=none \
    -e NEO4J_dbms_default__database=imdb \
    -p 7474:7474 \
    -p 7687:7687 \
    -v {neo4j_staging}/data:/data \
    -v {neo4j_staging}/logs:/logs \
    -v {neo4j_staging}/import:/var/lib/neo4j/import \
  neo4j:4.1.4-community
```"""
)
```





```shell
docker run \
    --rm \
    -e NEO4J_AUTH=none \
    -e NEO4J_dbms_default__database=imdb \
    -p 7474:7474 \
    -p 7687:7687 \
    -v /tmp/neo4j_staging/datasets.imdbws.com/data:/data \
    -v /tmp/neo4j_staging/datasets.imdbws.com/logs:/logs \
    -v /tmp/neo4j_staging/datasets.imdbws.com/import:/var/lib/neo4j/import \
  neo4j:4.1.4-community
```
    



## Exploratory Data Analysis

```cypher
MATCH (alex_garland:Name {nconst: 'nm0307497'}),
      (denis_villeneuve:Name {nconst: 'nm0898288'})
RETURN shortestPath((alex_garland)-[*..10]-(denis_villeneuve));
```

```cypher
MATCH (alex_garland:Name {nconst: 'nm0307497'}),
      (denis_villeneuve:Name {nconst: 'nm0898288'})
RETURN allShortestPaths((alex_garland)-[*..5]-(denis_villeneuve));
```
