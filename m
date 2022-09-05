Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF23A5ACD14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiIEHuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiIEHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:50:05 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000EDFB3;
        Mon,  5 Sep 2022 00:49:59 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2857nkNj029570;
        Mon, 5 Sep 2022 16:49:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2857nkNj029570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662364187;
        bh=A8H2tIWtmysI6q42/vGdpy/wkxM6S+6qAW0XkzspLV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cgY5u3eTZ88UYDSwr2fLxgjDmMYY6/Srnx7DPWM0pHwo/SpIqLi1lpR3F28bLtfQ6
         nXkBTHcFl6Asuvu98Ij4laU6ipVtPxPmjycUInjJFG+9U/7nNVRsEUNVBZPH6Wkwxb
         6uee0LIknkwdMgujAFnsxmuD6p5EMz4NmK2Hn07f2PCUKAnQfXk7hRHR9PbIqyWwZ5
         l4Da+gt0zwzo72RQLYbRsYabAdoGj38TIRftCpKNpHr7pZTU6QboWOrC8DIA2OoFSL
         sTW5RdvolAgklHeRW02nsq0VqckJHDTUHw7i6R/4zHKtXMZaFiZJTZ1knXnDZHBtqa
         fZZoUyshCHF4A==
X-Nifty-SrcIP: [209.85.160.46]
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11eab59db71so19626230fac.11;
        Mon, 05 Sep 2022 00:49:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo1ep+SPf+BmDAmlAcbFCvx3LQZ8/gV10ZZYoiEXZnI5ycCLMpZE
        WtNWpp623JLi5qKQbix7pnrRKIJChYUx1jKGj9k=
X-Google-Smtp-Source: AA6agR5j+W5p32b183YlmWIQL5NJzotW59WLEVaC5pMJZpzjNhHnJEyt2/Q6mCFyT3bydKKIN2nplHczDAE3ppMEGDA=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr8041384oab.287.1662364185752; Mon, 05
 Sep 2022 00:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220831184408.2778264-1-ndesaulniers@google.com> <20220831184408.2778264-5-ndesaulniers@google.com>
In-Reply-To: <20220831184408.2778264-5-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 5 Sep 2022 16:49:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWDH01=ZKLnsxc0vcib1zGDbEq8jLQwhWP7HkkmSb_Mw@mail.gmail.com>
Message-ID: <CAK7LNATWDH01=ZKLnsxc0vcib1zGDbEq8jLQwhWP7HkkmSb_Mw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile.debug: re-enable debug info for .S files
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        X86 ML <x86@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: multipart/mixed; boundary="000000000000c7ca9a05e7e95216"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c7ca9a05e7e95216
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 1, 2022 at 3:44 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Alexey reported that the fraction of unknown filename instances in
> kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
> to assembler defined symbols, which regressed as a result of:
>
> commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
>
> In that commit, I allude to restoring debug info for assembler defined
> symbols in a follow up patch, but it seems I forgot to do so in
>
> commit a66049e2cf0e ("Kbuild: make DWARF version a choice")
>
> This patch does a few things:
> 1. Add -g to KBUILD_AFLAGS. This will instruct the compiler to instruct
>    the assembler to emit debug info. But this can cause an issue for
>    folks using a newer compiler but older assembler, because the
>    implicit default DWARF version changed from v4 to v5 in gcc-11 and
>    clang-14.



What kind of bad things happen for "KBUILD_AFLAGS += -g"?


I think 'gcc -g -c -o foo.o foo.S' will invoke 'as --gdwarf-2' as the backend
if gcc is configured to work with old binutils.




> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 9f39b0130551..46e88f0ca998 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -4,18 +4,32 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   += -gsplit-dwarf
>  else
>  DEBUG_CFLAGS   += -g
> +KBUILD_AFLAGS  += -g
>  endif
>
> -ifndef CONFIG_AS_IS_LLVM
> -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> +ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> +# gcc-11+, clang-14+
> +ifeq ($(call cc-min-version, 110000, 140000),y)
> +dwarf-version-y := 5
> +else
> +dwarf-version-y := 4



If you explicitly specify the DWARF version
for CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT,
what is the point of CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT?


When CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y,
I believe the right thing to do is to pass only -g,
and let the tool do whatever it thinks is appropriate.






>  endif
> -
> -ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> +else # !CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
>  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
>  endif
>
> +# Binutils 2.35+ (or clang) required for -gdwarf-{4|5}.
> +# https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> +ifneq ($(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y)),)



When is this as-option supposed to fail?


Binutils <= 2.34 always accepts whatever -gdwarf-* option.
Surprisingly or not, it accepts -gdwarf-6, -gdwarf-7, ...

No matter what DWARF version you specify, GAS silently downgrades
it to DWARF-2.


masahiro@zoe:~/tools/binutils-2.34/bin$ ./as --version | head -n 1
GNU assembler (GNU Binutils) 2.34
masahiro@zoe:~/tools/binutils-2.34/bin$ cat /dev/null | ./as -gdwarf-5
-o /dev/null -
masahiro@zoe:~/tools/binutils-2.34/bin$ echo $?
0
masahiro@zoe:~/tools/binutils-2.34/bin$ cat /dev/null | ./as
-gdwarf-100 -o /dev/null -
masahiro@zoe:~/tools/binutils-2.34/bin$ echo $?
0




Overall, I am not convinced with this patch.



Please see the attached patch.
Is there any problem with writing this more simply?





