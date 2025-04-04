library(rvest)
library(htmltools)
library(stringr)
library(dplyr)

articles <- read.csv2("articles.csv")


# Lade Daten
templates_hq <- read.csv("high-quality-templates.csv", sep=";")
templates_lq <- read.csv("low-quality-templates.csv", sep=";")

# Zufällige Zuweisung der Templates
css_template_hq <- sample(templates_hq$css, 8, replace = FALSE)
css_template_lq <- sample(templates_lq$css, 8, replace = FALSE)

adverts_folder <- "advert_images" # Replace with the actual folder path


generate_article <- function(
    headline, article_text, main_image, pub_date, author, newspaper_title,
    categories, css_template, adverts_folder, social_media = TRUE,
    related_headlines, related_images, output_file
) {
  # Create the category bar
  category_bar <- tags$div(
    class = "category-bar",
    lapply(categories, function(category) {
      tags$span(class = "category", tags$a(href = "#", category))
    })
  )
  
  # Create the social media bar (optional)
  social_media_bar <- if (social_media) {
    tags$div(
      class = "social-media-bar",
      tags$a(href = "#", "Share on Facebook"),
      tags$a(href = "#", "Share on Twitter"),
      tags$a(href = "#", "Share on LinkedIn")
    )
  } else {
    NULL
  }
  
  # Sidebar content: either related articles or advertisements
  if (!is.null(related_headlines) && !is.null(related_images) && 
      length(related_headlines) == length(related_images)) {
    # Related articles section
    sidebar_content <- tags$div(
      class = "related-articles",
      lapply(seq_along(related_headlines), function(i) {
        tags$div(
          class = "related-article",
          tags$img(src = related_images[i], alt = "Related article image", class = "related-image"),
          tags$a(href = "#", related_headlines[i], class = "related-headline")
        )
      })
    )
  } else {
    # Advertisements section
    advert_images <- list.files(adverts_folder, pattern = "\\.jpg$|\\.png$", full.names = TRUE)
    sidebar_content <- tags$div(
      class = "advertisements",
      lapply(advert_images, function(advert) {
        tags$img(src = advert, class = "advert")
      })
    )
  }
  
  # Create the HTML document
  article_html <- tags$html(
    tags$head(
      tags$title(newspaper_title),
      tags$style(HTML(css_template)) # Inline CSS for testing
    ),
    tags$body(
      # Header with burger menu, logo, and user icon
      tags$header(
        class = "header",
        tags$div(
          class = "container",
          tags$div(
            class = "logo",
            newspaper_title
          ),
        )
      ),
      # Category bar
      category_bar,
      # Main content and sidebar layout with sidebar on the right
      tags$div(
        class = "container content-layout",
        tags$div(
          class = "main-content",
          tags$h1(headline, class = "headline"),
          tags$img(src = main_image, alt = "Main image", class = "main-image"),
          tags$p(class = "meta-info", paste("Published on", pub_date, "by", author)),
          tags$div(class = "article-text", tags$p(article_text)),
          social_media_bar
        ),
        tags$div(
          class = "sidebar",
          sidebar_content
        )
      ),
      # Footer
      tags$footer(
        paste("© 2024 - ", newspaper_title)
      )
    )
  )
  
  # Save the HTML document to a file
  save_html(article_html, file = output_file)
  message(paste("Article saved to", output_file))
}


output_file <- "article1.html"

titles = c("Die Tagesstimme", 
           "Aktuelle Perspektive", 
           "Nordlicht Nachrichten", 
           "Süddeutsche Rundschau", 
           "Das Informationsnetz", 
           "Fokus Heute", 
           "Stimme der Regionen", 
           "Horizont Online", 
           "Die Faktenlage", 
           "Echo des Tages", 
           "Globaler Ausblick", 
           "Der Zeitspiegel", 
           "Freie Meldungen", 
           "Die Gegenwart", 
           "Neutrale Stimmen", 
           "Regionale Einblicke", 
           "Täglicher Überblick", 
           "Direkt Aktuell", 
           "Pressespiegel Online", 
           "Die Klartext-Zeitung")


