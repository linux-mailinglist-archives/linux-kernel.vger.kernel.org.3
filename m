Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70684FB159
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbiDKBd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiDKBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E7A3CFD5;
        Sun, 10 Apr 2022 18:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D795460FD6;
        Mon, 11 Apr 2022 01:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6EEC385A6;
        Mon, 11 Apr 2022 01:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649640672;
        bh=EuaEs2BcrZZ13MypsGZEPjnFQjM4MZoNuOTs2HX8svc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgOzvhfauO8G+y9gCq+Gkv70d1hUiHGe2GUtn/7MA98iJMXQAPPVcMr8ERIduWpSp
         kX/cgsja00M9waU0Lm+K4lhEPL7yJiISW7zitvDwqZVTQRQ8L/NBv5kw1NmeaLAHh8
         uJgeGUb86LOlxmsH4zTqRjpox9fFG75xghvR2Cymzc/hWsvYpr/dEXStloncMvOZeY
         L/lBvelecmS8wQLUQCAKxvR+33OSEaCPOu/BTG/FMjriIb+ztglTf15H8SH0F2d1JN
         u2KHKsNLA1HgpnIRIFi5YgByWgItl6Cwoymy4D69RCWx94Wdb86HZS1CL8vHfaUgnW
         JLIfSSILpOoOw==
Date:   Mon, 11 Apr 2022 09:31:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] imx8mm-venice-gw7902: update pci refclk
Message-ID: <20220411013106.GD129381@dragon>
References: <20220405200625.19359-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405200625.19359-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:06:25PM -0700, Tim Harvey wrote:
> Use the correct PCI clock bindings.

Please improve the commit log to explain why clock "pcie_phy" can be
dropped.

Shawn

> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> index 6aa0eb463647..f71416be29a7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> @@ -595,7 +595,7 @@
>  &pcie_phy {
>  	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
>  	fsl,clkreq-unsupported;
> -	clocks = <&clk IMX8MM_CLK_DUMMY>;
> +	clocks = <&pcie0_refclk>;
>  	status = "okay";
>  };
>  
> @@ -604,8 +604,8 @@
>  	pinctrl-0 = <&pinctrl_pcie0>;
>  	reset-gpio = <&gpio4 5 GPIO_ACTIVE_LOW>;
>  	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
> -		 <&clk IMX8MM_CLK_DUMMY>, <&pcie0_refclk>;
> -	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +		 <&pcie0_refclk>;
> +	clock-names = "pcie", "pcie_aux", "pcie_bus";
>  	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
>  			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
>  	assigned-clock-rates = <10000000>, <250000000>;
> -- 
> 2.17.1
> 
