HOMEFILES := $(shell ls -A home)
DOTFILES := $(addprefix $(HOME)/,$(HOMEFILES))

.PHONEY: link unlink

link: | $(DOTFILES)

# This will link all of our dot files into our home directory.  The
# magic happening in the first arg to ln is just grabbing the file name
# and appending the path to dotfiles/home
$(DOTFILES):
	@ln -sv "$(PWD)/home/$(notdir $@)" $@

# Interactively delete symbolic links.
unlink:
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done

test: # echo pwd
	@echo $(HOMEFILES)
	@echo $(DOTFILES)
