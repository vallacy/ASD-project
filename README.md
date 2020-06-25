# Attitudes Toward College Students with Autism Spectrum Disorder (ASD) Pre- and Post-Intervention Analyses
## Factorial ANOVA, One-Way ANOVA, Wilcoxon Signed-Rank Test, and Wilcoxon Rank-Sum Test in R

### Project Background
I worked as a statistical consultant with a professor who wanted to see if he could improve his students' attitudes toward students who have Autism Spectrum Disorder (ASD) by creating and implementing a lecture about ASD for his Introduction to Psychology course. He also wanted to assess whether or not his lecture increased his students' knowledge about people with ASD. To do so, he gave students a survey pre- and post-lecture, which measured their attitudes toward and knowledge about students with ASD. These students were the treatment group. He also had other professors teaching Introduction to Psychology courses at the same institution give their students the same survey, without having the lecture, and they served as the control group.

### Analyses
I ran One-Way Within-Subjects ANOVAs, One-Way Between-Subjects ANOVAs, Factorial ANOVAs, Wilcoxon Rank-Sum Tests and Wilcoxon Signed-Rank Tests.

ANOVAs were run first, and results were not statistically significant. This was likely due to small sample sizes and non-normal distributions of scores on the attitudes and knowledge scales. Thus, non-parametric tests (Wilcoxon Rank-Sum Tests and Wilcoxon Signed-Rank Tests) were used.

Wilcoxon Signed-Rank Test Example Code:

~~~R
#test comparing total scores on attitude scale for treatment group at baseline and follow-up
wilcox.test(tx_2$a_tot, tx_2$a_tot_2, paired=TRUE)

#calculate effect size, Cliff's delta, for difference between baseline and follow-up in tx group, attitude scale 
cliff.delta(tx_2$a_tot, tx_2$a_tot_2, conf.level=.95, 
            use.unbiased=TRUE, use.normal=FALSE, 
            return.dm=FALSE)

~~~

### Results
Students in the treatment group had more favorable attitudes toward students with ASD and more knowledge about people with ASD after participating in the lecture. Results of the Wilcoxon Signed-Rank Tests showed statistically significant differences in the ranks between pre- and post-lecture attitudes and knowledge scores among students in the treatment group (those who experienced the lecture).

![histogram showing difference in attitude scores in treatment group between time 1 and time 2](histogram.png)

Code to create the above boxplot:

~~~R
#create boxplot for treatment group
ggboxplot(tx, x = "observation", y = "a_tot", 
          color = "observation", palette = c("#00AFBB", "#E7B800"),
          order = c("1", "2"),
          title = "Treatment Group Scores on Attitudes Toward Students with ASD Pre- and Post-Lecture",
          ylab = "Attitude Scale Score", xlab = "Time Point",
          legend = '')
~~~
