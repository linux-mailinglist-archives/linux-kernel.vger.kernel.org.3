Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3DD5AB4B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiIBPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiIBPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:09:31 -0400
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04D158F33
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:39:01 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-03.nifty.com with ESMTP id 282EZapm032456
        for <linux-kernel@vger.kernel.org>; Fri, 2 Sep 2022 23:35:36 +0900
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 282EZ7d1004313
        for <linux-kernel@vger.kernel.org>; Fri, 2 Sep 2022 23:35:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 282EZ7d1004313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662129308;
        bh=GUDCkmsH6figZ+L4dA6Fdq0YrnToibMGL5SHkTP3Kdo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcXNIG1py8Ycw9y9V1btG05NMbTro5w541fbAHrEbe/aBiq3wg355s+IsKu/CdR7b
         MXDfJ6t1gxAHWzh6mJ4ETDSLTFelF2ocY0CzRwJoGtSJ8Q+J7NWR1Vv5bCxGh1MLpK
         l505EOGEBFW0GGcbBQa5TUsLzPrD7ETGJjoV/65Vk5V6DV3+txDWJggIrcaQfUg4FF
         BnCR49LVvXIscvFMelf5r+6awaA9FzdWpKBZQrNgU/pA5uRthQEXczFtKBha0peMhg
         kUNDnMNvNp7IorbsUtmAyA9A7Ny+ehBTVee6InppP5P4ueDSXkKJDZGSiAeYRjK/pU
         SwHZpA7aNjHdw==
X-Nifty-SrcIP: [209.85.160.47]
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-12243fcaa67so5110959fac.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 07:35:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo2WCeEmm7iTVSOvQj8Hqn16S3enZK8QvXO3TY35t+5gNnT8forQ
        6AJgAnk66BbvfbjYUYw+4q5cwNuWC3RVAurrKlo=
X-Google-Smtp-Source: AA6agR7JHM3XDWVljTbD+mc16Wy5/EZgJE+Ic1P2coqLV4oc9+w24bGS08NdQnk56TbdWqMbWIOgaX31Flxh7lFtgEc=
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id
 j9-20020a056808118900b0033a34b36788mr2007654oil.194.1662129306631; Fri, 02
 Sep 2022 07:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <165442136963.152751.14259048792272164569.tglx@xen13> <CAHk-=wgjTMQgiKzBZTmb=uWGDEQxDdyF1+qxBkODYciuNsmwnw@mail.gmail.com>
In-Reply-To: <CAHk-=wgjTMQgiKzBZTmb=uWGDEQxDdyF1+qxBkODYciuNsmwnw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 2 Sep 2022 23:34:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNASL3tZ_NwNmCaovQdBaKvQf1HrFRsSMw3zrCB63wC9yKA@mail.gmail.com>
Message-ID: <CAK7LNASL3tZ_NwNmCaovQdBaKvQf1HrFRsSMw3zrCB63wC9yKA@mail.gmail.com>
Subject: Re: [GIT pull] objtool/urgent for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Jun 6, 2022 at 2:14 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jun 5, 2022 at 2:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 06400504150b..6a663b27b286 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -218,7 +218,7 @@ objtool_args =                                                              \
> >         $(if $(CONFIG_SLS), --sls)                                      \
> >         $(if $(CONFIG_STACK_VALIDATION), --stackval)                    \
> >         $(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)          \
> > -       --uaccess                                                       \
> > +       $(if $(CONFIG_HAVE_UACCESS_VALIDATION), --uaccess)              \
> >         $(if $(linked-object), --link)                                  \
> >         $(if $(part-of-module), --module)                               \
> >         $(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
>
> Since this clashed with the Kbuild cleanups I just merged, I looked at
> it and threw up in my mouth a little.
>
> Not a new problem, but can we do something like that attached, perhaps?
>
> Untested, but looks trivially obvious. FamousLastWords(tm).
>
>                   Linus

A nice idea.

I also cleaned up scripts/Makefile.vmlinux_o in a similar way,
and submitted a patch.

https://lore.kernel.org/lkml/20220902130846.654526-1-masahiroy@kernel.org/T/#u

I will send it in the next MW.


--
Best Regards
Masahiro Yamada
