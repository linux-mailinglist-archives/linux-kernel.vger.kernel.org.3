Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4EE48A84A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbiAKHUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:20:07 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:10013 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233066AbiAKHUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1641885606; x=1673421606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Jyu/v5o+vrp+3w/SDYYyY+040QxdlcF7dPATNH70YY=;
  b=gVSMLqDA/+3EI+ADbvB1B7iyKfv6v8p1hWpMkHNVlyDMXrYBzSqqJSIg
   fqkA2H/QbRnMjK7xk+x2jMLNjWVaz+92DCigr6sJzCUklZAnF4IYbJuQm
   80CuWW8pdzdwr5TiEYanF5tGeaj3nO1Yr6BqFUltVhZSraL42lv73JIHX
   aavQmz/MK1w4St8h7NGaK4Mjc2thF/cToWleYC8GQacVCu1pIq1AXFilw
   z9BdB0ff4Y09ivS0rkFb94o8JxsPiiwAK+6/N7qO164is25nYId5wUAwP
   HZNcO2SRIi3Rc5C+hSRgTEZhuHHUj3mfJJ1D/1CwA9lnl/wpd9quQcnRK
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,279,1635199200"; 
   d="scan'208";a="21419129"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Jan 2022 08:20:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 11 Jan 2022 08:20:05 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 11 Jan 2022 08:20:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1641885605; x=1673421605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Jyu/v5o+vrp+3w/SDYYyY+040QxdlcF7dPATNH70YY=;
  b=mImTkfGmWhTa5RFiG3xqVVSjwgAI1LZUvKi0XIHdgYU8Zm6qcUKmUQsi
   TvPt56HycPYVu1Tnz56KlkuWZ9KXy/YWcywQ73zemf/wBiN9fm9v7tg0y
   eEoWnBaKApayIQbueD7cWVPSf+uMrMszryddorLvWzSl0lEneX5ZZqC57
   E1EnT37MxwmcuoY+HqAOR0XFrMFn7U3TmbnDAUrimKJVGBPa+JOR+APFL
   MfnXChOGpusAfSWZf6Eskz08QPV8FXnEXpA4xrc9/xrK9CMBTtmTYN+ZZ
   wNJYdyEgQ/uTDY2zJBj6ocpI19nABSiAS+UDcHyWkLgDY5DmIg1SptL41
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,279,1635199200"; 
   d="scan'208";a="21419127"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Jan 2022 08:20:04 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 152F8280065;
        Tue, 11 Jan 2022 08:20:04 +0100 (CET)
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
Subject: Re: (EXT) Re: [PATCH] arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlays for serial modes
Date:   Tue, 11 Jan 2022 08:20:01 +0100
Message-ID: <2226437.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAJ+vNU0U7HknAZcnua39r9to+kJBea6Fg3NiJ9ybZ1xygKoF4g@mail.gmail.com>
References: <20211214213630.14819-1-tharvey@gateworks.com> <CAJ+vNU0U7HknAZcnua39r9to+kJBea6Fg3NiJ9ybZ1xygKoF4g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Januar 2022, 01:00:21 CET schrieb Tim Harvey:
> [SNIP]
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile index a14a6173b765..5ec8d59347b6
> > 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -44,6 +44,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> > 
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> > 
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtbo
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtbo
> > 
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
> > 
> [SNIP]
> I'm mostly interested to see if my approach to dt fragments here and
> the naming of the files makes sense to others.
> 
> This patch causes the kernel to build dtbo files for:
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtbo
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtbo
> 
> The intention is that these files are used by boot firmware (U-Boot)
> to adjust the dtb before passing it to the kernel.

Hi Tim,

do these dtbo actually work? I'm wondering because I was trying to useoverlays 
myself and noticed that the had to be compiled with -@ for u-boot to be able 
to apply them. Apparently there are 2 possibilities:
* Set "DTC_FLAGS_[dtb] := -@" yourself
See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
commit/?id=e426d63e752bdbe7d5ba2d872319dde9ab844a07

* Use dedicated overlay target
See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
commit/?id=15d16d6dadf6947ac7f9a686c615995c5a426ce2

You use neither of them. IIRC just naming the target file .dtbo will not apply 
symbols (-Q) during dtc call. Can you verify using 'V=1'
Also I'm wondering which way is the best to go.

Best regards,
Alexander



