Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64300504F93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiDRLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiDRLvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C019028;
        Mon, 18 Apr 2022 04:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36E0660C54;
        Mon, 18 Apr 2022 11:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B17C385A9;
        Mon, 18 Apr 2022 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650282554;
        bh=kF1iqOvzcYCRhQZ3FBUzZP/F6pqP8LGBbk1dEOCm4DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQkk10q/ZlynZYa8P8agi2keT3+8WlKljt/PjiJvw75O7nrNE4/SzMgkfzB1IbWrA
         lhqCafq8ENUHMDaco0yUmTKeab3MHyqHQjjOBamvEzzWtYo/k1MmWMhpJPKXo20Rfe
         Q4rp9yiJQ98i8KhQ0fUUbQEBiyn/fxicVcTwOB7bIEYRihx2WomQgEW14inoV1snfd
         6bOV/ZSl92o3Y/H/Js5QkW/b3NsD4xwB0OobAqpOfT/LBzng7AnTE5L6rV3YB0/dxy
         rWrAbXlth5xd2ccFluJRjCQKHjp9HCfX2W9/c+Gje+toSTCeMJitnrKdREHd8SBVqC
         anNgWOPcjm9cA==
Date:   Mon, 18 Apr 2022 19:49:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, David Jander <david@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH v1 01/17] arm: dts: imx6qdl-vicut1.dtsi: remove TiWi
 module
Message-ID: <20220418114908.GI391514@dragon>
References: <20220412074004.2485264-1-o.rempel@pengutronix.de>
 <20220412074004.2485264-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412074004.2485264-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 09:39:48AM +0200, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Only the first prototypes had a TiWi module. There is no publicly available
> hardware where this module is fitted and there are no plant to produce

s/plant/plan?

Shawn

> any.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 51 ---------------------------
>  1 file changed, 51 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> index ec39008c0950..fe2685642bf1 100644
> --- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> @@ -144,18 +144,6 @@ reg_otg_vbus: regulator-otg-vbus {
>  		enable-active-high;
>  	};
>  
> -	reg_wifi: regulator-wifi {
> -		compatible = "regulator-fixed";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_wifi_npd>;
> -		regulator-name = "wifi";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -		startup-delay-us = <70000>;
> -	};
> -
>  	sound {
>  		compatible = "simple-audio-card";
>  		simple-audio-card,name = "prti6q-sgtl5000";
> @@ -530,26 +518,6 @@ &usdhc1 {
>  	status = "okay";
>  };
>  
> -&usdhc2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usdhc2>;
> -	vmmc-supply = <&reg_wifi>;
> -	non-removable;
> -	cap-power-off-card;
> -	keep-power-in-suspend;
> -	no-1-8-v;
> -	no-mmc;
> -	no-sd;
> -	status = "okay";
> -
> -	wifi {
> -		compatible = "ti,wl1271";
> -		interrupts-extended = <&gpio1 30 IRQ_TYPE_LEVEL_HIGH>;
> -		ref-clock-frequency = "38400000";
> -		tcxo-clock-frequency = "19200000";
> -	};
> -};
> -
>  &usdhc3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc3>;
> @@ -808,19 +776,6 @@ MX6QDL_PAD_GPIO_1__GPIO1_IO01			0x1b0b0
>  		>;
>  	};
>  
> -	pinctrl_usdhc2: usdhc2grp {
> -		fsl,pins = <
> -			MX6QDL_PAD_SD2_CMD__SD2_CMD			0x170b9
> -			MX6QDL_PAD_SD2_CLK__SD2_CLK			0x100b9
> -			MX6QDL_PAD_SD2_DAT0__SD2_DATA0			0x170b9
> -			MX6QDL_PAD_SD2_DAT1__SD2_DATA1			0x170b9
> -			MX6QDL_PAD_SD2_DAT2__SD2_DATA2			0x170b9
> -			MX6QDL_PAD_SD2_DAT3__SD2_DATA3			0x170b9
> -			/* WL12xx IRQ */
> -			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30		0x10880
> -		>;
> -	};
> -
>  	pinctrl_usdhc3: usdhc3grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17099
> @@ -836,10 +791,4 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17099
>  			MX6QDL_PAD_SD3_RST__SD3_RESET			0x1b0b1
>  		>;
>  	};
> -
> -	pinctrl_wifi_npd: wifinpdgrp {
> -		fsl,pins = <
> -			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26		0x1b8b0
> -		>;
> -	};
>  };
> -- 
> 2.30.2
> 
