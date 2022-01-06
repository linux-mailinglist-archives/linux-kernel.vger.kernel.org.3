Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890E5486315
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiAFKoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiAFKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:44:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540F8C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 02:44:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e9so2387577wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 02:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=PKWBIi6a8SdDtPhqTyUsUTZnQv4uEA9nTaXqosHfFQ8=;
        b=QvYMu07/RXFZUHn2n5wKxcARy/eXsiDll5Welgu5imO/aTl80/anyx8W86lbQ+TYP9
         ba3NG+S3qTcDzFWA7it9DzPXbyePTAvsW12Fdt/G/MyonCvXm3YntwDgb8u5e8gtqcpS
         4uAltJbMH0jOjrLTvYXqcZYz5GjVn0GYA2N/rrJ4b9IkYm+dB/TPCzZQJb8+CPsdV6V+
         T/2ZSvZS5b4dfr+AdrqwCaN6SMU8Y27YBdoE39yNy/68RM11Yq0GOPOpq53KvkjXT/3K
         Wddc1bv15TI/UPMh4K1JA0qUY2JV7x2B4yxGf5bIfREILFLbARQ6ZW7Gg7g9dko6mcNp
         uaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=PKWBIi6a8SdDtPhqTyUsUTZnQv4uEA9nTaXqosHfFQ8=;
        b=lSR0fECkGl+W4kTbXQunb5eSgrE43s1nebHk1eeZd5QyAqRK0I4CLFDIyOABZXnpXk
         cG4crvukoLdHdewt6/NqvNTdf6HgqieHpsDAdyIIlJmnmbruWw4I4cVpiYSeGPXQIpx9
         2/vrWv/cvgAK9VU91n3g0GAzy1ODRl9FAK7lolORGLsANKcXU58jo2iTufM0/Y95dKeX
         hA6FxyPiNED0lm3CIAETt+iTSKSaxEB7KdV4T7PgS+mzGOF2fX0HzwzkFehu2yQR2KFl
         S81rj+vRJrOAxDnSFw9MPTQANKpsKhN0kAIqXcIomNz2kkJdLvj1EnpK56CM80DlC02G
         JSjA==
X-Gm-Message-State: AOAM532U/QUrvyb8sJ4WYFG/7E4EI4xvknyhUtHvejDrmzUMJV+S+VfA
        q6lwXIx5W3lU5NatmrZ+CYcMS+7/5pT2iq1A
X-Google-Smtp-Source: ABdhPJz4xvH/qvlvsr2w0SX5CYPq1+L3lKCAwpeljttFNNBFzXqDjjxjdsehLVw7cd+uvfZ8SOArVQ==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr49757766wrt.117.1641465846893;
        Thu, 06 Jan 2022 02:44:06 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id b5sm1670403wrr.19.2022.01.06.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 02:44:06 -0800 (PST)
References: <20220106054724.18637-1-xianwei.zhao@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V3] arm64: dts: add support for S4 based Amlogic AQ222
Date:   Thu, 06 Jan 2022 11:41:21 +0100
In-reply-to: <20220106054724.18637-1-xianwei.zhao@amlogic.com>
Message-ID: <1jv8yx5ekq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 06 Jan 2022 at 13:47, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Add basic support for the Amlogic S4 based Amlogic AQ222 board:
> which describe components as follows: CPU, GIC, IRQ, Timer, UART.
> It's capable of booting up into the serial console.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V2 -> V3: add of dts board  compatible family
> V1 -> V2: cleaned up coding style, modify CPU affinity of timer interrups,
>           and modify GIC reg defintions.
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../dts/amlogic/meson-s4-s805x2-aq222.dts     | 30 ++++++
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 99 +++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 5148cd9e5146..faea74a45994 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -57,3 +57,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> new file mode 100644
> index 000000000000..a942d7e06d6e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-s4.dtsi"
> +
> +/ {
> +	model = "Amlogic Meson S4 AQ222 Development Board";
> +	compatible = "amlogic,aq222", "amlogic,s4";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart_B;
> +	};
> +
> +	memory@00000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +};
> +
> +&uart_B {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> new file mode 100644
> index 000000000000..d7083c93d3d0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	cpus:cpus {
            ^ space after : ?

Do we need the alias here ?

> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0:cpu@0 {
                    ^ space after : ?

Why is the alias uppercase ?

same for the other nodes

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35","arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		CPU1:cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35","arm,armv8";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		CPU2:cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35","arm,armv8";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		CPU3:cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35","arm,armv8";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@fff01000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xfff01000 0 0x1000>,
> +			      <0x0 0xfff02000 0 0x2000>,
> +			      <0x0 0xfff04000 0 0x2000>,
> +			      <0x0 0xfff06000 0 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		apb4: apb4@fe000000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xfe000000 0x0 0x480000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> +
> +			uart_B: serial@7a000 {
> +				compatible = "amlogic,meson-s4-uart",
> +					     "amlogic,meson-ao-uart";
> +				reg = <0x0 0x7a000 0x0 0x18>;
> +				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +			};
> +		};
> +	};
> +};
>
> base-commit: c5468e3c930d4d2937d3a842a85df0f74e95e152

