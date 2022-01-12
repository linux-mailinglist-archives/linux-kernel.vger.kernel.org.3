Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E58848BEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 07:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351066AbiALG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 01:58:05 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:11815 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbiALG6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1641970684; x=1673506684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQh0O6/rKCnMFoyxGgyrGDbzM2AaqxxNNOy8TopRhYI=;
  b=NY2f7nFDWL8k9rb4XB5Kyoo4E8n89OpAeR00NYoutbsXRzsSx2UkG/jC
   oP/7G+MgwpKAEIPK00sxKNI/bjY4kVPs8+dA+4wi+VriyJMeW1ROsHq3R
   VRpuCNyx/CRyKPleFZB9RXSGFDUOFfkFUyA6a/K2wXwxlQb5sgFZQxima
   A5Nxz0Luk6f6jehQ41m+d/eHPgPo/TS+IEwQUGCmCyRrND4espea4/c0d
   NELVvlMVFMdv8e/aHIhVhwG0eciWTdCgZRvL7P9HAxM9bGQHMeuJLom3c
   duonuYDTMPqLuoWRVrwg2kjhorrnpqx30sXrofB7Gpajj9rtwSR0i3TQY
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208";a="21444560"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Jan 2022 07:58:03 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 12 Jan 2022 07:58:03 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 12 Jan 2022 07:58:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1641970683; x=1673506683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQh0O6/rKCnMFoyxGgyrGDbzM2AaqxxNNOy8TopRhYI=;
  b=j8Ih41gbJu6jpumQSAx/J1QcoOvCoad9fLuOFmrp3SaDx2yq8rfcpBkx
   n2NExLfeaILJVzxqI4YezQn9DVSi9M4YX/lFET6besfuBBiJE9TNeTgeO
   7Ge/MpCR+2GXn9NzivdMkYY3J2v4eWrIdy3E8ciNa7Z598l6fnl0Gue5g
   zahCnXhkHX37nsuAW6c4w2xZCz65c01SlWeQvKRADifDJ0KR4gZQc9lXU
   eN8DQdIhkuztx9fhq/2jV7Uk4ejtGOJBBVlrq9ElLj+UdK7aKRYZljWzd
   vyR4GOpIeLDOMq92mB4L8TjfcrFqIURjp6hOWDy5JRHNoLjuh6Ye+9DKA
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208";a="21444559"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Jan 2022 07:58:03 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2AF1B280065;
        Wed, 12 Jan 2022 07:58:03 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH] arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlays for serial modes
Date:   Wed, 12 Jan 2022 07:58:00 +0100
Message-ID: <6686721.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAJ+vNU2PxF=9VwMv4f8N5W5Gs2Ynxdn9jHTSkWH7zd3Fo5hBiw@mail.gmail.com>
References: <20211214213630.14819-1-tharvey@gateworks.com> <2226437.ElGaqSPkdT@steina-w> <CAJ+vNU2PxF=9VwMv4f8N5W5Gs2Ynxdn9jHTSkWH7zd3Fo5hBiw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Januar 2022, 18:53:29 CET schrieb Tim Harvey:
> On Mon, Jan 10, 2022 at 11:20 PM Alexander Stein
> 
> <alexander.stein@ew.tq-group.com> wrote:
> > Am Dienstag, 11. Januar 2022, 01:00:21 CET schrieb Tim Harvey:
> > > [SNIP]
> > > 
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > > b/arch/arm64/boot/dts/freescale/Makefile index
> > > > a14a6173b765..5ec8d59347b6
> > > > 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -44,6 +44,9 @@ dtb-$(CONFIG_ARCH_MXC) +=
> > > > imx8mm-var-som-symphony.dtb
> > > > 
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> > > > 
> > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtbo
> > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtbo
> > > > 
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
> > > 
> > > [SNIP]
> > > I'm mostly interested to see if my approach to dt fragments here and
> > > the naming of the files makes sense to others.
> > > 
> > > This patch causes the kernel to build dtbo files for:
> > > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> > > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtbo
> > > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtbo
> > > 
> > > The intention is that these files are used by boot firmware (U-Boot)
> > > to adjust the dtb before passing it to the kernel.
> > 
> > Hi Tim,
> > 
> > do these dtbo actually work? I'm wondering because I was trying to
> > useoverlays myself and noticed that the had to be compiled with -@ for
> > u-boot to be able
> > to apply them. Apparently there are 2 possibilities:
> Alexander,
> 
> Yes, they work, but I do manually set DTC_FLAGS=-@ when building
> kernel dtbs to make them work.

I see, I expected something like this. That's why I responded to you.

> > * Set "DTC_FLAGS_[dtb] := -@" yourself
> > See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > commit/?id=e426d63e752bdbe7d5ba2d872319dde9ab844a07
> > 
> > * Use dedicated overlay target
> > See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > commit/?id=15d16d6dadf6947ac7f9a686c615995c5a426ce2
> > 
> > You use neither of them. IIRC just naming the target file .dtbo will not
> > apply symbols (-Q) during dtc call. Can you verify using 'V=1'
> > Also I'm wondering which way is the best to go.
> 
> I wasn't aware there was a way to do this via Makefiles. It seems that
> perhaps Rob's approach with 'kbuild: Add generic rule to apply
> fdtoverlay' is a way to avoid having to add them all manually in the
> first approach? I must admit I'm not sure how to use that.

I tried using this myself for my custom board. I feel it is a bit cumbersome 
to get it right.
See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
arch/arm64/boot/dts/xilinx/Makefile for an example.

Essentially you define your .dtb as before and add another target (e.g. sm-
k26-revA-sck-kv-g-revA-dtbs) where you add your .dtbo _after_ the original 
.dtb. This target needs to be added to 'dtb-y' as before.

I suspect this way is needed to check the .dtbo against the base .dtb if it 
actually matches.

HTH
Alexander




