Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33C94B0988
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiBJJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:32:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiBJJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:32:42 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8135D192
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:32:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i14so8361417wrc.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=sE0UL3RxSE/XJwN6exUr6SQxpMt4J1dNpCV9VXj5qB8=;
        b=6Kvxn9CF7vvjwlRNBuSRaIYc2kaAdU1NmBJa906mzcnrZ3FTns1jEzSgTmAwcB2sIN
         StbgTTyjH6gacUtZ6pRLAeMyE0yJGwYZxu2ar12FNkG9KOtq833+FRvgoGnM8fz1ZQzR
         B25G1FKvtWeQA+mLRHzIrAIHZNopGVG1emKPOtYQffrz9NFZo4I+64xOdg+kjOWswvCc
         jJ/dpqKBndGKD8G9Xjh3gJBupYFiL4lRdXXgUtFVaqs+D4zdrzObABtsRpHcU4Tb7fjD
         RoekasqX2NLZZd2I0G0Pb1xqo1QADJEGag6iaY0iRqBRbVuuvfKOPB+vQnEvI/5KmQsL
         7Hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=sE0UL3RxSE/XJwN6exUr6SQxpMt4J1dNpCV9VXj5qB8=;
        b=JA748BEuO0x/8mB26wNqSBT0zdTLz0Tu4jANS4Ih3UlbVa8HEqGMINSXmdvS6C+qe8
         Fu/QF00zaZAxIxPU3vtUq7pp/ExohDcrmKB3T0hcoLH93FWF54FsU8SgJCvEYk6VCVBH
         zns3tM6P3y0djgE1U2EoqNjGVHagVr6ZYOGs9XMoLAy43/tfUrq8JZUDLA4zbmYv++Of
         gEjFtpe5iv39tn4z1Pkg4vzVRV2GM9r/TF5zTRSsX1OVERkPWX8NEMBCiyhFigdhJGvO
         g1jtMs75gtF38QRqmszY0xqIqd0BMt4uoAmMEaOcphS5+njaneYAIRfUsxntIGrKmVGU
         nYlg==
X-Gm-Message-State: AOAM533qR6r9q5va7NTfuBI/M9DukB7zfWqOTP53hl2woMx9hq9e8UVd
        /fzqYeTKdIIP/Bz/TRxg/9g5zA==
X-Google-Smtp-Source: ABdhPJxaCP++lYv4VszneZqW6IJlYjugiCxUlqoeqTy7SNnnwKM/Nht7WY1oUkjYp5khbO6cggUJpg==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr5611390wri.212.1644485561888;
        Thu, 10 Feb 2022 01:32:41 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:76d9:bf0e:e516:58a9? ([2001:861:44c0:66c0:76d9:bf0e:e516:58a9])
        by smtp.gmail.com with ESMTPSA id bk5sm6690872wrb.10.2022.02.10.01.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 01:32:41 -0800 (PST)
Message-ID: <c2be608a-9ce0-4125-3414-d5f05c1cc528@baylibre.com>
Date:   Thu, 10 Feb 2022 10:32:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] arm64: dts: meson: add support for OSMC Vero 4K+
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
References: <20220210044647.14443-1-christianshewitt@gmail.com>
 <20220210044647.14443-4-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220210044647.14443-4-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/02/2022 05:46, Christian Hewitt wrote:
> The OSMC Vero 4K+ device is based on the Amlogic S905D (P230)
> reference design with the following specifications:
> 
> - 2GB DDR4 RAM
> - 16GB eMMC
> - HDMI 2.1 video
> - S/PDIF optical output
> - AV output
> - 10/100/1000 Ethernet
> - AP6255 Wireless (802.11 a/b/g/n/ac, BT 4.2)
> - 2x USB 2.0 ports (1x OTG)
> - IR receiver (internal)
> - IR extender port (external)
> - 1x micro SD card slot
> - 1x Power LED (red)
> - 1x Reset button (in AV jack)
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Chad Wagner <wagnerch42@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>   .../amlogic/meson-gxl-s905d-vero4k-plus.dts   | 125 ++++++++++++++++++
>   2 files changed, 126 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 13f73ca700ef..0eec18678311 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-vero4k-plus.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts
> new file mode 100644
> index 000000000000..453d51a4b77e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Author: Christian Hewitt <christianshewitt@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxl-s905d.dtsi"
> +#include "meson-gx-p23x-q20x.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	compatible = "osmc,vero4k-plus", "amlogic,s905d", "amlogic,meson-gxl";
> +	model = "OSMC Vero 4K Plus";
> +
> +	reserved-memory {
> +		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
> +		secmon_reserved_bl32: secmon@5300000 {
> +			reg = <0x0 0x05300000 0x0 0x2000000>;
> +			no-map;
> +		};
> +	};

This can be dropped since I applied your "arm64: dts: meson-gx: add ATF BL32 reserved-memory region"

> +
> +	gpio-keys-polled {
> +		compatible = "gpio-keys-polled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		poll-interval = <20>;
> +
> +		button@0 {
> +			label = "power";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-standby {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +			panic-indicator;
> +		};
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 = <&eth_pins>;
> +	pinctrl-names = "default";
> +
> +	phy-mode = "rgmii-txid";
> +	phy-handle = <&external_phy>;
> +
> +	amlogic,tx-delay-ns = <0>;
> +};
> +
> +&external_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		pinctrl-0 = <&eth_phy_irq_pin>;
> +		pinctrl-names = "default";
> +
> +		reg = <0>;
> +		max-speed = <1000>;
> +
> +		/* External PHY reset is shared with internal PHY Led signal */

I don't think this comment is necessary

> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <80000>;
> +		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> +
> +		interrupt-parent = <&gpio_intc>;
> +		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&pinctrl_periphs {
> +	eth_phy_irq_pin: eth-phy-irq {
> +		mux {
> +			groups = "GPIOZ_15";
> +			function = "gpio_periphs";
> +			bias-disable;
> +			output-disable;
> +		};
> +	};
> +};

Add a comment here to specify why you disable bias for the eth irq line.

> +
> +&sd_emmc_a {
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		max-speed = <2000000>;
> +		clocks = <&wifi32k>;
> +		clock-names = "lpo";
> +	};
> +};
> +
> +&usb {
> +	dr_mode = "host";
> +};
> +
> +&usb2_phy0 {
> +	/* HDMI_5V also supplies the USB VBUS */
> +	phy-supply = <&hdmi_5v>;
> +};
> +
> +&usb2_phy0 {
> +	/* HDMI_5V also supplies the USB VBUS */
> +	phy-supply = <&hdmi_5v>;
> +};

With those changes, you can add my:

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
