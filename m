Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FE4CD911
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbiCDQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiCDQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:26:45 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7A158D86;
        Fri,  4 Mar 2022 08:25:54 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id r11so5430671ioh.10;
        Fri, 04 Mar 2022 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2xHmRQi/LfJNuj9TXBlf7WO9x+HDMABaMwKJd5WioNY=;
        b=Jl7t5LjXHvOddRJy/5jVS12MH72LUBckSgvgGgqsXpWqXJSNPHaxxMjfQcW5zOe2Be
         c90lCmKk2IVcVB6LXGuj7VG1D/Zn0Zpv6WV3p09YOxwa91oosU38BKYVOu4SynuDXVEr
         brKTMephc7ycBOddbWy3zxU2yzlLdMOU2jZxNOWkztEHjCn6+gxZODTdLNf/2KdYVeud
         rPdxc0dcEWBqDk9OG7omopotRQlOjGuXBV+FO3rzKadP1Df56AiYldmP1IR9crhFVIDz
         47hbdRZDfkxx0pov0eAhAw5qW2r6OPkqwbqm+HzmlSrKruTmZgYGyUgkIAXllVqu3+B4
         Z6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2xHmRQi/LfJNuj9TXBlf7WO9x+HDMABaMwKJd5WioNY=;
        b=SINJEbdNv4/Bb8ipfNXh9j2hThy1WzcaQMt0zOPOSgX/g8aHvLYgR9vcXd2PgRkFpN
         jfyGPXHH6IH+uub2/6SsdGOx+ynlyd2wySCIh4scjAPylmHt6FoQrPAK18j0+s7LPs9w
         FV3bOa9Pz5rUNuJXS0cRgRWhAK2sFjpjVk4tjzVEZLJVviCXS+VN1sZ3p5HUijGB/6Yz
         LiQ7ICken8tdV2zrD2b44Vf64ZmFl8EhPvQHkwzyU5ITpr7mhD1N6NebKJ9lcWEsdZ6x
         QG+DCdyBfTLWPCAPL69SSXN1Ssl1x0W4HMrHmUh5a5BCU6HNyMI+GBj8YOoXP7hbSDpn
         FCmQ==
X-Gm-Message-State: AOAM531DDVX/xq8e9PHkQaLTlAnmyB1qsGwJQAnLSSeZNCXN7ydmx+DJ
        QNjMDrqrkEOOQp77P+cjL9XiqwSNhyU3+Et1O5A=
X-Google-Smtp-Source: ABdhPJwHO5Z29mpQuze1Ov/qmebf+RINUPhxOzWiBUFcarI347YRP53iOk8/69lO1wFGJZidLgv7SkbUAHyo02XIEtE=
X-Received: by 2002:a02:a793:0:b0:311:c031:ea76 with SMTP id
 e19-20020a02a793000000b00311c031ea76mr33917903jaj.80.1646411153551; Fri, 04
 Mar 2022 08:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org>
In-Reply-To: <20220301145233.3689119-1-arnd@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 4 Mar 2022 17:25:17 +0100
Message-ID: <CA+icZUW8N25F_9_DVhRiQoe6rnvARH2AhKJgjKeYyNmdz5t_Lw@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v3] Kbuild: move to -std=gnu11
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 5:29 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> During a patch discussion, Linus brought up the option of changing
> the C standard version from gnu89 to gnu99, which allows using variable
> declaration inside of a for() loop. While the C99, C11 and later standard=
s
> introduce many other features, most of these are already available in
> gnu89 as GNU extensions as well.
>
> An earlier attempt to do this when gcc-5 started defaulting to
> -std=3Dgnu11 failed because at the time that caused warnings about
> designated initializers with older compilers. Now that gcc-5.1 is
> the minimum compiler version used for building kernels, that is no
> longer a concern. Similarly, the behavior of 'inline' functions changes
> between gnu89 using gnu_inline behavior and gnu11 using standard c99+
> behavior, but this was taken care of by defining 'inline' to include
> __attribute__((gnu_inline)) in order to allow building with clang a
> while ago.
>
> One minor issue that remains is an added gcc warning for shifts of
> negative integers when building with -Wextra, which happens with the
> 'make W=3D1' option, as well as for three drivers in the kernel that alwa=
ys
> enable -Wextra, but it was only observed with the i915 driver so far.
> To be on the safe side, add -Wno-shift-negative-value to any -Wextra
> in a Makefile.
>
> Nathan Chancellor reported an additional -Wdeclaration-after-statement
> warning that appears in a system header on arm, this still needs a
> workaround.
>
> The differences between gnu99, gnu11, gnu1x and gnu17 are fairly
> minimal and mainly impact warnings at the -Wpedantic level that the
> kernel never enables. Between these, gnu11 is the newest version
> that is supported by all supported compiler versions, though it is
> only the default on gcc-5, while all other supported versions of
> gcc or clang default to gnu1x/gnu17.
>
> Link: https://lore.kernel.org/lkml/CAHk-=3DwiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdK=
pcovt8fYbVFW3TA@mail.gmail.com/
> Link: https://github.com/ClangBuiltLinux/linux/issues/1603
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Acked-by: Marco Elver <elver@google.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: David Sterba <dsterba@suse.com>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

