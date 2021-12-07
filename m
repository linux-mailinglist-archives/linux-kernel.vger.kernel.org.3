Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64A46B6C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhLGJPg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 04:15:36 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhLGJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:15:34 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MkYkC-1m8mpL3sj8-00m5cI; Tue, 07 Dec 2021 10:12:01 +0100
Received: by mail-wm1-f54.google.com with SMTP id o29so10172384wms.2;
        Tue, 07 Dec 2021 01:12:01 -0800 (PST)
X-Gm-Message-State: AOAM530zZJ3crpckAZcNfwMIytnpN9JV+3f4hvR/coiNjDMNZayMlQxa
        Zfbmlgvv5Pto8w8kYp6wetjYs1HUvpCqugNBxgA=
X-Google-Smtp-Source: ABdhPJyLD3fDYV1EW4Zm6vqp1Sp5Hf4e0+yxPNK4sUEqwqNGTd2WHKtiQ0eZ5FrFkSBhgxRt35VAPgMt79GF3b9WHYk=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr5555654wmn.98.1638868321375;
 Tue, 07 Dec 2021 01:12:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638515726.git.qinjian@cqplus1.com> <eabfe1b84b889e4aa95e24c30a114c68ef95fd07.1638515726.git.qinjian@cqplus1.com>
 <CAK8P3a1_coAnp8P3L2UA+smxuRL9widFQv9Y5ZZ0X_Sr9zsZtg@mail.gmail.com> <88f8cc0b1334467aae7a5a4b0643176a@cqplus1.com>
In-Reply-To: <88f8cc0b1334467aae7a5a4b0643176a@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Dec 2021 10:11:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1-4XnrkWc_0SPns9xj9Yp4xWhEahLOkeafXmAYWfbYJA@mail.gmail.com>
Message-ID: <CAK8P3a1-4XnrkWc_0SPns9xj9Yp4xWhEahLOkeafXmAYWfbYJA@mail.gmail.com>
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
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:sNHnA4/Asw/xz23w6NSZQg8Q28Ul/VtKss29494Duj7/bYvo1Jx
 4boj1hdADDpyK6Xugmxb7dZ3mK+fi+2GBf9EZJXDrx/gYzSVfsRU0jzqKG2MJx6cu6C1tjm
 etRlKFr3y3bMoJ80krpDD5FY0sEubBo5OatxGC54EX+22+QARpuZTHnZtPsqbJW6J6CGWGJ
 TDXD5PVEoJHY4cxaeXQYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Jaz6qJBQCQ=:SDgjtEI9BbzKP3/WncCRii
 OVXDWSifegq4bMw+ZvQ61ClC1qa3FJ2XLvqC8DZMCuZLdzR9LS9g5ZOJ1aKz3TMUnXBX4wPmD
 yKUoPaVXQY71Ym5OOQshYzlhO15Q1ArWsZcgdAcA8Q4cCWpsr5wHjrlt+aE/a1WAGjyGYF1Jd
 PG7G33IQf+dWITa3x0nI697UyJ9TF1rjtbhtujurD+63fpPM6UctZ59zEurwAtBdG35Jo5bwS
 7Nd/H05rPhFMxKKVwZGRrbTwzG2pHuoiUO6ljh2aV46MSJgn+42kHzGQ5uWZAzWypeuBK09Ib
 RMfE6cWAcJ5nEPNQ8Uy116glqyab677VXN9h6SmFP7F8heXOyGaJP4+wbyHfc6XmT1XRnCPnJ
 E+IO8x6kcPIW/l6RL4JJTyE0RFMs5wQPAT1PbvDJlgl9kxBebto191LzZokBGFEMOxPiaxxtO
 Tl9K84b7sEbf3kUU3OzBdlqD+mK+a/xNpKrz9apZfBUcZlORWBNlb9YNjtPB3dICCzr8GHzw3
 KSPC/7XSGI4T1tc7YXugo3YL58vBYvHnp8J2XdA9F4GH7yPYp8G+zE1IZg+LDLcNRFR8T8aM2
 0T4as4Y1F0+dBF/VlzNSRKMUj2Fh+kkjiUn9bGV3xvq3YPzch1K45ybN/L4q1QqwnnLEvSBYu
 RcOJMys7UfV2TL1GPV4EmM6QvR4AhHP0+Utf+js+Mh7cSWHaVoQXmKuJLeGhnlnOUS6QHcn7h
 aYpaGJgFst2Gl4mafdlNU/ylNbjFBsGdR100Xt2uDD18Jf8rtyL6yI0LkMjsVHBR4AlshGZ+H
 9IMfl9T9uIDDw36AXJjfC56uuPLVKjos90+9Y4GJcX3vxcisqU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 8:21 AM qinjian[覃健] <qinjian@cqplus1.com> wrote:
> > > @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> > >  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> > >  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
> > >  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> > > +textofs-$(CONFIG_ARCH_SUNPLUS) := 0x00308000
> >
> > What is this needed for? If it boots without this line, better avoid
> > adding it, because
> > it will increase the kernel size for everyone else (unless they also enable
> > AXXIA).
> >
>
> SP7021 reserved the 1st 1MB memory for ARM926@P-Chip using,
> The 2nd 1MB memory for IOP device and the 3rd 1MB memory for bootloader.
> I'll add these comments at next commit.

I think you can just remove the memory from the system memory map in the
device tree and pretend it only starts after the bootloader. It's been a while
since I looked at this though, so I could be misremembering what the minimum
boundaries are for doing this.

        Arnd
