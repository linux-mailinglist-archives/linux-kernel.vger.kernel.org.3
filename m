Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F884B26E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbiBKNMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:12:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiBKNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:12:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5212C;
        Fri, 11 Feb 2022 05:12:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE28C61E55;
        Fri, 11 Feb 2022 13:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B75C340E9;
        Fri, 11 Feb 2022 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644585165;
        bh=mxPPHCFOv9wOqSJ+SKD7smQ5QOZ5zf1PCwR9hM57WiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrdpEBXGjpXGCE1/I22U/bhwSgvIVifVhrGZcXx+2Bx5fldw8oE+99TGhztEcMZee
         gCceMWSfCKqYd20VeyRNb5Lj9oIZO9Qne588kkxSVBP6ZXkBdme/dxEvd+Vl/3I+E9
         7uPDrliKfMD5myPHEgq5MmM/97R4+xDyd+q57hYgCGGLFWu1wbYhg/euMgIqG3GIWC
         Hl0T3OJtuahsIXrfzEd0Nm+rgw5Q35v6pDB5y+2o4aDVbSTdIlSSAd8/2L2Mo4yPNz
         4ZY6xuTH16dESAr5c/txEju5evKmdeJ6tlJKUY6vXDn7bp+djDIWdGz2hrtaE5E700
         CoBakB84ijVoA==
Date:   Fri, 11 Feb 2022 21:12:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/5] ARM: dts: imx6dl-prtvt7: Add missing tvp5150
 video decoder node
Message-ID: <20220211131237.GW4909@dragon>
References: <20220131102841.1955032-1-o.rempel@pengutronix.de>
 <20220131102841.1955032-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131102841.1955032-3-o.rempel@pengutronix.de>
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

On Mon, Jan 31, 2022 at 11:28:38AM +0100, Oleksij Rempel wrote:
> From: Robin van der Gracht <robin@protonic.nl>
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>

Please write up some commit log.  Also your SoB is missing.

Shawn

> ---
>  arch/arm/boot/dts/imx6dl-prtvt7.dts | 42 +++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
> index be7c4cb339e7..baaa6ffc4df9 100644
> --- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
> +++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  #include "imx6dl.dtsi"
>  #include "imx6qdl-prti6q.dtsi"
> +#include <dt-bindings/display/sdtv-standards.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/sound/fsl-imx-audmux.h>
> @@ -171,6 +172,18 @@ panel_in: endpoint {
>  		};
>  	};
>  
> +	connector {
> +		compatible = "composite-video-connector";
> +		label = "Composite0";
> +		sdtv-standards = <SDTV_STD_PAL_B>;
> +
> +		port {
> +			comp0_out: endpoint {
> +				remote-endpoint = <&tvp5150_comp0_in>;
> +			};
> +		};
> +	};
> +
>  	reg_bl_12v0: regulator-bl-12v0 {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -295,6 +308,31 @@ sgtl5000: audio-codec@a {
>  		VDDIO-supply = <&reg_3v3>;
>  		VDDD-supply = <&reg_1v8>;
>  	};
> +
> +	video@5c {
> +		compatible = "ti,tvp5150";
> +		reg = <0x5c>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			tvp5150_comp0_in: endpoint {
> +				remote-endpoint = <&comp0_out>;
> +			};
> +		};
> +
> +		/* Output port 2 is video output pad */
> +		port@2 {
> +			reg = <2>;
> +
> +			tvp5151_to_ipu1_csi0_mux: endpoint {
> +				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
> +			};
> +		};
> +	};
>  };
>  
>  &i2c3 {
> @@ -322,6 +360,10 @@ &ipu1_di0_disp0 {
>  	remote-endpoint = <&display_in>;
>  };
>  
> +&ipu1_csi0_mux_from_parallel_sensor {
> +	remote-endpoint = <&tvp5151_to_ipu1_csi0_mux>;
> +};
> +
>  &pwm1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pwm1>;
> -- 
> 2.30.2
> 
