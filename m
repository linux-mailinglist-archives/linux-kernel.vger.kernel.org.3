Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B0F5A9EA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiIASIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiIASIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:08:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C049550BF;
        Thu,  1 Sep 2022 11:08:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BB4DF6CD;
        Thu,  1 Sep 2022 20:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662055681;
        bh=YMIi5UBpbzantzAuqdDxtUWjhWEbfNnLmbHpGpFj4hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uP4w2XjNoWnYv+NUW1ikTgl4PQ6YdmfO4kGwEQOohDS6HFacyg1DmN0lC0SujVq7n
         1Fm+7l28dNUIRjUsOmyNfzGwpwgDOc+FqWNeAA5YCIWheoDVA2ZuTxrRJ+ccrxE0q+
         sfoDf/26SCpwQQIqow8iJXiU/NN3mBVY5+ZeYjXw=
Date:   Thu, 1 Sep 2022 21:07:49 +0300
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
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp-verdin: add dsi to hdmi
 functionality
Message-ID: <YxD09SqpcbB3dt8I@pendragon.ideasonboard.com>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901154051.1885509-1-max.oss.09@gmail.com>
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

On Thu, Sep 01, 2022 at 05:40:50PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Add the hdmi connector present on the dsi to hdmi adapter now
> required by the upstream lontium bridge driver.
> The dsi to hdmi adapter is enabled in an device tree overlay.

Shouldn't the connector also be in the overlay ? There's certainly no
physical HDMI connector on the i.MX8MP Verdin SoM :-)

> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 
> ---
> 
>  arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> index 76cc89296150..bd84a0d135dc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -59,6 +59,14 @@ button-wakeup {
>  		};
>  	};
>  
> +	hdmi_connector: hdmi-connector {
> +		compatible = "hdmi-connector";
> +		ddc-i2c-bus = <&i2c2>;
> +		label = "hdmi";
> +		type = "a";
> +		status = "disabled";
> +	};
> +
>  	/* Carrier Board Supplies */
>  	reg_1p8v: regulator-1p8v {
>  		compatible = "regulator-fixed";

-- 
Regards,

Laurent Pinchart
