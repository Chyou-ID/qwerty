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
BZh91AY&SYi�n%  ���qp����������@   P��7(+��k�d��?L�4����O)�P�<�ؐ��I��S�4�!51�B0CPe4��H� 4@� jh��&����d1�   4�F�2hѣM��@�M  2@HHe24l���B�Bz4FЏ@����0'�0�,��Yrwͮ˖�ϸn۴�̉Ϧ�i�C&aLA�Dv}�� ��2.e3�ޤ�xJ/�����W��ϭ9q͙�KE�yjF�cDk�Is��6�Y�ɗ������V�5��'��7S�ק���KVX�܇b��őf��֦�/��5*�q�-���A��`�ߟ*���	X�N�|����S>6K�L�5��l��T�Q����}��!�K ]���^b8�W�=-?r�0���H"���p�s|g��n����(�B�3�A�EDEPMu� ����0�B�y&w�����؎��xH��x��nk��E^;����T�=ې'~�wR:��,G͟V?��8 �kV"��D��@/&OG<W�l'�ݨ\[6/��XUu����I�s>a4}yLK��oXwr�v��N{-�;��e�Qź����~!~�B���e�ʔv�,�H�Atl�B��"��&��_4c2t��M�N`���Kx��n�1�^���ć A\DE+5�ǭ���㪞�9&�B`KV����(h�F��ց�Z�*�|~���9çP!)�������1[�)\���
!��X\������Ҟ�B&��z�E8肻*Z���:���)�l+�k�����gd�ڜ�D�@M���p�A�_5�:Ba×f�YHH�A<��LjR�~T���A3��|C"Y7���W���|�h�����0`P��H�u����b-t��TXP0��aH�E�3�@��I�U��D�3[b� �4	Içv]qZ�LV1F{}a���.HH�.��
i�*�ď��f��J��pZ�W@Zs@�^g ��&G
jR��"��s����+r�!�E>P2�h���B́B8���5�iYc^
�!tGy�*����9�̓��N�u��JB�b�9U����̃����o�p×M��9ox� �: 5�.�p� ���J