Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B027525D79
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbiEMIap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378268AbiEMIa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:30:26 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC92A805B;
        Fri, 13 May 2022 01:30:24 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24D8UADs030389;
        Fri, 13 May 2022 17:30:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24D8UADs030389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652430611;
        bh=xwQUcCuSdiBEAUsLh/QjGhFxHJPH9BOto+TxiXdTFS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zclHX7e0AIOCuEgtAHRCq86RPT+RFalnhBpx48pccNpK47qZzEQnXhSp8FaiK+N66
         8KXpuNelq1ujLRd0BTCi3zy5l0iHgXrSaYVuxpUB3E44lalsgb2DU1cZwTDbI3NIIg
         B/dbpe0G3G8GcD3Ek0ZM157hD9LhwUb6Wr7bgDgw+OQExp6Un2ZRBHPQiPMnE8hRUl
         Y1PdCdp/OplkXchrSx3k1PIsasVSfo52awDIv32RZCpgfYb8gm31esk0Fq+uDNNt4h
         KnyiolXzDSOH9WYcwYmgZ5C5r2O7tuaVUvQF12Blnb+jHt3JKbPTHQR+jij98ElleA
         OjzfMw75no9gw==
X-Nifty-SrcIP: [209.85.215.174]
Received: by mail-pg1-f174.google.com with SMTP id x12so6872692pgj.7;
        Fri, 13 May 2022 01:30:10 -0700 (PDT)
X-Gm-Message-State: AOAM532c2+myU9xnLdV7lFQdc/7Bb77MvD5Zf2jQcQ/wi1qwYxxEDMBD
        wY0URLQoAnyFqJwSq8QK3ddAhm8U7SS5Duic6ms=
X-Google-Smtp-Source: ABdhPJyWaARH7kP3udlEkBFZS+dq9jp45KcuHkgk1gw80CFiDT/HA+anIznGX3AngyDSu3X4Sjo9qekT58OmrARZ4Yk=
X-Received: by 2002:a63:e108:0:b0:3c6:6833:9192 with SMTP id
 z8-20020a63e108000000b003c668339192mr3019013pgh.616.1652430609879; Fri, 13
 May 2022 01:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220512035903.2779287-1-masahiroy@kernel.org>
 <20220512035903.2779287-3-masahiroy@kernel.org> <CAJF2gTTWo2XGsov7HLdjj60YrrSUCVJ3xzW5=g9Xyr7Q8Tsq4A@mail.gmail.com>
In-Reply-To: <CAJF2gTTWo2XGsov7HLdjj60YrrSUCVJ3xzW5=g9Xyr7Q8Tsq4A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 May 2022 17:28:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARq+WqMn=POoJtAsOj-CXagFBERveum1314Ook4wenWkQ@mail.gmail.com>
Message-ID: <CAK7LNARq+WqMn=POoJtAsOj-CXagFBERveum1314Ook4wenWkQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] csky: introduce CONFIG_CSKY_ABI_V1/2
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 3:57 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 12:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > This is useful to clean up Makefile.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/csky/Kconfig  | 11 +++++++++++
> >  arch/csky/Makefile | 14 ++++++++------
> >  2 files changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index 75ef86605d69..da756ecf0f85 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -161,6 +161,12 @@ config ARCH_MMAP_RND_BITS_MIN
> >  config ARCH_MMAP_RND_BITS_MAX
> >         default 17
> >
> > +config CSKY_ABI_V1
> > +       bool
> > +
> > +config CSKY_ABI_V2
> > +       bool
> > +
> >  menu "Processor type and features"
> >
> >  choice
> > @@ -172,15 +178,18 @@ config CPU_CK610
> >         select CPU_NEED_TLBSYNC
> >         select CPU_NEED_SOFTALIGN
> >         select CPU_NO_USER_BKPT
> > +       select CSKY_ABI_V1
> >
> >  config CPU_CK810
> >         bool "CSKY CPU ck810"
> >         select CPU_HAS_HILO
> >         select CPU_NEED_TLBSYNC
> > +       select CSKY_ABI_V2
> >
> >  config CPU_CK807
> >         bool "CSKY CPU ck807"
> >         select CPU_HAS_HILO
> > +       select CSKY_ABI_V2
> >
> >  config CPU_CK860
> >         bool "CSKY CPU ck860"
> > @@ -188,6 +197,8 @@ config CPU_CK860
> >         select CPU_HAS_CACHEV2
> >         select CPU_HAS_LDSTEX
> >         select CPU_HAS_FPUV2
> > +       select CSKY_ABI_V2
> > +
> >  endchoice
> >
> >  choice
> > diff --git a/arch/csky/Makefile b/arch/csky/Makefile
> > index 4d72aca4069b..2b30525f39e1 100644
> > --- a/arch/csky/Makefile
> > +++ b/arch/csky/Makefile
> > @@ -16,34 +16,36 @@ endif
> >
> >  ifdef CONFIG_CPU_CK610
> >  CPUTYPE        = ck610
> > -CSKYABI        = abiv1
> >  endif
> >
> >  ifdef CONFIG_CPU_CK810
> >  CPUTYPE = ck810
> > -CSKYABI        = abiv2
> >  endif
> >
> >  ifdef CONFIG_CPU_CK807
> >  CPUTYPE = ck807
> > -CSKYABI        = abiv2
> >  endif
> >
> >  ifdef CONFIG_CPU_CK860
> >  CPUTYPE = ck860
> > +endif
> > +
> > +ifdef CONFIG_CSKY_ABI_V1
> > +CSKYABI        = abiv1
> > +endif
> > +
> > +ifdef CONFIG_CSKY_ABI_V2
> >  CSKYABI        = abiv2
> We still need CSKYABI, so I don't think adding CONFIG_CSKY_ABI_V2 is
> necessary. And ck807 & ck860 have different ABI.


My main motivation is 4/4.

I want to use the standard Kbuild syntax in arch/csky/Kbuild.

 obj-$(CONFIG_ ...)  += abiv1/
 obj-$(CONFIG_ ...)  += abiv2/



>
> >  endif
> >
> > -ifneq ($(CSKYABI),)
> >  MCPU_STR = $(CPUTYPE)$(FPUEXT)$(VDSPEXT)$(TEEEXT)
> >  KBUILD_CFLAGS += -mcpu=$(CPUTYPE) -Wa,-mcpu=$(MCPU_STR)
> >  KBUILD_CFLAGS += -DCSKYCPU_DEF_NAME=\"$(MCPU_STR)\"
> >  KBUILD_CFLAGS += -msoft-float -mdiv
> >  KBUILD_CFLAGS += -fno-tree-vectorize
> > -endif
> >
> >  KBUILD_CFLAGS += -pipe
> > -ifeq ($(CSKYABI),abiv2)
> > +ifdef CONFIG_CSKY_ABI_V2
> >  KBUILD_CFLAGS += -mno-stack-size
> >  endif
> >
> > --
> > 2.32.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
Masahiro Yamada
