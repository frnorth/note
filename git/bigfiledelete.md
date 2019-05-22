git verify-pack -v .git/objects/pack/pack-5856510724b1f49018f9253dbac7a903744a1ca3.idx | sort -k 3 -n
git rev-list --objects --all | grep 47235a39b50782937b6ea626fe021fb435cf29ac
git filter-branch --force --index-filter 'git rm -rf --cached --ignore-unmatch 大文件路径名称' --prune-empty --tag-name-filter cat -- --all
git push origin master --force
ls .git/refs/original/
rm .git/refs/original/ -rf ?
git reflog expire --expire=now --all
git gc --prune=now
git verify-pack -v .git/objects/pack/pack-d645d3f1a3cf6c6f6f289932f1b710140d9a497b.idx | sort -k 3 -n


https://www.hollischuang.com/archives/1708 写的不错
