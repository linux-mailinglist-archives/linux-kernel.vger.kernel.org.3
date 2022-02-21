Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CCD4BD411
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbiBUDA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:00:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245754AbiBUDA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:00:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A049279;
        Sun, 20 Feb 2022 19:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E56F61126;
        Mon, 21 Feb 2022 03:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8E7C340E8;
        Mon, 21 Feb 2022 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645412402;
        bh=Z11mP6FU9ojgXwPg+o0cYxKyTiDeQ75L3RW9Rl4Rakg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAwiVyGXD4CQtxMfkHVZ2loJ1mFhOiSrUASFc+yuulumSpyBBjqzkdUM1bsnVGqrG
         GbUjpgXyBfV/wLAI3q8QaPi6DXHZKOOA7V9B0z9kXls8LiByYhL3lWMWlTN4JaVUYJ
         H7vkQsafEkr9RrulEr4oHmYs58PzyU+O3+uNmOlp5yVsWtSxtBy7k/8mFKPwKzJq10
         LwQWLLDVy8VbdT79qI2h+ZUpMGDSWX6O52rvNil2Sjhc8BSROLEZraAm8hJaV0+oCo
         VHHyrALpqu46Xd9hm3/xDjRSFV1N4h0Jtqn1Pn5tkFtLyfA9jjV1c6tLTefT08Yv9o
         n3qp0Aar4QiGA==
Date:   Mon, 21 Feb 2022 10:59:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15.1 11/13] ARM64: dts: freescale: imx8q: add imx vpu
 codec entries
Message-ID: <20220221025954.GB2249@dragon>
References: <cover.1643165764.git.ming.qian@nxp.com>
 <7f8db91ae941309e38684a17ae1d3c088e72b209.1643165765.git.ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f8db91ae941309e38684a17ae1d3c088e72b209.1643165765.git.ming.qian@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:09:30AM +0800, Ming Qian wrote:
> Add the Video Processing Unit node for IMX8Q SoC.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>

'arm64: ...' in subject prefix.

> ---
>  .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi | 72 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 17 +++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 24 +++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> new file mode 100644
> index 000000000000..f2dde6d14ca3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 NXP
> + *	Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +vpu: vpu@2c000000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0x2c000000 0x0 0x2c000000 0x2000000>;
> +	reg = <0 0x2c000000 0 0x1000000>;
> +	power-domains = <&pd IMX_SC_R_VPU>;
> +	status = "disabled";
> +
> +	mu_m0: mailbox@2d000000 {
> +		compatible = "fsl,imx6sx-mu";
> +		reg = <0x2d000000 0x20000>;
> +		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
> +		#mbox-cells = <2>;
> +		power-domains = <&pd IMX_SC_R_VPU_MU_0>;
> +		status = "okay";

We generally use 'okay' status to flip a disabled device, so it can be
saved here?

> +	};
> +
> +	mu1_m0: mailbox@2d020000 {
> +		compatible = "fsl,imx6sx-mu";
> +		reg = <0x2d020000 0x20000>;
> +		interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
> +		#mbox-cells = <2>;
> +		power-domains = <&pd IMX_SC_R_VPU_MU_1>;
> +		status = "okay";
> +	};
> +
> +	mu2_m0: mailbox@2d040000 {
> +		compatible = "fsl,imx6sx-mu";
> +		reg = <0x2d040000 0x20000>;
> +		interrupts = <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
> +		#mbox-cells = <2>;
> +		power-domains = <&pd IMX_SC_R_VPU_MU_2>;
> +		status = "disabled";
> +	};
> +
> +	vpu_core0: vpu_core@2d080000 {
> +		reg = <0x2d080000 0x10000>;
> +		compatible = "nxp,imx8q-vpu-decoder";
> +		power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
> +		mbox-names = "tx0", "tx1", "rx";
> +		mboxes = <&mu_m0 0 0>,
> +			<&mu_m0 0 1>,
> +			<&mu_m0 1 0>;
> +		status = "disabled";
> +	};

Have a newline between nodes.

> +	vpu_core1: vpu_core@2d090000 {
> +		reg = <0x2d090000 0x10000>;
> +		compatible = "nxp,imx8q-vpu-encoder";
> +		power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
> +		mbox-names = "tx0", "tx1", "rx";
> +		mboxes = <&mu1_m0 0 0>,
> +			<&mu1_m0 0 1>,
> +			<&mu1_m0 1 0>;
> +		status = "disabled";
> +	};
> +	vpu_core2: vpu_core@2d0a0000 {
> +		reg = <0x2d0a0000 0x10000>;
> +		compatible = "nxp,imx8q-vpu-encoder";
> +		power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
> +		mbox-names = "tx0", "tx1", "rx";
> +		mboxes = <&mu2_m0 0 0>,
> +			<&mu2_m0 0 1>,
> +			<&mu2_m0 1 0>;
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 863232a47004..05495b60beb8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -196,6 +196,23 @@ &usdhc2 {
>  	status = "okay";
>  };
>  
> +&vpu {
> +	compatible = "nxp,imx8qxp-vpu";
> +	status = "okay";
> +};
> +
> +&vpu_core0 {
> +	reg = <0x2d040000 0x10000>;
> +	memory-region = <&decoder_boot>, <&decoder_rpc>;
> +	status = "okay";
> +};
> +
> +&vpu_core1 {
> +	reg = <0x2d050000 0x10000>;
> +	memory-region = <&encoder_boot>, <&encoder_rpc>;
> +	status = "okay";
> +};
> +
>  &iomuxc {
>  	pinctrl_fec1: fec1grp {
>  		fsl,pins = <
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index dbec7c106e0b..a041b85d612b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -46,6 +46,9 @@ aliases {
>  		serial1 = &lpuart1;
>  		serial2 = &lpuart2;
>  		serial3 = &lpuart3;
> +		vpu_core0 = &vpu_core0;
> +		vpu_core1 = &vpu_core1;
> +		vpu_core2 = &vpu_core2;
>  	};
>  
>  	cpus {
> @@ -162,10 +165,30 @@ reserved-memory {
>  		#size-cells = <2>;
>  		ranges;
>  
> +		decoder_boot: decoder-boot@84000000 {
> +			reg = <0 0x84000000 0 0x2000000>;
> +			no-map;
> +		};
> +
> +		encoder_boot: encoder-boot@86000000 {
> +			reg = <0 0x86000000 0 0x200000>;
> +			no-map;
> +		};
> +
> +		decoder_rpc: decoder-rpc@0x92000000 {

No '0x' in unit-address.

Shawn

> +			reg = <0 0x92000000 0 0x100000>;
> +			no-map;
> +		};
> +
>  		dsp_reserved: dsp@92400000 {
>  			reg = <0 0x92400000 0 0x2000000>;
>  			no-map;
>  		};
> +
> +		encoder_rpc: encoder-rpc@0x94400000 {
> +			reg = <0 0x94400000 0 0x700000>;
> +			no-map;
> +		};
>  	};
>  
>  	pmu {
> @@ -287,6 +310,7 @@ map0 {
>  
>  	/* sorted in register address */
>  	#include "imx8-ss-img.dtsi"
> +	#include "imx8-ss-vpu.dtsi"
>  	#include "imx8-ss-adma.dtsi"
>  	#include "imx8-ss-conn.dtsi"
>  	#include "imx8-ss-ddr.dtsi"
> -- 
> 2.33.0
> 
