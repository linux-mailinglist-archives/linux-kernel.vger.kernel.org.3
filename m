Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F656015D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiF2Nej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiF2Nee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:34:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341DC18346;
        Wed, 29 Jun 2022 06:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2DE5B8249E;
        Wed, 29 Jun 2022 13:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE45C34114;
        Wed, 29 Jun 2022 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656509670;
        bh=gj+vg2IVeXjYKBJmnL54JfVG6X8RSjznQuc6WRpzK+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J23XU6m4mCLml/4II2XqMUkJvgZHELWAcMhBn8hHkfAVKiqSf9FF5nOQzZbB19E2q
         u7MkydnzsF1zZ8NxFDLman6F5vzyx+/lpQGXt2DYQhk3zFFHeSl5I+vGLduavORgTJ
         swI+E6rsKnqXPA57oV5RVjp9+g9DSyvpyPgZx9XmzkqmnQwneJB9GdP2eMnAvtbyEe
         xjLQ+yfjOmGhbhE3SO7yQbLatzfa8aJ8jPyiHKTnfJuwkGd+aL3OY1F83K+0cXQtUy
         wfiBYQNTaGJpH0HOshwKIVbruWtCXTD8h+wwsuvodXS9z2UIXZ3xuhKkqtYZW68idQ
         m9v15P/BwSA5g==
Date:   Wed, 29 Jun 2022 21:34:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 6/9] ARM: dts: layerscape: Add SFP binding for TA 2.1
 devices
Message-ID: <20220629133424.GN819983@dragon>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
 <20220428181703.2194171-7-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428181703.2194171-7-sean.anderson@seco.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:17:00PM -0400, Sean Anderson wrote:
> This adds an appropriate SFP binding for Trust Architecture 2.1 devices.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/boot/dts/ls1021a.dtsi                 | 7 +++++++

Separate patches for arm and arm64 DTS, please.

Also prefix arm patches like 'ARM: dts: ...', while 'arm64: dts: ...'
for arm64 ones.

Shawn

>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 8 ++++++++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 2e69d6eab4d1..c1e94a317cba 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -129,6 +129,13 @@ ifc: ifc@1530000 {
>  			status = "disabled";
>  		};
>  
> +		sfp: efuse@1e80000 {
> +			compatible = "fsl,ls1021a-sfp";
> +			reg = <0x0 0x1e80000 0x0 0x10000>;
> +			clocks = <&clockgen 4 3>;
> +			clock-names = "sfp";
> +		};
> +
>  		dcfg: dcfg@1ee0000 {
>  			compatible = "fsl,ls1021a-dcfg", "syscon";
>  			reg = <0x0 0x1ee0000 0x0 0x1000>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index 50a72cda4727..47ce525e0a72 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -271,6 +271,14 @@ rtic_d: rtic-d@60 {
>  			};
>  		};
>  
> +		sfp: efuse@1e80000 {
> +			compatible = "fsl,ls1021a-sfp";
> +			reg = <0x0 0x1e80000 0x0 0x10000>;
> +			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> +					    QORIQ_CLK_PLL_DIV(4)>;
> +			clock-names = "sfp";
> +		};
> +
>  		sec_mon: sec_mon@1e90000 {
>  			compatible = "fsl,sec-v5.4-mon", "fsl,sec-v5.0-mon",
>  				     "fsl,sec-v4.0-mon";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 35d1939e690b..b0ab0b19de7e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -383,6 +383,14 @@ sec_jr3: jr@40000 {
>  			};
>  		};
>  
> +		sfp: efuse@1e80000 {
> +			compatible = "fsl,ls1021a-sfp";
> +			reg = <0x0 0x1e80000 0x0 0x10000>;
> +			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> +					    QORIQ_CLK_PLL_DIV(4)>;
> +			clock-names = "sfp";
> +		};
> +
>  		dcfg: dcfg@1ee0000 {
>  			compatible = "fsl,ls1043a-dcfg", "syscon";
>  			reg = <0x0 0x1ee0000 0x0 0x10000>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 4e7bd04d9798..c30056afc02a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -413,6 +413,14 @@ bportals: bman-portals@508000000 {
>  			ranges = <0x0 0x5 0x08000000 0x8000000>;
>  		};
>  
> +		sfp: efuse@1e80000 {
> +			compatible = "fsl,ls1021a-sfp";
> +			reg = <0x0 0x1e80000 0x0 0x10000>;
> +			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> +					    QORIQ_CLK_PLL_DIV(4)>;
> +			clock-names = "sfp";
> +		};
> +
>  		dcfg: dcfg@1ee0000 {
>  			compatible = "fsl,ls1046a-dcfg", "syscon";
>  			reg = <0x0 0x1ee0000 0x0 0x1000>;
> -- 
> 2.35.1.1320.gc452695387.dirty
> 
