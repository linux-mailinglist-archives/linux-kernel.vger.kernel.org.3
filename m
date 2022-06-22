Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E664554052
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356013AbiFVB6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355919AbiFVB6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:58:42 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A133368;
        Tue, 21 Jun 2022 18:58:41 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 25M1wFRA011408;
        Wed, 22 Jun 2022 10:58:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 25M1wFRA011408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655863096;
        bh=xnd6kF0zhf65sr2NXr92ZM/d52MAYdhye7LUEr75tKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wzXWeqKQZPBhmNIy25RWZW67t1rgrDwfkx8zMWLiSJ0S9pdLGXG+iEQ2QTEgkOcjo
         8e5EDm6hFGqOVW0bGdLEgYsHBdQT4t0JDUJecGmvpw0k7pUaSc+vqS0nMWZEPmB48e
         tAcVoLqmQIZp6QLNCpVCkiMYeCUeKKqTH1V0rFdaPDBntrmwXJ5YTuYuG2vgVHyxTu
         QlI0EPEkPdwxc+7MuSNjv75aVYzbMfIJbBsrDoQ2zVWTab9EvMNz8OG4Ahs+QHc+FB
         prYX0vHHP03sXBfF8gWZkdgz9BvIKSgoZ3oBhEQ1CNpzNXL+POSe/HDT818WHbCNlg
         SJLGiWkf1KeSA==
X-Nifty-SrcIP: [209.85.128.50]
Received: by mail-wm1-f50.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso8135405wml.1;
        Tue, 21 Jun 2022 18:58:15 -0700 (PDT)
X-Gm-Message-State: AJIora8jKptiyROnEnBdFm4SBAKdC7ZcYPQC6jho5epHF5KDj5ZbNAtS
        XJk0Xia6P4s/SWJRU0Od3b0NHz07/aEr1sUtKFI=
X-Google-Smtp-Source: AGRyM1t46gviljb+jOdiUVWa+yjIrK/SiwKA6FRFw+14MzIRIDZ1Nsce/tON8apaS7zFmPFang+jS3YA8haOHjJEUU4=
X-Received: by 2002:a1c:4409:0:b0:39e:f586:6fd8 with SMTP id
 r9-20020a1c4409000000b0039ef5866fd8mr1042679wma.157.1655863094276; Tue, 21
 Jun 2022 18:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220621133526.29662-1-mikoxyzzz@gmail.com> <CAKwvOd=Bmu40+_11GOBTeJBjToUf0LNG_RX0RiLcRLimUUkgcw@mail.gmail.com>
In-Reply-To: <CAKwvOd=Bmu40+_11GOBTeJBjToUf0LNG_RX0RiLcRLimUUkgcw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Jun 2022 10:57:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3FrpLnhSgfTo5bxk-9cHm6g1ti58wSY6W-fxMx+mUrA@mail.gmail.com>
Message-ID: <CAK7LNAT3FrpLnhSgfTo5bxk-9cHm6g1ti58wSY6W-fxMx+mUrA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Miko Larsson <mikoxyzzz@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 1:17 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jun 21, 2022 at 6:35 AM Miko Larsson <mikoxyzzz@gmail.com> wrote:
> >
> > Hi,
> >
> > This very small series allows -O3 to be used for all architectures. The
> > first patch marks -O3 as experimental, with the reasoning being that it
> > might expose unwanted regressions to users, and the second patch
> > actually allows -O3 by removing the "depend on ARC" string.
>
> I think we should just remove -O3 support from KCONFIG.
>
> If someone wants to mess around with "experimental features," there's
> nothing stopping you from doing:
>
> $ make KCFLAGS=-O3
>

ARC uses -O3 since day1.

"Generic build system uses -O2, we want -O3"
in commit cfdbc2e16e65c1ec1c23057640607cee98d1a1bd

If they want -O3, it is up to the ARC maintainer.



If you want to say "use this option carefully",
EXPERT might be another option.

    depends on ARC || EXPERT







> >
> > The reasoning behind this series is to open up -O3 so that bugs related
> > to it (both compiler-related and kernel-related) can be discovered by
> > eyeballs wanting to improve the "-O3 experience," as that might be
> > beneficial to both compilers and the kernel. This has been attempted
> > before [1], but unfortunately nothing ever came of it.
> >
> > [1] https://lore.kernel.org/lkml/20191211104619.114557-1-oleksandr@redhat.com/
> >
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: x86@kernel.org
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Chris Down <chris@chrisdown.name>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: John Ogness <john.ogness@linutronix.de>
> > Cc: Elliot Berman <quic_eberman@quicinc.com>
> > Cc: Oleksandr Natalenko <oleksandr@redhat.com>
> >
> > Miko Larsson (2):
> >   Kconfig: Mark -O3 as experimental
> >   Kconfig: Allow -O3 for all architectures
> >
> >  init/Kconfig | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > --
> > 2.36.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
