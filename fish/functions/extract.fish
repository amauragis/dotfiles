# Shameless stolen from https://github.com/oh-my-fish/plugin-extract/blob/master/functions/extract.fish

function extract --description "Expand or extract bundled & compressed files"
  if test -e $argv[1]
    set --local ext (echo $argv[1] | awk -F. '{print $NF}')
    switch $ext
      case tar  # non-compressed, just bundled
        tar -xvf $argv[1]
      case gz
        if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar  # tar bundle compressed with gzip
          tar -zxvf $argv[1]
        else  # single gzip
          gunzip $argv[1]
        end
      case tgz  # same as tar.gz
        tar -zxvf $argv[1]
      case bz2  # tar compressed with bzip2
        tar -jxvf $argv[1]
      case rar
        unrar x $argv[1]
      case zip
        unzip $argv[1]
      case xz
        if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar
          tar -xJf $argv[1]
        else
          unxz $argv[1]
        end
      case 7z
        7z e $argv[1]
      case zst
        if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar
          tar -I zstd -xvf $argv[1]
        else
          unzstd $argv[1]
        end
      case '*'
        echo "unknown/unsupported extension"
    end
  else
    echo "'$argv[1]' is not a valid file"
  end
end
