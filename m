Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3541A4FF897
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiDMOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiDMOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:08:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A0B60CD3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:06:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g18so4151931ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1K/RPiyzv/rwySVDedqK5ecMTT01CdoSCB+tdz/b9HI=;
        b=bYPycsGq1Dy1M+2s+8o3DuKr3Bt4dqO5oF3Q7J8B4f7KxwxbLRYfMcws+fXB8veOYp
         gsCxuu8nkIQXuF9wTkli8wllqevhX7i6IMDRjr4Xoqts7Xg4p3emJNgGeV20sO/FJuDn
         YaYFdNPeg/d6GeUVOTslta7snioXVLoz3cajM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1K/RPiyzv/rwySVDedqK5ecMTT01CdoSCB+tdz/b9HI=;
        b=HtfL0j5Mat9Rc8hjcyQHOLjUSx3apvHts3+L3vMXulFtyY0gtAeyPC41f5VrOsiymj
         LpyFddBn8Bn/RLGYwa5acfWXjyCktC65OkFdj8J/AOmrUSqUMhmqkT56HGufDYG43hib
         98q8FrPAXQhPDTiWjF7FfHR+yucQ/V8nj9hwSpwHpUcePezf02wBxTvgNOVhjaH21eVX
         C2kOFoO1KVCcChFO3P2Pxn/qhwPCVeAXEaYHBZQAp9H7jEoJkdxnxmO+JrRYedBCjcnB
         n8wMJMgDaPgvvDFwUUOTVjAXkmBotpFk1ZBgvi1TuBZ6aiSEFP2BmLJ1Y4Gt6kacAoe2
         CoeA==
X-Gm-Message-State: AOAM533+jTIVUm92i09GgfkVkXhPPryTR93pcqJ8V53km/UJQyI2LeDq
        jG7bM49L13rFLR/D08KmXHtveg==
X-Google-Smtp-Source: ABdhPJyDLkxYfQJbdeaHEzd/tsYxg3C6HOqAziPxNHd+yNsF3Zci7M5aRWaWBaPd2d5DkowAVVjbXA==
X-Received: by 2002:a17:906:c282:b0:6ce:369d:3d5 with SMTP id r2-20020a170906c28200b006ce369d03d5mr38884028ejz.425.1649858794786;
        Wed, 13 Apr 2022 07:06:34 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (host-95-245-147-71.retail.telecomitalia.it. [95.245.147.71])
        by smtp.gmail.com with ESMTPSA id o5-20020a50c905000000b0041d828d0c58sm1197762edh.53.2022.04.13.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:06:34 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:06:32 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Li Jun <jun.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mm-evk: add pwm1/backlight support
Message-ID: <20220413140632.GC4713@tom-ThinkPad-T14s-Gen-2i>
References: <20220413125636.28650-1-tommaso.merciai@amarulasolutions.com>
 <8283132d-c271-d1b8-cb28-8f95305b11ec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8283132d-c271-d1b8-cb28-8f95305b11ec@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:45:44PM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2022 14:56, Tommaso Merciai wrote:
> > Add pwm1/backlight support nodes for imx8mm_evk board.
> > Align with u-boot dts
> > 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > index 6d67df7692f1..4c18f8fcd377 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > @@ -59,6 +59,15 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >  		enable-active-high;
> >  	};
> >  
> > +	backlight: backlight {
> > +		status = "okay";
> 
> All nodes have status=okay by default, so no need for this.
> 
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
> > @@ -395,6 +404,12 @@ &wdog1 {
> >  	status = "okay";
> >  };
> >  
> > +&pwm1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_backlight>;
> > +	status = "okay";
> 
> This is needed if the node was disabled in DTSI (I did not check it).
> 
> 
> Best regards,
> Krzysztof

Hi Krzysztof,
Thanks for review, I'll update in v3.

Regards,
Tommaso
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
