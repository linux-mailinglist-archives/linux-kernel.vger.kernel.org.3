Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF25B1BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiIHLpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiIHLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:45:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D6043328
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:45:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so14968076lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PUtAz8desguEl68/tce2iU0pKPCrbs6PkBvi143GG70=;
        b=YhydizFsw7cEJmWpahaOj9cS4+Mi1J22/pZvVKZN6es+rvSLsmlGzC1EAzeCGpJBcD
         CxS3hzf5OHMiX8vZPswF98/HFk0B1EPYTruLbkbrNli5Esn8b5LNlJ4inQKhqzIKpGsC
         PYTfkI5IOowADtPFndpiYvm5ARRgvzmescL1rO86uQTrMopdf2WrI4YEU+lZFbRw+aPE
         ruhk2v/O6E2QnJGVS0FWxQxXTw/tfxQLZnkwj0g9gB/QH2xOog53SZKoPJOpQT3DvATP
         abRcnd8miZXtLC4K35CyEkhvRoyjzRIXXzMB99EhI6KC4B3/BsXPtbNS5OVOqe7O94W8
         Ww6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PUtAz8desguEl68/tce2iU0pKPCrbs6PkBvi143GG70=;
        b=sCRbdi36CFg6kmfz192Fz22doOUsdMAhgbZPh9FsUquIm5Lq32mFGQCZQl9DSo/H5B
         IFjH4oL1lI0coKS1e0WNVdNDZ0bA13dUF1GFGLLd4WMx8pL6cPKoSe0NjctLOHd/cqeT
         2B9agHTYg01/+XkQb+f/islQ7r6zJ6lAHIDhBW9hCo0JM+9zLKRGZbpQccGlWPTpduK0
         dGVd9YhBvDBNcJKq0zf1Lc+Q8jzdzh+6E5X14DWg2R5mm7lbddSwVGFQX7CN53lWvTHq
         EnlF+4iaWKxaa+niA5FLIPwc2A0Jk+iiS+0t7xgVe0QkuQkQsA6aGCUE08Lcwd7ZYKOi
         So2A==
X-Gm-Message-State: ACgBeo1Sx6K42/A9sGh/GgYj1WWiijw0VuIZ3vMTEZspSxvjoVHEbH/e
        q1EWUTovr31p8dRc4bMjdISwsA==
X-Google-Smtp-Source: AA6agR4yFLlg0sc/a+7CfHprstIMk3AieUmLr2WL1tjMivUvWIUcHOv+rRcX5m5EW+ouucid19iGow==
X-Received: by 2002:ac2:4e10:0:b0:498:f132:d5c1 with SMTP id e16-20020ac24e10000000b00498f132d5c1mr609014lfr.648.1662637512841;
        Thu, 08 Sep 2022 04:45:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n27-20020a05651203fb00b0048a757d1303sm2994356lfq.217.2022.09.08.04.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:45:12 -0700 (PDT)
Message-ID: <bc6f19f3-0825-7c9c-c11d-92474bb12375@linaro.org>
Date:   Thu, 8 Sep 2022 13:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Content-Language: en-US
To:     Jerry Ray <jerry.ray@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220902192236.14862-2-jerry.ray@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902192236.14862-2-jerry.ray@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 21:22, Jerry Ray wrote:
> The SAMA5D3-EDS board is an Ethernet Development Platform allowing for
> evaluating many Microchip ethernet switch and PHY products.  Various
> daughter cards can connect up via an RGMII connector or an RMII connector.
> 
> The EDS board is not intended for stand-alone use and has no ethernet
> capabilities when no daughter board is connected.  As such, this device
> tree is intended to be used with a DT overlay defining the add-on board.
> To better ensure consistency, some items are defined here as a form of
> documentation so that all add-on overlays will use the same terms.
> 
> Google search keywords: "Microchip SAMA5D3-EDS"
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> ---
> v5->v6:
>  - Replaced underscores in names where I can, improving naming.
> v4->v5:
>  - patch now applies to v6.0-rc2
> v3->v4:
>  - Fixed regulators as necessary to get the board to boot from SD Card.
> v2->v3:
>  - Alphabetized pinctrl entries.
>  - cleaned up a warning in the regulators section.
>  - License tweaked to 'OR MIT'
>  - Included Makefile change
> v1->v2:
>  - Modified the compatible field in the device tree to reflect Microchip
>    Ethernet Development System Board.
> ---
>  arch/arm/boot/dts/Makefile             |   1 +
>  arch/arm/boot/dts/at91-sama5d3_eds.dts | 309 +++++++++++++++++++++++++
>  2 files changed, 310 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d3_eds.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..e92e639a2dc3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -61,6 +61,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-sama5d2_icp.dtb \
>  	at91-sama5d2_ptc_ek.dtb \
>  	at91-sama5d2_xplained.dtb \
> +	at91-sama5d3_eds.dtb \
>  	at91-sama5d3_ksz9477_evb.dtb \
>  	at91-sama5d3_xplained.dtb \
>  	at91-dvk_som60.dtb \
> diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts b/arch/arm/boot/dts/at91-sama5d3_eds.dts
> new file mode 100644
> index 000000000000..b4fe1c5f2997
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d3_eds.dts
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * at91-sama5d3_eds.dts - Device Tree file for the SAMA5D3 Ethernet
> + *    Development System board.
> + *
> + * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Jerry Ray <jerry.ray@microchip.com>
> + */
> +/dts-v1/;
> +#include "sama5d36.dtsi"
> +
> +/ {
> +	model = "SAMA5D3 Ethernet Development System";
> +	compatible = "microchip,sama5d3-eds", "atmel,sama5d36",
> +		     "atmel,sama5d3", "atmel,sama5";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clocks {
> +		slow_xtal {

No underscores in node names. Override by label.

> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <12000000>;
> +		};
> +	};
> +
> +	gpio {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio>;
> +
> +		button-3 {
> +			label = "PB_USER";
> +			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
> +			linux,code = <0x104>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	memory@20000000 {
> +		reg = <0x20000000 0x10000000>;
> +	};
> +
> +	vcc_3v3_reg: buck-regulator-1 {

Keep consistent prefix or suffix, so:
regulator-buck-1

> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_2v5_reg: ldo-regulator-2 {

regulator-ldo-1
(why numbering of LDO regulators starts from 2? keep some sense in this)


> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_2V5";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_3v3_reg>;
> +	};
> +
> +	vcc_1v8_reg: ldo-regulator-3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_3v3_reg>;
> +	};
> +
> +	vcc_1v2_reg: buck-regulator-4 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_1V2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_mmc0_reg: fixedregulator-mmc0 {

Just regulator-mmc0

> +		compatible = "regulator-fixed";
> +		regulator-name = "mmc0-card-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_vcc_mmc0_reg_gpio>;
> +		gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
> +	};


Best regards,
Krzysztof
