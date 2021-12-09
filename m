Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071B546E60E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhLIKCz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 05:02:55 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:37219 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhLIKB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:01:57 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MmCyE-1mD9zy2Z0a-00iBc1; Thu, 09 Dec 2021 10:58:22 +0100
Received: by mail-wr1-f43.google.com with SMTP id u1so8625702wru.13;
        Thu, 09 Dec 2021 01:58:22 -0800 (PST)
X-Gm-Message-State: AOAM533TaK5xNNPLIK81SuVkcExGkRnp4gIGS+bGh0oLTse3XG6+I3Jk
        TwvBrSsxVrJCvUIzuc4ZovJWDt1w+IweLU4dOw0=
X-Google-Smtp-Source: ABdhPJyxeLV7UtF1l/rFSuX941psQjIIY4BAsfEbKAiHX5Z3htWVEMTxwBq+97o3qdAvmBEF6L1VG6S/My2R0ahy3xE=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr5321203wrw.32.1639043901966;
 Thu, 09 Dec 2021 01:58:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638515726.git.qinjian@cqplus1.com> <eabfe1b84b889e4aa95e24c30a114c68ef95fd07.1638515726.git.qinjian@cqplus1.com>
 <CAK8P3a1_coAnp8P3L2UA+smxuRL9widFQv9Y5ZZ0X_Sr9zsZtg@mail.gmail.com>
 <88f8cc0b1334467aae7a5a4b0643176a@cqplus1.com> <CAK8P3a1-4XnrkWc_0SPns9xj9Yp4xWhEahLOkeafXmAYWfbYJA@mail.gmail.com>
 <6a8271f5c6b74ce7874b7583b8d7eee4@cqplus1.com>
In-Reply-To: <6a8271f5c6b74ce7874b7583b8d7eee4@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Dec 2021 10:58:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2w2rava_ozRfWizYDYRe7J3j-=wMgzGA_9t0kd3qJ1NA@mail.gmail.com>
Message-ID: <CAK8P3a2w2rava_ozRfWizYDYRe7J3j-=wMgzGA_9t0kd3qJ1NA@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:QAcfvcI3XDtNhINEM/3DMhz24D80X89c80Oc/nY3jPP6W9CBF0t
 +uth+3os0iMJmnomH082T9XrdsDqw8XbwSi80MeGw1bavNkRlYlTPfFAKLhymMLLxASm5to
 2J3BTtCN6YrUQ3YYYkGE9ujN8bqSgLpqYia8gmB8EgGZ9S6hh7cSHnyS+gXfWWzdly88jtS
 Sq0UNSmJTjvkogttqtSrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JWRrvN909fA=:Bf0onvZHiT3E4v21aA2ME4
 pvWY7lbL+lu5AuEYI0Hm66ujadoSYN0q08aqUyHSWkBJD4pt2lHZe3stjsccXEtaWPUZRhFv9
 1iqqnGgY37aE9c4Im9B7akaOUGEIu9zTQHET5ZDXdcFBRnkNiFAMe0X6BhXqBPWfBSjDZ2EsH
 RjUzEfv8LzBVhglfc2x6Bge//eHeJZlXf6YuaXHfQ3GXLkqz/P5F9JyuUMN52LwjcU0h2cM9m
 PqUcQgIETwy4lKV0S8IcWhingxc+50ZBgu/N+q0ng4PdS0/WZo1cs8YlGvZmFSNxBK3Fj+eoe
 OzFf/3vLLupRCR6mqm8tramovo7+QW4mDEBw4JcKRP0Qo7MkkvBhmN9aCE6sPuCzE2Zj/MviZ
 fHMZ2aF95AI8HEBq/0VigX/3VKUa0VihXlqPzrDqz8NoQBZD6EtpUOLoyCH1uE7MEVdxq1aI7
 VJppnOHWSola+yMncOPv6koEOQlIDndEeD+bY8jEkfD/2yqRUn88nECoalA+bMuKwRAD0MSs0
 vIKguaKaktogTBAqXRJzfmhB7oGi1NNNwDaGsBoJ7uDb+G+4ItaSh8EhVj8v+QoBXJ14pyy0t
 HRPmjNlqfPqmnaLFv0WJTatiJ4IVJigxyLzzCX/RwCXptv7fsdkilXnz07UQJHODdqRD/t+ll
 eeIIt2hY25UeiyT2pYYrB+GTk+vAInl+NTzeR4E7QKevSf5MxbIsClNqEV9wAlxGAjsEwV+F8
 vjyDA83jo/QmnbyIB+aU3gX9f/e7kotgfX3I2TH6bJ5irbvxNBbSg1ib7f2WNa76Ojk8uqBx7
 ipqSniZ0TXjqdpAV8YTAnJMcJKw4HNw8RgfyKbdiIZbgg1LNSE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 9:49 AM qinjian[覃健] <qinjian@cqplus1.com> wrote:
