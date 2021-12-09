Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09E646E66A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhLIKQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:16:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48044 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhLIKQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:16:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D256EB82417;
        Thu,  9 Dec 2021 10:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A555C341CF;
        Thu,  9 Dec 2021 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639044746;
        bh=cEmt8CLs9SbD6QJkC26M6lS7gchfwBo62aRiAyOrkCI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eGkf+NdeNP5J9seRktnul7rN7LNw/fuL132tf474y/7f1Z09dQpgiWVMeth3JtvcF
         wojOXhFxjGDgA2iQhZBDFFOPCcsMfhXQ+9gN+dMSsQkbXC9dZFx38toeIkQa5Lqj/e
         wAASKPyOVC+Ch0O7wtaUl1heBI7pRrGwpHf2ZLQTTXjw76jIN/yf+3ivlHvrEkfKOY
         ZYWY+vSsZFL93Jt6I3jhSttL6W3w6lX5GGnfebnoLqXI6LmaWQHaqM5/ztSsMEY0Jx
         u8EMY/h7/hQBMeAH5Q0FZnbVG5wnsVvNlfFqnZOT+5R5Amv4tsx1ETTM/9Hfsq8SFP
         2TDOGkjuH1+xw==
Received: by mail-oi1-f172.google.com with SMTP id t23so8050680oiw.3;
        Thu, 09 Dec 2021 02:12:26 -0800 (PST)
X-Gm-Message-State: AOAM532wP8YzVHQ/3atfdv7Wb4r777BfikfMXDq1DliOfLNJrf4JxwdO
        SJwRw4nLSPTXqyM2Y+wtUMIYGS9iR+u4YDv0owg=
X-Google-Smtp-Source: ABdhPJwmFwFH7yNeKLDGv9ESijsgrsV3qnfotlQUfaxSR/wldiFyeSXczBI/C4IrzfM5JXfi3LehFhiyMyvYaYlYddw=
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr4832308oib.33.1639044745638;
 Thu, 09 Dec 2021 02:12:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638515726.git.qinjian@cqplus1.com> <eabfe1b84b889e4aa95e24c30a114c68ef95fd07.1638515726.git.qinjian@cqplus1.com>
 <CAK8P3a1_coAnp8P3L2UA+smxuRL9widFQv9Y5ZZ0X_Sr9zsZtg@mail.gmail.com>
 <88f8cc0b1334467aae7a5a4b0643176a@cqplus1.com> <CAK8P3a1-4XnrkWc_0SPns9xj9Yp4xWhEahLOkeafXmAYWfbYJA@mail.gmail.com>
 <6a8271f5c6b74ce7874b7583b8d7eee4@cqplus1.com> <CAK8P3a2w2rava_ozRfWizYDYRe7J3j-=wMgzGA_9t0kd3qJ1NA@mail.gmail.com>
In-Reply-To: <CAK8P3a2w2rava_ozRfWizYDYRe7J3j-=wMgzGA_9t0kd3qJ1NA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Dec 2021 11:12:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEAQi58iXwoBoVHzqcM9EVU1O-_D+HaAVWpQYvjRYT+mg@mail.gmail.com>
Message-ID: <CAMj1kXEAQi58iXwoBoVHzqcM9EVU1O-_D+HaAVWpQYvjRYT+mg@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 at 10:58, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 9, 2021 at 9:49 AM qinjian[=E8=A6=83=E5=81=A5] <qinjian@cqplu=
s1.com> wrote:
> > > On Tue, Dec 7, 2021 at 8:21 AM qinjian[=E8=A6=83=E5=81=A5] <qinjian@c=
qplus1.com> wrote:
> > > > > > @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) :=3D 0x00208=
000
> > > > > >  textofs-$(CONFIG_ARCH_MSM8960) :=3D 0x00208000
> > > > > >  textofs-$(CONFIG_ARCH_MESON) :=3D 0x00208000
> > > > > >  textofs-$(CONFIG_ARCH_AXXIA) :=3D 0x00308000
> > > > > > +textofs-$(CONFIG_ARCH_SUNPLUS) :=3D 0x00308000
> > > > >
> > > > > What is this needed for? If it boots without this line, better av=
oid
> > > > > adding it, because
> > > > > it will increase the kernel size for everyone else (unless they a=
lso enable
> > > > > AXXIA).
> > > > >
> > > >
> > > > SP7021 reserved the 1st 1MB memory for ARM926@P-Chip using,
> > > > The 2nd 1MB memory for IOP device and the 3rd 1MB memory for bootlo=
ader.
> > > > I'll add these comments at next commit.
> > >
> > > I think you can just remove the memory from the system memory map in =
the
> > > device tree and pretend it only starts after the bootloader. It's bee=
n a while
> > > since I looked at this though, so I could be misremembering what the =
minimum
> > > boundaries are for doing this.
> >
> > I have test following 3 methods:
>
> Right, I was thinking of the third method here, which has the advantage o=
f
> not requiring the same odd base address for all other platforms, this
> is important to us.
> I don't see what the problem is with it in your example, does that mean y=
ou
> have a little less usable memory, or that something fails to work right? =
I don't
> know what the requirements are for memreserve.
>
> Adding a few more people to Cc, maybe they have ideas about how this
> was solved elsewhere.
>

