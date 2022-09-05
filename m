Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7375AC851
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 02:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiIEAr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 20:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIEArx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 20:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88C123142;
        Sun,  4 Sep 2022 17:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7357260FCB;
        Mon,  5 Sep 2022 00:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D338DC433D7;
        Mon,  5 Sep 2022 00:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662338870;
        bh=0ISkgDpBocmb554mn9Xsxf+y8I7y2rmxX94tQy2sVs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJtqSToupmQfMornX9qx6FLStcpWGdWe9rLce1pc+joAx7ilCtREWkmSVhOfVhY85
         PvY4IQgoczSK8kqLi6eclk/Yr4XDNFz1eYLu3STlJdp6Zkx8lY7Idd01iPyjC9HlFq
         WAp6Ex1WkwEUocgsfjW/z7Jd8sNbs0whRhgU1OEHB6lB5E/dDUGfffRcpWSFkayKx4
         TGqmKXqfz+6OGbwWgPHRexxnbNMltcsmAtuBY2ca3OcXs8YdkObb6xr7goFHBU82L0
         pduiOB0iBITga9Igd7fImu54YmUsZ0IIgl9XdDtQrlg9dRaIk5XDlfzgTTdsEEnG6D
         dUHMe0jr6N/Cw==
Date:   Mon, 5 Sep 2022 08:47:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Santan Kumar <santan.kumar@nxp.com>,
        Tao Yang <b31903@freescale.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Abhimanyu Saini <abhimanyu.saini@nxp.com>
Subject: Re: [PATCH v3 3/5] arm64: dts: ls2081a-rdb: Add DTS for NXP
 LS2081ARDB
Message-ID: <20220905004744.GN1728671@dragon>
References: <20220823234913.30325-1-leoyang.li@nxp.com>
 <20220823234913.30325-4-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823234913.30325-4-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 06:49:11PM -0500, Li Yang wrote:
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
>  .../boot/dts/freescale/fsl-ls2081a-rdb.dts    | 132 ++++++++++++++++++
>  2 files changed, 133 insertions(+)
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
> index 000000000000..44e955d2db12
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> @@ -0,0 +1,132 @@
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

In alphabetic order, ifc should go after i2c0.

Shawn

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
> +
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
