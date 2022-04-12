Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DB14FE776
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358548AbiDLRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiDLRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:52:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981194756F;
        Tue, 12 Apr 2022 10:49:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q14so24993315ljc.12;
        Tue, 12 Apr 2022 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=bZD6MIHOgstiitM1UOkrGGlVLBJ6vm9PI8DMS7m0H98=;
        b=dymxGqcQwtPQPM6BPjjBYCYZXG8ECnjuvlwfz0ISm2672OAB2V6jnch6NLABRwyi0y
         FbVdqZC84Uwxc61L7KKgWOoReDCbY2oowB86e1km5QKO/4dfaCLjyIZ8pq7Pzg9RVdh7
         EpUZm5M8ciyCUfnTNNlTqCDgxHU5ssagpbiC4FRSbU7B7QRAZltyPEbz/eAng7KM0MSF
         16Hoch8imIBBEWytaRg94lcgTdtXX5y6GsvosltNqBjSdNuw0trpVqzv1764Dnifw8P6
         iuThqU1mdYBbnFc/SgLKE5z5uLerFdr07hOTU2znNxIYd38e5WRRriR9+n+kw3IYH6jX
         ShWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bZD6MIHOgstiitM1UOkrGGlVLBJ6vm9PI8DMS7m0H98=;
        b=Pmrm0FL0JUxG3gpxg15nJVaeAvwBt+ySn2ikN5FsmUisoqBAWuK8aupO5bBtjDUy8P
         NGg0cGWbHz08DjlTXbCC2tJdO9ktis6oeV8tiSsKI/qNBZfiUbDS5bNGAp2jme08FyHY
         6VlDxXednvGaBSVOHrPjfU8EdtGbzJ0gfL7586FFehMPvKfQy7lYzMvOGM3F0QRBjpZ2
         20JQMcY2abSj8mfoZh8qvsf6JcjxfDIvWoDwkp01WL9i/w2idPpfgS49gOX+cYdAyqoz
         Bq9eHksf/x6h6Dl/GB9D4GzKPLzVsC/OpnHND9GsqPPVdVbOCQEDwfT4cYxquAeqRrTl
         IcPg==
X-Gm-Message-State: AOAM53041WpXnve9EQoIZUxSBz942dnZOSnK+rVhZPdKSE82Fnjp/KzI
        QGFkN/js9HMxroHWvFZPaDE=
X-Google-Smtp-Source: ABdhPJxveI9cOFkBq9T1R6cPlKQLl1G0bBU3Tc2fCUa97Rtzngv/cvXMNyWJdUZ4qO6S9gkX0Mnh7A==
X-Received: by 2002:a2e:a362:0:b0:24b:5c8d:3a71 with SMTP id i2-20020a2ea362000000b0024b5c8d3a71mr9752706ljn.305.1649785797726;
        Tue, 12 Apr 2022 10:49:57 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id n26-20020a2e879a000000b0024b47286a60sm1666071lji.135.2022.04.12.10.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 10:49:57 -0700 (PDT)
Message-ID: <ab529968-7dc5-f4c9-5ce4-5dc95b64838f@gmail.com>
Date:   Tue, 12 Apr 2022 19:49:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] ARM: dts: BCM5301X: Add DT for Buffalo WZR-1166DHP2
To:     SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220412154432.12124-1-takayoshi.shimamoto.360@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220412154432.12124-1-takayoshi.shimamoto.360@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.2022 17:44, SHIMAMOTO Takayoshi wrote:
> Buffalo WZR-1166DHP2  wireless router with
> 
>   - BCM4708A0
>   - 256MiB DDR2 SDRAM
>   - 128MiB NAND flash
>   - 2T2R 11ac/a/b/g/n Wi-Fi
>   - 4x 10/100M ethernet switch

Isn't that 10/100/1000?


> The hardware configuration is very similar to the WZR-1750DHP,
> except for memory size and number of antennas.
> 
> Signed-off-by: SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
> ---
>   .../boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts | 189 ++++++++++++++++++
>   1 file changed, 189 insertions(+)
>   create mode 100644 arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts
> 
> diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts
> new file mode 100644
> index 000000000000..22e54a0a202a
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Broadcom BCM470X / BCM5301X ARM platform code.
> + * DTS for Buffalo WZR-1166DHP2
> + *
> + * Copyright (C) 2014 Rafał Miłecki <zajec5@gmail.com>
> + * Copyright (C) 2022 SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "bcm4708.dtsi"
> +#include "bcm5301x-nand-cs0-bch8.dtsi"
> +
> +/ {
> +	compatible = "buffalo,wzr-1166dhp2", "brcm,bcm4708";
> +	model = "Buffalo WZR-1166DHP2 (BCM4708)";

We stopped adding SoC name to the "model" value, please drop it.


> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x08000000>,
> +		      <0x88000000 0x08000000>;
> +	};
> +
> +	spi {
> +		compatible = "spi-gpio";
> +		num-chipselects = <1>;
> +		gpio-sck = <&chipcommon 7 0>;
> +		gpio-mosi = <&chipcommon 4 0>;
> +		cs-gpios = <&chipcommon 6 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hc595: gpio_spi@0 {
> +			compatible = "fairchild,74hc595";
> +			reg = <0>;
> +			registers-number = <1>;
> +			spi-max-frequency = <100000>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		usb {
> +			label = "bcm53xx:blue:usb";
> +			gpios = <&hc595 0 GPIO_ACTIVE_HIGH>;
> +			trigger-sources = <&ohci_port1>, <&ehci_port1>,
> +					  <&xhci_port1>, <&ohci_port2>,
> +					  <&ehci_port2>;
> +			linux,default-trigger = "usbport";
> +		};
> +
> +		power0 {
> +			label = "bcm53xx:red:power";
> +			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		power1 {
> +			label = "bcm53xx:white:power";
> +			gpios = <&hc595 2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		router0 {
> +			label = "bcm53xx:blue:router";
> +			gpios = <&hc595 3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		router1 {
> +			label = "bcm53xx:amber:router";
> +			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		wan {
> +			label = "bcm53xx:blue:wan";
> +			gpios = <&hc595 5 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		wireless0 {
> +			label = "bcm53xx:blue:wireless";
> +			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		wireless1 {
> +			label = "bcm53xx:amber:wireless";
> +			gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
> +		};
> +	};

I'm wondering if all new DTS files should use "function" and "color"
instead of "label". That's preferred solution and I guess it's good idea
to use it for new code.
