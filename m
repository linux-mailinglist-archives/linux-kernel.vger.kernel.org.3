Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29B531C93
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiEWT2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiEWT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:27:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED04A122B42
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653332844;
        bh=xtsxVL89mj/h79GI2jkhv7FMKlLVIQBzi9XvDHxwzDI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=d0DqnmmNrlKQJeA3ulT/OuWcgiiUYPaeKOtTFPXURIrg8a77tRO+lMA4WsrsOLuTv
         d7e+GnWA1UwU1F3QO3HyGJp591HvuN+plavaDKZsgGkvmiZnq2m7zpfTNbmgZTMKa3
         MKhOxOgfaL2UXOumK5E4O8Gs39RgK52fYQQTPqDY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.100.20] ([46.142.33.161]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9nxt-1nyQSv0k1V-005oRH for
 <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:07:24 +0200
Message-ID: <f0864b26-4be0-ee85-48dc-62028a3648c0@gmx.de>
Date:   Mon, 23 May 2022 21:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Content-Language: de-DE
Subject: Re: [PATCH 5.17 000/158] 5.17.10-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O+wGCyvToNnWHUIt6ciTzJLR6EO8GQ1iKqY0CpX0amQEroJsRa7
 V5kY7AYTgr1oP+33SNTzIw53xnj6B+rAfR2fcW6242bxE1tTSzv6uy3GDtL/YvbUoLQj6C9
 Iu5CECf2CbUUoCI3EZ7zBujIUvJs5l8pUe+KUKbyfH+HVddCVTOzfTh8JSQCXLGQvnAAzZD
 ph4PPd2Qav/KbeiQXGAbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6t1M3eczIcE=:DtBNDiPREl/PaecsR94UKY
 s72B1KiGaWC9E1jwTjbECKreJM8b/ixFI4C5dasKR2gZ5D7UdUcs0PXNwgYTY0/CqQi/w/3JI
 bgOvOBLZ1g5NRF3GjSOf59eCWyrBBMtMAIZEGGEN2HSVCb9rU3MNGZPx5rGDRLCRmSdn2smcs
 nK6KnQA2OXknj1Kq2WLzvyp/S+xxwmjGpCIotRqi1guu3dWVDbYxcOG4OouQM14zwcHssD5zU
 zgmOmBSc0xgdzesvzZEB2wfMG+/dkkVLzjsSm9d9hsit5B+0hWlMIvhO/ySx4+6tz45knilBu
 OC2ZynTOfNVFOh406d+zBBGaMhUpDJc2bsn4S6jHqGiLUYkfHZAhoJJgEh5Rxf8c54U+ODCPP
 hrZSpfeyY8o2GFmO6jZssIxxGq5zth8SnRdZkB5tsTDnWISVv4OatdTUyj8QXp4FGfuR6Te9m
 FPEbji7w4i886lc1ariO10ezjM8w22wS/kXXRj0wDVzzPpqQi5Vk/VXbuMTD3goYImBT7nFL9
 qpZY+uPHBkZzruyTx7p41qM+UutBOgBRX8hbc6+LxzbfE9nXJWq2zdGjEOwVLo1ZYuU7h/u63
 zVoKsjfw6fAicfXZIckIjQFherbNCBk18aQc6xeddvZuYh2eblr57I7PYrzV7280un33EuGFv
 EvGWdm+jBxpgCypm0nMOBmDfLUUbangNc33pWxbAC3MIs3qiBg0QeiJawRRT8Hi27BK/rocP2
 /rxGACVWE9c62qopXdfbCHJc13f/J37H7OSFtd2a7SzPc8hNU5QaygznL9zUHX0pzbMXcRfO6
 OfUD462MrngGlpLvh4qElQlwotRE4LfcifWAAt8fSIZHBZ8D30ePaLCcfJy8Bs5RmXN0m6aru
 e8XRAzdJsRwl1F0k7DG8kVxZGVOn/K84F8kfc6rl1CbINgslrrl2CvvzdJ+eX93cWQsa3zY8d
 HzBy/NmuDk9aPbmIMBdIrxr+Ql/e2ztrlw8zrm03eeb7O8uEeEq49XOfRXrfo/Ai1jqEAjELo
 R0whjFiSL25YfYAVfu3oiW58gyCgv0ETpR+6C7YGQGdkGj/sdQHFS2Sm0VQ/eAPoi9/oab5bP
 UP2bkrYe2K7XaNIj5sVzxWFwT5S+P0mPxoXQOZhb8O+6D1a1Weak+Sgmw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hallo Greg

5.17.10-rc1

compiles [1], boots and runs here on x86_64
(Intel i5-11400, Fedora 36)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de


[1]

I see the following since switching to Fedora 36 Beta (~4 weeks ago) and
over the whole 5.17 series I compiled under it.

I thought it was Fedora *Beta* and the state of gcc
currently: gcc version 12.1.1 20220507 (Red Hat 12.1.1-1)


My assumption was wrong.

sorry !

=3D=3D=3D

   CC      /home/DATA/devel/linux-5.17.9/tools/objtool/elf.o
scripts/sign-file.c: In function =E2=80=98display_openssl_errors=E2=80=99:
   CC      /home/DATA/devel/linux-5.17.9/tools/objtool/objtool.o
scripts/sign-file.c:89:9: warning: =E2=80=98ERR_get_error_line=E2=80=99 is=
 deprecated:
Since OpenSSL 3.0 [-Wdeprecated-declarations]
    89 |         while ((e =3D ERR_get_error_line(&file, &line))) {
       |         ^~~~~
In file included from scripts/sign-file.c:29:
/usr/include/openssl/err.h:411:15: note: declared here
   411 | unsigned long ERR_get_error_line(const char **file, int *line);
       |               ^~~~~~~~~~~~~~~~~~
scripts/sign-file.c: In function =E2=80=98drain_openssl_errors=E2=80=99:
scripts/sign-file.c:102:9: warning: =E2=80=98ERR_get_error_line=E2=80=99 i=
s deprecated:
Since OpenSSL 3.0 [-Wdeprecated-declarations]
   102 |         while (ERR_get_error_line(&file, &line)) {}
       |         ^~~~~
/usr/include/openssl/err.h:411:15: note: declared here
   411 | unsigned long ERR_get_error_line(const char **file, int *line);
       |               ^~~~~~~~~~~~~~~~~~
scripts/sign-file.c: In function =E2=80=98read_private_key=E2=80=99:
scripts/sign-file.c:142:17: warning: =E2=80=98ENGINE_load_builtin_engines=
=E2=80=99 is
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
   142 |                 ENGINE_load_builtin_engines();
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from scripts/sign-file.c:30:
/usr/include/openssl/engine.h:358:28: note: declared here
   358 | OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sign-file.c:144:17: warning: =E2=80=98ENGINE_by_id=E2=80=99 is dep=
recated: Since
OpenSSL 3.0 [-Wdeprecated-declarations]
   144 |                 e =3D ENGINE_by_id("pkcs11");
       |                 ^
/usr/include/openssl/engine.h:336:31: note: declared here
   336 | OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
       |                               ^~~~~~~~~~~~
scripts/sign-file.c:146:17: warning: =E2=80=98ENGINE_init=E2=80=99 is depr=
ecated: Since
OpenSSL 3.0 [-Wdeprecated-declarations]
   146 |                 if (ENGINE_init(e))
       |                 ^~
/usr/include/openssl/engine.h:620:27: note: declared here
   620 | OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
       |                           ^~~~~~~~~~~
scripts/sign-file.c:151:25: warning: =E2=80=98ENGINE_ctrl_cmd_string=E2=80=
=99 is
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
   151 |                         ERR(!ENGINE_ctrl_cmd_string(e, "PIN",
key_pass, 0),
       |                         ^~~
/usr/include/openssl/engine.h:479:5: note: declared here
   479 | int ENGINE_ctrl_cmd_string(ENGINE *e, const char *cmd_name,
const char *arg,
       |     ^~~~~~~~~~~~~~~~~~~~~~
scripts/sign-file.c:153:17: warning: =E2=80=98ENGINE_load_private_key=E2=
=80=99 is
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
   153 |                 private_key =3D ENGINE_load_private_key(e,
private_key_name,
       |                 ^~~~~~~~~~~
/usr/include/openssl/engine.h:638:11: note: declared here
   638 | EVP_PKEY *ENGINE_load_private_key(ENGINE *e, const char *key_id,
       |           ^~~~~~~~~~~~~~~~~~~~~~~
   CC      /home/DATA/devel/linux-5.17.9/tools/objtool/libstring.o

...


+.In file included from arch/x86/realmode/rm/../../boot/video-mode.c:16,
                  from arch/x86/realmode/rm/video-mode.c:1:
In function =E2=80=98rdfs8=E2=80=99,
     inlined from =E2=80=98vga_recalc_vertical=E2=80=99 at
arch/x86/realmode/rm/../../boot/video-mode.c:123:14,
     inlined from =E2=80=98set_mode=E2=80=99 at
arch/x86/realmode/rm/../../boot/video-mode.c:163:3:
arch/x86/realmode/rm/../../boot/boot.h:114:9: warning: array subscript 0
is outside array bounds of =E2=80=98u8[0]=E2=80=99 {aka =E2=80=98unsigned =
char[]=E2=80=99} [-Warray-bounds]
   114 |         asm volatile("movb %%fs:%1,%0" : "=3Dq" (v) : "m" (*(u8
*)addr));
       |         ^~~
In function =E2=80=98rdfs8=E2=80=99,
     inlined from =E2=80=98vga_recalc_vertical=E2=80=99 at
arch/x86/realmode/rm/../../boot/video-mode.c:124:29,
     inlined from =E2=80=98set_mode=E2=80=99 at
arch/x86/realmode/rm/../../boot/video-mode.c:163:3:
arch/x86/realmode/rm/../../boot/boot.h:114:9: warning: array subscript 0
is outside array bounds of =E2=80=98u8[0]=E2=80=99 {aka =E2=80=98unsigned =
char[]=E2=80=99} [-Warray-bounds]
   114 |         asm volatile("movb %%fs:%1,%0" : "=3Dq" (v) : "m" (*(u8
*)addr));
       |         ^~~
...........  CC      fs/quota/quota_tree.o

....

In function =E2=80=98rdfs16=E2=80=99,
     inlined from =E2=80=98bios_probe=E2=80=99 at
arch/x86/realmode/rm/../../boot/video-bios.c:108:11,
     inlined from =E2=80=98bios_probe=E2=80=99 at
arch/x86/realmode/rm/../../boot/video-bios.c:61:12:
arch/x86/realmode/rm/../../boot/boot.h:120:9: warning: array subscript 0
is outside array bounds of =E2=80=98u16[0]=E2=80=99 {aka =E2=80=98short un=
signed int[]=E2=80=99}
[-Warray-bounds]
   120 |         asm volatile("movw %%fs:%1,%0" : "=3Dr" (v) : "m" (*(u16
*)addr));
       |         ^~~
In function =E2=80=98rdfs8=E2=80=99,
     inlined from =E2=80=98bios_probe=E2=80=99 at
arch/x86/realmode/rm/../../boot/video-bios.c:109:11,
     inlined from =E2=80=98bios_probe=E2=80=99 at
arch/x86/realmode/rm/../../boot/video-bios.c:61:12:
arch/x86/realmode/rm/../../boot/boot.h:114:9: warning: array subscript 0
is outside array bounds of =E2=80=98u8[0]=E2=80=99 {aka =E2=80=98unsigned =
char[]=E2=80=99} [-Warray-bounds]
   114 |         asm volatile("movb %%fs:%1,%0" : "=3Dq" (v) : "m" (*(u8
*)addr));
       |         ^~~
.+  CC      fs/quota/netlink.o

....


certs/extract-cert.c: In function =E2=80=98display_openssl_errors=E2=80=99=
:
certs/extract-cert.c:46:9: warning: =E2=80=98ERR_get_error_line=E2=80=99 i=
s deprecated:
Since OpenSSL 3.0 [-Wdeprecated-declarations]
    46 |         while ((e =3D ERR_get_error_line(&file, &line))) {
       |         ^~~~~
In file included from certs/extract-cert.c:23:
/usr/include/openssl/err.h:411:15: note: declared here
   411 | unsigned long ERR_get_error_line(const char **file, int *line);
       |               ^~~~~~~~~~~~~~~~~~
certs/extract-cert.c: In function =E2=80=98drain_openssl_errors=E2=80=99:
certs/extract-cert.c:59:9: warning: =E2=80=98ERR_get_error_line=E2=80=99 i=
s deprecated:
Since OpenSSL 3.0 [-Wdeprecated-declarations]
    59 |         while (ERR_get_error_line(&file, &line)) {}
       |         ^~~~~
/usr/include/openssl/err.h:411:15: note: declared here
   411 | unsigned long ERR_get_error_line(const char **file, int *line);
       |               ^~~~~~~~~~~~~~~~~~
certs/extract-cert.c: In function =E2=80=98main=E2=80=99:
certs/extract-cert.c:124:17: warning: =E2=80=98ENGINE_load_builtin_engines=
=E2=80=99 is
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
   124 |                 ENGINE_load_builtin_engines();
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from certs/extract-cert.c:24:
/usr/include/openssl/engine.h:358:28: note: declared here
   358 | OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
certs/extract-cert.c:126:17: warning: =E2=80=98ENGINE_by_id=E2=80=99 is de=
precated:
Since OpenSSL 3.0 [-Wdeprecated-declarations]
   126 |                 e =3D ENGINE_by_id("pkcs11");
       |                 ^
/usr/include/openssl/engine.h:336:31: note: declared here
   336 | OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
       |                               ^~~~~~~~~~~~
certs/extract-cert.c:128:17: warning: =E2=80=98ENGINE_init=E2=80=99 is dep=
recated: Since
OpenSSL 3.0 [-Wdeprecated-declarations]
   128 |                 if (ENGINE_init(e))
       |                 ^~
/usr/include/openssl/engine.h:620:27: note: declared here
   620 | OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
       |                           ^~~~~~~~~~~
certs/extract-cert.c:133:25: warning: =E2=80=98ENGINE_ctrl_cmd_string=E2=
=80=99 is
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
   133 |                         ERR(!ENGINE_ctrl_cmd_string(e, "PIN",
key_pass, 0), "Set PKCS#11 PIN");
       |                         ^~~
/usr/include/openssl/engine.h:479:5: note: declared here
   479 | int ENGINE_ctrl_cmd_string(ENGINE *e, const char *cmd_name,
const char *arg,
       |     ^~~~~~~~~~~~~~~~~~~~~~
certs/extract-cert.c:134:17: warning: =E2=80=98ENGINE_ctrl_cmd=E2=80=99 is=
 deprecated:
Since OpenSSL 3.0 [-Wdeprecated-declarations]
   134 |                 ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms,
NULL, 1);
       |                 ^~~~~~~~~~~~~~~
/usr/include/openssl/engine.h:450:27: note: declared here
   450 | OSSL_DEPRECATEDIN_3_0 int ENGINE_ctrl_cmd(ENGINE *e, const char
*cmd_name,
       |                           ^~~~~~~~~~~~~~~
   CC      arch/x86/kernel/cpu/proc.o

...


In file included from arch/x86/boot/a20.c:14:
In function =E2=80=98rdfs32=E2=80=99,
     inlined from =E2=80=98a20_test=E2=80=99 at arch/x86/boot/a20.c:62:16:
arch/x86/boot/boot.h:126:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u32[0]=E2=80=99 {aka =E2=80=98unsigned int[]=E2=80=99} =
[-Warray-bounds]
   126 |         asm volatile("movl %%fs:%1,%0" : "=3Dr" (v) : "m" (*(u32
*)addr));
       |         ^~~
In function =E2=80=98wrfs32=E2=80=99,
     inlined from =E2=80=98a20_test=E2=80=99 at arch/x86/boot/a20.c:65:3:
arch/x86/boot/boot.h:140:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u32[0]=E2=80=99 {aka =E2=80=98unsigned int[]=E2=80=99} =
[-Warray-bounds]
   140 |         asm volatile("movl %1,%%fs:%0" : "+m" (*(u32 *)addr) :
"ri" (v));
       |         ^~~
arch/x86/boot/boot.h:140:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u32[0]=E2=80=99 {aka =E2=80=98unsigned int[]=E2=80=99} =
[-Warray-bounds]
In function =E2=80=98rdgs32=E2=80=99,
     inlined from =E2=80=98a20_test=E2=80=99 at arch/x86/boot/a20.c:67:8:
arch/x86/boot/boot.h:158:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u32[0]=E2=80=99 {aka =E2=80=98unsigned int[]=E2=80=99} =
[-Warray-bounds]
   158 |         asm volatile("movl %%gs:%1,%0" : "=3Dr" (v) : "m" (*(u32
*)addr));
       |         ^~~
In function =E2=80=98wrfs32=E2=80=99,
     inlined from =E2=80=98a20_test=E2=80=99 at arch/x86/boot/a20.c:72:2:
arch/x86/boot/boot.h:140:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u32[0]=E2=80=99 {aka =E2=80=98unsigned int[]=E2=80=99} =
[-Warray-bounds]
   140 |         asm volatile("movl %1,%%fs:%0" : "+m" (*(u32 *)addr) :
"ri" (v));
       |         ^~~
arch/x86/boot/boot.h:140:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u32[0]=E2=80=99 {aka =E2=80=98unsigned int[]=E2=80=99} =
[-Warray-bounds]
   CC      arch/x86/boot/main.o
   CC      arch/x86/boot/memory.o
   CC      arch/x86/boot/pm.o
   AS      arch/x86/boot/pmjump.o
   CC      arch/x86/boot/printf.o
In function =E2=80=98copy_boot_params=E2=80=99,
     inlined from =E2=80=98main=E2=80=99 at arch/x86/boot/main.c:137:2:
arch/x86/boot/main.c:42:19: warning: array subscript 0 is outside array
bounds of =E2=80=98const struct old_cmdline[0]=E2=80=99 [-Warray-bounds]
    42 |             oldcmd->cl_magic =3D=3D OLD_CL_MAGIC) {
       |             ~~~~~~^~~~~~~~~~
arch/x86/boot/main.c:49:27: warning: array subscript 0 is outside array
bounds of =E2=80=98const struct old_cmdline[0]=E2=80=99 [-Warray-bounds]
    49 |                 if (oldcmd->cl_offset <
boot_params.hdr.setup_move_size)
       |                     ~~~~~~^~~~~~~~~~~
   CC      arch/x86/boot/regs.o
   CC      arch/x86/boot/string.o
   CC      arch/x86/boot/tty.o
   CC      arch/x86/boot/video.o
   CC      arch/x86/boot/video-mode.o
   CC      arch/x86/boot/version.o
   CC      arch/x86/boot/video-vga.o
In file included from arch/x86/boot/video.c:16:
In function =E2=80=98rdfs16=E2=80=99,
     inlined from =E2=80=98store_mode_params.part.0=E2=80=99 at arch/x86/b=
oot/video.c:83:14:
arch/x86/boot/boot.h:120:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u16[0]=E2=80=99 {aka =E2=80=98short unsigned int[]=E2=
=80=99} [-Warray-bounds]
   120 |         asm volatile("movw %%fs:%1,%0" : "=3Dr" (v) : "m" (*(u16
*)addr));
       |         ^~~
In function =E2=80=98rdfs16=E2=80=99,
     inlined from =E2=80=98store_mode_params.part.0=E2=80=99 at arch/x86/b=
oot/video.c:86:6:
arch/x86/boot/boot.h:120:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u16[0]=E2=80=99 {aka =E2=80=98short unsigned int[]=E2=
=80=99} [-Warray-bounds]
   120 |         asm volatile("movw %%fs:%1,%0" : "=3Dr" (v) : "m" (*(u16
*)addr));
       |         ^~~
In function =E2=80=98rdfs8=E2=80=99,
     inlined from =E2=80=98store_mode_params.part.0=E2=80=99 at arch/x86/b=
oot/video.c:87:38:
arch/x86/boot/boot.h:114:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u8[0]=E2=80=99 {aka =E2=80=98unsigned char[]=E2=80=99} =
[-Warray-bounds]
   114 |         asm volatile("movb %%fs:%1,%0" : "=3Dq" (v) : "m" (*(u8
*)addr));
       |         ^~~
   CC      arch/x86/boot/video-vesa.o
   CC      arch/x86/boot/video-bios.o
   HOSTCC  arch/x86/boot/tools/build
In file included from arch/x86/boot/video-mode.c:16:
In function =E2=80=98rdfs8=E2=80=99,
     inlined from =E2=80=98vga_recalc_vertical=E2=80=99 at
arch/x86/boot/video-mode.c:123:14,
     inlined from =E2=80=98set_mode=E2=80=99 at arch/x86/boot/video-mode.c=
:163:3:
arch/x86/boot/boot.h:114:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u8[0]=E2=80=99 {aka =E2=80=98unsigned char[]=E2=80=99} =
[-Warray-bounds]
   114 |         asm volatile("movb %%fs:%1,%0" : "=3Dq" (v) : "m" (*(u8
*)addr));
       |         ^~~
In function =E2=80=98rdfs8=E2=80=99,
     inlined from =E2=80=98vga_recalc_vertical=E2=80=99 at
arch/x86/boot/video-mode.c:124:29,
     inlined from =E2=80=98set_mode=E2=80=99 at arch/x86/boot/video-mode.c=
:163:3:
arch/x86/boot/boot.h:114:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u8[0]=E2=80=99 {aka =E2=80=98unsigned char[]=E2=80=99} =
[-Warray-bounds]
   114 |         asm volatile("movb %%fs:%1,%0" : "=3Dq" (v) : "m" (*(u8
*)addr));
       |         ^~~
In file included from arch/x86/boot/video-bios.c:16:
In function =E2=80=98rdfs16=E2=80=99,
     inlined from =E2=80=98bios_probe=E2=80=99 at arch/x86/boot/video-bios=
.c:108:11:
arch/x86/boot/boot.h:120:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u16[0]=E2=80=99 {aka =E2=80=98short unsigned int[]=E2=
=80=99} [-Warray-bounds]
   120 |         asm volatile("movw %%fs:%1,%0" : "=3Dr" (v) : "m" (*(u16
*)addr));
       |         ^~~
In function =E2=80=98rdfs8=E2=80=99,
     inlined from =E2=80=98bios_probe=E2=80=99 at arch/x86/boot/video-bios=
.c:109:11:
arch/x86/boot/boot.h:114:9: warning: array subscript 0 is outside array
bounds of =E2=80=98u8[0]=E2=80=99 {aka =E2=80=98unsigned char[]=E2=80=99} =
[-Warray-bounds]
   114 |         asm volatile("movb %%fs:%1,%0" : "=3Dq" (v) : "m" (*(u8
*)addr));
       |         ^~~
   LDS     arch/x86/boot/compressed/vmlinux.lds

=3D=3D=3D=3D


Ronald