> > On Tue, Dec 7, 2021 at 8:21 AM qinjian[覃健] <qinjian@cqplus1.com> wrote:
> > > > > @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> > > > >  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> > > > >  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
> > > > >  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> > > > > +textofs-$(CONFIG_ARCH_SUNPLUS) := 0x00308000
> > > >
> > > > What is this needed for? If it boots without this line, better avoid
> > > > adding it, because
> > > > it will increase the kernel size for everyone else (unless they also enable
> > > > AXXIA).
> > > >
> > >
> > > SP7021 reserved the 1st 1MB memory for ARM926@P-Chip using,
> > > The 2nd 1MB memory for IOP device and the 3rd 1MB memory for bootloader.
> > > I'll add these comments at next commit.
> >
> > I think you can just remove the memory from the system memory map in the
> > device tree and pretend it only starts after the bootloader. It's been a while
> > since I looked at this though, so I could be misremembering what the minimum
> > boundaries are for doing this.
>
> I have test following 3 methods:

Right, I was thinking of the third method here, which has the advantage of
not requiring the same odd base address for all other platforms, this
is important to us.
I don't see what the problem is with it in your example, does that mean you
have a little less usable memory, or that something fails to work right? I don't
know what the requirements are for memreserve.

Adding a few more people to Cc, maybe they have ideas about how this
was solved elsewhere.

          Arnd

> 1. current patch
> DT:
>         memory {
>                 reg = <0x00000000 0x20000000>; /* 512MB */
>         };
>
>         reserved-memory {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges;
>
>                 iop_reserve: iop_device {
>                         no-map;
>                         reg = <0x00100000 0x00100000>;
>                 };
>                 a926_reserve: a926_memory {
>                         no-map;
>                         reg = <0x00000000 0x00100000>;
>                 };
>         };
> arch/arm/Makefile:
>         textofs-$(CONFIG_ARCH_SUNPLUS) := 0x00308000
>
> bootlog & meminfo :
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x000000001fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x00000000001fffff]
> [    0.000000]   node   0: [mem 0x0000000000200000-0x000000001fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001fffffff]
>
> ~ # cat /proc/meminfo
> MemTotal:         514008 kB
> MemFree:          491960 kB
> MemAvailable:     488608 kB
>
>
>
> 2. DT same as case 1, but no modify @ arch/arm/Makefile
>
> bootlog & meminfo :
> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory for node 'iop_device': base 0x00100000, size 1 MiB
> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory for node 'a926_memory': base 0x00000000, size 1 MiB
> ...
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x000000001fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000001fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001fffffff]
>
> ~ # cat /proc/meminfo
> MemTotal:         516056 kB
> MemFree:          493928 kB
> MemAvailable:     490572 kB
>
>
>
> 3. DT:
>         memory {
>                 reg = <0x00300000 0x1FD00000>; /* 512 - 3 MB */
>         };
> no modify @ arch/arm/Makefile
>
> bootlog & meminfo :
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000400000-0x000000001fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000400000-0x000000001fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000400000-0x000000001fffffff]
>
> ~ # cat /proc/meminfo
> MemTotal:         511964 kB
> MemFree:          489636 kB
> MemAvailable:     486292 kB
>
>
>
> I think method 1 should be correct (compare method 2) & better (compare method 3).
>
