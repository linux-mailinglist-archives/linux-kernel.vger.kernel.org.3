Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FD94CEA71
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiCFKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 05:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCFKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 05:04:38 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234AB692A2;
        Sun,  6 Mar 2022 02:03:47 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d19so14142013ioc.8;
        Sun, 06 Mar 2022 02:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=niJBbZgiI5OBSLzHg1nrz9EzrLqTnnJRoqrcX06Ph8c=;
        b=gQzYX5+c1SWh3o9SrqV4/mdHeNbYDClO8uqa+fCKWHwOi9jD1u6v7C/w0SY/gAS1Ld
         GzWjY3Hofn31JaEwnViv/IjI+5Q8GdAXDd826iFVu2RTAo+9ZsL2k+l45x4BFSCeFhNh
         JtuVTs2SuH3UD+SRvD7hSt7OVarJaxsgd0o1YP6FZFpqOr6V9XV1M13NJfNZuwHI+ksw
         X63unOD+ogiq2tgFoCSeZuCCBx/uGWT2gEE3OCVB1M3zsW8dHNiviCj00opY+8Jc/amf
         43LJu9g7Ol6LrqpyxqOlwHsrG+mq0ZXJD6OZaIEk6hshiNJqt+CpjqyO6PyHxg59whBp
         TA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=niJBbZgiI5OBSLzHg1nrz9EzrLqTnnJRoqrcX06Ph8c=;
        b=q9Uy639Dmdfb1icD+2WBn/hAEuqfrlNsnER94yHzMq1UeyaXPyOi45pXtCMeqNu8cl
         toCGrv6o2TK0drg7QODTPGbts1/l0KRl86YxPVj75hc0dAgZZnVEq4P409MsjHWkRGhL
         jVTpJfVo836dWja3r/2o4jlHMp8uwjvBmRTn0lBL9sJjBBfwjMHTAaLeHRJvai2djUWq
         JFeGtjM5PNBv5vPesnmXZp7vUlCgPquTGq6taAYUlxSr1f4MV0w5h8a2lrHEy6JaOPV6
         5eHx7FdhYGsPpd1xpQzDDXKoQSHxI6ywtV5oUXObLzu+DUm7KBE74izX+M+YlkEzwm2s
         27Jw==
X-Gm-Message-State: AOAM533hwsdHKF5cSEwcLuz3mhjXPUYxURvtArOFJ2ofJBpXi7Vdabfy
        2e7ZVNtpdbCzU5iJoz7yo9W/ybWFxS3CSeIwqaM=
X-Google-Smtp-Source: ABdhPJydSEmwomHwyNsWYaGS/ohQWvidZgafVS8CwhaQS/OMYrQf2CmHLB8gJp1NguIARHfPlrLXm1nwizmXiCozfeU=
X-Received: by 2002:a02:c733:0:b0:2fe:ab40:d2cc with SMTP id
 h19-20020a02c733000000b002feab40d2ccmr6516525jao.126.1646561026589; Sun, 06
 Mar 2022 02:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-2-arnd@kernel.org>
 <CA+icZUVcNppitX53A-f9EAh-Lp6aQq1Qn7Ns1J=tDfQAf_K9vQ@mail.gmail.com>
In-Reply-To: <CA+icZUVcNppitX53A-f9EAh-Lp6aQq1Qn7Ns1J=tDfQAf_K9vQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 6 Mar 2022 11:03:10 +0100
Message-ID: <CA+icZUVkpvQuRHqeRtQbrVHU7mb0rK7-TTFMHEgZ8k=_keMTSA@mail.gmail.com>
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

On Fri, Mar 4, 2022 at 12:29 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, Mar 1, 2022 at 4:59 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Mark Rutland <mark.rutland@arm.com>
> >
> > In a subsequent patch we'll move the kernel from using `-std=3Dgnu89` t=
o
> > `-std=3Dgnu11`, permitting the use of additional C11 features such as
> > for-loop initial declarations.
> >
> > One contentious aspect of C99 is that it permits mixed declarations and
> > code, and for now at least, it seems preferable to enforce that
> > declarations must come first.
> >
> > These warnings were already disabled in the kernel itself, but not
> > for KBUILD_USERCFLAGS or the compat VDSO on arch/arm64, which uses
> > a separate set of CFLAGS.
> >
> > This patch fixes an existing violation in modpost.c, which is not
> > reported because of the missing flag in KBUILD_USERCFLAGS:
> >
> > | scripts/mod/modpost.c: In function =E2=80=98match=E2=80=99:
> > | scripts/mod/modpost.c:837:3: warning: ISO C90 forbids mixed declarati=
ons and code [-Wdeclaration-after-statement]
> > |   837 |   const char *endp =3D p + strlen(p) - 1;
> > |       |   ^~~~~
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > [arnd: don't add a duplicate flag to the default set, update changelog]
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I was able to build and boot on bare metal.
>
> No new warnings in my build-log here after switching to -std=3Dgnu11.
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13.0.0 x86-6=
4
>

I have re-tested with Debian's LLVM/Clang v14.0.0-rc2.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v14.0.0-rc2 (x8=
6-64)

- sed@ -

> - sed@ -
>
> > ---
> >  Makefile                          | 3 ++-
> >  arch/arm64/kernel/vdso32/Makefile | 1 +
> >  scripts/mod/modpost.c             | 4 +++-
> >  3 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 94fa9a849a7a..37ef6a555dcd 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -432,7 +432,8 @@ HOSTCXX     =3D g++
> >  endif
> >
> >  export KBUILD_USERCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prot=
otypes \
> > -                             -O2 -fomit-frame-pointer -std=3Dgnu89
> > +                           -O2 -fomit-frame-pointer -std=3Dgnu89 \
> > +                           -Wdeclaration-after-statement
> >  export KBUILD_USERLDFLAGS :=3D
> >
> >  KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOS=
TCFLAGS)
> > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso=
32/Makefile
> > index 9378ea055bf2..ed181bedbffc 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -68,6 +68,7 @@ VDSO_CFLAGS +=3D -Wall -Wundef -Wstrict-prototypes -W=
no-trigraphs \
> >                 -fno-strict-aliasing -fno-common \
> >                 -Werror-implicit-function-declaration \
> >                 -Wno-format-security \
> > +               -Wdeclaration-after-statement \
> >                 -std=3Dgnu11
> >  VDSO_CFLAGS  +=3D -O2
> >  # Some useful compiler-dependent flags from top-level Makefile
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 6bfa33217914..fe693304b120 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -833,8 +833,10 @@ static int match(const char *sym, const char * con=
st pat[])
> >  {
> >         const char *p;
> >         while (*pat) {
> > +               const char *endp;
> > +
> >                 p =3D *pat++;
> > -               const char *endp =3D p + strlen(p) - 1;
> > +               endp =3D p + strlen(p) - 1;
> >
> >                 /* "*foo*" */
> >                 if (*p =3D=3D '*' && *endp =3D=3D '*') {
> > --
> > 2.29.2
> >
