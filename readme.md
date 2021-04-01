Introduction
Welcome, this is my personal training page where I keep the tutorials I have written for myself and hope they will be of use to others. There are a series of self-taught modules focused on various bioinformatics topics. This page is was built using a Jekyll template. Features that can be added can be viewed here. If the build fails for some reason send an email to Jill Hagey jvhagey@gmail.com.

Bioinformatics Tutorials

- Workflows: SnakeMake and WDL


Landing Page Edits
Edits to the landing page can be made in the index.md file.

Instructions for Adding New Content to the Tutorials Page
To create a new tutorials page go to pages/mydoc/ and create a new .md markdown file. At the beginning of this new file add the following lines.
---
title: Snakemake Basics # Make this the name of the tutorial
sidebar: mydoc_sidebar # Keep this the same as here
permalink: mydoc_myTutorial.html  # change the name of the file to something you want 
folder: mydoc # Keep this the same as here
---
To add your new page to the sidebar of the webpage, go to _data/sidebars/mydoc_sidebar.yml then add the following lines.
 - title: Name_of_Tutorial # Should be the name of "title" of the .md file as defined at the top of the .md file.
    output: web, pdf
    folderitems:

    - title: Name_of_Subfolder_for_Tutorial
      url: /mydoc_myTutorial.html  #Needs to be the same as the permalink in the .md file
      output: web, pdf

How to add a new blog post
To add a new blog post go to _posts and add a new .md file with the following added to the beginning of the file.
---
title:  "Welcome to the WDPB Tutorials Page!" # Change to the title of your blog post
categories: update
permalink: myupdate.html
tags: [news]
---
