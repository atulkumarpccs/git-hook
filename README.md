## Pre-commit git hooks

### Installation
Clone the repository
```
cd local/file/path
git@gitlab.squiz.net:dkarunakaran/git-hooks.git
```
### Script Usage
Here I will demonstrate how to use the git-hook on your projects

#### 1)Go to project repo you are working on
```
cd path/to/project/repo/

```

#### 2)Find the location of the cloned git-hook repo and run below bash script will give you possible options
```
 path/to/git-hook/repo/git_hook.sh
```

#### 3)Currently you can add two pre-commit hooks:
a) Checking the syntax error
b) Package the html directory as zip file

For Example,

```
 path/to/git-hook/repo/git_hook.sh add_syntax
```
The above command will create a syntax checking pre-commit hook on your project repo. Then it will allow you to commit only when there is no syntax error.

If you want to use this for another project repo, you may need to run the above command there.

### Project Maintainers
* Dhanoop Karunakaran