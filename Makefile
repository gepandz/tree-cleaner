MOD := $(shell grep "name" info.json | sed -n 's/.*"name":.*"\(.*\)",.*/\1/p')
VERSION := $(shell grep "version" info.json | grep -Po '([0-9]+\.){2}[0-9]+')
DIRECTORY := $(MOD)_$(VERSION)
MOD_ZIP := $(DIRECTORY).zip

.PHONY: clean deploy

MOD_ZIP: clean
	rsync -r --progress --exclude-from .makeignore . $(DIRECTORY)
	zip -9qyrm $(MOD_ZIP) $(DIRECTORY)/

clean:
	rm -rf $(MOD_ZIP) $(DIRECTORY)

deploy: $(MOD_ZIP)
	cp $(MOD_ZIP) ../../../AppData/Roaming/Factorio/mods
