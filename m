Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD6497A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiAXIpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:45:11 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:35717 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiAXIpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:45:11 -0500
Received: by mail-ua1-f46.google.com with SMTP id m90so29601709uam.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6Gpa+U3Jnjel5sEtCrAt9uAbw7/60/ytFCn45HA+eA=;
        b=1xULPvOpolDRcrDsyfpmFvZ9YcJW//lTBwTQAJdyAk24rdsJSKnGo9Ir1G6zVYyrii
         MRAXLxeB9VV4s5oD1aFv7mH76JBq/kuclJe09Yku36ea4Hdsz5z2oD8eBfESzKpH6zJ2
         fof3IM/rRl714C484W7ZJj6Az0lDrxhEJ8yia9TMZvcWDRAbCeZo1WrmU+Kitoast1US
         9GVMXySPT3fJ3Ra2889Ut63d2LbCE4WueRbLt9ZlNjyBRJpAIt5voc0LeAJsvsQYd4Gz
         dJqFF/M54/r6ZYsJJZe3b1g4yoO6PLshoYrKPsX92BQWsFpUlHbyLQIxEUWyVVFRVdER
         h5+g==
X-Gm-Message-State: AOAM533BKxyHBHTMfOxV7IUoSF2vR4rV1ZxO18CgYh44EQXDDJDclvFJ
        VxBkPZaVawGxq1muNzkhjNkcZs8WzX6D3g==
X-Google-Smtp-Source: ABdhPJwlJWlbd8Yi24txkseog2LcudscDn3eWF5zABvYUdFSbaf5qXxqYx4ojqHKoNIVbAnjJRCdqA==
X-Received: by 2002:a05:6102:3ed2:: with SMTP id n18mr5526509vsv.72.1643013910245;
        Mon, 24 Jan 2022 00:45:10 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id q4sm1007607vke.15.2022.01.24.00.45.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 00:45:10 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id u6so29632871uaq.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:45:09 -0800 (PST)
X-Received: by 2002:ab0:2991:: with SMTP id u17mr708394uap.89.1643013909629;
 Mon, 24 Jan 2022 00:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20210913054915.GA3631@lst.de> <20220120075233.GA4777@lst.de> <20220121104006.7e51367a@canb.auug.org.au>
In-Reply-To: <20220121104006.7e51367a@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jan 2022 09:44:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVua+YmzHxHqUfopARs-A+8f74iLAPPBJ33iCv0QqP=_g@mail.gmail.com>
Message-ID: <CAMuHMdVua+YmzHxHqUfopARs-A+8f74iLAPPBJ33iCv0QqP=_g@mail.gmail.com>
Subject: Re: h8300 pull request for 5.14-rc?
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 1:25 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Thu, 20 Jan 2022 08:52:33 +0100 Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Sep 13, 2021 at 07:49:15AM +0200, Christoph Hellwig wrote:
> > > what happened to the h8300 pull request with the set_fs() removal that
> > > is in linux-next?
> >
> > Given that we're at the end of yet another merge window:  what is the
> > status of the h8300 tree?  As far as I can tell the last pull request
> > was in July 2019, and it has commit since just after that.
>
> The h8300-next branch (which is what I merge into linux-next) has some
> more commits, but even there the last commit is from Aug 2021.  It also
> has a lot of old back merges of Linus' tree, and so probably needs a
> good clean.

Indeed.

$ git cherry -v v5.17-rc1 uclinux-h8/h8300-next
+ caf3f4bdb535f73c6e7b828bc98097f275f819bb h8300: fix memset return value.
+ 3e138fe1a4fb6aa834b46529e4faaee4ce2d5505 h8300: Add missing symbol
"BOOT_LINK_OFFSET"
+ ece7be2c964c2aa5015e74628ca33c03a5ff4e47 h8300: move definition of
__kernel_size_t etc. to posix_types.h
+ de98871736825349b367275b0790e42ea4157350 h8300: move definition of
__kernel_size_t etc. to posix_types.h
+ 5d90be1ecf44a116b503649e67e952a7ec070745 h8300: Fix BOOT_LINK_OFFSET
+ b2c03bb18a6dd957130ad8a37f660030e4b7932a smc91x: remove GPIOLIB dependency.
+ 2fdf50bd510fd183ee89e4fdea52e7474ed9709c sh-sci: 8bit register fix.
+ 04fffbe01d2df57e600da35d3f31e3cca8ee14f4 h8300: update dts.
+ 951261bc483479d4c18ee435c35f94cccd659012 h8300_timer8: fix count mode.
+ 2c496a11304da8263e1dce9bdcef1ce04c027414 irq-renesas-h8s: fix
interrupt handling.
+ 8bd55b5fce8011d0026f7d233f7b45788f01ad0c irq-renesas-h8300h: Fix
external interrupt contorol.
+ beab3d5cb0e14e6397c4e596b3dbf1d36bf49d06 irq-renesas-h8s: Fix
external interrupt control.
+ 35b34568912cb19c53b83d6daba96fe960941279 h8300: dts: Fix /chosen:stdout-path
+ 8808515be0ed4e33de9bfdc65f4c1b547ee11065 h8300: Replace
<linux/clk-provider.h> by <linux/of_clk.h>
+ 81dd24966885113968dc5599b9b371b60c3bf7b2 h8300: remove memory.c
+ 1ec10274d436fbe77b821fbdf095b45d0888e46d h8300: don't implement set_fs

Some of these are fixes that need more explanation.
Others should be posted to public lists, and go in through a different tree
(if accepted).
Some are +2-year old fixes (perhaps I should send mine to akpm?).
The last two are Christoph's set_fs() work.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
