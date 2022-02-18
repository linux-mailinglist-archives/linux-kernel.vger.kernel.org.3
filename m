Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC14BBE41
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbiBRRUg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 12:20:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiBRRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:20:33 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE82B523A;
        Fri, 18 Feb 2022 09:20:15 -0800 (PST)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M433w-1nL6vW1Ka0-0000YL; Fri, 18 Feb 2022 18:20:14 +0100
Received: by mail-wr1-f51.google.com with SMTP id o24so15715965wro.3;
        Fri, 18 Feb 2022 09:20:14 -0800 (PST)
X-Gm-Message-State: AOAM530OYnMBKHbPQ5PIPh98PvvQPli1FCBmJWBXGvhJh8lEESIVKzww
        f3OtYCpkRpXUBJqQzNpHjowtm/A3qhaEHVij2w0=
X-Google-Smtp-Source: ABdhPJw+uQLrWDPTpaVZ2hg+LNvKUOpuIxEMj1NjckGcj0wwgwCnAHT9Xg0He56mfzVIg4cUyUq5DUDOvJoCst25FuU=
X-Received: by 2002:adf:cf0c:0:b0:1e6:22fe:4580 with SMTP id
 o12-20020adfcf0c000000b001e622fe4580mr6693423wrj.12.1645204813909; Fri, 18
 Feb 2022 09:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20220113170755.11856-1-pali@kernel.org> <CAK8P3a2D8Yv+KpM4NJyP9mosieqbhHh08=mdEy+OA84Vx6FVCQ@mail.gmail.com>
 <20220218165530.j62nafuofe342sfi@pali>
In-Reply-To: <20220218165530.j62nafuofe342sfi@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Feb 2022 18:19:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1CHRztMCOFN6iomVf2J7_9qRi4GdZBQfDyhjqDb1Z0Vw@mail.gmail.com>
Message-ID: <CAK8P3a1CHRztMCOFN6iomVf2J7_9qRi4GdZBQfDyhjqDb1Z0Vw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Increase PCIe IO size
 from 64 KiB to 1 MiB
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:sAedr4StlE0AfwTwvazt/sikNnozQKkTmku1eP7cz5Bfac//0Fo
 K7Jz/P3gEMu0ocfrTr2srvZFAiAmUNOWP8D2LGC6fS0aELv/M0fKqEd+bIcM1wNaTmqyhEy
 1+Qd+ZcC5M2wxsd6dcMWB9I3Vdr78BCdaI6MrHwife9OWnGMpItvhXzN6/e8IG4r8twU/5o
 G/Vzk5VQd2iTv+HCYJgaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bAYExVEZUsI=:sm2JTVg0I7xsOYmC/Klq1b
 QVRElotdl8y0+Gz3ocWShaGaDBJl4PDpB/Dc8GyfVzmnDI6c4GKoUTldiD2osEKif67zK6GDo
 +8XG6QKUGejPYHekM4bQk7zmjN210jCdh83ZtBd47pgvKb2H/2MqtZXoaiz5W8R8pxfN7S/PL
 Yz8cmODWnp9c5OXIRcyXjy7sedXbaN/YcHhvGrfzGsrfTLEMqB9wDZ3Oeb24W9l0VliqKZwVd
 8a0x8GATkvmWnMrGsoMYK+mSjj0KR7cqQQhAl0zjCGFGHOgfRtTDG2YbvDutDAJBHyvx2KQgW
 zOqUXDMG8HT5CfhFtWGJA5H4/AI2L8WBkusVev51GhwbVe5anRPxQUku2BXIgHoWtnCyK2bZu
 dO3O8nbskjo9GYQs4VQfOMhu6+a2iXys/614lcN4eL2uIMA5k+JHBPbRiC6JI53ccOixx5NoG
 qj+q7uHk8COqTEhZQQ84xslOWpCZsDKvFv7hBNfKBMAgXhnY7QROn2uNw6CEupQK8yBSdsRm7
 Pozv9PTLYC8schHEo3UyKviXej1CKey9bHBAAO3lWXV3EjaaCXGcmTOgX6kceWxO2USGYTOZ3
 y2fpUaYrCB1KHMWpzlVDW+MHhlSUowhBJQRHtuzHB+yLfp3kyzx7onR3kNUDU+P9UL3htAque
 3WJHU7OqHz4dESkzAqh+98kQrrpnzg/eCNUZyfUMUjQAJu0esAKajSHL/Iap0WASdxD5/TcFx
 9llyar/WKPS9Sy3eMdQq6bbFrVtnAsU1bDNhC7K0QZbrUd5warO6Ov9sYAgl7YCywHGL4TN4b
 8uZMBXT8mwb1TQfnmjrw5pKbCBTXDjrf8ndVgnoXhTL0+/hB/Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 5:55 PM Pali Rohár <pali@kernel.org> wrote:
> On Friday 18 February 2022 17:43:04 Arnd Bergmann wrote:
> > On Thu, Jan 13, 2022 at 6:07 PM Pali Rohár <pali@kernel.org> wrote:
> > >
> > > Commit 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM
> > > space") increased size of PCIe MEM to 127 MiB, which is the maximal
> > > possible size for allocated 128 MiB PCIe window. PCIe IO size in that
> > > commit was unchanged.
> > >
> > > Armada 3720 PCIe controller supports 32-bit IO space mapping so it is
> > > possible to assign more than 64 KiB if address space for IO.
> > >
> > > Currently controller has assigned 127 MiB + 64 KiB memory and therefore
> > > there is 960 KiB of unused memory. So assign it to IO space by increasing
> > > IO window from 64 KiB to 1 MiB.
> > >
> > > DTS file armada-3720-turris-mox.dts already uses whole 128 MiB space, so
> > > only update comment about 32-bit IO space mapping.
> > >
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Fixes: 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM space")
> >
> > I just saw this is the fixes pull request, and it seems very odd. Does this
> > fix an actual bug?
>
> Do you mean this patch or commit 514ef1e62d65?

This one. 514ef1e62d65 looks fine.

> > Note that Linux normally doesn't map more than 64KB
> > of I/O space per PCI domain, so it should not make a difference to us.
>
> Last time I looked into ARM code, it can allocate more than 64 kB for IO.



> > Also, note that having a high bus address for the I/O space (0xefff0000,
> > as as the CPU physical address here) means that a lot of the older
> > devices that actually require I/O space won't work, because they need a
> > low bus address in the first few KB.
> >
> > Is this mapping a requirement from a broken bootloader, or can you change
> > the mapping of the I/O port window in the physical space to the usual
> > bus address 0?
>
> At physical address 0x0 it is not possible as at this address is mapped
> DDR.

I meant bus address 0, not CPU physical address 0 of course. We don't
care where in physical space the I/O window is.

> ARM Trusted-Firmware sets PCIe space to range [0xe8000000-0xf0000000].
> This (default) configuration is specified in DTS file. Which parts of
> this range is used for IO and which MEM is up to the a3720 PCIe kernel
> driver and currently it configures it based on how sub-ranges are
> specified in DT.
>
> In some cases (e.g. when board has 4 GB of RAM), TF-A relocates this
> PCIe range to different location (otherwise it cannot activate more than
> 2 GB of RAM) and U-Boot during loading of kernel DTB file, is patching
> it.
>
> It could be possible to change TF-A code to move PCIe space to different
> location (from [0xe8000000-0xf0000000]) but not to 0x0. But changing it
> means to move other parts and invent mapping in which most of RAM can be
> mapped to...

Can't you change the mapping to have a bus address that is different
the physical address?

       Arnd
