Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257CA512AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbiD1Evm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbiD1Evj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:51:39 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E407DE21;
        Wed, 27 Apr 2022 21:48:23 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 23S4lsHu001405;
        Thu, 28 Apr 2022 13:47:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 23S4lsHu001405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651121274;
        bh=iNPcdynsiE9cFa7PrW6D5J6kKtmXCdTuoM66ZTzKmP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v0jaH2oKbbR4d6pZgPxUhXXYQoHwJ+bMcPi6Vu0HjMI1ypEPnpBEEx4fl4wrzdYxZ
         SotssQIZqlnhiL71wqKFGvNkBWs6r86Rk3jsvnHXPurcPz9i0e5k8+XjQF5XjgXRoC
         JNjIR2K6bFhkKkkvdedE9EBR1M0tGxOl/y6uvspv6yZsAO6YMT8joZF7e7/glT7Uwf
         Bsqt7Tp/QyGpd1TBKak1JtE4xY40NNMcAxm3YRUf2r6+3mpeI/d+UwjrJNOkZrjDH4
         nDtmo+QiiaK5SBk4yxJA9kz+nHauEKFzhAFq7/kjP7itzd2sqZJlKfP5PgzKaaEaCg
         mfU6YF6sSQ3pQ==
X-Nifty-SrcIP: [209.85.215.174]
Received: by mail-pg1-f174.google.com with SMTP id g3so3054033pgg.3;
        Wed, 27 Apr 2022 21:47:54 -0700 (PDT)
X-Gm-Message-State: AOAM530achmGJfDURkinLL9JXAva3cNSCHLDpajqF5j64uju+fC91q7u
        ob3Rxyvaujgx2D07MKKD6r5UMZzxU9hb6Gano80=
X-Google-Smtp-Source: ABdhPJyUQ0pcXh3obFtIlIt1EVXqWYssVzaeU4h5YCjrFADTlGfHje1qeWPv1QFFMgxUNg9rIWdwKZaxj2UF+4f9Kfs=
X-Received: by 2002:a63:18c:0:b0:3aa:d794:7c44 with SMTP id
 134-20020a63018c000000b003aad7947c44mr23991414pgb.126.1651121273648; Wed, 27
 Apr 2022 21:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-27-masahiroy@kernel.org> <YmoGuY82c/gGI/sU@bergen.fjasle.eu>
In-Reply-To: <YmoGuY82c/gGI/sU@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 28 Apr 2022 13:46:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDWPUuF3psbPb948LMumHn0BvcpPuuBgNLALgQ8y9=Kw@mail.gmail.com>
Message-ID: <CAK7LNASDWPUuF3psbPb948LMumHn0BvcpPuuBgNLALgQ8y9=Kw@mail.gmail.com>
Subject: Re: [PATCH 26/27] kbuild: stop generating *.symversions
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:15 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Mon 25 Apr 2022 04:08:10 GMT Masahiro Yamada wrote:
> > Now *.symversions is unneeded. Clean up the Makefile and script.
> >
> > I will keep *.symversions in .gitignore and 'make clean' for a while
> > to avoid flooding the output from 'git status'.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.build  | 28 ++++------------------------
> >  scripts/link-vmlinux.sh | 19 -------------------
> >  2 files changed, 4 insertions(+), 43 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index aadc16e04632..7f199b0a5170 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -170,12 +170,9 @@ ifdef CONFIG_MODVERSIONS
> >  # to the kernel and/or modules at the end.
> >  gen_symversions =                                                            \
> >       if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then                       \
> > -             $(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
> > -                 > $@.symversions;                                           \
> >               echo >> $(dot-target).cmd ;                                     \
> > -             sed 's/\(.*\) = \(.*\);/$(pound)\1=\2/' $@.symversions >> $(dot-target).cmd ; \
> > -     else                                                                    \
> > -             rm -f $@.symversions;                                           \
> > +             $(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) | \
> > +             sed 's/\(.*\) = \(.*\);/$(pound)\1=\2/' >> $(dot-target).cmd ; \
>
> I was wondering, whether we should integrate the 'sed' part into
> genksyms and make it output the lines as we need them.
> If genksyms fails, we now don't see any error code and make will
> silently continue as the pipe hides genksyms' exit code, right?


You are right.
I was also thinking of doing this directly in genksyms.
I will do it in v2.

bash supports 'set -o pipefail', but I do not know how
to do it in other shells.

I am also thinking of switching over to SHELL=/bin/bash,
but we cannot rely on bash'ism here yet.

-- 
Best Regards
Masahiro Yamada
