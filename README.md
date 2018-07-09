# dotfiles
My linux config files and scripts managed with git and [stow][] - inspired by the many users of [stow][] for this task.
Clone it to `~/dotfiles` (default when running from home dir) to put it in the "right" place.

> **Note: may assume specifics of Ryan's systems, e.g. username is ryan, etc. Non-Ryan use is at your own risk!**
>
> i.e., This is primarily for Ryan's own usage, don't have time to help "port" this to other people.
> It is public and permissively licensed so that others may use bits from it as they find useful,
> but the audience is primarily "me", so any use anybody else gets out of this is just a bonus.


Essentially, these top-level directories are "packages" of thematically-related config files.
Running `stow` (or `stow -D`, to unlink) from this directory, along with the name of such a package,
will adjust the symlinks in `/home/ryan` accordingly.

# Interesting Features

## `.bashrc.d/`
The bits I'd like sourced in my shell come from lots of different thematic places.
So, I have hacked together a (not-necessarily-optimal) system where
every `foo.rc` file in `~/.bashrc.d` get sourced from within `.bash_aliases`
(which is being created by the `bashrc` package as a clean place to hook shell starts).
The interesting bits are in the `bashrc` package.

# directory workarounds - `*-dir/`
Stow will try to be "efficient"/minimal and symlink things as far up the directory tree as possible.
Unfortunately, there are some directories where I want to mix versioned and private files.
For instance I'm not going to commit private SSH keys in `.ssh`,
even though I want to keep the config file in git.
My workaround for this is, for each such directory, I create a dummy "package":
handling the `.ssh/` directory means I made a dummy `dotssh-dir` package that just contains the directory and a dummy file,
and install both that package and the non-dummy one.
Then, the directory in question gets files from two packages,
so Stow can't successfully link the whole directory instead of just the files.

# Ignored files
`.gitignore` files and `README.md` files are globally ignored via a `.stowrc` file.

# Machines

There's a file for each machine in this parent directory, for use with commands like:

- Install: `stow $(cat ryzenshine.txt)`
- Uninstall: `stow -D $(cat ryzenshine.txt)`

The list of machines that might be used with this:

- `ryzenshine` - Debian Stretch amd64 on a Collabora-owned Dell Inspiron Gaming 5676 desktop, with RyZen 2700X, Radeon RX580, and ridiculously bright blue LEDs, because gaming?
- `trex` - Debian Stretch on a privately-owned Dell Precision T5500, with an older, but substantial, Xeon and a random video card.

[stow]: http://www.gnu.org/software/stow/
