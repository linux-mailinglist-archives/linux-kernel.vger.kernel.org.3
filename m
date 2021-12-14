Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586BD473A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbhLNCEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:04:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40152 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbhLNCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:04:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95D57B8122A;
        Tue, 14 Dec 2021 02:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BD1C34603;
        Tue, 14 Dec 2021 02:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639447477;
        bh=t719aQBdqthRCMd09G9nJzrJtwmP+k0r75AlquttTKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OL6eyJ2fqcDfo54yWNciMGtz2ZOA61bRGZAVRIzKEtDnAwORRAXAl+coHk6j5Mrgv
         jrK/T5b/0fQb+fe9KU99x0kyOawkPWtWZPkzzeht2wX/gPZbJP7g4UQ+HEbfBjV4pb
         vJC6X+PCztYwyCbT3mR/Zip0EsXI3s1KMH2vQYP83EhufwHsZ/fUPg/SLJcK0x50mb
         j4D6nF99Gxf9DBJRLO87ue3rfrLu2v/bx4xNPPhk6En6irf4e2yafcRyiNdJ3EXr4h
         aZf9F7byWrLAd/JtjY9MHqXmBOs+hTSEw2yzK3Rnow8524dzuNTNGYd/MsRgQO1rWJ
         uwIOdK5amcLRg==
Date:   Tue, 14 Dec 2021 10:04:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        tharvey@gateworks.com
Subject: Re: [PATCH v2 5/5] arm: dts: imx8ulz-bsh-smm-m2: Add BSH SMM-M2
 IMX6ULZ SystemMaster
Message-ID: <20211214020427.GL4216@dragon>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
 <20211123151252.143631-6-ariel.dalessandro@collabora.com>
 <20211206013531.GO4216@dragon>
 <4dbe2516-3a72-8c01-d0c9-fa4cfdddf4f6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbe2516-3a72-8c01-d0c9-fa4cfdddf4f6@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 03:15:52PM -0300, Ariel D'Alessandro wrote:
> Hi Shawn,
> 
> On 12/5/21 10:35 PM, Shawn Guo wrote:
> > On Tue, Nov 23, 2021 at 12:12:52PM -0300, Ariel D'Alessandro wrote:
> >> From: Michael Trimarchi <michael@amarulasolutions.com>
> >>
> >> Add DTS of BSH SMM-M2 SystemMaster.
> >>
> >> This version comes with:
> >> - 128 MiB DDR3 RAM
> >> - 256 MiB Nand
> >> - wifi
> >> - bluetooth
> >>
> >> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> >> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> >> ---
> >>  arch/arm/boot/dts/Makefile               |   3 +-
> >>  arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts | 153 +++++++++++++++++++++++
> >>  2 files changed, 155 insertions(+), 1 deletion(-)
> >>  create mode 100644 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
> >>
> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >> index 0de64f237cd8..e6d4ad497985 100644
> >> --- a/arch/arm/boot/dts/Makefile
> >> +++ b/arch/arm/boot/dts/Makefile
> >> @@ -693,7 +693,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
> >>  	imx6ull-phytec-segin-ff-rdk-nand.dtb \
> >>  	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
> >>  	imx6ull-phytec-segin-lc-rdk-nand.dtb \
> >> -	imx6ulz-14x14-evk.dtb
> >> +	imx6ulz-14x14-evk.dtb \
> >> +	imx6ulz-bsh-smm-m2.dts
> >>  dtb-$(CONFIG_SOC_IMX7D) += \
> >>  	imx7d-cl-som-imx7.dtb \
> >>  	imx7d-colibri-aster.dtb \
> >> diff --git a/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
> >> new file mode 100644
> >> index 000000000000..9e82860469e3
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
> >> @@ -0,0 +1,153 @@
> >> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >> +/*
> >> + * Copyright (C) 2021 BSH Hausgeraete GmbH
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include <dt-bindings/input/input.h>
> >> +#include "imx6ulz.dtsi"
> >> +
> >> +/ {
> >> +	model = "BSH SMM M2";
> >> +	compatible = "bsh,imx6ulz-bsh-smm-m2", "fsl,imx6ull";
> >> +
> >> +	chosen {
> >> +		stdout-path = &uart4;
> >> +	};
> >> +
> >> +	usdhc2_pwrseq: usdhc2_pwrseq {
> >> +		compatible = "mmc-pwrseq-simple";
> >> +		reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
> >> +		status = "okay";
> > 
> > "okay" status is generally used to flip "disabled" devices.
> 
> Fixed in v3.
> 
> > 
> >> +	};
> >> +
> >> +};
> >> +
> >> +&uart3 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pinctrl_bluetooth_uart>;
> >> +	uart-has-rtscts;
> >> +
> > 
> > Unneeded newline.
> 
> Fixed in v3.
> 
> > 
> >> +	status = "okay";
> >> +
> >> +	bluetooth {
> >> +		compatible = "brcm,bcm4330-bt";
> >> +		max-speed = <3000000>;
> >> +		shutdown-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> >> +		device-wakeup-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
> >> +		host-wakeup-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
> >> +	};
> >> +};
> >> +
> >> +&uart4 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pinctrl_debug_uart>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&usbotg1 {
> >> +	dr_mode = "peripheral";
> >> +	srp-disable;
> >> +	hnp-disable;
> >> +	adp-disable;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&usbphy1 {
> >> +	fsl,tx-d-cal = <106>;
> >> +};
> >> +
> >> +&usdhc2 {
> >> +	#address-cells = <1>;
> >> +	#size-cells = <0>;
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pinctrl_wlan>;
> >> +	bus-width = <4>;
> >> +	no-1-8-v;
> >> +	non-removable;
> >> +	cap-power-off-card;
> >> +	pm-ignore-notify;
> > 
> > What is this?
> 
> Wrong vendor property, removed in v3.
> 
> Interesting there're other cases as well:
> 
> $ git grep -w pm-ignore-notify
> arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts:       pm-ignore-notify;
> arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi:   pm-ignore-notify;
> arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts:
> pm-ignore-notify;
> arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts:
> pm-ignore-notify;
> arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi:   pm-ignore-notify;
> arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi:    pm-ignore-notify;

Thanks for the reminding!  I will fix them.

Shawn