journalist_names <- c(
  "Anna Müller",
  "Johannes Schmidt",
  "Sophie Fischer",
  "Lukas Becker",
  "Marie Wagner",
  "Felix Hoffmann",
  "Leonie Schneider",
  "Maximilian Weber",
  "Clara Braun",
  "Paul Meier"
)

abo_options <- c(
  "Probe-Abo",
  "Jetzt testen",
  "Kostenlos testen",
  "Testen Sie unser Abo",
  "Testzugang sichern",
  "Test-Abo",
  "Abo entdecken"
)



###
# Define inputs
for (i in 1:8) {
  input_article_index <- ceiling(i / 4)  # Jeder Input-Artikel hat 4 manipulierte Varianten
  pub_date <- "2025-17-01"
  author <- sample(journalist_names,1)
  newspaper_title <- sample(titles,1)
  categories_list <- list(
    set1 = c("Nachrichten", "Sport", "Stimmen", "Kultur", "Lifestyle", "Reisen"),
    set2 = c("Bundestagswahl", "Nahostkonflikt", "Ukrainekrieg", "Klimakrise", "Politik", "Ausland", "Panorama", "Sport", "Wirtschaft"),
    set3 = c("Gesellschaft", "Bildung", "Digitalisierung", "Energiepolitik", "Kultur", "Wissenschaft", "Medizin", "Europa", "Justiz"),
    set4 = c("Verkehrspolitik", "Migration", "Technologie", "Börse", "Infrastruktur", "Umwelt", "Literatur", "Film und Fernsehen", "Reise"),
    set5 = c("Forschung", "Datenschutz", "KI", "Wirtschaftskriminalität", "Agrarpolitik", "Meinung", "Techniktrends", "Regional", "Verbraucherschutz")
  )
  
  categories <- unlist(sample(categories_list, size = 1))
  
  # Related articles, related images, main-image
  related_headlines <- c(articles$R1[i], articles$R2[i], articles$R3[i])
  related_images <- paste0("related_images_", input_article_index, "/", 2:4, ".jpg")
  main_image <- paste0("related_images_", input_article_index, "/1.jpg")
  
  # Advertisements folder
  adverts_folder <- "adverts"
  
  output_file <- paste("article_HQ",i,".html")
  
  
  generate_article(
    articles$headline[i], articles$body[i], main_image, pub_date, author, newspaper_title,
    categories, css_template_hq[i], adverts_folder, social_media = TRUE,
    related_headlines = related_headlines, related_images = related_images,
    output_file = output_file
  )
}




# low quality

output_file <- "article2.html"

# Advertisements folder
adverts_folder <- "advert_images"


