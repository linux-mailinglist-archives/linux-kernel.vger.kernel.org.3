Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17DA4761C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhLOTdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhLOTdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:33:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8FC061574;
        Wed, 15 Dec 2021 11:33:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t18so39955603wrg.11;
        Wed, 15 Dec 2021 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=79+FhVBjs4o3yYVhPlsAjU+5rDQFf4+UuCCoWP0VrP8=;
        b=OgYSlRMNbdHZvtFtkran+ccjafcycUS0JZpyIVGxE4Ob4UDAft8ubuW4LddsPECHGL
         3BwIv0mzJcZ/hcx97C/O9TWHbYmuj8HghiKWDl41soxENYdul0TG8L5LI/h+pQ+noqbX
         WVwuWMkbpodIrlZwRJtvfoDiL6vU1xOez1O5yNWkkiE91eL66H1ywh3annGEo7V0ITnw
         B3KeQMVyohARDxHeRMdUmY9ZVss+KuftPfeLxodEhE1fGy0OpxymUipH9e4rMSy5bO3K
         J7YXJQ+7lH8KOeohVdDRbIL10aYm1GoQpnXw4XmhJxcTDs+7QtVxTaq+bpphSqZe98gC
         lYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=79+FhVBjs4o3yYVhPlsAjU+5rDQFf4+UuCCoWP0VrP8=;
        b=2yz5FPwx56tpHoapBJ3Rg7vodfh2Xh8pOZ4JXZ7MFcQozrO8o0PFBL1bwibY10L/23
         hdVzZR/HkKgU6KQwV+ki0QktfgZt7BMuMPxLDN2bQeONfiunKYZzOn2XiHGr/mdAWkYY
         S2gw4V2gqc5fPUsSe3npgW6FVSjUl3YLkta8d0Q+fHGjr1to0BdOqDvWkCCqUwy2Nu3L
         RtQcSBKb0jqHSYQkqlkqJq+UT0woIVEYHYRqY/r7uQR9HAXpdUqo7vX6v6bPu4HzVtDL
         TRCKX7M42gY8hiZ4wIA4B8QcRiNMlH70CN6tIb9Na4UQAa0J06AkpdjUrOuK9BJA/r/a
         jw3g==
X-Gm-Message-State: AOAM531LwBC0QPPGv82FR9BxKU88IjLQs/wXUWGaxaXER51ASyBlGJyW
        jH3x/IECVBDcTLLWqSEOKFE=
X-Google-Smtp-Source: ABdhPJzdnNtSy9sIiHfrr83EJYE7w4XvmIH+FUk2TcetbRS3tuZcEfMFQ3Sj1cJ+pA8drKuEWB4ZMA==
X-Received: by 2002:a5d:6d4c:: with SMTP id k12mr5828831wri.511.1639596784230;
        Wed, 15 Dec 2021 11:33:04 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id s8sm3291108wra.9.2021.12.15.11.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 11:33:03 -0800 (PST)
Message-ID: <bc0a9df0-8ba0-76ed-4522-43a3082f42b4@gmail.com>
Date:   Wed, 15 Dec 2021 20:33:02 +0100
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

Should be:
         memory@40000000 {

                 device_type = "memory";

                 reg = <0 0x40000000 0 0x40000000>;

         };


Please send a follow-up patch for that.

Regards,
Matthias

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
