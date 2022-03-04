Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF84CD372
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiCDLaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239564AbiCDLao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:30:44 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC181533BD;
        Fri,  4 Mar 2022 03:29:56 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r7so9197114iot.3;
        Fri, 04 Mar 2022 03:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OUTH3v/fnndRoLHLoNDZj54pSJjVQzXZgk9GmAka9/I=;
        b=iQv1Uf9c4iucVEERCHjPd557iNYrzv0n3FzL0h0g0MAAtW1oQD5+SgZqiFK+732iuc
         +1uAzztT0Ipr2CDHkBfFayzO9Jgredxx8ebYfnYml6KjWp+nF73E6yCYnNEgqw06WQ1F
         u8phh2jhq+y1sRzyPBsY1rocEN0kHpy/KDK9EKjPyviVFtf4Za4PEjtVOl02gzLC128/
         1BNxhIQCWB9Zn6HY7AM3tYenysK+0oq7EHXvvwPtDqwA+V4dluzTtFMQ++M+E8mVw+rz
         z8snsXJZAeNgHvXMeEmwgs2dAtFGVuRr2cIhG7NXRFabaCgvE5ihhfC8OF9VDG9xPBff
         gyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=OUTH3v/fnndRoLHLoNDZj54pSJjVQzXZgk9GmAka9/I=;
        b=3CZcysr6Vr5v4zgry/hYSLhrKdHSHWJA/Ud7lvbhc6Jqqo+2i1iQq7r421LLE28LFR
         WVR0OeDY3aUDdkOTOh9N4HEWZ56vTtCwsH/DyK5I2XXoMgmxtkBz4KjBXofVhAtrvYpK
         ANqbJpwzl82gTvGHZUtz5p8PftEaJPntGXtSeq7zyYJoonvj3NFPs4IV5WkjZhI6Kcjh
         RhVwA10igRXu6XLyTwyJ7UiNdMWIm0h1W32LNreni1IRbcAJy2KXjWwEFZSZaZlRIuP8
         xR37+O8C34uhDAiMcSBICDjRjGn3lUCGvxEc4yTUFWGts7xlztu5uMaaP37/YqH5d8jc
         D3Fw==
X-Gm-Message-State: AOAM533sJJcfJ3bMAdlOsrJ054Nm9/DtoNoz10Wr70eCojhfX6C6X/E2
        i8C8nS/dyxSBXsDx/o3PSXZOuDogN2K7uLJmwCMfwtVxqBCXBw==
X-Google-Smtp-Source: ABdhPJwMXFY/sXuhKdZ/ZRirvYto0fbQ19f1N67WRZCDleFGgpKVpISq2X3n/YX8VOq1b4I0rA8l+T/v/368CzTYg8U=
X-Received: by 2002:a05:6602:3ca:b0:63d:dfc8:fa66 with SMTP id
 g10-20020a05660203ca00b0063ddfc8fa66mr30775474iov.128.1646393396181; Fri, 04
 Mar 2022 03:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-2-arnd@kernel.org>
In-Reply-To: <20220301145233.3689119-2-arnd@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 4 Mar 2022 12:29:20 +0100
Message-ID: <CA+icZUVcNppitX53A-f9EAh-Lp6aQq1Qn7Ns1J=tDfQAf_K9vQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] treewide: use -Wdeclaration-after-statement
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

On Tue, Mar 1, 2022 at 4:59 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Mark Rutland <mark.rutland@arm.com>
>
> In a subsequent patch we'll move the kernel from using `-std=3Dgnu89` to
> `-std=3Dgnu11`, permitting the use of additional C11 features such as
> for-loop initial declarations.
>
> One contentious aspect of C99 is that it permits mixed declarations and
> code, and for now at least, it seems preferable to enforce that
> declarations must come first.
>
> These warnings were already disabled in the kernel itself, but not
> for KBUILD_USERCFLAGS or the compat VDSO on arch/arm64, which uses
> a separate set of CFLAGS.
>
> This patch fixes an existing violation in modpost.c, which is not
> reported because of the missing flag in KBUILD_USERCFLAGS:
>
> | scripts/mod/modpost.c: In function =E2=80=98match=E2=80=99:
> | scripts/mod/modpost.c:837:3: warning: ISO C90 forbids mixed declaration=
s and code [-Wdeclaration-after-statement]
> |   837 |   const char *endp =3D p + strlen(p) - 1;
> |       |   ^~~~~
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [arnd: don't add a duplicate flag to the default set, update changelog]
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I was able to build and boot on bare metal.

No new warnings in my build-log here after switching to -std=3Dgnu11.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13.0.0 x86-64

- sed@ -

> ---
>  Makefile                          | 3 ++-
>  arch/arm64/kernel/vdso32/Makefile | 1 +
>  scripts/mod/modpost.c             | 4 +++-
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 94fa9a849a7a..37ef6a555dcd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -432,7 +432,8 @@ HOSTCXX     =3D g++
>  endif
>
>  export KBUILD_USERCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-protot=
ypes \
> -                             -O2 -fomit-frame-pointer -std=3Dgnu89
> +                           -O2 -fomit-frame-pointer -std=3Dgnu89 \
> +                           -Wdeclaration-after-statement
>  export KBUILD_USERLDFLAGS :=3D
>
>  KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTC=
FLAGS)
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32=
/Makefile
> index 9378ea055bf2..ed181bedbffc 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -68,6 +68,7 @@ VDSO_CFLAGS +=3D -Wall -Wundef -Wstrict-prototypes -Wno=
-trigraphs \
>                 -fno-strict-aliasing -fno-common \
>                 -Werror-implicit-function-declaration \
>                 -Wno-format-security \
> +               -Wdeclaration-after-statement \
>                 -std=3Dgnu11
>  VDSO_CFLAGS  +=3D -O2
>  # Some useful compiler-dependent flags from top-level Makefile
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 6bfa33217914..fe693304b120 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -833,8 +833,10 @@ static int match(const char *sym, const char * const=
 pat[])
>  {
>         const char *p;
>         while (*pat) {
> +               const char *endp;
> +
>                 p =3D *pat++;
> -               const char *endp =3D p + strlen(p) - 1;
> +               endp =3D p + strlen(p) - 1;
>
>                 /* "*foo*" */
>                 if (*p =3D=3D '*' && *endp =3D=3D '*') {
> --
> 2.29.2
>