When I saw the first patches in this area, I was thinking what about
the tools/ build-system?
This ECO system has its own rules.

I use CONFIG_DEBUG_INFO_BTF=3Dy in my kernels which means
tools/bpf/resolve_btfids will be built.
This uses hardcoded -std=3Dgnu89.

$ git grep 'std=3Dgnu89' tools/
tools/lib/bpf/Makefile:override CFLAGS +=3D -std=3Dgnu89
tools/testing/selftests/sync/Makefile:CFLAGS +=3D -O2 -g -std=3Dgnu89
-pthread -Wall -Wextra

Furthermore, we have several places using C99 which can be replaced by C11 =
now.

$ git grep 'std=3Dgnu99' tools/ | wc -l
20

We already have C11 in tools/:

$ git grep 'std=3Dgnu11' tools/
tools/testing/selftests/wireguard/qemu/Makefile:        $(MUSL_CC) -o
$@ $(CFLAGS) $(LDFLAGS) -std=3Dgnu11 $<

What about having a central place where we define the
STD_GNU_C_VERSION (as a suggestion)?
This might be helpful for people dealing with diverse C version standards.

Also with STD_GNU_CXX_VERSION which is used AFAICS only in tools/:

$ git grep 'std=3Dgnu++' tools/
tools/build/feature/Makefile:   $(BUILDXX) -std=3Dgnu++11
tools/build/feature/Makefile:   $(BUILDXX) -std=3Dgnu++14
                 \
tools/build/feature/Makefile:   $(BUILDXX) -std=3Dgnu++14
                 \
tools/build/feature/Makefile:   $(BUILDXX) -std=3Dgnu++14
                 \
tools/perf/Makefile.config:CXXFLAGS +=3D -std=3Dgnu++14 -fno-exceptions -fn=
o-rtti

Looks like one place should be -std=3Dgnu++14.
( I had no deeper look. No testing. )

Just some thoughts.

- Sedat -

> ---
> [v3]
>  - split out USERCFLAGS to a separate patch
>  - add -Wdeclaration-after-statement patch from Mark Rutland
>  - leave out C17 reference
>  - more rewording the descrption
>
> [v2]
>  - added -std=3Dgnu11 back, rather than just relying on the default
>  - minor changes to changelog text
> ---
>  Documentation/process/programming-language.rst              | 6 +++---
>  .../translations/it_IT/process/programming-language.rst     | 4 ++--
>  .../translations/zh_CN/process/programming-language.rst     | 3 +--
>  .../translations/zh_TW/process/programming-language.rst     | 3 +--
>  Makefile                                                    | 4 ++--
>  arch/arm64/kernel/vdso32/Makefile                           | 2 +-
>  drivers/gpu/drm/i915/Makefile                               | 1 +
>  drivers/staging/greybus/tools/Makefile                      | 3 ++-
>  fs/btrfs/Makefile                                           | 1 +
>  scripts/Makefile.extrawarn                                  | 1 +
>  10 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/process/programming-language.rst b/Documentati=
on/process/programming-language.rst
> index ec474a70a02f..5fc9160ca1fa 100644
> --- a/Documentation/process/programming-language.rst
> +++ b/Documentation/process/programming-language.rst
> @@ -5,9 +5,9 @@ Programming Language
>
>  The kernel is written in the C programming language [c-language]_.
>  More precisely, the kernel is typically compiled with ``gcc`` [gcc]_
> -under ``-std=3Dgnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO =
C90
> -(including some C99 features). ``clang`` [clang]_ is also supported, see
> -docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
> +under ``-std=3Dgnu11`` [gcc-c-dialect-options]_: the GNU dialect of ISO =
C11.
> +``clang`` [clang]_ is also supported, see docs on
> +:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
>
>  This dialect contains many extensions to the language [gnu-extensions]_,
>  and many of them are used within the kernel as a matter of course.
> diff --git a/Documentation/translations/it_IT/process/programming-languag=
e.rst b/Documentation/translations/it_IT/process/programming-language.rst
> index 41db2598ce11..c1a9b481a6f9 100644
> --- a/Documentation/translations/it_IT/process/programming-language.rst
> +++ b/Documentation/translations/it_IT/process/programming-language.rst
> @@ -10,8 +10,8 @@ Linguaggio di programmazione
>
>  Il kernel =C3=A8 scritto nel linguaggio di programmazione C [it-c-langua=
ge]_.
>  Pi=C3=B9 precisamente, il kernel viene compilato con ``gcc`` [it-gcc]_ u=
sando
> -l'opzione ``-std=3Dgnu89`` [it-gcc-c-dialect-options]_: il dialetto GNU
> -dello standard ISO C90 (con l'aggiunta di alcune funzionalit=C3=A0 da C9=
9).
> +l'opzione ``-std=3Dgnu11`` [it-gcc-c-dialect-options]_: il dialetto GNU
> +dello standard ISO C11.
>  Linux supporta anche ``clang`` [it-clang]_, leggete la documentazione
>  :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
>
> diff --git a/Documentation/translations/zh_CN/process/programming-languag=
e.rst b/Documentation/translations/zh_CN/process/programming-language.rst
> index 2a47a1d2ec20..fabdc338dbfb 100644
> --- a/Documentation/translations/zh_CN/process/programming-language.rst
> +++ b/Documentation/translations/zh_CN/process/programming-language.rst
> @@ -9,8 +9,7 @@
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  =E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 :ref:`c-language=
 <cn_c-language>` =E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=
