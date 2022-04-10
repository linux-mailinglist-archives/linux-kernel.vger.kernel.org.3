Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10674FAB54
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiDJBWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiDJBVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:21:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DEC7;
        Sat,  9 Apr 2022 18:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 891ACB80A39;
        Sun, 10 Apr 2022 01:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1954BC385A4;
        Sun, 10 Apr 2022 01:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649553584;
        bh=RKZGZZFqYkTuto/B6SKG7HgLvK2hvzhwcduFq+fXXXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ce57SvrYZ98Ddl7fpVV+1fYkAhXBHVcxKboBToge8KSRjZIPziIz/TjCgwltHnwXJ
         EzAkKI3H23gXcmSoJ2SRvRSp0+3YahV7Jkx/7sgMlVzIkFyJ7Pl0SDqG31GN9J0r8S
         oxvV3mdQ+5xAUoy9ObYfTGEq7yJ0d5xTlap7JHVtg1VB6Z+byj8gasSJq5vz25kJxQ
         uUVzwAm1PRD/9lllX6xzMSl6G5QSf9ertqEBDgaS9Hxe2YnAGK/DM3femXQukCuVAf
         1xl4Wh8qsovehzxo7eSBagruHnl9TUNe73TdYzpCYRO9cNbdMycXHl+UPMLnNTGzIP
         lycaXzeDjBs6Q==
Date:   Sun, 10 Apr 2022 09:19:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Santan Kumar <santan.kumar@nxp.com>,
        Tao Yang <b31903@freescale.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Abhimanyu Saini <abhimanyu.saini@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] arm64: dts: ls2081a-rdb: Add DTS support for NXP
 LS2081ARDB
Message-ID: <20220410011938.GI129381@dragon>
References: <20220317190109.3742-1-leoyang.li@nxp.com>
 <20220317190109.3742-4-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317190109.3742-4-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:01:07PM -0500, Li Yang wrote:
> From: Priyanka Jain <priyanka.jain@nxp.com>
> 
> This patch add support for NXP LS2081ARDB board which has
> LS2081A SoC.
> 
> LS2081A SoC is 40-pin derivative of LS2088A SoC So, from functional

... SoC. So, ...?

> perspective both are same.  Hence,ls2088a SoC dtsi files are included

Hence, ls2088a ...

> from ls2081ARDB dts

LS2081ARDB dts.

I won't review the patch content until the commit log looks good.

Shawn

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
> index 6d8f0a532587..1b5cb71a6828 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-ten64.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2081a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> new file mode 100644
> index 000000000000..908b9aff0489
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
> +			reg = <0x01>;
> +			rtc@51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +			};
> +		};
> +
> +		i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x02>;
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
> 2.25.1
> 
