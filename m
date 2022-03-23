Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B04E516D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiCWLly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiCWLlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:41:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A01F37BFA;
        Wed, 23 Mar 2022 04:40:23 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5BBE9DE;
        Wed, 23 Mar 2022 12:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648035621;
        bh=5FOLOdg+keD5Ld/XWJRitYJ2sdA0NV1UdHW91zVIQUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejqiD13TJqkZgPtorZNlN1ohTk7uThUVwbsscLWBstcMN0B9ihBmRfUIO4GT2tOLG
         MtrIPwKRxixEmba/MKTL0kzuC11N2LnUnZ7KrkGWb0Dzt/L93jjvHJQx4tc5zhE8KC
         ryP6udTdkiqZGAnZhcfatZUaZ3CjAUailWlQT7oQ=
Date:   Wed, 23 Mar 2022 13:40:03 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "reinhold.mueller@emtrion.com" <reinhold.mueller@emtrion.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alexandru.marginean@nxp.com" <alexandru.marginean@nxp.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: freescale: add initial support for
 verdin imx8m plus
Message-ID: <YjsHE9fDFye0+O5T@pendragon.ideasonboard.com>
References: <20220317160122.341484-1-marcel@ziswiler.com>
 <20220317160122.341484-4-marcel@ziswiler.com>
 <YjpVlmEGewIGE3WR@pendragon.ideasonboard.com>
 <4c5f438da678097642d9442e5d672a8423ef5804.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c5f438da678097642d9442e5d672a8423ef5804.camel@toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Wed, Mar 23, 2022 at 10:55:33AM +0000, Marcel Ziswiler wrote:
