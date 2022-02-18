Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFC4BBE59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiBRR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:27:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiBRR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:27:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F75BFD24;
        Fri, 18 Feb 2022 09:26:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B6C61FDA;
        Fri, 18 Feb 2022 17:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8E3C340E9;
        Fri, 18 Feb 2022 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645205208;
        bh=+CsiT9aObl7pRKrN4X1EFOMytJanhfZAOxH4JPRCsTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9UlKsliY/spNXDMb9Kj4P4u/GB/CpjBzHNbnKjEW/u/ubgMEzvjrQlrTumw7Ru95
         eof51FLbxL8TH6iTBka0XtevRpu1JOGtf9y2waX4StQ+7rDbtOSBTze9BYG+oeolNk
         bH8Bl+LybFkNpCs54CPMQlWomqAd09kwobHreRMMYZ2muOGVJJphuzVpIIHwY1ysnN
         4QCAcibihVYvnA5b0lLN9osvPNHoINiH8VBHovWRBsCxjmGLyyfxKDIEIr2rM6CwgO
         r2gjt3dnSK7YNuuiG5Kpz6oKkqDy4xhqSd5TPqRO4ux2hIW0ghbyUmu0uVu4JaaYic
         aizOFdzUp63GQ==
Received: by pali.im (Postfix)
        id A0DE32BAE; Fri, 18 Feb 2022 18:26:45 +0100 (CET)
Date:   Fri, 18 Feb 2022 18:26:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Increase PCIe IO size
 from 64 KiB to 1 MiB
Message-ID: <20220218172645.rfp3526mp3zp4yzm@pali>
References: <20220113170755.11856-1-pali@kernel.org>
 <CAK8P3a2D8Yv+KpM4NJyP9mosieqbhHh08=mdEy+OA84Vx6FVCQ@mail.gmail.com>
 <20220218165530.j62nafuofe342sfi@pali>
 <CAK8P3a1CHRztMCOFN6iomVf2J7_9qRi4GdZBQfDyhjqDb1Z0Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1CHRztMCOFN6iomVf2J7_9qRi4GdZBQfDyhjqDb1Z0Vw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 February 2022 18:19:57 Arnd Bergmann wrote:
> On Fri, Feb 18, 2022 at 5:55 PM Pali Rohár <pali@kernel.org> wrote:
> > On Friday 18 February 2022 17:43:04 Arnd Bergmann wrote:
> > > On Thu, Jan 13, 2022 at 6:07 PM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > Commit 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM
> > > > space") increased size of PCIe MEM to 127 MiB, which is the maximal
> > > > possible size for allocated 128 MiB PCIe window. PCIe IO size in that
> > > > commit was unchanged.
> > > >
> > > > Armada 3720 PCIe controller supports 32-bit IO space mapping so it is
> > > > possible to assign more than 64 KiB if address space for IO.
> > > >
> > > > Currently controller has assigned 127 MiB + 64 KiB memory and therefore
> > > > there is 960 KiB of unused memory. So assign it to IO space by increasing
> > > > IO window from 64 KiB to 1 MiB.
> > > >
> > > > DTS file armada-3720-turris-mox.dts already uses whole 128 MiB space, so
> > > > only update comment about 32-bit IO space mapping.
> > > >
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > Fixes: 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM space")
> > >
> > > I just saw this is the fixes pull request, and it seems very odd. Does this
> > > fix an actual bug?
> >
> > Do you mean this patch or commit 514ef1e62d65?
> 
> This one. 514ef1e62d65 looks fine.

Well, this patch just increase size of IO window, nothing more. What
what is wrong with this patch if is just moves end of the window?

> > > Note that Linux normally doesn't map more than 64KB
> > > of I/O space per PCI domain, so it should not make a difference to us.
> >
> > Last time I looked into ARM code, it can allocate more than 64 kB for IO.
> 
> 
> 
> > > Also, note that having a high bus address for the I/O space (0xefff0000,
> > > as as the CPU physical address here) means that a lot of the older
> > > devices that actually require I/O space won't work, because they need a
> > > low bus address in the first few KB.
> > >
> > > Is this mapping a requirement from a broken bootloader, or can you change
> > > the mapping of the I/O port window in the physical space to the usual
> > > bus address 0?
> >
> > At physical address 0x0 it is not possible as at this address is mapped
> > DDR.
> 
> I meant bus address 0, not CPU physical address 0 of course. We don't
> care where in physical space the I/O window is.

Currently all mapping between CPU and PCIe is 1:1.

There are registers for adding remapping, but nobody played with it yet.
And it needs to be done again in TF-A (or probably in U-Boot could be too).

> > ARM Trusted-Firmware sets PCIe space to range [0xe8000000-0xf0000000].
> > This (default) configuration is specified in DTS file. Which parts of
> > this range is used for IO and which MEM is up to the a3720 PCIe kernel
> > driver and currently it configures it based on how sub-ranges are
> > specified in DT.
> >
> > In some cases (e.g. when board has 4 GB of RAM), TF-A relocates this
> > PCIe range to different location (otherwise it cannot activate more than
> > 2 GB of RAM) and U-Boot during loading of kernel DTB file, is patching
> > it.
> >
> > It could be possible to change TF-A code to move PCIe space to different
> > location (from [0xe8000000-0xf0000000]) but not to 0x0. But changing it
> > means to move other parts and invent mapping in which most of RAM can be
> > mapped to...
> 
> Can't you change the mapping to have a bus address that is different
> the physical address?
> 
>        Arnd

That could be possible, need to investigate... but I think it would be
done in bootloader and then by patching DTB file on the fly.