The phys2virt patching now assumes a granularity of 2 MiB. This means
that by removing 3 MiB at the start of DRAM, you lose 1 MIB of usable
memory unless you find a way to memremap() it directly.

So I think a combination of the two approaches might work here
- remove 2 MiB from the the /memory node.
- add 1 MiB to the text offset instead of 3 MiB.

Note that this is a compromise, and still not our preferred approach.
It would be far better to move these reserved regions to the end of
DRAM instead.


>
> > 1. current patch
> > DT:
> >         memory {
> >                 reg =3D <0x00000000 0x20000000>; /* 512MB */
> >         };
> >
> >         reserved-memory {
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <1>;
> >                 ranges;
> >
> >                 iop_reserve: iop_device {
> >                         no-map;
> >                         reg =3D <0x00100000 0x00100000>;
> >                 };
> >                 a926_reserve: a926_memory {
> >                         no-map;
> >                         reg =3D <0x00000000 0x00100000>;
> >                 };
> >         };
> > arch/arm/Makefile:
> >         textofs-$(CONFIG_ARCH_SUNPLUS) :=3D 0x00308000
> >
> > bootlog & meminfo :
> > [    0.000000] Zone ranges:
> > [    0.000000]   Normal   [mem 0x0000000000000000-0x000000001fffffff]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000000000-0x00000000001fffff]
> > [    0.000000]   node   0: [mem 0x0000000000200000-0x000000001fffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001=
fffffff]
> >
> > ~ # cat /proc/meminfo
> > MemTotal:         514008 kB
> > MemFree:          491960 kB
> > MemAvailable:     488608 kB
> >
> >
> >
> > 2. DT same as case 1, but no modify @ arch/arm/Makefile
> >
> > bootlog & meminfo :
> > [    0.000000] OF: fdt: Reserved memory: failed to reserve memory for n=
ode 'iop_device': base 0x00100000, size 1 MiB
> > [    0.000000] OF: fdt: Reserved memory: failed to reserve memory for n=
ode 'a926_memory': base 0x00000000, size 1 MiB
> > ...
> > [    0.000000] Zone ranges:
> > [    0.000000]   Normal   [mem 0x0000000000000000-0x000000001fffffff]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000000000-0x000000001fffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001=
fffffff]
> >
> > ~ # cat /proc/meminfo
> > MemTotal:         516056 kB
> > MemFree:          493928 kB
> > MemAvailable:     490572 kB
> >
> >
> >
> > 3. DT:
> >         memory {
> >                 reg =3D <0x00300000 0x1FD00000>; /* 512 - 3 MB */
> >         };
> > no modify @ arch/arm/Makefile
> >
> > bootlog & meminfo :
> > [    0.000000] Zone ranges:
> > [    0.000000]   Normal   [mem 0x0000000000400000-0x000000001fffffff]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000400000-0x000000001fffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000400000-0x000000001=
fffffff]
> >
> > ~ # cat /proc/meminfo
> > MemTotal:         511964 kB
> > MemFree:          489636 kB
> > MemAvailable:     486292 kB
> >
> >
> >
> > I think method 1 should be correct (compare method 2) & better (compare=
 method 3).
> >
