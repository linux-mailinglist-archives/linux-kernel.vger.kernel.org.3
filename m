Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1C4B3961
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 06:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiBMFXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 00:23:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiBMFXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 00:23:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCDB5E778;
        Sat, 12 Feb 2022 21:23:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15CEEB80954;
        Sun, 13 Feb 2022 05:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85784C004E1;
        Sun, 13 Feb 2022 05:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644729794;
        bh=vYSNojDh0K1HAwwbXJB0icOSyWl3HotrRpbPrie1v5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3LdzOx7+QWnaej7zbIzdXyjlSb1bUPGyzAX2Lf1O3YzS5/6+qceDTh1EMDAEmnsI
         6NPWuwdQd2kvzKnVnd8bly82gQC8ZB32iqvIFn2remJY6I+difRAhzwMDWRSczZJ+D
         5mdT/1dKEFRg3I9LBjdI+5q4+IPEbbKWmSh8RhiWQ5X5xvgeu8FoFkmZSEQLPkGtKj
         5eWSDiqaTvzfPHy/B9+JaejGLntTX3lwAk/WgYGBr54xhneleAfxCUA7/X0qneyDds
         xJJYOKBi8xkD/09xXUtkGVGVDLPoDZeevyQts+tsLDtH3KEhRtuHHSIDqNDWmFcpNi
         3Wc6GM89rPxWw==
Date:   Sun, 13 Feb 2022 13:23:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/5] ARM: dts: imx6qdl-vicut1: add CAN termination
 support
Message-ID: <20220213052305.GP4909@dragon>
References: <20220211133035.2321330-1-o.rempel@pengutronix.de>
 <20220211133035.2321330-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211133035.2321330-4-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 02:30:33PM +0100, Oleksij Rempel wrote:
> The gpio1 0 pin is controlling CAN termination, not USB H1 VBUS. So,
> remove wrong regulator and assign this gpio to new DT CAN termnation

Sigh, the typo is still there with a new version.

Fixed it up and applied the series.

Shawn

> property.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> index b9e305774fed..1ac7e13249d2 100644
> --- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> @@ -126,15 +126,6 @@ reg_3v3: regulator-3v3 {
>  		regulator-max-microvolt = <3300000>;
>  	};
>  
> -	reg_h1_vbus: regulator-h1-vbus {
> -		compatible = "regulator-fixed";
> -		regulator-name = "h1-vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
>  	reg_otg_vbus: regulator-otg-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "otg-vbus";
> @@ -212,6 +203,8 @@ IMX_AUDMUX_V2_PTCR_SYN		IMX_AUDMUX_V2_PDCR_RXDSEL(0)
>  &can1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_can1>;
> +	termination-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +	termination-ohms = <150>;
>  	status = "okay";
>  };
>  
> @@ -492,7 +485,6 @@ &uart5 {
>  };
>  
>  &usbh1 {
> -	vbus-supply = <&reg_h1_vbus>;
>  	pinctrl-names = "default";
>  	phy_type = "utmi";
>  	dr_mode = "host";
> -- 
> 2.30.2
> 
