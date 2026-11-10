## ----include = FALSE----------------------------------------------------------
# R CMD check runs this code without knitr: pdf() can not draw Liberation Sans
if (!isTRUE(getOption("knitr.in.progress"))) ragg::agg_capture()
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dev = "ragg_png",
  dpi = 300,
  out.width = "100%",
  fig.width = 5,
  fig.height = 1.5
)

## ----setup, message=FALSE-----------------------------------------------------
library(munch)
library(grid)
library(flextable)
library(gdtools)

fset <- font_set_liberation()
set_flextable_defaults(font.family = "Liberation Sans")
# text properties with a monospace font for inline code
lib_props <- default_text_props(code_font_family = "Liberation Mono")

## ----basic-mdgrob-------------------------------------------------------------
gr <- md_grob("This is **bold** and *italic* text.")

grid.newpage()
grid.draw(gr)

## ----positioning--------------------------------------------------------------
grid.newpage()

gr1 <- md_grob("**Top left**", x = 0, y = 1, hjust = 0, vjust = 1)
gr2 <- md_grob("*Center*", x = 0.5, y = 0.5, hjust = 0.5, vjust = 0.5)
gr3 <- md_grob("`Bottom right`", x = 1, y = 0, hjust = 1, vjust = 0,
  text_props = lib_props)

grid.draw(gr1)
grid.draw(gr2)
grid.draw(gr3)

## ----wrapping-----------------------------------------------------------------
long_text <- "This is a **long text** that will be automatically
wrapped across multiple lines using the `width` parameter."

gr <- md_grob(long_text, x = 0.1, hjust = 0, width = 3,
  text_props = lib_props)

grid.newpage()
grid.draw(gr)

## ----chunks-basic, fig.width=3------------------------------------------------
chunks <- as_paragraph(
  as_chunk("E = mc"),
  as_sup("2")
)

gr <- chunks_grob(chunks)

grid.newpage()
grid.draw(gr)

## ----chunks-complex, fig.width=4----------------------------------------------
chunks <- as_paragraph(
  as_chunk("The speed of light is "),
  as_b("c"),
  as_chunk(" = 3\u00D710"),
  as_sup("8"),
  as_chunk(" m/s")
)

gr <- chunks_grob(chunks)

grid.newpage()
grid.draw(gr)

## ----chunks-colors, fig.width=4-----------------------------------------------
chunks <- as_paragraph(
  as_chunk("Normal "),
  colorize(as_chunk("Red "), color = "red"),
  as_highlight(as_chunk("Yellow bg"), color = "yellow")
)

gr <- chunks_grob(chunks)

grid.newpage()
grid.draw(gr)

## ----text-props---------------------------------------------------------------
props <- default_text_props(
  font_size = 14,
  font_family = fset$serif,
  font_color = "darkblue",
  code_font_family = "Liberation Mono"
)

gr <- md_grob("Custom **styled** text with `code`", text_props = props)

grid.newpage()
grid.draw(gr)

## ----flextable-defaults-------------------------------------------------------
old <- set_flextable_defaults(
  font.size = 14,
  font.color = "darkblue"
)

gr <- md_grob("Text using **flextable** defaults")

grid.newpage()
grid.draw(gr)

# Restore the previous defaults
do.call(set_flextable_defaults, old)

## ----images-md----------------------------------------------------------------
img_path <- file.path(R.home("doc"), "html", "logo.jpg")

text_with_img <- sprintf("The R logo: ![](%s) in text.", img_path)

gr <- md_grob(text_with_img)

grid.newpage()
grid.draw(gr)

## ----images-chunks------------------------------------------------------------
img_path <- file.path(R.home("doc"), "html", "logo.jpg")

chunks <- as_paragraph(
  as_chunk("The R logo "),
  as_image(src = img_path, width = 0.3, height = 0.3),
  as_chunk(" is iconic.")
)

gr <- chunks_grob(chunks)

grid.newpage()
grid.draw(gr)

## ----image-baseline-----------------------------------------------------------
props <- default_text_props(img_baseline_ratio = 0.35)

gr <- md_grob(
  sprintf("Text ![](%s) centered", img_path),
  text_props = props
)

grid.newpage()
grid.draw(gr)

## ----annotation-custom, fig.width=6, fig.height=4, message=FALSE--------------
library(ggplot2)

stats_grob <- md_grob(
  "**R\u00B2 = 0.87**\n\n*p < 0.001*",
  hjust = 0,
  vjust = 1
)

ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  annotation_custom(
    grob = stats_grob,
    xmin = 25, xmax = 35,
    ymin = 4.5, ymax = 5.5
  )

## ----flextable-cells----------------------------------------------------------
ft <- flextable(head(iris, 3))
ft <- mk_par(ft, j = 1, part = "header",
  value = as_paragraph_md("*Sepal* **Length**"))
autofit(ft)

