# Central Limit Theorem: A peak down a rabbit hole  

_Given a sufficiently large sample size, the sampling distribution of the sample mean (or sum) will be approximately normally distributed, regardless of the original distribution of the data—as long as the data are independent and identically distributed (i.i.d.) and have finite variance.__


**Below if gif showing binomial converging to normal with more replicates
![](images/distribution_histograms.gif){width="90%"}

- This was huge
<aside> Developing a rigorous proof of CLT was a major milestone in statistics, taking some ~170 years </aside>

- historically, limited in statistical approaches...
a) large sample sizes 
b) transformations - almightly Box-Cox  

$$
y^{(\lambda)} =
\begin{cases}
\frac{y^\lambda - 1}{\lambda}, & \text{if } \lambda \ne 0 \\
\ln(y), & \text{if } \lambda = 0
\end{cases}
$$






# Evolution of GLMs: A peak down a rabbit hole

Names: t-test, Anova, ANCOVA, 


```{r, echo=F, eval=T}
# Key Differences between General Linear Model and Generalized Linear Models
ds_glm <- data.frame(
  Aspect = c("Distribution", "Link function", "Variance", "Response type", "Historical"),
  General_Linear_Model = c("Normal only", 
                          "Identity only", 
                          "Constant (homoscedastic)", 
                          "Continuous", 
                          "1950s-60s framework"),
  Generalized_Linear_Models = c("Any exponential family", 
                               "Flexible (logit, log, etc.)", 
                               "Can vary with mean", 
                               "Continuous, binary, count, etc.", 
                               "Nelder & Wedderburn (1972)"),
  stringsAsFactors = FALSE
)

regulartable(ds_glm) %>% bold(j=1) %>%   table_font()
```




### Recommendations

- think about the processes that may be underlying the process
- "Don’t bring a cannon to a chess match" [try to keep is simple...just because you can does not mean you should]
- can overfit using mixture distributions



