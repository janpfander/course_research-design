# Code to generate hex sticker
library(ggplot2)
library(hexSticker)
library(gridExtra)
library(grid)
library(ggtext)  # This library allows for rich text formatting

# for some reason, this is in the wrong working directory
getwd()

# ... but just play along with it

# Wes Anderson colors
wes_palette <- c(
  "Zissou" = "#0C4B6A",    # Dark blue (for text)
  "Moonrise" = "#F4C542",   # Warm yellow (for accents)
  "Darjeeling" = "#9E2A2F" # Dark red (for hex border)
)

# Simulated data: Normal distribution
set.seed(123)
df <- data.frame(x = rnorm(1000))

# Create a faded density plot (right side)
p1 <- ggplot(df, aes(x)) +
  geom_density(fill = wes_palette["Zissou"], alpha = 0.2, color = "black", linewidth = 0.3) +  
  theme_void() +  
  theme_transparent()

# Simulated "data frame" with faded appearance (left side)
df_table <- data.frame(ID = 1:5, Value = round(rnorm(5), 2))
p2 <- tableGrob(df_table, theme = ttheme_minimal(core = list(fg_params = list(alpha = 0.2)))) 

# Arrange table (left) & plot (right)
combined_plot <- arrangeGrob(p2, p1, ncol = 2, widths = c(1, 2))

# Save as image (make sure to set background to transparent)
img_path <- "images/combined_plot.png"
ggsave(img_path, combined_plot, width = 5, height = 3, dpi = 300, bg = "transparent")

# Now, use the image in sticker()
sticker(img_path,  # Pass the file path, NOT readPNG()
        package = "research_design",  # Title with line breaks
        p_x = 1, p_color = wes_palette["Zissou"],  # Dark blue text
        p_size = 16,  # Adjusted font size for better fit
        s_x = 1, s_y = 0.8, s_width = .6,
        h_color = wes_palette["Darjeeling"],  # Dark red border
        h_fill = wes_palette["Moonrise"],  # Soft green background
        filename = "images/hex_sticker.png")
