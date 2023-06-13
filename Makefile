# Notes:
# inserted variables need $$; ;\ needed for multiline commands in every instance:

mrgi--help:
	echo "The following commands are available: ";\
	echo "\tgit-push";\
	echo "\t\tpush to git with a message";\
	echo "\tgit-checkout-build";\
	echo "\t\tcheckout a new branch and push it to git";\
	echo "\tgit-commit";\
	echo "\t\tcommit without a push:";\
	echo "\tgit-delete-current-branch";\
	echo "\t\tdelete the current branch and push the deletion to origin and switch to master:";\
	echo "\tgit-fetch-all";\
	echo "\t\tFetch all branches from origin:";\
	echo "\tosx_sanitize_hidden";\
	echo "\t\tRemove all messy OSX hidden files:";\
	echo "\trsync_update_destination";\
	echo "\t\tInternal SCP solution:";\
	echo "\n";\


# push to git with a message
mrgi-git-push:
	echo "Please provide a message for your git push: ";\
	read branch_message || exit 1;\
	git add .;\
	git commit -m "$${branch_message}";\
	git push;\

# checkout a new branch and push it to git
mrgi-git-checkout-build:
	echo "Getting the current branches name... ";\
	branch_original=$$(git rev-parse --abbrev-ref HEAD);\
	echo "Original branch: $${branch_original}";\
	echo "Please provide a branch name to checkout: ";\
	read branch_name || exit 1;\
	git checkout -B $${branch_name};\
	git push --set-upstream origin $${branch_name};\
	git checkout $${branch_original};\
	echo "Branch scaffold operation completed successfully.";\

# delete the current branch and push the deletion to origin and switch to master:
mrgi-git-delete-current-branch:
	echo "Warning: This will delete the current branch and push the deletion to origin. Are you sure? (y/n)";\
	read branch_delete || exit 1;\
	if [ "$${branch_delete}" != "y" ]; then\
		echo "Aborting...";\
		exit 1;\
	fi;\
	echo "Getting the current branches name... ";\
	branch_original=$$(git rev-parse --abbrev-ref HEAD);\
	echo "Original branch: $${branch_original}";\
	echo "Deleting branch: $${branch_original}";\
	git branch -D $${branch_original};\
	git push origin --delete $${branch_original};\
	git checkout master;\

# Fetch all branches from origin:
mrgi-git-fetch-all:
	git branch -r | grep -v '\->' | while read remote; do git branch --track "$${remote#origin/}" "$${remote}"; done;\
	git fetch --all;\
	git pull --all;\
	echo "Fetch all branches operation completed successfully.";\

# Start a simple python server (checking if the user wants to specify a port and if they are using python or python3):
mrgi-http.server:
	if [ -z "$$(which python)" ]; then\
		python=python3;\
	else\
		python=python;\
	fi;\
	echo "What port would you like to use? (default: 8000 if ignored)";\
	read port;\
	if [ -z "$${port}" ]; then\
		port=8000;\
	fi;\
	echo "Starting server on port $${port}";\
	$${python} -m SimpleHTTPServer $${port};\
	echo "Server stopped.";\
	
# Remove OSX mess of hidden files:
mrgi-osx_sanitize_hidden:
	find . -name '._*' -exec rm -rf {} +
	find . -type d -name '._*' -exec rm -rf {} +


# Rsync update new folder:
mrgi-rsync_update_destination:
	echo "Please provide path as source: ";\
	read rsync_source || exit 1;\
	echo "Please provide path as a destination: ";\
	read rsync_destination || exit 1;\
	rsync -av --update --delete --recursive "$${rsync_source}" "$${rsync_destination}"


