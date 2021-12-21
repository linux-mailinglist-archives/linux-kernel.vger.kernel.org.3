Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35A347C9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhLUXzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:55:54 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:30175 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhLUXzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:55:52 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 1BLNtV2p001802;
        Wed, 22 Dec 2021 08:55:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1BLNtV2p001802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1640130932;
        bh=n2Eb00e4RTLyTVTZ0LmIJLe63CyDnGATMDBofhoW3vw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EiXgVCQxKurJsljktUS6R0KnFwLT1jYM9yHbW4mIW8Lgujnpkq2kopp7Pjmi+1e5S
         w3b+4+qKDr2diQtVA+/otGth65l4HeGTysMrvfwoj+ZCfVA5wNM86lwYyYWnUbqyAg
         QHTyfFT8P678lNDuFU9D4+jj5l+bBV10J/ItrMmNUGR2PKXYz+8WyVKwK2D0OQhQ1g
         8bpsH80q1oK4CnhNIyoXs19upzjQhngWIvj/Z+szjK5LfjlbBjzbXNidqcur8n+GVv
         owWIBnyJ8sCVaDsiso3yr66zjSuzOG5txAkqPNuCqm/JE/8AyLcq8YAtLcnkyYOukh
         nD5jgkOb8TJHQ==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id co15so674834pjb.2;
        Tue, 21 Dec 2021 15:55:32 -0800 (PST)
X-Gm-Message-State: AOAM533rO1ERAjoshWSCYhJIz0llxCtE0sthEa6lD5Ytkv8A75BToo24
        FjLWHkAhWim3lSynH9heHSFKEN3cFbAuSKPl9TQ=
X-Google-Smtp-Source: ABdhPJwzNkmDmzzzUDE9OIT5uS3OjX4ogtriAg3VYCoQkT8TK6j0dRhv8qi4UuQ4C+zc94r9vCYs+Pq3Hu8wxYzh5Q4=
X-Received: by 2002:a17:902:bb0f:b0:148:b895:4995 with SMTP id
 im15-20020a170902bb0f00b00148b8954995mr624739plb.99.1640130931435; Tue, 21
 Dec 2021 15:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20211213024044.1165969-1-masahiroy@kernel.org> <2fa1f8fb-2a30-1445-758c-4aa2e7fc5ec0@gmx.de>
In-Reply-To: <2fa1f8fb-2a30-1445-758c-4aa2e7fc5ec0@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Dec 2021 08:54:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgPjnRer_y=QRqUVHikU2ut7MQzy+P=XEcBxk-o+2vGQ@mail.gmail.com>
Message-ID: <CAK7LNASgPjnRer_y=QRqUVHikU2ut7MQzy+P=XEcBxk-o+2vGQ@mail.gmail.com>
Subject: Re: [PATCH] parisc: remove ARCH_DEFCONFIG
To:     Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 7:45 PM Helge Deller <deller@gmx.de> wrote:
>
> On 12/13/21 03:40, Masahiro Yamada wrote:
> > Commit 2a86f6612164 ("kbuild: use KBUILD_DEFCONFIG as the fallback for
> > DEFCONFIG_LIST") removed ARCH_DEFCONFIG because it does not make much
> > sense.
> >
> > In the same development cycle, Commit ededa081ed20 ("parisc: Fix
> > defconfig selection") added ARCH_DEFCONFIG for parisc.
> >
> > Please use KBUILD_DEFCONFIG in arch/*/Makefile for defconfig selection.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Helge Deller <deller@gmx.de>

Can you apply it to your tree?
Thanks.


> Thanks!
> Helge
>
> > ---
> >
> >  arch/parisc/Kconfig | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > index b2188da09c73..011dc32fdb4d 100644
> > --- a/arch/parisc/Kconfig
> > +++ b/arch/parisc/Kconfig
> > @@ -85,11 +85,6 @@ config MMU
> >  config STACK_GROWSUP
> >       def_bool y
> >
> > -config ARCH_DEFCONFIG
> > -     string
> > -     default "arch/parisc/configs/generic-32bit_defconfig" if !64BIT
> > -     default "arch/parisc/configs/generic-64bit_defconfig" if 64BIT
> > -
> >  config GENERIC_LOCKBREAK
> >       bool
> >       default y
> >
>


-- 
Best Regards
Masahiro Yamada
