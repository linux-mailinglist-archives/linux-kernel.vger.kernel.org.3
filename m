Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A826B525E84
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378683AbiEMIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378675AbiEMIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:51:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933C814AF53;
        Fri, 13 May 2022 01:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44AE1B82CD3;
        Fri, 13 May 2022 08:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA429C34114;
        Fri, 13 May 2022 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652431887;
        bh=fn99UCHpq5sTDx/67QtIRekKniksEWKJ7xMg0TtyL6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VvbTFJxl4xuonp69qIsKVOwAXZWDr/hLsuH7iSiOUiPWphvzYYECT1psVI/ie67Ye
         eMd6B8wh93b2ZhflCpSKjBr0QDNDM0j6BZ42ie3KiLt2xMW+HuMNEhwq8la2eGdaqQ
         nxNWQ46Gydqecu2Joiink/58gmWVp+o6gDFTfXmL7PiOuU0LAYTkeexAV+l0JMe71V
         QLfU1l9WD3skMCPOKCU5SWGQ6+hWE7SKEU8XWjlyUzA9W6MReil80407yTlrztL2I5
         1vVoJJq0W/oAzWqumh5XrWSI7nahf8OBd7gSNokE9pc9BfJwvNZNZQRcuYmOZsJbik
         jAkVZBdi5fISA==
Received: by mail-vs1-f46.google.com with SMTP id t85so7722746vst.4;
        Fri, 13 May 2022 01:51:27 -0700 (PDT)
X-Gm-Message-State: AOAM5307aWoZGV5uQjvFnENUlSHG2uC/ivrU58t7Rf3JPZayenkRxK8D
        icPk59Pl1fSZKli7SOfOij8zldet+NVqYr+mk10=
X-Google-Smtp-Source: ABdhPJzmCSZeIftZlPdeqUbcilsYJJ5sRvGYRJXVpQtNVJGXlJeXuDB25unlKIXMRXKUYwf7Lsnd5fS9p6FsMNIpMUQ=
X-Received: by 2002:a67:ca09:0:b0:32d:4069:5657 with SMTP id
 z9-20020a67ca09000000b0032d40695657mr1776441vsk.59.1652431886754; Fri, 13 May
 2022 01:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220512035903.2779287-1-masahiroy@kernel.org>
 <20220512035903.2779287-3-masahiroy@kernel.org> <CAJF2gTTWo2XGsov7HLdjj60YrrSUCVJ3xzW5=g9Xyr7Q8Tsq4A@mail.gmail.com>
 <CAK7LNARq+WqMn=POoJtAsOj-CXagFBERveum1314Ook4wenWkQ@mail.gmail.com>
In-Reply-To: <CAK7LNARq+WqMn=POoJtAsOj-CXagFBERveum1314Ook4wenWkQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 13 May 2022 16:51:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTabiLYg2cMLcMRpVCN7yG64q_xxJz1yg19F6jQYhGf6w@mail.gmail.com>
Message-ID: <CAJF2gTTabiLYg2cMLcMRpVCN7yG64q_xxJz1yg19F6jQYhGf6w@mail.gmail.com>
Subject: Re: [PATCH 3/4] csky: introduce CONFIG_CSKY_ABI_V1/2
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 64d83f06774668081258bd7f3241267239bb9ab2 (HEAD -> linux-next,
origin/linux-next)
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu May 12 12:59:02 2022 +0900

    csky: Move $(core-y) into arch/csky/Kbuild

    Use the standard obj-y form to specify the sub-directories under
    arch/csky/. Only leave core-y += arch/csky/$(CSKYABI)/ there.

    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    Signed-off-by: Guo Ren <guoren@kernel.org>

diff --git a/arch/csky/Kbuild b/arch/csky/Kbuild
index 4e39f7abdeb6..0621eaea4196 100644
--- a/arch/csky/Kbuild
+++ b/arch/csky/Kbuild
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only

+obj-y += kernel/ mm/
+
 # for cleaning
 subdir- += boot
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 4d72aca4069b..4e1d619fd5c6 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -61,8 +61,6 @@ KBUILD_AFLAGS += $(KBUILD_CFLAGS)

 head-y := arch/csky/kernel/head.o

-core-y += arch/csky/kernel/
-core-y += arch/csky/mm/
 core-y += arch/csky/$(CSKYABI)/

 libs-y += arch/csky/lib/ \

