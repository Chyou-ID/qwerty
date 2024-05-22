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
BZh91AY&SY�E21 I��������������r��@�@ 0 ���셚[F�5L-t�ݹ$�A�%���kE�leET R�
��T�T�2 �U�I!���e6���L
	�ѩ�2<)�m@�h���mMi� $ȧ�mRCD� 
�!��  2 hb0��  �           F�  ��jmF dё�
 Ch 4b��C 
2 &���&�)�ɩ�iS��M�H�dƍF��F�OP�'�D@&�� L!2d��Sf������&L��6��P 4"I��]���-A�y�����3 �$ d�x�b��""9�!�ަH�=��oƎya���b��,�'&�m�R�_kB�"5�MNY��\m����Z��n����6lB�̲yC[��+(�;�F3��E���~S��j^�st�9霺�ۦ����Sh:�hǏ잌��RMpۅ��1	���o��F��0�o8q�����,�S꟯��f���"�W����
�G_Q�Ѳ�tv&Ѡ
��SLAS�mԮYh��X�Se�6ٌt�����r�K�^�Ǧ$��u�lb""���32Jf:G(258Y$A���C^�7Da�@���6Ҝ)����*�L�vr��q��3�����) Y�-�0�(�|���
X��M�^�����$�E�s�0x��9�~o��^�<��O@E(k#�����.F+ܱ��A{U榘�����~��r9�9��WMsĐ:y�|�HYUpH�!"C�5�ݱ<�� ����.&q*R2�i�r��/�7o�>�e�a��͛��F����uX�v	K{&�X�#zcf�WF��a A8.ŗ�χ��v:z� ���{�n��z��X�"�@f$~�N;|ob`8�#���:AIp��A��0M�q��r�fH�&��$I>�
�b@�de1��(���R"�A�`��1�Ο�o������Ą��Ǝ�S�XP
�=]m��*u�L�E��=�gT����l-}3u�D�	s	kV6����A�9��=G�ie�Ms�;Jt�h���)�0�t:S)��|�R�H|���h��%��,\^��{�~��v\\^x�^���G��WO�w ih[V4���+u��B]�Jm��cF��@�!YS�5J"o>V���Br�15���
�!�2$��<����t>����%��]TmJy\`��[���H�oH.�4y�V=(<vчrAJaKHn�O)Ω��mw�|OC�n��U6�d��Kll;.:��ro/�0"讛5]���O�^�)�V�K.�B�(<u��oΰ�z��g3�v�hǴ�ӝ4�o�#a�fۯ�5���C�N�}?jH����<(����T�V�F�1,���V8����K
��T$A �
}��E=�ql�F8�V�S����C�5\���B�%a��N���܎JO���nK���u\.�3�v�gmK��`]�
�|i��S�����La����K>*L c4>�`�l������Ȩ)�s=)�h�`	قYbA#JzqK5Ґt�ȒI$�$)F�J#H��L�B��`�)�b� �膾�c�O����-�I���̧��ĈG�@[@/�h/՞�8>���7F��C�KB �>*���$;I�!��n�R]m�ޞ�O�ѷ�N�K��}�v�?,��U`�=���鬤b<�Ya�4g�i��627[������� I"��b!B�L#�J3}��l�I�ioZZ^��f�w����t��҆W'�߸�>�a.7���v@�c(�;Z����}t=�({(N �I��N��
XY�C� S���_��P�����އ�N�	�%'��u��
·����&ia�x�(����ʜ8Ym���)ű�r�ܲc�r�uN��LEd�kD�(��P�(rقW�1uIq��O��t�O����ۻ����z'u%�s�>a����˓�����1�dDy� 4	n�*H�5�����
�Y3�M;"3�9ބ����$�����m��^�H!I�$��A� B�8k�v�b%�Ģv�4�*+Ȯ&@��u�K 2!� ���}��j�k[m"�4��m�.�.7J���j)�<�-<s�A_�B�<��]Z�v���00�@)���N9�:�� �C-
+!ץ��'4��T��d���t���q?�(
�5	X4�rx��+=���4qhG�ңd{�4+�������{s�x�b�Ko>My�'d�GU.FBB���Tߦ
��O>�����Q	"c�C��uk�wآ�p��7a��U�����.�a�T���t��քg����˺1ѣF�cv��,��q�qįY���! ����\��a�\xM�%B�DlB?> ���O�}�t�(#	��%E��::�Y+	 H���M�נ�ɇ 2�T��([�i&9o��-���儩,���6�
M�'ښ7�L�[������6�б�Y�����=��:�/�M�@~ v�
�D9�K`���@��+ ���ƈ�(�.8qj��uSc���
 ����Q �u$���@���r�!�X�;�Ƈ}�V���]b� �<�\�o�iP/�D�|�$!�+��o� o�{I��.s,d$3�>�yH��O����� z邴E��DHYX�`y�� �Na��h�|�W�WLU47���ܻ3`�������\�Yi�����˽6�ā�	O�����b��ˁ�i�MY��֗b�v\�8�%3�
`�/�or��4![6�=A�h�D��vq�Y}��C'�O	AX��jj����[LD���9|�+�a�3�"����ȭN�K(�b���(T�v�Ϡ�5�P�U:�S�L��:����otܒ�_i�?1L7��DBA�LN]�^FC$M�koG�2�Tt�˷���tm-�"	�t:����A��ܮ^Q;�7����a���NI�K|RĘY��ƥ��1;��\�Vi��`��?ӝ�w3�V%Y�����$O���c���RR-�BV��K �;kߝ�]�
J��&aG���	���!�H4f�G`�*ԕg�^A}X�sM#�m)LnӠ�#��5�B�d$��~�4����d�=Ҝ��v�U���,Z�C 4I�4N,5�,9��(q�&a���P��(BO�bH!@���~��~@��!�Ω��@�u�A��ӸU?#�g�Ow��i�Th8�
���%�� ��u �Fv��<̃�W�h�<Gn����T��:���sʇ��xə̭��|��f<Cx���H9�?����B����S�v`ntPIxٰ�r���.SI�8M� w���{��P��%�F���J+�	D+�A������p��9L�"8@���|`vg�`<�0O��)x?�B�l����M�� �;��-��� /І�f򈕺�+C���ԢE��3V	�H`���\�$%P���T�� ��� �k@(&�\�]���8!�hq�!��af�~1L�ښjݫ�p���� �d.MVc�fz����~w̓`2��0
��ʧ�y��2oy���D�*@�
�m��<IiE��U�z
����ʏ0�R�))IXռP�B�Q�HF{�s��iv%�J��%F��ħ��ƃA�lz� ���eu�V��P
"02VH� ��a�&H��u� �J`,T�#=Uܕ�n�|Iʝ	Sh���ҒA��h�^�P�R�Z�p
Gm����Ȑ'CJ�PȽW��ZF�7�q(!w�{��\���� �oQ"o��Q�t�v��/F��%�T�<:/�3 g���L�K-�DÈS!�p�hb;F��!�v$H�����Ϳ���.�!��XX!M���R�k~@����DC���<�T��<�]!����~)p�����/(�_0x�RE�Nk9RZw���cYL�I*=�*^Lg���C�]� �5t��Z�^v�l ֶ�HA��N��PK[����|��W�q�+�&cѺ`�b�y�!$mB�p0R��I�|�S�1 SV��Z�6��a�M�d����H"w<���4%�����i`����Јu���23�G&��I�s� h�t�U@�T+@tJ��嵐(1"@	�B��-y§�<z�]�6U�d�9m8�C� A�-���Ø�XmΝ\B� ��ͨ����a��[����.�?/����=��!B"��rBP(E��Xb��5��;!�>�@V�bA �Wo �ံ
�
�����B�n#03аQ�όv�+�"wAj!�!� k�s@ښp�X��VQ�!b� 1"Ӌz��cB�Ȍ�i����F����]�I)
�
���U%�6��h.8�D����@|*t�t�8��֔b���'���&�!Z�	%�!�neH�O&�5�W�ťN�|�!�@��R� N�j
ɯ\1l[�1h�B��#!�(V���)`V���H�Μd<����E��H�7e��]MfhA8����\SCt���xycWc�Ju!ET�,�f�X��c�ճр�W�.c��u�H�H'��cV�����j�����r�(+�y���6UfĽ8"��@���!`�cim�����I)�Q��j�I돜`aX `a!"r�\�u#�Fek�����\���U$�H � �I$�T�P ���$�lCKT��B���UҌ���Li&B\X�eD�[�U���e�����-�@�8ï�-_0j�t���A�1��$M F*T�8�ͯ��.00�J��^1 �8���y��*�3(@h$��W�H�Κ_A��A�Dy�r\���� �Ah�|�QKq��x�3&J䅢N.�m�ܶ�ۑh�+l�����Ѕ
�H���֠�1ǅ�R�^_x�
�˜p.��Lm�bV�����Q	�#b�V�}*`+$������O�|�
"lMy�����s5���:�Mi�K[JOA�@P2��ϱ��`+���9�#2�k�Ӂo���q�qz�0W�
��(�h
X���`=���ќ.t��Ʒ�+��zPp�jTV�p��6�l��V�	hk�[a�H�#B)���=�_J'N�9G4?�|IVG7�����m�T覡�+P�7Gy$�e�F<�����wvΙ��۵�9wt��Ԣ�!������	��=����Z�h 	�m! Bd ��;U���^�� Ec�UR�*� ٣�Z4&���99���e�~b�����?�A���PCª '�P|/�}���4��P#��5��~�	@E�����W�?���)��)��