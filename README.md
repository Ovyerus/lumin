# lumin

> A simple and clean fish prompt.

![lumin preview](./preview.png)

## Installing

With [Fisher](https://github.com/jorgebucaran/fisher)

```
fisher add ovyerus/lumin
```

<details>
<summary>Without a package manager</summary>

Copy [`functions/lumin.fish`](functions/lumin.fish) to any directory on your function path.

```fish
curl https://git.io/lumin.fish --create-dirs -sLo ~/.config/fish/functions/lumin.fish
```

</details>

## Options

lumin has a couple options to can set to slightly customise the theme.

#### `set -g __lumin_symb`

The icon the goes before your text input.  
Default: `▲`

#### `set -g __lumin_leading_brace`

Whether or not the prompt starts with with a brace or not.
Default: `0`