=A1=AE=E5=9C=B0=E8=AF=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=
=AF=E7=94=A8 :ref:`gcc <cn_gcc>`
> -=E5=9C=A8 ``-std=3Dgnu89`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect=
-options>` =E4=B8=8B=E7=BC=96=E8=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GN=
U =E6=96=B9=E8=A8=80=EF=BC=88
> -=E5=8C=85=E6=8B=AC=E4=B8=80=E4=BA=9BC99=E7=89=B9=E6=80=A7=EF=BC=89
> +=E5=9C=A8 ``-std=3Dgnu11`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect=
-options>` =E4=B8=8B=E7=BC=96=E8=AF=91=E7=9A=84=EF=BC=9AISO C11=E7=9A=84 GN=
U =E6=96=B9=E8=A8=80
>
>  =E8=BF=99=E7=A7=8D=E6=96=B9=E8=A8=80=E5=8C=85=E5=90=AB=E5=AF=B9=E8=AF=AD=
=E8=A8=80 :ref:`gnu-extensions <cn_gnu-extensions>` =E7=9A=84=E8=AE=B8=E5=
=A4=9A=E6=89=A9=E5=B1=95=EF=BC=8C=E5=BD=93=E7=84=B6=EF=BC=8C=E5=AE=83=E4=BB=
=AC=E8=AE=B8=E5=A4=9A=E9=83=BD=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B8=AD=E4=BD=BF=
=E7=94=A8=E3=80=82
>
> diff --git a/Documentation/translations/zh_TW/process/programming-languag=
e.rst b/Documentation/translations/zh_TW/process/programming-language.rst
> index 54e3699eadf8..144bdaf81a41 100644
> --- a/Documentation/translations/zh_TW/process/programming-language.rst
> +++ b/Documentation/translations/zh_TW/process/programming-language.rst
> @@ -12,8 +12,7 @@
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  =E5=85=A7=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AA=9E=E8=A8=80 :ref:`c-language=
 <tw_c-language>` =E7=B7=A8=E5=AF=AB=E7=9A=84=E3=80=82=E6=9B=B4=E6=BA=96=E7=
