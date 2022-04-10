Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D793A4FAB45
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiDJBDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiDJBDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:03:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E609CFE;
        Sat,  9 Apr 2022 18:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 318E9B807E7;
        Sun, 10 Apr 2022 01:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3C7C385A4;
        Sun, 10 Apr 2022 01:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649552446;
        bh=gscMQDA1Nf1JKZaGWicmeiTr6Zz5nB+FiP4QfEUIFpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pj3BsvmqNLI6EkHpK1lEkntdPY39BHUWxB5prxLsZmIb/uW+Gd9nziAakjbfMDDMT
         YyaeigjmQFa2ymkY0g6aqBMLmbj0vxd0zS5SVaDb8ZwB7WTku+PGdMSpL4vssREDAT
         x5CJoVWjMxHPKJHuyR5WtShVnPNzImOY8VCbJTl7fdqcFXAInjUsLAvs4443a5L//q
         IUuGJRF6xiBgee7l/W3KKjOioKhJmc/Gq4hrNOqxx7YUb+2aUBpxKJkBKt+n4VTa/I
         0QRUVjhSfQntz0eg0QF3Y1INd4TIMzYcaWXD2NKsUt/n7XBcjdF1g0npRlsf+ung9f
         J1hLOV88wA6XA==
Date:   Sun, 10 Apr 2022 09:00:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v19] arm64: dts: freescale: imx8q: add imx vpu codec
 entries
Message-ID: <20220410010039.GE129381@dragon>
References: <20220317061130.20857-1-ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317061130.20857-1-ming.qian@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:11:30PM +0800, Ming Qian wrote:
> Add the Video Processing Unit node for IMX8Q SoC.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi | 74 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 25 +++++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 24 ++++++
>  3 files changed, 123 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> new file mode 100644
> index 000000000000..989f2bf07b5e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> @@ -0,0 +1,74 @@
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
> +		status = "disabled";
> +	};
> +
> +	mu1_m0: mailbox@2d020000 {
> +		compatible = "fsl,imx6sx-mu";
> +		reg = <0x2d020000 0x20000>;
> +		interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
> +		#mbox-cells = <2>;
> +		power-domains = <&pd IMX_SC_R_VPU_MU_1>;
> +		status = "disabled";
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

Hyphen is recommended in node name than underscore.

> +		reg = <0x2d080000 0x10000>;
> +		compatible = "nxp,imx8q-vpu-decoder";
> +		power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
> +		mbox-names = "tx0", "tx1", "rx";
> +		mboxes = <&mu_m0 0 0>,
> +			<&mu_m0 0 1>,
> +			<&mu_m0 1 0>;
> +		status = "disabled";
> +	};
> +
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
> +
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
> index 863232a47004..44347a076722 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -196,6 +196,31 @@ &usdhc2 {
>  	status = "okay";
>  };
>  
> +&vpu {
> +	compatible = "nxp,imx8qxp-vpu";
> +	status = "okay";
> +};
> +
> +&mu_m0 {

Keep them sort alphabetically.

Shawn

> +	status = "okay";
> +};
> +
> +&mu1_m0 {
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
> index dbec7c106e0b..a79ae33cbad2 100644
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
> +		decoder_rpc: decoder-rpc@92000000 {
> +			reg = <0 0x92000000 0 0x100000>;
> +			no-map;
> +		};
> +
>  		dsp_reserved: dsp@92400000 {
>  			reg = <0 0x92400000 0 0x2000000>;
>  			no-map;
>  		};
> +
> +		encoder_rpc: encoder-rpc@94400000 {
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
