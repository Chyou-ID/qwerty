#!/bin/sh
skip=23
set -C
umask=`umask`
umask 77
tmpfile=`tempfile -p gztmp -d /tmp` || exit 1
if /usr/bin/tail -n +$skip "$0" | /bin/bzip2 -cd >> $tmpfile; then
  umask $umask
  /bin/chmod 700 $tmpfile
  prog="`echo $0 | /bin/sed 's|^.*/||'`"
  if /bin/ln -T $tmpfile "/tmp/$prog" 2>/dev/null; then
    trap '/bin/rm -f $tmpfile "/tmp/$prog"; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile "/tmp/$prog") 2>/dev/null &
    /tmp/"$prog" ${1+"$@"}; res=$?
  else
    trap '/bin/rm -f $tmpfile; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile) 2>/dev/null &
    $tmpfile ${1+"$@"}; res=$?
  fi
else
  echo Cannot decompress $0; exit 1
fi; exit $res
BZh91AY&SY�  �_�C}罛~������@��25A��I���`�&��b4�#����&I�=M2 4 A��4P 8i�F#	���12dhh�&�&���)�&&$dz�P��i�3R`@�ݖ��e6]W�W�譓�mL��	�E@�$DO�������2x�O��lCV�]\�6��.RZ�,���,K�>�f�T;~��Ȝ�.��K}��>�F?����Ϋ$�&�baSL0��G�ͫ���s�Q�u��F���2�	������r�-g!bc`�6����˽j�K�T�Xm#��y"҃�t��y��o��a?�Y��uĎ���q�MD�ؙ �N-IF%*���0M�⯲4���0�f�����§�r����E��R:9��y�E'J���]4�C<��#A��&�y��A1�,X��0������!d۷�xZ��L[#u����-3�Mp���WiB��bLJ�mj�!�=��}��3����)��ʱ?9#:��9�X���d��ɀx�"R0 NLؖ����K�#�5�p�5���3c�1����xѯ	[��:
<�(Ad�]A����x; �Ir�K�I�u.H����r��%��+<|�JV�P@���a1Yi4i�ဩq�)ƈ� �d$�R(U���1����
ȅ����r;G����9�1�I������)��80