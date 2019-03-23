---
description: an example of self built registry, with pull-cache and push local images
keywords: registry, pull-cache, push, images, repository, distribution, recipes
title: One example
---

After all the recipes read, an example may need be refered, which contains:
1. authenticate proxy with nginx  
2. pull-cache  
3. push local images at the same time  

# Mechanism

Once a self registry is built as a pull-cache, it can not be used as a local station to push images. The solution is compose another registry on port 442, with the same data volum as the pull-cache.

# Setup


