Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C304525BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377436AbiEMGo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353693AbiEMGo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A6B2A28C5;
        Thu, 12 May 2022 23:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE2261E4F;
        Fri, 13 May 2022 06:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E21C34100;
        Fri, 13 May 2022 06:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652424294;
        bh=1USFO/ueix8y9sIsPsYPr5ZMBRBhxUiKRO0K3An8GC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VdwJKmL9ryPiZpNFpAAuuxhq4AvjeQ7AQ9+Faz8wMpcnXoE+Z0bsLbAGn9GEdRmEI
         SRlrFxIBNT+fwugJAKuw/V8pLHqCPYuAzNfVPW/48Up4fCgeOp9wh6MGftmB5JLE6P
         L1anJ1pKQcN7n3m5kP5h5uQmVEBzGaC6i/SyImV1HM8lljEVPWJc5sLQ90OwcCaJoi
         O6SWX5+Uiai799K3SoOLYgh87jllxuP2DjZq4IkKEPxfvezWbGscXrznp7bpt2fAM6
         B6U7xtDT58ntxwiwTWOt09Bt1N81YA06akGQKYSZpwcqncBO7l8T+p2Jb0cbmZqPLl
         oFEZdRlx6GmPg==
Received: by mail-vs1-f44.google.com with SMTP id x8so7441329vsg.11;
        Thu, 12 May 2022 23:44:54 -0700 (PDT)
X-Gm-Message-State: AOAM532vnsNUD6RdYai1D7admLkfiX7CzVZTcIR5TP8rzG5/kfXzI14H
        f1T4j/xPALJUxhr7i+RxBytJiZnVh2wEVV8KQoA=
X-Google-Smtp-Source: ABdhPJyjk8IB4LX4U47l3xdD64chvt6mjiJyxL38Wp/4scOGXKpz2zP4QMc/z0IzQ6HpNaCD5EjHOevGbdf/sGidIvU=
X-Received: by 2002:a67:af01:0:b0:32d:3d57:cff with SMTP id
 v1-20020a67af01000000b0032d3d570cffmr1861323vsl.8.1652424293826; Thu, 12 May
 2022 23:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220512035903.2779287-1-masahiroy@kernel.org>
 <20220512035903.2779287-4-masahiroy@kernel.org> <CAK7LNASsrr_birFp=1MO6fVauogU1uiqSytQNgzFxBiOuLVw1w@mail.gmail.com>
In-Reply-To: <CAK7LNASsrr_birFp=1MO6fVauogU1uiqSytQNgzFxBiOuLVw1w@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 13 May 2022 14:44:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSiOUkyFhjEZS=p-On-chg566e4bFUawQ+gPRJHq3zXVg@mail.gmail.com>
Message-ID: <CAJF2gTSiOUkyFhjEZS=p-On-chg566e4bFUawQ+gPRJHq3zXVg@mail.gmail.com>
Subject: Re: [PATCH 4/4] cskly: move $(core-y) into arch/csky/Kbuild
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

On Fri, May 13, 2022 at 11:28 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 1:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Use the standard obj-y form to specify the sub-directories under
> > arch/csky/. No functional change intended.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> I am not sending v2 just for typo "cskly:"
>
> I hope the maintainer can fix it.
Okay.

>
>
>
>
> >  arch/csky/Kbuild   | 4 ++++
> >  arch/csky/Makefile | 4 ----
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/csky/Kbuild b/arch/csky/Kbuild
> > index 4e39f7abdeb6..3015be1afd59 100644
> > --- a/arch/csky/Kbuild
> > +++ b/arch/csky/Kbuild
> > @@ -1,4 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >
> > +obj-y += kernel/ mm/
> > +obj-$(CONFIG_CPU_ABI_V1) += abiv1/
> > +obj-$(CONFIG_CPU_ABI_V2) += abiv2/
> > +
> >  # for cleaning
> >  subdir- += boot
> > diff --git a/arch/csky/Makefile b/arch/csky/Makefile
> > index 2b30525f39e1..51150abd2831 100644
> > --- a/arch/csky/Makefile
> > +++ b/arch/csky/Makefile
> > @@ -63,10 +63,6 @@ KBUILD_AFLAGS += $(KBUILD_CFLAGS)
> >
> >  head-y := arch/csky/kernel/head.o
> >
> > -core-y += arch/csky/kernel/
> > -core-y += arch/csky/mm/
> > -core-y += arch/csky/$(CSKYABI)/
> > -
> >  libs-y += arch/csky/lib/ \
> >         $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
> >
> > --
> > 2.32.0
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
