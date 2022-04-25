Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC02F50D8B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiDYFSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiDYFSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:18:22 -0400
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C2681B7;
        Sun, 24 Apr 2022 22:15:17 -0700 (PDT)
Date:   Mon, 25 Apr 2022 07:15:03 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Aparna M <a-m1@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, praneeth@ti.com,
        grygorii.strashko@ti.com, nikhil.nd@ti.com,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: dts: ti: k3-am642-sk: Add DT entry for
 onboard LEDs
Message-ID: <YmYuV3lhncn6RWGQ@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: Aparna M <a-m1@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, praneeth@ti.com,
        grygorii.strashko@ti.com, nikhil.nd@ti.com,
        linux-leds@vger.kernel.org
References: <20220420072952.3509-1-a-m1@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420072952.3509-1-a-m1@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Wed, Apr 20, 2022 at 12:59:52PM +0530 schrieb Aparna M:
> AM642 SK has 8 leds connected to tpic2810 onboard. Add support for these
> gpio leds.
> 
> Signed-off-by: Aparna M <a-m1@ti.com>
> ---
> 
> This patch is dependent on:
> https://lore.kernel.org/all/20220223174215.17838-1-a-m1@ti.com/ 
> 
> RESEND patch has been rebased on top of v5.18-rc2.
> 
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 70 ++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 1d7db8bf3a5c..c5979d03c287 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/mux/ti-serdes.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/net/ti-dp83867.h>
>  #include "k3-am642.dtsi"
>  
> @@ -125,6 +126,67 @@
>  		vin-supply = <&vcc_3v3_sys>;
>  		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
>  	};
> +
> +	leds {

According to Documentation/devicetree/bindings/leds/common.yaml this
should read 'led-controller'.

> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <1>;
> +			gpios = <&exp2 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		led-1 {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <2>;
> +			gpios = <&exp2 1 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		led-2 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <3>;
> +			gpios = <&exp2 2 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		led-3 {
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <4>;
> +			gpios = <&exp2 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		led-4 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <5>;
> +			gpios = <&exp2 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		led-5 {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <6>;
> +			gpios = <&exp2 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		led-6 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <7>;
> +			gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		led-7 {
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <8>;
> +			linux,default-trigger = "heartbeat";
> +			gpios = <&exp2 7 GPIO_ACTIVE_HIGH>;
> +		};

This might also be LED_FUNCTION_HEARTBEAT, but it's probably up to
author's personal preferences?

I added the linux-leds list to Cc.

Greets
Alex

> +	};
>  };
>  
>  &main_pmx0 {
> @@ -274,6 +336,14 @@
>  				  "VPP_LDO_EN", "RPI_PS_3V3_En",
>  				  "RPI_PS_5V0_En", "RPI_HAT_DETECT";
>  	};
> +
> +	exp2: gpio@60 {
> +		compatible = "ti,tpic2810";
> +		reg = <0x60>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "LED1","LED2","LED3","LED4","LED5","LED6","LED7","LED8";
> +	};
>  };
>  
>  &main_i2c3 {
> -- 
> 2.17.1
> 
