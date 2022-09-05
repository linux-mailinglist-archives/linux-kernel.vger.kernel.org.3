Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633D15AC8A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiIECBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIECBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:01:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740C21F2E5;
        Sun,  4 Sep 2022 19:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10622B80E7E;
        Mon,  5 Sep 2022 02:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B123C433D6;
        Mon,  5 Sep 2022 02:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662343290;
        bh=Zl2KoVG9L7Ff5UvXhjC4QqCs2BRPLFThP/yuHu36bLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kA9eB9jbCuLjnqQTQHN9Dp4ffpGQo++PT64nqZkyaazY+w6BO0H6vYdIaFPgj9axT
         CoTTOWmwS2gBQloHgMoe1IgCSIy6VluavVeDXL1jXxJ747DQofiRQhDQfBxS6VV1Aq
         R88w1hjdktyCBk6BcVEbeRdnhTECW78RsMOsxYdYzk8Kb8ajwavfEEbTpBuM0zOavl
         0u9kn6Ese+GR8kIeUPE6bH0u6/LtWAh/XTAY8nlr8Xks5iaxhdZ8I7c7RhKELzVDyD
         R3YIyi8yD+27MSWP+jTGVzjQugpqwqQLu0Up13vT80VkD8E5JK0Jpn4UJWy1xyVOp+
         Z/L6SYTYs0XAA==
Date:   Mon, 5 Sep 2022 10:01:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] ARM: dts: imx6sx-udoo-neo: don't use multiple
 blank lines
Message-ID: <20220905020124.GY1728671@dragon>
References: <20220826192252.794651-1-marcel@ziswiler.com>
 <20220826192252.794651-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826192252.794651-3-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 09:22:49PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following warning:
> 
> arch/arm/boot/dts/imx6sx-udoo-neo.dtsi:309: check: Please don't use multiple
> blank lines

It includes changes more than multiple blank lines fix.  I mentioned
those indent changes a bit in the commit log.

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!

Shawn

> ---
> 
>  arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> index 35861bbea94e..c84ea1fac5e9 100644
> --- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> @@ -226,7 +226,7 @@ lcdc: endpoint {
>  &iomuxc {
>  	pinctrl_bt_reg: btreggrp {
>  		fsl,pins =
> -			<MX6SX_PAD_KEY_ROW2__GPIO2_IO_17        0x15059>;
> +			<MX6SX_PAD_KEY_ROW2__GPIO2_IO_17	0x15059>;
>  	};
>  
>  	pinctrl_enet1: enet1grp {
> @@ -306,7 +306,6 @@ MX6SX_PAD_LCD1_RESET__GPIO3_IO_27		0x4001b0b0
>  		>;
>  	};
>  
> -
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins =
>  			<MX6SX_PAD_GPIO1_IO04__UART1_DCE_TX	0x1b0b1>,
> @@ -347,24 +346,23 @@ pinctrl_uart6: uart6grp {
>  
>  	pinctrl_otg1_reg: otg1grp {
>  		fsl,pins =
> -			<MX6SX_PAD_GPIO1_IO09__GPIO1_IO_9        0x10b0>;
> +			<MX6SX_PAD_GPIO1_IO09__GPIO1_IO_9	0x10b0>;
>  	};
>  
> -
>  	pinctrl_otg2_reg: otg2grp {
>  		fsl,pins =
> -			<MX6SX_PAD_NAND_RE_B__GPIO4_IO_12        0x10b0>;
> +			<MX6SX_PAD_NAND_RE_B__GPIO4_IO_12	0x10b0>;
>  	};
>  
>  	pinctrl_usb_otg1: usbotg1grp {
>  		fsl,pins =
> -			<MX6SX_PAD_GPIO1_IO10__ANATOP_OTG1_ID    0x17059>,
> -			<MX6SX_PAD_GPIO1_IO08__USB_OTG1_OC       0x10b0>;
> +			<MX6SX_PAD_GPIO1_IO10__ANATOP_OTG1_ID	0x17059>,
> +			<MX6SX_PAD_GPIO1_IO08__USB_OTG1_OC	0x10b0>;
>  	};
>  
>  	pinctrl_usb_otg2: usbot2ggrp {
>  		fsl,pins =
> -			<MX6SX_PAD_QSPI1A_DATA0__USB_OTG2_OC     0x10b0>;
> +			<MX6SX_PAD_QSPI1A_DATA0__USB_OTG2_OC	0x10b0>;
>  	};
>  
>  	pinctrl_usdhc2: usdhc2grp {
> -- 
> 2.36.1
> 
