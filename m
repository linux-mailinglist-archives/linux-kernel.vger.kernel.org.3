Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E402E4761BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhLOTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhLOTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:30:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3FC061574;
        Wed, 15 Dec 2021 11:30:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o13so39931361wrs.12;
        Wed, 15 Dec 2021 11:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y4KYZYbmHmOnFAGiPJsnb/ToH7SegH1Iwoa7ADMxpfw=;
        b=FYtYiM9oyvpPmWHENImMI3pw3mwC0F0efmMKLKouZACetLXHkw1XeSDfAj/OmizJ4b
         XW+lxdwNl0kQe7hYp17Tck/EBCOm5+jnzpbgICjSA0okX16MYe25UBBlS+lZxyRUpahL
         Meyag30sUR8gWfnMtKcv67W9qUkWQC2FpM4SZuFkprrhC7UgWJ3yof777/IVUGSC2dBO
         4X8b04+lDVHeVKYFshCNt2xb/Yjc2PPHUHD5ABhPt6P2sNZEsC6qHq3+ka6O54pWtg9b
         6m7MabQl8gECdoxTxiHYBSE1e3A6uhS9d++mHV5+EuKEA+zaIGp4GK2hYj2VQTE1BcJu
         fhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y4KYZYbmHmOnFAGiPJsnb/ToH7SegH1Iwoa7ADMxpfw=;
        b=Vt8WAieNGg2bSqFmHF7Ge1Qc16Ew+xonu0i6RyJ6RRPkubKc8qWhivtU0IrVxLRzb/
         Ms9dDnCaoh3EtwdQsLRjziXM79d50s1PoDNNEf3mJriqYUeLA0NKk7hY0bfC0OsRn12P
         7aaT7oBycnbKAEA9tJw/n6KWezvlRJUhivvQCelNOrJgXQcYSN41BxV2GdoC4UGiZuNV
         tEoZakSLb7hJBrYaRLuqsPei4L5S3eeyowvzAfKJ1m00775gay5J8bMoj2SPoa6OwL7h
         4D+tqfeWKzDantatJlt5grcLfcY4a1+kTAaT4Rlls8q8ER9xGX2OjQk1/89Ta/vtoAcR
         xy/A==
X-Gm-Message-State: AOAM533cZ0QZ11mABiepA5xK7XRo+oT0CG8bfJ8/Mt7GPKV9w6tvfaGC
        q7hz9Nv6/OWdOQG1kFmHGhE=
X-Google-Smtp-Source: ABdhPJyEek4ofghq1j1jzRaQfwQ9jMNIMvRSegM3Lv8m7+3vrwCSh83lUg1yJBVvl6CoA2lcnZgcSg==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr5587022wrt.689.1639596657651;
        Wed, 15 Dec 2021 11:30:57 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id d16sm2891177wrv.111.2021.12.15.11.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 11:30:57 -0800 (PST)
Message-ID: <4ba7d0ff-3715-8ec1-91c7-26da23ea1709@gmail.com>
Date:   Wed, 15 Dec 2021 20:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 2/2] arm64: dts: mediatek: add basic mt7986 support
Content-Language: en-US
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     John Crispin <john@phrozen.org>, Ryder Lee <Ryder.Lee@mediatek.com>
References: <20211122123222.8016-1-sam.shih@mediatek.com>
 <20211122123222.8016-3-sam.shih@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211122123222.8016-3-sam.shih@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2021 13:32, Sam Shih wrote:
> Add basic chip support for Mediatek mt7986, include
> basic uart nodes, rng node and watchdog node.
> 
> Add cpu node, timer node, gic node, psci and reserved-memory node
> for ARM Trusted Firmware.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> 

Applied to v5.16-next/dts64

Thanks!

> ---
> v8: removed debug bootargs
> v7: added memory node back to dts
> v6: removed clock and pinctrl node, to separate basic part into a single
>      patch series
> 
> Original thread:
> https://lore.kernel.org/all/20211004124155.1404-1-sam.shih@mediatek.com/
> 
> v5: follow reviewr's comment: removed clock freqency node in timer due to
>      we have set CNTFRQ_EL0 in ATF firmware, and also corrected GICD range
> v4: added missing gic register bases, and fixed range of GICR
> v3: used the stdout-path instead of console=ttyS0
> v2: modified clock and uart node due to clock driver updated
> ---
>   arch/arm64/boot/dts/mediatek/Makefile        |   1 +
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts |  37 +++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 148 +++++++++++++++++++
>   3 files changed, 186 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 4f68ebed2e31..e6c3a73b9e4a 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> new file mode 100644
> index 000000000000..6911862390d7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Sam.Shih <sam.shih@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include "mt7986a.dtsi"
> +
> +/ {
> +	model = "MediaTek MT7986a RFB";
> +	compatible = "mediatek,mt7986a-rfb";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		reg = <0 0x40000000 0 0x40000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> new file mode 100644
> index 000000000000..77906839cc85
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Sam.Shih <sam.shih@mediatek.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	system_clk: dummy40m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <40000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x2>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			#cooling-cells = <2>;
> +		};
> +	};
> +
> +	psci {
> +		compatible  = "arm,psci-0.2";
> +		method      = "smc";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon_reserved: secmon@43000000 {
> +			reg = <0 0x43000000 0 0x30000>;
> +			no-map;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x10000>,  /* GICD */
> +			      <0 0x0c080000 0 0x80000>,  /* GICR */
> +			      <0 0x0c400000 0 0x2000>,   /* GICC */
> +			      <0 0x0c410000 0 0x1000>,   /* GICH */
> +			      <0 0x0c420000 0 0x2000>;   /* GICV */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		watchdog: watchdog@1001c000 {
> +			compatible = "mediatek,mt7986-wdt",
> +				     "mediatek,mt6589-wdt";
> +			reg = <0 0x1001c000 0 0x1000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			#reset-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		trng: trng@1020f000 {
> +			compatible = "mediatek,mt7986-rng",
> +				     "mediatek,mt7623-rng";
> +			reg = <0 0x1020f000 0 0x100>;
> +			clocks = <&system_clk>;
> +			clock-names = "rng";
> +			status = "disabled";
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt7986-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x400>;
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&system_clk>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt7986-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x400>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&system_clk>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@11004000 {
> +			compatible = "mediatek,mt7986-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11004000 0 0x400>;
> +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&system_clk>;
> +			status = "disabled";
> +		};
> +
> +	};
> +
> +};
> 