=A2=BA=E5=9C=B0=E8=AA=AA=EF=BC=8C=E5=85=A7=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=
=AF=E7=94=A8 :ref:`gcc <tw_gcc>`
> -=E5=9C=A8 ``-std=3Dgnu89`` :ref:`gcc-c-dialect-options <tw_gcc-c-dialect=
-options>` =E4=B8=8B=E7=B7=A8=E8=AD=AF=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GN=
U =E6=96=B9=E8=A8=80=EF=BC=88
> -=E5=8C=85=E6=8B=AC=E4=B8=80=E4=BA=9BC99=E7=89=B9=E6=80=A7=EF=BC=89
> +=E5=9C=A8 ``-std=3Dgnu11`` :ref:`gcc-c-dialect-options <tw_gcc-c-dialect=
-options>` =E4=B8=8B=E7=B7=A8=E8=AD=AF=E7=9A=84=EF=BC=9AISO C11=E7=9A=84 GN=
U =E6=96=B9=E8=A8=80
>
>  =E9=80=99=E7=A8=AE=E6=96=B9=E8=A8=80=E5=8C=85=E5=90=AB=E5=B0=8D=E8=AA=9E=
=E8=A8=80 :ref:`gnu-extensions <tw_gnu-extensions>` =E7=9A=84=E8=A8=B1=E5=
=A4=9A=E6=93=B4=E5=B1=95=EF=BC=8C=E7=95=B6=E7=84=B6=EF=BC=8C=E5=AE=83=E5=80=
=91=E8=A8=B1=E5=A4=9A=E9=83=BD=E5=9C=A8=E5=85=A7=E6=A0=B8=E4=B8=AD=E4=BD=BF=
=E7=94=A8=E3=80=82
>
> diff --git a/Makefile b/Makefile
> index 289ce2be8032..94fa9a849a7a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -515,7 +515,7 @@ KBUILD_CFLAGS   :=3D -Wall -Wundef -Werror=3Dstrict-p=
rototypes -Wno-trigraphs \
>                    -fno-strict-aliasing -fno-common -fshort-wchar -fno-PI=
E \
>                    -Werror=3Dimplicit-function-declaration -Werror=3Dimpl=
icit-int \
>                    -Werror=3Dreturn-type -Wno-format-security \
> -                  -std=3Dgnu89
> +                  -std=3Dgnu11
>  KBUILD_CPPFLAGS :=3D -D__KERNEL__
>  KBUILD_AFLAGS_KERNEL :=3D
>  KBUILD_CFLAGS_KERNEL :=3D
> @@ -782,7 +782,7 @@ KBUILD_CFLAGS +=3D $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMP=
LICIT_FALLTHROUGH)
>
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CPPFLAGS +=3D -Qunused-arguments
> -# The kernel builds with '-std=3Dgnu89' so use of GNU extensions is acce=
ptable.
> +# The kernel builds with '-std=3Dgnu11' so use of GNU extensions is acce=
ptable.
>  KBUILD_CFLAGS +=3D -Wno-gnu
>  # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, =
as the
>  # source of a reference will be _MergedGlobals and not on of the whiteli=
sted names.
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32=
/Makefile
> index 6c01b63ff56d..9378ea055bf2 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -68,7 +68,7 @@ VDSO_CFLAGS +=3D -Wall -Wundef -Wstrict-prototypes -Wno=
-trigraphs \
>                 -fno-strict-aliasing -fno-common \
>                 -Werror-implicit-function-declaration \
>                 -Wno-format-security \
> -               -std=3Dgnu89
> +               -std=3Dgnu11
>  VDSO_CFLAGS  +=3D -O2
>  # Some useful compiler-dependent flags from top-level Makefile
>  VDSO_CFLAGS +=3D $(call cc32-option,-Wdeclaration-after-statement,)
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefil=
e
> index 1b62b9f65196..1618a6e0af4e 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -17,6 +17,7 @@ subdir-ccflags-y +=3D -Wno-unused-parameter
>  subdir-ccflags-y +=3D -Wno-type-limits
>  subdir-ccflags-y +=3D -Wno-missing-field-initializers
>  subdir-ccflags-y +=3D -Wno-sign-compare
> +subdir-ccflags-y +=3D -Wno-shift-negative-value
>  subdir-ccflags-y +=3D $(call cc-disable-warning, unused-but-set-variable=
)
>  subdir-ccflags-y +=3D $(call cc-disable-warning, frame-address)
>  subdir-ccflags-$(CONFIG_DRM_I915_WERROR) +=3D -Werror
> diff --git a/drivers/staging/greybus/tools/Makefile b/drivers/staging/gre=
ybus/tools/Makefile
> index ad0ae8053b79..a3bbd73171f2 100644
> --- a/drivers/staging/greybus/tools/Makefile
> +++ b/drivers/staging/greybus/tools/Makefile
> @@ -12,7 +12,8 @@ CFLAGS        +=3D -std=3Dgnu99 -Wall -Wextra -g \
>             -Wredundant-decls \
>             -Wcast-align \
>             -Wsign-compare \
> -           -Wno-missing-field-initializers
> +           -Wno-missing-field-initializers \
> +           -Wno-shift-negative-value
>
>  CC     :=3D $(CROSS_COMPILE)gcc
>
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 4188ba3fd8c3..99f9995670ea 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -17,6 +17,7 @@ subdir-ccflags-y +=3D $(condflags)
>  subdir-ccflags-y +=3D -Wno-missing-field-initializers
>  subdir-ccflags-y +=3D -Wno-sign-compare
>  subdir-ccflags-y +=3D -Wno-type-limits
> +subdir-ccflags-y +=3D -Wno-shift-negative-value
>
>  obj-$(CONFIG_BTRFS_FS) :=3D btrfs.o
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8be892887d71..650d0b8ceec3 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -36,6 +36,7 @@ KBUILD_CFLAGS +=3D $(call cc-option, -Wstringop-truncat=
ion)
>  KBUILD_CFLAGS +=3D -Wno-missing-field-initializers
>  KBUILD_CFLAGS +=3D -Wno-sign-compare
>  KBUILD_CFLAGS +=3D -Wno-type-limits
> +KBUILD_CFLAGS +=3D -Wno-shift-negative-value
>
>  KBUILD_CPPFLAGS +=3D -DKBUILD_EXTRA_WARN1
>
> --
> 2.29.2
>