generate_low_quality_news <- function(
    headline, article_text, main_image, pub_date, author, newspaper_title,
    categories, css_template, adverts_folder, related_headlines, 
    related_images, output_file, ads = TRUE, top_ad = FALSE,
    social_media_image = NULL # New parameter for social media widget
) {
  # Split `newspaper_title` into first and remaining words
  title_words <- unlist(strsplit(newspaper_title, " ", fixed = TRUE))
  if (length(title_words) == 1) {
    first_word <- title_words[1]
    remaining_words <- ""
  } else {
    first_word <- title_words[1]
    remaining_words <- paste(title_words[-1], collapse = " ")
  }
  
  # Generate Category Bar
  category_bar <- tags$div(
    class = "category-bar",
    lapply(categories, function(category) {
      tags$a(href = "#", category)
    })
  )
  
  # Generate Advertisements for Sidebars
  advert_images <- list.files(adverts_folder, pattern = "\\.jpg$|\\.png$", full.names = TRUE)
  
  # Left Sidebar: Related Headlines or Ads
  left_sidebar <- if (!ads) {
    tags$div(
      class = "related-articles",
      lapply(seq_along(related_headlines), function(i) {
        tags$div(
          class = "related-article",
          tags$img(src = related_images[i], alt = "Related article image", class = "related-image"),
          tags$a(href = "#", related_headlines[i], class = "related-headline")
        )
      })
    )
  } else {
    tags$div(
      class = "sidebar",
      lapply(advert_images, function(ad) tags$img(src = ad, alt = "Advertisement"))
    )
  }
  
  # Right Sidebar: Ads Only
  right_sidebar <- tags$div(
    class = "sidebar",
    lapply(advert_images, function(ad) tags$img(src = ad, alt = "Advertisement"))
  )
  
  # Top Advertisement (if enabled)
  top_ad_banner <- if(!top_ad){
    if (top_ad && length(advert_images) > 0) {
      tags$div(
        class = "top-ad",
        tags$img(src = advert_images[1], alt = "Top Advertisement")
      )
    }
  } else {
    NULL
  }
  
  # Logo with Split Text and Star
  logo <- tags$div(
    class = "logo-container",
    tags$div(
      class = "logo-star",
      tags$span(class = "star") # Include a star icon here
    ),
    tags$div(
      class = "logo",
      tags$span(class = "first-word", first_word),
      tags$span(class = "remaining-words", remaining_words)
    )
  )
  
  # Social Media Share Widget
  social_media_widget <- if (!is.null(social_media_image)) {
    tags$div(
      class = "social-media-widget",
      tags$img(src = social_media_image, alt = "Share on social media")
    )
  } else {
    NULL
  }
  
  # Main Article Content
  main_content <- tags$div(
    class = "main-content",
    tags$h1(headline),
    tags$p(class = "meta-info", paste("Published on", pub_date, "by", author)),
    tags$img(src = main_image, class = "main-image"),
    tags$div(class = "article-text", tags$p(article_text)),
    social_media_widget # Add the social media widget below the article text
  )
  
  # Assemble Full Page
  low_quality_html <- tags$html(
    tags$head(
      tags$title(newspaper_title),
      tags$style(HTML(css_template))
    ),
    tags$body(
      top_ad_banner, # Add top ad banner here
      tags$header(
        logo # Insert the updated logo structure here
      ),
      category_bar,
      tags$div(
        class = "container",
        left_sidebar,
        main_content,
        right_sidebar
      ),
      tags$footer(
        paste("© 2024", newspaper_title, "- All Rights Reserved")
      )
    )
  )
  
  # Save HTML File
  save_html(low_quality_html, file = output_file)
  message(paste("Low-quality news saved to", output_file))
}

articles <- read.csv2("articles.csv")


###
# Define inputs
for (i in 1:8) {
  input_article_index <- ceiling(i / 4)  # Jeder Input-Artikel hat 4 manipulierte Varianten
  pub_date <- "2024-12-01"
  author <- sample(journalist_names,1)
  newspaper_title <- sample(titles,1)
  categories_list <- list(
    set1 = c("Nachrichten", "Sport", "Stimmen", "Kultur", "Lifestyle", "Reisen"),
    set2 = c("Bundestagswahl", "Nahostkonflikt", "Ukrainekrieg", "Klimakrise", "Politik", "Ausland", "Panorama", "Sport", "Wirtschaft"),
    set3 = c("Gesellschaft", "Bildung", "Digitalisierung", "Energiepolitik", "Kultur", "Wissenschaft", "Medizin", "Europa", "Justiz"),
    set4 = c("Verkehrspolitik", "Migration", "Technologie", "Börse", "Infrastruktur", "Umwelt", "Literatur", "Film und Fernsehen", "Reise"),
    set5 = c("Forschung", "Datenschutz", "KI", "Wirtschaftskriminalität", "Agrarpolitik", "Meinung", "Techniktrends", "Regional", "Verbraucherschutz")
  )
  
  categories <- unlist(sample(categories_list, size = 1))
  # Related articles, related images, main-image
  related_headlines <- c(articles$R1[i], articles$R2[i], articles$R3[i])
  related_images <- paste0("related_images_", input_article_index, "/", 2:4, ".jpg")
  main_image <- paste0("related_images_", input_article_index, "/1.jpg")
  
  output_file <- paste("article_LQ",i,".html")
  
  
  generate_low_quality_news(articles$headline[i], articles$body[i], main_image, pub_date, author, newspaper_title,
                            categories, css_template_lq[i], adverts_folder, 
                            related_headlines = related_headlines, related_images = related_images,
                            output_file = output_file, ads = TRUE,top_ad = FALSE, social_media_image = "published_sm.png")
}

