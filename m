Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2547C9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhLUXy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:54:57 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:62451 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhLUXy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:54:56 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1BLNsW0I027486;
        Wed, 22 Dec 2021 08:54:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BLNsW0I027486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1640130873;
        bh=lt5/Q1qF/gM5zxSTWJAiuYhZ7G063l8nDfj5NFBWPFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bh96yNjfb6Yj02+wz5jpvvCQp45C5hUHe1yw9BJb03RSm5Ca7mQrmI5Exb2tIZpAi
         UQ4Wshddr/+a4zeAjjiIS/RR8+NzchKfO6PFVDqWtV06daxVs5UNCKhKKFf6obU2qK
         k4Zk2Aa9FxYCy4SUcCoOVxUX7P/bu5VLaVdM+b7ptdyb6Te9jSqiDr30Hhw+bbxnyP
         1ncY2dcdYD402rjDNvDYfUOjN01jr7zSykAASfCQtgA3A4jHUnvonIF+AEtJHpQ8+D
         SoLTsDtC4aD2TDvglp0BoZSEbpELUGm7yH9ZE7vFqoO+J/Nd3ydKL1rJsF8Wkfb25L
         acZi3WsWv+a8Q==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so747382pjb.5;
        Tue, 21 Dec 2021 15:54:32 -0800 (PST)
X-Gm-Message-State: AOAM532aqX6TyaFpZsMWkgVcEp+OHiD1eN4jKuoAZri73W7X8UKt0sxW
        tijQ684oNBvLquxdgOJV+z9MCcgttuIHQOcMq34=
X-Google-Smtp-Source: ABdhPJyHmvEe/SbJP3NHZTlSWYDquxYNiXZefe5wDyRzBFR3pBzKvvtO4Qazoi1sYZxSb/j4kgFS4EFu261nxG1IfAU=
X-Received: by 2002:a17:90b:164a:: with SMTP id il10mr609570pjb.77.1640130872060;
 Tue, 21 Dec 2021 15:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20211213030915.1170219-1-masahiroy@kernel.org> <0314b689-4445-def8-5f17-0c73f7567cf1@gmx.de>
In-Reply-To: <0314b689-4445-def8-5f17-0c73f7567cf1@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Dec 2021 08:53:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS1fBV1=tA0v-u0vYEopxhw7U5KjMku2Duz++Na3DfB6Q@mail.gmail.com>
Message-ID: <CAK7LNAS1fBV1=tA0v-u0vYEopxhw7U5KjMku2Duz++Na3DfB6Q@mail.gmail.com>
Subject: Re: [PATCH] parisc: decompressor: do not copy source files while building
To:     Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Rich Felker <dalias@libc.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 7:45 PM Helge Deller <deller@gmx.de> wrote:
>
> On 12/13/21 04:09, Masahiro Yamada wrote:
> > As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
> > builds") stated, copying source files during the build time may not
> > end up with as clean code as expected.
> >
> > Do similar for parisc to clean up the Makefile.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Helge Deller <deller@gmx.de>
>

Can you apply it to your tree?
Thanks.


> Thanks!
> Helge
>
> > ---
> >
> >  arch/parisc/boot/compressed/.gitignore | 2 --
> >  arch/parisc/boot/compressed/Makefile   | 8 --------
> >  arch/parisc/boot/compressed/firmware.c | 2 ++
> >  arch/parisc/boot/compressed/real2.S    | 2 ++
> >  scripts/remove-stale-files             | 5 +++++
> >  5 files changed, 9 insertions(+), 10 deletions(-)
> >  create mode 100644 arch/parisc/boot/compressed/firmware.c
> >  create mode 100644 arch/parisc/boot/compressed/real2.S
> >
> > diff --git a/arch/parisc/boot/compressed/.gitignore b/arch/parisc/boot/compressed/.gitignore
> > index b9853a356ab2..a5839aa16706 100644
> > --- a/arch/parisc/boot/compressed/.gitignore
> > +++ b/arch/parisc/boot/compressed/.gitignore
> > @@ -1,6 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -firmware.c
> > -real2.S
> >  sizes.h
> >  vmlinux
> >  vmlinux.lds
> > diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
> > index bf4f2891d0b7..116bd5c1873c 100644
> > --- a/arch/parisc/boot/compressed/Makefile
> > +++ b/arch/parisc/boot/compressed/Makefile
> > @@ -13,7 +13,6 @@ OBJECTS := head.o real2.o firmware.o misc.o piggy.o
> >  targets := vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
> >  targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
> >  targets += $(OBJECTS) sizes.h
> > -targets += real2.S firmware.c
> >
> >  KBUILD_CFLAGS := -D__KERNEL__ -O2 -DBOOTLOADER
> >  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> > @@ -42,14 +41,7 @@ $(obj)/head.o: $(obj)/sizes.h
> >  CFLAGS_misc.o += -I$(objtree)/$(obj)
> >  $(obj)/misc.o: $(obj)/sizes.h
> >
> > -$(obj)/firmware.o: $(obj)/firmware.c
> > -$(obj)/firmware.c: $(srctree)/arch/$(SRCARCH)/kernel/firmware.c
> > -     $(call cmd,shipped)
> > -
> >  AFLAGS_real2.o += -DBOOTLOADER
> > -$(obj)/real2.o: $(obj)/real2.S
> > -$(obj)/real2.S: $(srctree)/arch/$(SRCARCH)/kernel/real2.S
> > -     $(call cmd,shipped)
> >
> >  CPPFLAGS_vmlinux.lds += -I$(objtree)/$(obj) -DBOOTLOADER
> >  $(obj)/vmlinux.lds: $(obj)/sizes.h
> > diff --git a/arch/parisc/boot/compressed/firmware.c b/arch/parisc/boot/compressed/firmware.c
> > new file mode 100644
> > index 000000000000..16a07137fe92
> > --- /dev/null
> > +++ b/arch/parisc/boot/compressed/firmware.c
> > @@ -0,0 +1,2 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include "../../kernel/firmware.c"
> > diff --git a/arch/parisc/boot/compressed/real2.S b/arch/parisc/boot/compressed/real2.S
> > new file mode 100644
> > index 000000000000..cdc6a4da3240
> > --- /dev/null
> > +++ b/arch/parisc/boot/compressed/real2.S
> > @@ -0,0 +1,2 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#include "../../kernel/real2.S"
> > diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> > index f0d53227fe7b..80430b8fb617 100755
> > --- a/scripts/remove-stale-files
> > +++ b/scripts/remove-stale-files
> > @@ -33,4 +33,9 @@ if [ -n "${building_out_of_srctree}" ]; then
> >       do
> >               rm -f arch/mips/boot/compressed/${f}
> >       done
> > +
> > +     for f in firmware.c real2.S
> > +     do
> > +             rm -f arch/parisc/boot/compressed/${f}
> > +     done
> >  fi
> >
>


-- 
Best Regards
Masahiro Yamada
