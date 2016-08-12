# usecases
Contains the source elements for use cases


NOTES: Building (Scott & Peter)

* Partial Files
	* Edit partial files in source/**/*.md
	* Partial files should be complete Markdown
	* Edit a master file (pulling others in) source/**/*.mdx
* Master files
	* Master files can contain markdown, but mostly just includes
	* TODO: What include format (custom, pandoc-include, gcc, other)
* Version Control
* Building / Automation
	* URL (low or no protection required) to build Alpha HTML files on hits
	* URL (slight protection) to build release files onto site
	* Code part of hits-dashboard
		* Update usecases repository
		* Choose master (alpha) or release (released version)
		* Run update.sh to build files
		* Commit new files back to dist/
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

