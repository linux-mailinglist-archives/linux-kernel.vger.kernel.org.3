Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0D50013E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiDMViQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiDMViN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:38:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103B56C24
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:35:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q8so1662282wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KgpH8E8Be3mLImfDuc7rcAzwOJ8eNCA0wVEOLBBjmmo=;
        b=Pyb/JtRmDglYafeGT9DnYvtGO7mseoHJWlxBWUNQO3xPD/Hfw5SdposQc/zLfC8TZE
         U0vyMgWVViLZ6BmQUTkt7TZihL80XxzSm9bCf29CGU8jBa/+ew2rBWQFncxLhTCaCiBy
         RJZW0bwS9uIhiIeYIn7MZ1+g37gTgzQQfg/jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KgpH8E8Be3mLImfDuc7rcAzwOJ8eNCA0wVEOLBBjmmo=;
        b=ePjWV0UqIteMu88mdUHBrHwSve5iUOjs0XfDzVkOdOUbmgGAt2tmih4y73EdtyZfcw
         XMHl54rLvdo1TfJk591ZLu0p797D4YC5kEFa5U2PCDhVt8mKvR/W+296U0y6EU648yiF
         KHKgPf7ObRTJyu401xT7rRq0pzibFRclPhPIK2tBnzlmT3fxCoUzJ8+CPE+f59dXXzDy
         dQNWwCqP1mskuep7ZWB+FnNfRfn5T5gavC4hn2su1loVNgUKCYM7+SwMqEQn0MT0nw+A
         gKaqASeOideaaGlUgTu7kUpzleUt6DXperxExCGAhpSGKYN84IgJQ85Ae3UzdcjFEP10
         AbyA==
X-Gm-Message-State: AOAM530bHfVC+FgDJTYfGS1JaGy8ERSYvEUW5y7Zi8ij5i5Gyi/FXnEn
        evbXF7/N/pdmI4pUaaaSp+aKAg==
X-Google-Smtp-Source: ABdhPJylm1FwSAG+uiLlo8hTEXpIbhcw0aXer6Zn3oVPIznnRJNzbsJ2zE5Z9PwqlDrOi7TQ2BVALA==
X-Received: by 2002:a05:600c:34d4:b0:38c:5ec7:1e38 with SMTP id d20-20020a05600c34d400b0038c5ec71e38mr558062wmq.184.1649885749834;
        Wed, 13 Apr 2022 14:35:49 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-56-163.cust.vodafonedsl.it. [188.217.56.163])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0038cafe3d47dsm8705wmq.42.2022.04.13.14.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:35:49 -0700 (PDT)
Date:   Wed, 13 Apr 2022 23:35:46 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, Li Jun <jun.li@nxp.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-evk: add pwm1/backlight support
Message-ID: <20220413213546.GA11567@tom-ThinkPad-T14s-Gen-2i>
References: <20220413160900.36271-1-tommaso.merciai@amarulasolutions.com>
 <11f8bf43-d6f7-12fe-f5da-1f7a397c4317@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f8bf43-d6f7-12fe-f5da-1f7a397c4317@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 06:31:34PM +0200, Ahmad Fatoum wrote:
> Hello Tomasso,
> 
> On 13.04.22 18:08, Tommaso Merciai wrote:
> > Add pwm1/backlight support nodes for imx8mm_evk board.
> > Align with u-boot dts
> > 
> > References:
> >  - https://patchwork.ozlabs.org/project/uboot/patch/20220326111911.13720-9-tommaso.merciai@amarulasolutions.com/
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > ---
> > Changes since v1:
> >  - Fix commit body
> >  - Enable pwm, backlight
> > 
> > Changes since v2:
> >  - Remove status okay from pwm1,backlight (enable as default)
> > 
> >  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > index 6d67df7692f1..c50d2cc3ca71 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > @@ -59,6 +59,14 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >  		enable-active-high;
> >  	};
> >  
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&pwm1 0 5000000>;
> > +		brightness-levels = <0 255>;
> > +		num-interpolated-steps = <255>;
> > +		default-brightness-level = <250>;
> > +	};
> > +
> >  	ir-receiver {
> >  		compatible = "gpio-ir-receiver";
> >  		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> > @@ -395,6 +403,11 @@ &wdog1 {
> >  	status = "okay";
> >  };
> >  
> > +&pwm1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_backlight>;
> 
> imx8mm.dtsi has &pwm1 { status = "disabled" };
> Where is it enabled?

Hi Ahmad,
Thanks for review, update in v4.

Tommaso
> 
> > +};
> > +
> >  &iomuxc {
> >  	pinctrl_fec1: fec1grp {
> >  		fsl,pins = <
> > @@ -549,4 +562,10 @@ pinctrl_wdog: wdoggrp {
> >  			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
> >  		>;
> >  	};
> > +
> > +	pinctrl_backlight: backlightgrp {
> > +		fsl,pins = <
> > +			MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT	0x06
> > +		>;
> > +	};
> >  };
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
