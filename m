Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0552065C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiEIVI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiEIVIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:08:24 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90012266F18;
        Mon,  9 May 2022 14:04:28 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id s18-20020a056830149200b006063fef3e17so10926742otq.12;
        Mon, 09 May 2022 14:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ryOLWjMPT8Mm3DDjQPX0Tbxt3buJ6J+17byxV9HGCHQ=;
        b=nn9+JNcB/xX6yU3cePncwQ9XF3GFgIJt6CBa6xIOzB9VAyNAQKgLFilnTq8pwMAOdq
         VX091m+QLk9yvcKuWrbvFZnINkYaxMhcJvFYSkOP5VMeWT0BertUkjmndFpzuKTEq05h
         wdG+OjrGPJWQxRU/yRtbsg59Ha6KspZ/25x1KYhgnI8Nyxmj7vumW/1PVoI4sWZccvo1
         2opxLkWeYeiti65Gv+HOQWpxSfbUJa2e9SK3GhzHhHEB8vleDg9COXPi/LS7ZfS7k9zK
         l0FwVFpJWMTaXukApURa3tOKHBy63kAp7EIQVvfww7fzFmAw4nxBhsmA5F2KDsoRltRY
         BMGw==
X-Gm-Message-State: AOAM533kDrDGfsUtjMHwOfpywfqU9mNoss5EGRijMMXeuyFpeTERKBEW
        oUjO5hAoGPaqEbcuctYG9A==
X-Google-Smtp-Source: ABdhPJy3XO65FmWcnpk439o/M1lHaweG3P2AIApnSMEHbNsZ5R180qy7LX5gcqK5FoL2OasT0A9clQ==
X-Received: by 2002:a9d:460b:0:b0:605:da9d:31eb with SMTP id y11-20020a9d460b000000b00605da9d31ebmr6682816ote.286.1652130267861;
        Mon, 09 May 2022 14:04:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a9-20020a056808128900b00326d2cba5d3sm1020374oiw.8.2022.05.09.14.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:04:27 -0700 (PDT)
Received: (nullmailer pid 174170 invoked by uid 1000);
        Mon, 09 May 2022 21:04:26 -0000
Date:   Mon, 9 May 2022 16:04:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 1/3] arm64: dts: freescale: Add i.MX93 dtsi support
Message-ID: <YnmB2mo2BrOdUlNg@robh.at.kernel.org>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
 <20220503122951.4147636-2-peng.fan@oss.nxp.com>
 <20220505084404.GF14615@dragon>
 <DU0PR04MB94174452A46F14A5C0C1813F88C49@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94174452A46F14A5C0C1813F88C49@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 06:46:16AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2 1/3] arm64: dts: freescale: Add i.MX93 dtsi support
> > 
> > On Tue, May 03, 2022 at 08:29:49PM +0800, Peng Fan (OSS) wrote:
> > ...
> > > diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > > new file mode 100644
> > > index 000000000000..ae8daffe3492
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > > @@ -0,0 +1,337 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright 2022 NXP
> > > + */
> > > +
> > > +#include <dt-bindings/clock/imx93-clock.h> #include
> > > +<dt-bindings/gpio/gpio.h> #include <dt-bindings/input/input.h>
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +#include "imx93-pinfunc.h"
> > > +
> > > +/ {
> > > +	interrupt-parent = <&gic>;
> > > +	#address-cells = <2>;
> > > +	#size-cells = <2>;
> > > +
> > > +	aliases {
> > > +		mmc0 = &usdhc1;
> > > +		mmc1 = &usdhc2;
> > > +		mmc2 = &usdhc3;
> > > +		serial0 = &lpuart1;
> > > +		serial1 = &lpuart2;
> > > +		serial2 = &lpuart3;
> > > +		serial3 = &lpuart4;
> > > +		serial4 = &lpuart5;
> > > +		serial5 = &lpuart6;
> > > +		serial6 = &lpuart7;
> > > +		serial7 = &lpuart8;
> > > +	};
> > > +
> > > +	cpus {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		A55_0: cpu@0 {
> > > +			device_type = "cpu";
> > > +			compatible = "arm,cortex-a55";
> > > +			reg = <0x0>;
> > > +			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > > +		};
> > > +
> > > +		A55_1: cpu@100 {
> > > +			device_type = "cpu";
> > > +			compatible = "arm,cortex-a55";
> > > +			reg = <0x100>;
> > > +			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > > +		};
> > > +
> > > +	};
> > > +
> > > +	osc_32k: clock-osc-32k {
> > > +		compatible = "fixed-clock";
> > > +		#clock-cells = <0>;
> > > +		clock-frequency = <32768>;
> > > +		clock-output-names = "osc_32k";
> > > +	};
> > > +
> > > +	osc_24m: clock-osc-24m {
> > > +		compatible = "fixed-clock";
> > > +		#clock-cells = <0>;
> > > +		clock-frequency = <24000000>;
> > > +		clock-output-names = "osc_24m";
> > > +	};
> > > +
> > > +	clk_ext1: clock-ext1 {
> > > +		compatible = "fixed-clock";
> > > +		#clock-cells = <0>;
> > > +		clock-frequency = <133000000>;
> > > +		clock-output-names = "clk_ext1";
> > > +	};
> > > +
> > > +	psci {
> > > +		compatible = "arm,psci-1.0";
> > > +		method = "smc";
> > > +	};
> > > +
> > > +	timer {
> > > +		compatible = "arm,armv8-timer";
> > > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) |
> > IRQ_TYPE_LEVEL_LOW)>;
> > > +		clock-frequency = <24000000>;
> > > +		arm,no-tick-in-suspend;
> > > +		interrupt-parent = <&gic>;
> > > +	};
> > > +
> > > +	gic: interrupt-controller@48000000 {
> > > +		compatible = "arm,gic-v3";
> > > +		reg = <0 0x48000000 0 0x10000>,
> > > +		      <0 0x48040000 0 0xc0000>;
> > > +		#interrupt-cells = <3>;
> > > +		interrupt-controller;
> > > +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > > +		interrupt-parent = <&gic>;
> > > +	};
> > > +
> > > +	soc@0 {
> > 
> > Why do we need unit-address '@0' here?
> 
> I follow other i.MX dtsi, imx8m[q/m/n/q] all has it.

Not a great reason, but yes it is needed. A unit-address should be there 
if you have 'reg' or 'ranges' and the latter is true here.

Rob
