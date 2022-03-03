Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE64CB404
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiCCAp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCCApz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:45:55 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75B11AA3F;
        Wed,  2 Mar 2022 16:45:10 -0800 (PST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2230ipOW000573;
        Thu, 3 Mar 2022 09:44:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2230ipOW000573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646268291;
        bh=qFJlBbOGHIjmGqrsHLgsSVnCFKYD56zFTMBoZ4bzgoI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d+QqzInMPNKAtFKqHwSKLeqtPTZMXtp4QljZokz0tRh+GlX8mJPKdroYJxp+/+qXQ
         Iaqv/Yu6Tg6A0Dkt2XTm7Bh0H9n92eKjSuW7Qx6lhHkxguuCqBRBW7APC2GxA4BSyZ
         ZENOD4LuUhXWd+jLgGDEY/StHwUeGdJAvx4dgTV5JynbQ5fx14N9o9zJCEtpjrLTKo
         KF2Ul3a6+iisSvW9VA/umjTlM9b9jmZbDrI9DEiqNKRi7Hfhrj67HKJz1MXrGvabP6
         LIS7HU6TQC0/5uiwPf+m4vm8iGHn0GDaCC9KAv5ja41rneuHjcfpreWnfrJl+vKccs
         /l7vqgtT9K2nQ==
X-Nifty-SrcIP: [209.85.210.171]
Received: by mail-pf1-f171.google.com with SMTP id u16so3373750pfg.12;
        Wed, 02 Mar 2022 16:44:51 -0800 (PST)
X-Gm-Message-State: AOAM532lTzm+eNbFdsKlOuuJQALlY7pjhXZEwy5b6iRs5hhqD6VM6Swe
        1bGxqxr5F2QrOn6m+sJzzy1wpkc7kfvalbalN9w=
X-Google-Smtp-Source: ABdhPJxJmpCr7cqZbg0899QCITX2rIIHdJURDFdP7XyJOclpsettcbZAqBuZIHSTaJ8scctyB/vsOG2d8BxfkFG7zqE=
X-Received: by 2002:a05:6a00:24c7:b0:4e1:cb76:32d1 with SMTP id
 d7-20020a056a0024c700b004e1cb7632d1mr35565422pfv.36.1646268290741; Wed, 02
 Mar 2022 16:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-2-arnd@kernel.org>
In-Reply-To: <20220301145233.3689119-2-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Mar 2022 09:44:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpmqncnnaO+NKEuDajx4G0=7eQ1s5e+o+fPyuxrkwncg@mail.gmail.com>
Message-ID: <CAK7LNAQpmqncnnaO+NKEuDajx4G0=7eQ1s5e+o+fPyuxrkwncg@mail.gmail.com>
Subject: Re: [PATCH 2/3] treewide: use -Wdeclaration-after-statement
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 11:52 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Mark Rutland <mark.rutland@arm.com>
>
> In a subsequent patch we'll move the kernel from using `-std=3Dgnu89` to


Precisely speaking,
"In a subsequent patch we'll move the userspace tools ..."

The kernel part was done by 1/3.



> `-std=3Dgnu11`, permitting the use of additional C11 features such as
> for-loop initial declarations.
>
> One contentious aspect of C99 is that it permits mixed declarations and
> code, and for now at least, it seems preferable to enforce that
> declarations must come first.
>
> These warnings were already disabled in the kernel itself, but not

Is this the opposite?

"These warnings were already _enabled_ in the kernel itself, ..."




If you have a chance to resend this,
can you please rebase on top of kbuild/for-next?

This is not applicable due to the conflict with:
https://patchwork.kernel.org/project/linux-kbuild/patch/20220201213542.2808=
035-1-quic_eberman@quicinc.com/






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


--=20
Best Regards
Masahiro Yamada