> +KBUILD_AFLAGS  += -Wa,-gdwarf-$(dwarf-version-y)
> +else
> +ifndef CONFIG_AS_IS_LLVM
> +KBUILD_AFLAGS  += -Wa,-gdwarf-2
> +endif
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS   += -fno-var-tracking
>  ifdef CONFIG_CC_IS_GCC
> --
> 2.37.2.672.g94769d06f0-goog
>


--
Best Regards
Masahiro Yamada

--000000000000c7ca9a05e7e95216
Content-Type: text/x-patch; charset="US-ASCII"; name="dwarf.diff"
Content-Disposition: attachment; filename="dwarf.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l7ogoa5i0>
X-Attachment-Id: f_l7ogoa5i0

ZGlmZiAtLWdpdCBhL2xpYi9LY29uZmlnLmRlYnVnIGIvbGliL0tjb25maWcuZGVidWcKaW5kZXgg
YmNiZTYwZDZjODBjLi4zN2FhMTlmMGY3YjAgMTAwNjQ0Ci0tLSBhL2xpYi9LY29uZmlnLmRlYnVn
CisrKyBiL2xpYi9LY29uZmlnLmRlYnVnCkBAIC0yNjQsNiArMjY0LDcgQEAgY29uZmlnIERFQlVH
X0lORk9fRFdBUkZfVE9PTENIQUlOX0RFRkFVTFQKIGNvbmZpZyBERUJVR19JTkZPX0RXQVJGNAog
CWJvb2wgIkdlbmVyYXRlIERXQVJGIFZlcnNpb24gNCBkZWJ1Z2luZm8iCiAJc2VsZWN0IERFQlVH
X0lORk8KKwlkZXBlbmRzIG9uICFDQ19JU19DTEFORyB8fCAoQ0NfSVNfQ0xBTkcgJiYgKEFTX0lT
X0xMVk0gfHwgKEFTX0lTX0dOVSAmJiBBU19WRVJTSU9OID49IDIzNTAwKSkpCiAJaGVscAogCSAg
R2VuZXJhdGUgRFdBUkYgdjQgZGVidWcgaW5mby4gVGhpcyByZXF1aXJlcyBnY2MgNC41KyBhbmQg
Z2RiIDcuMCsuCiAKZGlmZiAtLWdpdCBhL3NjcmlwdHMvTWFrZWZpbGUuZGVidWcgYi9zY3JpcHRz
L01ha2VmaWxlLmRlYnVnCmluZGV4IDlmMzliMDEzMDU1MS4uYzVlY2I4ODJhNjM4IDEwMDY0NAot
LS0gYS9zY3JpcHRzL01ha2VmaWxlLmRlYnVnCisrKyBiL3NjcmlwdHMvTWFrZWZpbGUuZGVidWcK
QEAgLTMsMTcgKzMsMjAgQEAgREVCVUdfQ0ZMQUdTCTo9CiBpZmRlZiBDT05GSUdfREVCVUdfSU5G
T19TUExJVAogREVCVUdfQ0ZMQUdTCSs9IC1nc3BsaXQtZHdhcmYKIGVsc2UKLURFQlVHX0NGTEFH
UwkrPSAtZworZGVidWctZmxhZ3MteQkrPSAtZwogZW5kaWYKIAotaWZuZGVmIENPTkZJR19BU19J
U19MTFZNCi1LQlVJTERfQUZMQUdTCSs9IC1XYSwtZ2R3YXJmLTIKLWVuZGlmCitkZWJ1Zy1mbGFn
cy0kKENPTkZJR19ERUJVR19JTkZPX0RXQVJGNCkgKz0gLWdkd2FyZi00CitkZWJ1Zy1mbGFncy0k
KENPTkZJR19ERUJVR19JTkZPX0RXQVJGNSkgKz0gLWdkd2FyZi01CisKK0RFQlVHX0NGTEFHUwkr
PSAkKGRlYnVnLWZsYWdzLXkpCiAKLWlmbmRlZiBDT05GSUdfREVCVUdfSU5GT19EV0FSRl9UT09M
Q0hBSU5fREVGQVVMVAotZHdhcmYtdmVyc2lvbi0kKENPTkZJR19ERUJVR19JTkZPX0RXQVJGNCkg
Oj0gNAotZHdhcmYtdmVyc2lvbi0kKENPTkZJR19ERUJVR19JTkZPX0RXQVJGNSkgOj0gNQotREVC
VUdfQ0ZMQUdTCSs9IC1nZHdhcmYtJChkd2FyZi12ZXJzaW9uLXkpCitpZmVxICgkKENPTkZJR19D
Q19JU19DTEFORykkKENPTkZJR19BU19JU19HTlUpLHl5KQorIyBDbGFuZyBkb2VzIG5vdCBwYXNz
IC1nIG9yIC1nZHdhcmYtKiBvcHRpb24gZG93biB0byBHQVMuCisjIEFkZCAtV2EsIHByZWZpeCB0
byBleHBsaWNpdGx5IHNwZWNpZnkgdGhlIGZsYWdzLgorS0JVSUxEX0FGTEFHUwkrPSAkKGFkZHBy
ZWZpeCAtV2EkKGNvbW1hKSwgJChkZWJ1Zy1mbGFncy15KSkKK2Vsc2UKK0tCVUlMRF9BRkxBR1MJ
Kz0gJChkZWJ1Zy1mbGFncy15KQogZW5kaWYKIAogaWZkZWYgQ09ORklHX0RFQlVHX0lORk9fUkVE
VUNFRAo=
--000000000000c7ca9a05e7e95216--
