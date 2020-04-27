# 我的 Linux 配置

## 基本软件和功能

### Git/Github

#### 首次使用

```bash
git config --global-user.name "TianyiShi2001"
git config --global-user.email "ShiTianyi2001@outlook.com"
```

```
git config --global color.ui true
git config --global core.editor vim
```

##### SSH generation

检查是否有`~/.ssh/id_rsa and ~/.ssh/id_rsa.pub`。若无：

```
ssh-keygen -t rsa -C "ShiTianyi2001@outlook.com"
```

把`id_rsa.pub`的内容拷贝到[Github SSH 配置](https://github.com/settings/ssh)中

##### SSH

```
git clone git@github.com:username/your-repository.git
```

```
git remote set-url origin git@github.com:username/your-repository.gi
```

#### gitignore

In `~/.gitignore_global`:

```
*~
.*~
**/.DS_Store
.Rhistory
.RData
```

```
git config --global core.excludesfile ~/.gitignore_global
```

to remove .DS_Store

```
git rm --cached .DS_Store # current dir
```

```
find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch --cached
```

### LaTeX

```bash
sudo apt install texlive-full
```
