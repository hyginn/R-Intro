# A simple markdown Cheatsheet
<sub>[Boris Steipe](https://orcid.org/0000-0002-1134-6758) &lt; boris.steipe@utoronto.ca &gt; [&copy;CC-BY](https://creativecommons.org/licenses/by/4.0/)</sub>

<style type="text/css" rel="stylesheet">
td {border:1px solid #dddddd; padding:7px; }
</style>

&nbsp;


<table>
<tr>
<td>**Topic:**</td>
<td>**You type ...**</td>
<td>**You get ...**</td>
</tr>
<tr>
<td rowspan="6">MD Formatting</td>
<td>`**bold**`</td>
<td>**bold**</td>
</tr>
<tr>
<td>`_italic_`</td>
<td>_italic_</td>
</tr>
<tr>
<td>``type `?seq` for details``</td>
<td>type `?seq` for details</td>
</tr>
<tr>
<td>`~~strikethrough~~`</td>
<td>~~strikethrough~~</td>
</tr>
<tr>
<td>`> quoted text`</td>
<td>
> quoted text
</td>
</tr>
<tr>
<td>`[qrandom](https://cran.r-project.org/package=qrandom)`</td>
<td>[qrandom](https://cran.r-project.org/package=qrandom)</td>
</tr>
</table>

&nbsp;

```
----
```
----

&nbsp;

```
# Heading
## Subheading
### Subsubheading
```
# Heading
## Subheading
### Subsubheading

&nbsp;

```
- Red
    - Roses
- Blue
    - Violets
- Sweet
    - Sugar
    - You
```
- Red
    - Roses
- Blue
    - Violets
- Sweet
    - Sugar
    - You
&nbsp;

```
I hate:

1. Lists
1. Irony
1. Lists
1. Repetition

E. Inconsistency
```
I hate:

1. Lists
1. Irony
1. Lists
1. Repetition

E. Inconsistency

&nbsp;

````
```R
set.seed(NULL)
(a <- runif(1))  # The surrounding parentheses print
                 # the value of the expression
```
````

```R
set.seed(NULL)
(a <- runif(1))  # The surrounding parentheses print
                 # the value of the expression
ifelse(a > 0.5, "You win", "I win")
```

&nbsp;

`[END]`<!-- END -->