> On Wed, 2022-03-23 at 01:02 +0200, Laurent Pinchart wrote:
> > On Thu, Mar 17, 2022 at 05:01:22PM +0100, Marcel Ziswiler wrote:
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > This patch adds the device tree to support Toradex Verdin iMX8M Plus [1]
> > > a computer on module which can be used on different carrier boards.
> > > 
> > > The module consists of an NXP i.MX 8M Plus family SoC (either i.MX 8M
> > > Plus Quad or 8M Plus QuadLite), a PCA9450C PMIC, a Gigabit Ethernet PHY,
> > > 1, 2, 4 or 8 GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC, an I2C EEPROM, an
> > > RX8130 RTC, an optional I2C temperature sensor plus an optional
> > > Bluetooth/Wi-Fi module.
> > > 
> > > Anything that is not self-contained on the module is disabled by
> > > default.
> > > 
> > > The device tree for the Dahlia includes the module's device tree and
> > > enables the supported peripherals of the carrier board.
> > > 
> > > The device tree for the Verdin Development Board includes the module's
> > > device tree as well as the Dahlia one as it is a superset and supports
> > > almost all peripherals available.
> > > 
> > > So far there is no display functionality supported at all but basic
> > > console UART, USB host, eMMC and Ethernet functionality work fine.
> > > 
> > > [1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-plus
> > > 
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > ---
> > > 
> > >  arch/arm64/boot/dts/freescale/Makefile        |    4 +
> > >  .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  125 ++
> > >  .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |   44 +
> > >  .../imx8mp-verdin-nonwifi-dahlia.dts          |   18 +
> > >  .../freescale/imx8mp-verdin-nonwifi-dev.dts   |   18 +
> > >  .../dts/freescale/imx8mp-verdin-nonwifi.dtsi  |   54 +
> > >  .../freescale/imx8mp-verdin-wifi-dahlia.dts   |   18 +
> > >  .../dts/freescale/imx8mp-verdin-wifi-dev.dts  |   18 +
> > >  .../dts/freescale/imx8mp-verdin-wifi.dtsi     |   82 +
> > >  .../boot/dts/freescale/imx8mp-verdin.dtsi     | 1373 +++++++++++++++++
> > >  10 files changed, 1754 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dts
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dts
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dts
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dts
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi

[snip]

> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-
> > > verdin.dtsi
> > > new file mode 100644
> > > index 000000000000..26d6c2819ee8
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> > > @@ -0,0 +1,1373 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > > +/*
> > > + * Copyright 2022 Toradex
> > > + */
> > > +
> > > +#include "dt-bindings/pwm/pwm.h"
> > > +#include "imx8mp.dtsi"
> > > +
> > > +/ {
> > > +       chosen {
> > > +               stdout-path = &uart3;
> > > +       };
> > > +
> > > +       aliases {
> > > +               /* Ethernet aliases to ensure correct MAC addresses */
> > > +               ethernet0 = &eqos;
> > > +               ethernet1 = &fec;
> > 
> > On Dahlia the ethernet connector is routed to the eqos if I'm not
> > mistaken.
> 
> Yes, actually the on-module PHY which is what is routed to the RJ-45 on Dahlia uses the EQOS MAC, correct.
> 
> > On my board U-Boot considers this to be the second ethernet
> > controller, with the fec being the first one.
> 
> Yes, however, U-Boot does use the EQOS one as primary MAC as well. This is just how U-Boot does things. There
> is no easy way to change the actual instance numbering. Actually just like on Linux really with the one
> difference that U-Boot will always show both independent whether or not your carrier board even has the second
> PHY or not. This is due to U-Boot doing lazy loading aka not touch any Ethernet hardware unless you actually
> run some network commands.
> 
> > The mismatch results in
> > the MAC addresses being swapped between eth0 and eth1 when comparing
> > U-Boot and Linux.
> 
> No, this alias should really be what ensures the correct MAC addresses.
> 
> > Am I using a too old boot loader, or should the two
> > ethernet controlls be swapped here ?
> 
> Yes, I guess you might not be using latest mainline U-Boot. I just verified this on my table again having both
> the Dahlia and Verdin Development carrier boards available. Please note that on the Verdin Development Board
> the primary Ethernet is also called eth1. Unfortunately, changing this naming is also not entirely trivial. But
> it really should have the proper MAC address.

I've updated U-Boot to 2022-rc4 and I confirm it now works fine.

> Dahlia
> 
> U-Boot 2022.04-rc4-00068-g5f68470d69 (Mar 23 2022 - 10:15:46 +0100)
> 
> Verdin iMX8MP # echo $ethaddr
> 00:14:2d:6c:71:64
> => verified with wireshark
> 
> root@verdin-imx8mp-07106916:~# ip addr
> ...
> 4: eth0: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
>     link/ether 00:14:2d:6c:71:64 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.10.239/24 brd 192.168.10.255 scope global eth0
>        valid_lft forever preferred_lft forever
>     inet6 fe80::214:2dff:fe6c:7164/64 scope link 
>        valid_lft forever preferred_lft forever
> ...
> 
> Verdin Developer Board
> 
> U-Boot 2022.04-rc4-00068-g5f68470d69 (Mar 23 2022 - 10:15:46 +0100)
> 
> Verdin iMX8MP # echo $ethaddr  
> 00:14:2d:6c:71:64
> => verified with wireshark
> 
> root@verdin-imx8mp-07106916:~# uname -a
> Linux verdin-imx8mp-07106916 5.17.0-rc8-next-20220317-00003-g695dc7d13c2a #12 SMP PREEMPT Thu Mar 17 16:07:49
> CET 2022 aarch64 aarch64 aarch64 GNU/Linux
> 
> root@verdin-imx8mp-07106916:~# ip addr
> ...
> 2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
>     link/ether 00:14:2d:7c:71:64 brd ff:ff:ff:ff:ff:ff
> ...
> 5: eth1: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
>     link/ether 00:14:2d:6c:71:64 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.10.239/24 brd 192.168.10.255 scope global eth1
>        valid_lft forever preferred_lft forever
>     inet6 fe80::214:2dff:fe6c:7164/64 scope link 
>        valid_lft forever preferred_lft forever
> ...
> 
> > > +               rtc0 = &rtc_i2c;
> > > +               rtc1 = &snvs_rtc;
> > > +       };
> > 
> > [snip]
> > 
> > With these issues addressed,
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks again!

-- 
Regards,

Laurent Pinchart
