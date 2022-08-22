Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931B359B81F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiHVDq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHVDq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:46:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8652495F;
        Sun, 21 Aug 2022 20:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2BC1B80E72;
        Mon, 22 Aug 2022 03:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DACC433C1;
        Mon, 22 Aug 2022 03:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661140012;
        bh=RFNZNQQXYq+W/Ztgxu7x4hbjSIwxCSoZZrUPT41imIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGMxNHjn3gG/7V0VA+yKPhFhWlDsBcgfxKxV9wuJkzusw8Nh00Jkf1LCh+bk1uBNV
         Va1C/uvFXwhsHF/jCNyD8/4FQJsqtWOit/WJT2+31FNftgDNOZPQoi6xK+K26vrtNE
         DRmoOK7QPrHFGrpxE3AK8dQYuFGtIirUy5XMP6dYtrFtJTBRRuac63ZtJ3kTdMXFkc
         Uig5pbzkIxgEla2JdpfO4qFiYYUni2/TTLDOXDCK9ZBPYjCXKzrg+n8JV7lNLTg9U9
         i5VXUMhox3AGX73fx4SaVf3LSYFvs6bneBvGssGUwmIK5f+Pp91ASUY+B1RrNM47MC
         8i5wUynVflSrg==
Date:   Mon, 22 Aug 2022 11:46:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Santan Kumar <santan.kumar@nxp.com>,
        Tao Yang <b31903@freescale.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Abhimanyu Saini <abhimanyu.saini@nxp.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: ls2081a-rdb: Add DTS for NXP
 LS2081ARDB
Message-ID: <20220822034646.GT149610@dragon>
References: <20220817204357.21753-1-leoyang.li@nxp.com>
 <20220817204357.21753-5-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817204357.21753-5-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:43:55PM -0500, Li Yang wrote:
> From: Priyanka Jain <priyanka.jain@nxp.com>
> 
> This patch adds support for NXP LS2081ARDB board which has LS2081A SoC.
> 
> LS2081A SoC is 40-pin derivative of LS2088A SoC. From functional
> perspective both are same. Hence, LS2088a SoC dtsi file is included
> from LS2081ARDB dts.
> 
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Santan Kumar <santan.kumar@nxp.com>
> Signed-off-by: Tao Yang <b31903@freescale.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/fsl-ls2081a-rdb.dts    | 131 ++++++++++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 2cf55534c162..bf7c448fa817 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-ten64.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2081a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> new file mode 100644
> index 000000000000..0148f8c93442
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for NXP LS2081A RDB Board.
> + *
> + * Copyright 2017 NXP
> + *
> + * Priyanka Jain <priyanka.jain@nxp.com>
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "fsl-ls2088a.dtsi"
> +
> +/ {
> +	model = "NXP Layerscape 2081A RDB Board";
> +	compatible = "fsl,ls2081a-rdb", "fsl,ls2081a";
> +
> +	aliases {
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +};
> +
> +&dspi {
> +	status = "okay";
> +
> +	n25q512a: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <3000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&esdhc {
> +	status = "okay";
> +};
> +
> +&ifc {
> +	status = "disabled";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	pca9547: mux@75 {
> +		compatible = "nxp,pca9547";
> +		reg = <0x75>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x1>;

Have a newline between properties and child node.

Shawn

> +			rtc@51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +			};
> +		};
> +
> +		i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			ina220@40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <500>;
> +			};
> +		};
> +
> +		i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			adt7481@4c {
> +				compatible = "adi,adt7461";
> +				reg = <0x4c>;
> +			};
> +		};
> +	};
> +};
> +
> +&qspi {
> +	status = "okay";
> +
> +	s25fs512s0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +	};
> +
> +	s25fs512s1: flash@1 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +		spi-max-frequency = <20000000>;
> +		reg = <1>;
> +	};
> +};
> +
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&sata1 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> -- 
> 2.37.1
> 