On Fri, May 13, 2022 at 4:30 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, May 13, 2022 at 3:57 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Thu, May 12, 2022 at 12:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > This is useful to clean up Makefile.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  arch/csky/Kconfig  | 11 +++++++++++
> > >  arch/csky/Makefile | 14 ++++++++------
> > >  2 files changed, 19 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > > index 75ef86605d69..da756ecf0f85 100644
> > > --- a/arch/csky/Kconfig
> > > +++ b/arch/csky/Kconfig
> > > @@ -161,6 +161,12 @@ config ARCH_MMAP_RND_BITS_MIN
> > >  config ARCH_MMAP_RND_BITS_MAX
> > >         default 17
> > >
> > > +config CSKY_ABI_V1
> > > +       bool
> > > +
> > > +config CSKY_ABI_V2
> > > +       bool
> > > +
> > >  menu "Processor type and features"
> > >
> > >  choice
> > > @@ -172,15 +178,18 @@ config CPU_CK610
> > >         select CPU_NEED_TLBSYNC
> > >         select CPU_NEED_SOFTALIGN
> > >         select CPU_NO_USER_BKPT
> > > +       select CSKY_ABI_V1
> > >
> > >  config CPU_CK810
> > >         bool "CSKY CPU ck810"
> > >         select CPU_HAS_HILO
> > >         select CPU_NEED_TLBSYNC
> > > +       select CSKY_ABI_V2
> > >
> > >  config CPU_CK807
> > >         bool "CSKY CPU ck807"
> > >         select CPU_HAS_HILO
> > > +       select CSKY_ABI_V2
> > >
> > >  config CPU_CK860
> > >         bool "CSKY CPU ck860"
> > > @@ -188,6 +197,8 @@ config CPU_CK860
> > >         select CPU_HAS_CACHEV2
> > >         select CPU_HAS_LDSTEX
> > >         select CPU_HAS_FPUV2
> > > +       select CSKY_ABI_V2
> > > +
> > >  endchoice
> > >
> > >  choice
> > > diff --git a/arch/csky/Makefile b/arch/csky/Makefile
> > > index 4d72aca4069b..2b30525f39e1 100644
> > > --- a/arch/csky/Makefile
> > > +++ b/arch/csky/Makefile
> > > @@ -16,34 +16,36 @@ endif
> > >
> > >  ifdef CONFIG_CPU_CK610
> > >  CPUTYPE        = ck610
> > > -CSKYABI        = abiv1
> > >  endif
> > >
> > >  ifdef CONFIG_CPU_CK810
> > >  CPUTYPE = ck810
> > > -CSKYABI        = abiv2
> > >  endif
> > >
> > >  ifdef CONFIG_CPU_CK807
> > >  CPUTYPE = ck807
> > > -CSKYABI        = abiv2
> > >  endif
> > >
> > >  ifdef CONFIG_CPU_CK860
> > >  CPUTYPE = ck860
> > > +endif
> > > +
> > > +ifdef CONFIG_CSKY_ABI_V1
> > > +CSKYABI        = abiv1
> > > +endif
> > > +
> > > +ifdef CONFIG_CSKY_ABI_V2
> > >  CSKYABI        = abiv2
> > We still need CSKYABI, so I don't think adding CONFIG_CSKY_ABI_V2 is
> > necessary. And ck807 & ck860 have different ABI.
>
>
> My main motivation is 4/4.
>
> I want to use the standard Kbuild syntax in arch/csky/Kbuild.
>
>  obj-$(CONFIG_ ...)  += abiv1/
>  obj-$(CONFIG_ ...)  += abiv2/
>
>
>
> >
> > >  endif
> > >
> > > -ifneq ($(CSKYABI),)
> > >  MCPU_STR = $(CPUTYPE)$(FPUEXT)$(VDSPEXT)$(TEEEXT)
> > >  KBUILD_CFLAGS += -mcpu=$(CPUTYPE) -Wa,-mcpu=$(MCPU_STR)
> > >  KBUILD_CFLAGS += -DCSKYCPU_DEF_NAME=\"$(MCPU_STR)\"
> > >  KBUILD_CFLAGS += -msoft-float -mdiv
> > >  KBUILD_CFLAGS += -fno-tree-vectorize
> > > -endif
> > >
> > >  KBUILD_CFLAGS += -pipe
> > > -ifeq ($(CSKYABI),abiv2)
> > > +ifdef CONFIG_CSKY_ABI_V2
> > >  KBUILD_CFLAGS += -mno-stack-size
> > >  endif
> > >
> > > --
> > > 2.32.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
