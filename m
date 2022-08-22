Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9496159BCC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiHVJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiHVJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:23:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980651903C;
        Mon, 22 Aug 2022 02:23:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 554032B3;
        Mon, 22 Aug 2022 11:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661160181;
        bh=B3pgSHrLCN2t4fVlgMLtRS8SxMf8MmjoNgpVcUHlikY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8fUDCvllDKeWPe8WgVG2XVPGF8p5fAIlVZ5I/PqmQ1R+4B0RBY78k/L87LERK2G/
         YADQXBZqaKOKV6ePstUm9Qy2VgbPoLIPJZVmxLUhKrP1MCYy9pa/2d6qR33vKE7OwP
         y37jVSuS7b/ajrtF7KHLUIh66aYdoxhcCvsyKtYY=
Date:   Mon, 22 Aug 2022 12:22:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-verdin: add cpu-supply
Message-ID: <YwNK8cZT4umgI4yS@pendragon.ideasonboard.com>
References: <20220822075342.2611279-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220822075342.2611279-1-max.oss.09@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

Thank you for the patch.

On Mon, Aug 22, 2022 at 09:53:42AM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Add the cpu-supply property to all CPU nodes to enable the cpufreq
> driver.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  .../boot/dts/freescale/imx8mp-verdin.dtsi      | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> index f062fdbb2719..dbc22b672fb3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -146,6 +146,22 @@ reserved-memory {
>  	};
>  };
>  
> +&A53_0 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
>  &cpu_alert0 {
>  	temperature = <95000>;
>  };
> @@ -453,7 +469,7 @@ BUCK1 {
>  				regulator-ramp-delay = <3125>;
>  			};
>  
> -			BUCK2 {
> +			reg_vdd_arm: BUCK2 {
>  				nxp,dvs-run-voltage = <950000>;
>  				nxp,dvs-standby-voltage = <850000>;
>  				regulator-always-on;

-- 
Regards,

Laurent Pinchart
