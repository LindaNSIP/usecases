# usecases
Contains the source elements for use cases

**Please read the [style guide](https://github.com/nsip/usecases/wiki/Style-guide) before making any changes to the publishable content of these files.**


NOTES: Building (Scott & Peter)

* Partial Files
	* Edit partial files in source/**/*.md
	* Partial files should be complete Markdown
	* Edit a master file (pulling others in) source/**/*.mdx
* Master files
	* Master files can contain markdown, but mostly just includes
	* TODO: What include format (custom, pandoc-include, gcc, other)
* Version Control
	* master branch = Alpha version being worked on
	* release branch = Current released version
	* tags v1, v2, ... for release versions (allows diff)
* Building / Automation
	* URL (low or no protection required) to build Alpha HTML files on hits
	* URL (slight protection) to build release files onto site
	* Code part of hits-dashboard
		* Update usecases repository
		* Choose master (alpha) or release (released version)
		* Run update.sh to build files
		* Commit new files back to dist/
		* Automatic generate diff (from master to release for now)
* File Formats
	* Original Partials
		* Standard Markdown
		* TODO supported tags
	* Original Master Documents
		* Extended Markdown to support includes
		* TODO settle on format
	* Static HTML
		* Generated stand alone, simple, simple CSS
		* Generated part of hits-dashboard via Jade/Pugs
	* Word Document
		* Generate clean Word Versions for use in other places
		* Should be clean (style names) for applying alternative style sheets



Directory Structure


	docs/*
		Master documents
			Master document, pulls in Fragments
		Fragments
			No processing or output
		Resources (images, CSV, PDF)
			Some processing - e.g. convert size/format of image

		docs/timetable/
			business.mdx
			hits-developer.mdx
			images/flowchart.png
		docs/common/
			tech_preamble.md
		docs/common/images/
			logo.png
		docs/common/resources/
			license.pdf

		Stage 1
			docs/timetable/business.md
			docs/timetable/hits-developer.md
			docs/common/tech_preamble.md
			docs/common/images/logo.png
			docs/common/resources/license.pdf
			docs/timetable/images/flowchart.png

		Stage 2
			output/generic/timetable/business.html
			output/generic/timetable/hits-developer.html
			output/generic/common/tech_preamble.html
			output/generic/common/images/logo.png
			output/generic/common/resources/license.pdf
			output/generic/timetable/images/flowchart.png
			output/hits-dashboard/timetable/business.html
			output/hits-dashboard/timetable/hits-developer.html
			output/hits-dashboard/common/tech_preamble.html
			output/hits-dashboard/common/images/logo.png
			output/hits-dashboard/common/resources/license.pdf
			output/hits-dashboard/timetable/images/flowchart.png
			output/word/timetable/business.doc
			output/word/timetable/hits-developer.doc
			output/word/common/tech_preamble.doc

	templates/
		hits-dashboard/
		generic/

	combined files/
		Final Mark down file (combined from master document/fragments)
		Resources

	build files/ (output/build)
		HTML via Jade/hits-dashboard
		HTML stand alone
		Word doc 
			Convert to PDF
		PDF

			* commit to master
			* URL on HITS server - pull and build
				Pull changes from 
				/dev/usecases/

		for each Master Document
			Generated (include) new Markdown file

		for each Template
			mkdir TemplateName
			for each Markdown file
				Build
				Copy resources
					Recursive copy all resource file types

	release/
		HTML (hits-dashboard)
			* merge to 'release' branch
			* URL on HITS server to pull files and rebuild
				/usecases/
		Manual - PDF etc

