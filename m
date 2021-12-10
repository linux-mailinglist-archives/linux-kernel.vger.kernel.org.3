Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B134705FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhLJQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:43:55 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:26812 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhLJQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:43:53 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1BAGdmG1011961;
        Sat, 11 Dec 2021 01:39:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BAGdmG1011961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639154389;
        bh=caU8WhgZKRFWbo5uPLG/+Ze9EYTB2SiCAV0Fr4H7pbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NrBH93NPgc3ghFl/6P9XwrSooRwpgx7QXvn4qAECm2Bzyis0hWSdJCVWMyCBa1/tK
         8zsvabnAv2zf9JYgTaFLWeuxZFFwwhzaUcOLaD/gPB5WkDX8vIEI94Wj4j9pstoteF
         08OnnPYBux6eWIi6eUbRd4Y7QD2cnNYxmocZ9U4pqetaP8wS+kDd5oiOfH/TFQE0JJ
         1NXzsJgmtI8jumNzdo9VPlTjdKmWv2v4POX8UFEB5/MxruVpE5A7OQM4K7gi5ECWHs
         W+PsED3JBCtEF7qQcNX8SVrN/mVJLpb3rQB0y87MukX5UiO0/WI84+cfJm3jowtWEY
         CMH9z2v+yBeLA==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id r130so8967122pfc.1;
        Fri, 10 Dec 2021 08:39:49 -0800 (PST)
X-Gm-Message-State: AOAM533/ehQzpu6ErTb+8dX+5ag6bCkafgKCqIKqC0QvqM8Al7J2fWZ0
        Qi8aIVcKBEd5bSaro6CZTMwe62A2Fc4XwQ3gy6k=
X-Google-Smtp-Source: ABdhPJwvfNn9BqNf97UTkmviipxc3LJ75wiXmN5UlSDYGjAR4mHL8PCi5GM3yle/LQaeoX/jo4MouSU+1PtnpdKk/hQ=
X-Received: by 2002:a65:430a:: with SMTP id j10mr40213077pgq.126.1639154388222;
 Fri, 10 Dec 2021 08:39:48 -0800 (PST)
MIME-Version: 1.0
References: <1639109105-1545-1-git-send-email-yangtiezhu@loongson.cn> <YbN+0NrHmsFKfNWP@archlinux-ax161>
In-Reply-To: <YbN+0NrHmsFKfNWP@archlinux-ax161>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Dec 2021 01:39:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7=qYs7NdDRY+4Dz5Zt0tLDo-W-EMcx+9TaNazNVcX=Q@mail.gmail.com>
Message-ID: <CAK7LNAS7=qYs7NdDRY+4Dz5Zt0tLDo-W-EMcx+9TaNazNVcX=Q@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jason Self <jason@bluehome.net>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 1:22 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Dec 10, 2021 at 12:05:05PM +0800, Tiezhu Yang wrote:
> > After commit 13ceb48bc19c ("MIPS: Loongson2ef: Remove unnecessary
> > {as,cc}-option calls"), no need to use "ifdef need-compiler" for
> > Kbuild.platforms, because the cause of the build issue mentioned
> > in commit 0706f74f719e ("MIPS: fix *-pkg builds for loongson2ef
> > platform") has been disappeared, so just remove it.
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >
> > v2: fix the typo "casue" --> "cause" in the commit message,
> >     sorry for that.
> >
> >  arch/mips/Makefile | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index ace7f03..e036fc0 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -253,9 +253,7 @@ endif
> >  #
> >  # Board-dependent options and extra files
> >  #
> > -ifdef need-compiler
> >  include $(srctree)/arch/mips/Kbuild.platforms
> > -endif
> >
> >  ifdef CONFIG_PHYSICAL_START
> >  load-y                                       = $(CONFIG_PHYSICAL_START)
> > --
> > 2.1.0
> >


Nathan's patch cleaned up  arch/mips/loognson2ef/Platform,
but I still see similar code in arch/mips/sgi-ip22/Platform.


ifdef CONFIG_SGI_IP28
  ifeq ($(call cc-option-yn,-march=r10000 -mr10k-cache-barrier=store), n)
      $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
  endif
endif


Doesn't this cause a failure of *-pkg builds for sgi-ip22 platform?






-- 
Best Regards
Masahiro Yamada
