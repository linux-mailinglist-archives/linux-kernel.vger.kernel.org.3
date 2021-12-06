Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04466469484
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhLFLAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241980AbhLFLAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:00:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF2C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 02:57:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso10068735wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 02:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Og4d+0J+D9XBip4Glln9SQpuxIVWP+20n5XjcghlMp8=;
        b=IsAua1IAP1z5CUNMqn5XZ7vWJYX1PnAQWEJBOhPlNn6F9/q6+/oBam9orG+0r3Nnsj
         8x+Av69kMJ1SMWC5ze/PMN2igdPbpRVzQyNQUdqYxRa+LThlLNvZ5V0uYwx5AxCE+G7e
         0VWbXkf8Sf+KY/N498s9aAhPmM7hpylXroPp73xvKE1E9bBFR9Lc6R0wkD4Qj1VYhsRS
         EaNKhTluSampSAOWFOdKbb3MzidzWGpAnqOFfnGs13r8btIXA5KMJYGrZjmsswinHq2B
         kXiOt7E3ic+PIfRmN/tyqqxsi99e/pV+1Br3hgFnVKxd89XuYBwAgVL+XyVYmSFPk0sq
         Ihww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Og4d+0J+D9XBip4Glln9SQpuxIVWP+20n5XjcghlMp8=;
        b=VBQXwvjfMJN+VA8hI6WTtcFEChxoEjq27u7Qm/m9gbvs2Etg2HgilG+fojayTdGHtg
         8KhM8mBOmByeBIzAofo0bLoBzFR4I+bz9dS+MwPphj053z0Rkekx/vrnQnKNwKJeR+29
         Vna5dXOZCBou5mw+T1Y2cetCcx3oWuCe6AltK5Mz7wx+HoqoZF2hpUI8YOwFD899pqyO
         tCm+K02i0aQFVbACymNp1cOkBovAcFfsSVh5vn3NZ20daQ9Dq6l5zTLTQLaUHp+wYMMe
         cktLMLpzGhQHUD9AGyiy/+rBE5MmNLG967m5ZC7QQCpfPnr6pA7eI6l4GpNYMIC8ZPdg
         4b0g==
X-Gm-Message-State: AOAM532rOgP6vtKzhOQzRm1TX5mkWSSNsgANcFKn6YAgMT8825rnechC
        H9NgF3Uz0aNn2dz6kO5VO+SSbQ==
X-Google-Smtp-Source: ABdhPJyNMlSeQmABbFLDeE9E3YkY/0bH/WkPssvqGe97C395cdU2wnYMEMKNauY/7YgLR+JCPW820w==
X-Received: by 2002:a1c:23d4:: with SMTP id j203mr36956959wmj.35.1638788229940;
        Mon, 06 Dec 2021 02:57:09 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:70c1:5ce3:e1aa:1275? ([2001:861:44c0:66c0:70c1:5ce3:e1aa:1275])
        by smtp.gmail.com with ESMTPSA id e7sm13895884wrg.31.2021.12.06.02.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 02:57:09 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: add support for S4 based Amlogic AQ222
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20211206100209.31971-1-xianwei.zhao@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <f20968ff-667f-3fd9-3f8e-af8eced694f0@baylibre.com>
Date:   Mon, 6 Dec 2021 11:57:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211206100209.31971-1-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/12/2021 11:02, xianwei.zhao wrote:
> Add basic support for the Amlogic S4 based Amlogic AQ222 board:
> which describe components as follows: CPU, GIC, IRQ, Timer, UART.
> It's capable of booting up into the serial console.
> 
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../dts/amlogic/meson-s4-s805x2-aq222.dts     | 30 ++++++
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 98 +++++++++++++++++++
>  3 files changed, 129 insertions(+)
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
> index 000000000000..6b6ecb40be4a
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
> +	model = "Amlogic";

Please change to something like "Amlogic Meson S4 AQ222 Development Board"

> +	compatible = "amlogic, aq222";

Drop the space after amlogic, and add "amlogic,aq222" to the Documentation/devicetree/bindings/arm/amlogic.yaml bindings.

You will probably need to add a new "amlogic,s4" family compatibla aswell.

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
> +		linux,usable-memory = <0x0 0x0 0x0 0x40000000>;

Drop linux,usable-memory in favor or reg

> +	};
> +
> +};
> +
> +&uart_B {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> new file mode 100644
> index 000000000000..b66f62701063
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

Add blank line hiere

> +/ {
> +	cpus:cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0:cpu@0 {
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
> +		interrupts = <GIC_PPI 13 0xff08>,
> +			     <GIC_PPI 14 0xff08>,
> +			     <GIC_PPI 11 0xff08>,
> +			     <GIC_PPI 10 0xff08>;
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
> +			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xfff01000 0 0x1000>,
> +			      <0x0 0xfff02000 0 0x0100>;
> +			interrupts = <GIC_PPI 9 0xf04>;
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
> +				compatible = "amlogic,meson-gx-uart",
> +					     "amlogic,meson-ao-uart";

use the proper compatibles for s4


> +				reg = <0x0 0x7a000 0x0 0x18>;
> +				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				xtal_tick_en = <1>;

Drop this property

> +				fifo-size = <64>;

No need to specify if 64

> +			};
> +		};
> +	};
> +};
> 
> base-commit: c5468e3c930d4d2937d3a842a85df0f74e95e152
> 

Thanks,
Neil
