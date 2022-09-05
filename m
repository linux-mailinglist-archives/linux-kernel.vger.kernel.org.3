Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB05AC873
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiIEBMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiIEBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E862715B;
        Sun,  4 Sep 2022 18:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D04661042;
        Mon,  5 Sep 2022 01:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C044C433C1;
        Mon,  5 Sep 2022 01:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662340352;
        bh=e3wD2zWI6m2XFpYjfPzWth/MkgFw8cN+IsG/hA2wv/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JC4KW+tGyIPy10TQBMYG/60zs1yML+mm3ZunLfevMBOaN7AULR3n7YsWG39N8ixis
         cWyfURyF0EWmUp8nnno6GGoVYL+C2SyiVVyT5H4kzsICktb17ulKVE9o1h5IOyHByd
         mONeMDhf3ADBC2PjzdaNzOcxf3TbxBSPgEnAMV7DmnsjgeisONzyAmakHSw1eHB/RV
         sWQVGtJXBHSFqx17iJAaoRKpKTs1iUPyGhITFIK2icqFsZFt1W05mR1tvd5xwD/n5R
         TLscBX9FoC4XE14csTNE/qgyIWOm32uM3muFnXvaujn0flUSbum4g6rdmQmD0cyLZS
         2MaiKxhzSVITQ==
Date:   Mon, 5 Sep 2022 09:12:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Ying <ying.zhang22455@nxp.com>
Subject: Re: [PATCH 7/9] arm64: dts: ls1046a: add gpios based i2c recovery
 information
Message-ID: <20220905011227.GS1728671@dragon>
References: <20220824231200.494-1-leoyang.li@nxp.com>
 <20220824231200.494-8-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824231200.494-8-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:11:58PM -0500, Li Yang wrote:
> Add scl-gpios property for i2c recovery and add SoC specific compatible
> string for SoC specific fixup.
> 
> Signed-off-by: Zhang Ying <ying.zhang22455@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index c7c6c82626fd..c95a990e2edd 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -502,7 +502,7 @@ dspi: spi@2100000 {
>  		};
>  
>  		i2c0: i2c@2180000 {
> -			compatible = "fsl,vf610-i2c";
> +			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x2180000 0x0 0x10000>;
> @@ -516,35 +516,38 @@ i2c0: i2c@2180000 {
>  		};
>  
>  		i2c1: i2c@2190000 {
> -			compatible = "fsl,vf610-i2c";
> +			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x2190000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(2)>;
> +			scl-gpios = <&gpio3 2 0>;

Use define for polarity cell?

Shawn

>  			status = "disabled";
>  		};
>  
>  		i2c2: i2c@21a0000 {
> -			compatible = "fsl,vf610-i2c";
> +			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x21a0000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(2)>;
> +			scl-gpios = <&gpio3 10 0>;
>  			status = "disabled";
>  		};
>  
>  		i2c3: i2c@21b0000 {
> -			compatible = "fsl,vf610-i2c";
> +			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x21b0000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(2)>;
> +			scl-gpios = <&gpio3 12 0>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.37.1
> 
