Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E304530E10
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiEWJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiEWJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:08:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E84553B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:08:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v8so22504237lfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+gkruPfauVziDXLSKtJ8JdAtuSmLZSndfwFUO0C6s8M=;
        b=OIqnmTbbaF0wekh3DIkgvMXkfsZ/RKvvw2nH7ZxA93h5C84U43/uP9ghp7+3qzsz+Y
         RpySF754PkAQAcG/htzkhDCT/W4YH3wmPYxmrkC40PK2l27ItrgQ0x0F2LMO7yiI/seR
         zobJm0PqVPlIu4nG6Ufg5ZM3x8OpE10RD3ZCps1Kmkf0HP/tVy+ZAoybDG1F4PvSLnIv
         +wWG3XUilGa3txzLYRDbJ2O3O/Ws5vJ7I0oTGVcuNs5Bo/QWpchqYDEcCLG7G/OtuXR3
         rb0FrHd2MIitgqbMkokhJ5riuRM6zjZNPmDlOXAbOMMaNWofU7S3NqjJTDvKAj/4fLHn
         H15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+gkruPfauVziDXLSKtJ8JdAtuSmLZSndfwFUO0C6s8M=;
        b=CPMmjCU4uWo+WB1fEaoPYbXN0eEPvvYDpz/jOvSPn9283OjrUo9X8TEb/s7gn5+HrK
         XVCVAQTEV2LXGGMU541H/uDdfkgHYxCvya7KPFbAzU7AuRdwNczeivMvKxYeiLEFzEVR
         Iz8cWcPfKptlKbulZnyAja2wfPdcjpH5j+YkzB5qr0D4jaxWFbNoqD+7X0Jnx2up0nPj
         UhPruUwDLjN+NB9W1Fdg3WStTnR+W7G0w6ZJuAvV9/zE/hQDT7WLXhVXf5R/dGOBmWA5
         1KjVLPsh7jEtqtdSc4qSQqs+OWxRHwJUD9IHDcWw3bj9bHDkmJN4RakGnteYbB4n9fiV
         DrVA==
X-Gm-Message-State: AOAM530zV9J/tMhyOXU6cSt/LcbD1LlnBYU8SO1hGwGnqxa+k9KDW1i5
        PZoLWvmyE62/gF6s5I1c+Xskqw==
X-Google-Smtp-Source: ABdhPJxRL0NWt1+XGIYsPk6WVUB63i+n1Q5H+fxE/7J5f8PuLiu7JgwO4ZtbHb98OoYwgXsWvyj/Zw==
X-Received: by 2002:a19:674b:0:b0:477:bd37:f464 with SMTP id e11-20020a19674b000000b00477bd37f464mr15302754lfj.661.1653296888713;
        Mon, 23 May 2022 02:08:08 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q15-20020ac2510f000000b0047255d21124sm1873685lfb.83.2022.05.23.02.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 02:08:08 -0700 (PDT)
Message-ID: <c1b86493-d82d-a639-07af-4c979d733786@linaro.org>
Date:   Mon, 23 May 2022 11:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 17/19] arm64: dts: nuvoton: Add initial NPCM8XX device
 tree
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-18-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-18-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> This adds initial device tree support for the
> Nuvoton NPCM845 Board Management controller (BMC) SoC family.

Thank you for your patch. There is something to discuss/improve.

> 
> The NPCM845 based quad-core Cortex-A35 ARMv8 architecture and
> have various peripheral IPs.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 197 ++++++++++++++++++
>  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  77 +++++++
>  3 files changed, 275 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 1ba04e31a438..7b107fa7414b 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -19,6 +19,7 @@ subdir-y += lg
>  subdir-y += marvell
>  subdir-y += mediatek
>  subdir-y += microchip
> +subdir-y += nuvoton
>  subdir-y += nvidia
>  subdir-y += qcom
>  subdir-y += realtek
> diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> new file mode 100644
> index 000000000000..19c672ecfee7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2021 Nuvoton Technology tomer.maimon@nuvoton.com
> +
> +#include <dt-bindings/clock/nuvoton,npcm8xx-clock.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&gic>;
> +
> +	/* external reference clock */
> +	clk_refclk: clk-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>

This is not a property of a SoC, but board.

> +		clock-output-names = "refclk";
> +	};
> +
> +	/* external reference clock for cpu. float in normal operation */
> +	clk_sysbypck: clk-sysbypck {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1000000000>;

This is not a property of a SoC, but board.


> +		clock-output-names = "sysbypck";
> +	};
> +
> +	/* external reference clock for MC. float in normal operation */
> +	clk_mcbypck: clk-mcbypck {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1050000000>;

This is not a property of a SoC, but board.

> +		clock-output-names = "mcbypck";
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		gcr: gcr@f0800000 {

Generic node names. I guess it is system-controller?

> +			compatible = "nuvoton,npcm845-gcr", "syscon",
> +				"simple-mfd";
> +			reg = <0x0 0xf0800000 0x0 0x1000>;
> +		};
> +
> +		gic: interrupt-controller@dfff9000 {
> +			compatible = "arm,gic-400";
> +			reg = <0x0 0xdfff9000 0x0 0x1000>,
> +			      <0x0 0xdfffa000 0x0 0x2000>,
> +			      <0x0 0xdfffc000 0x0 0x2000>,
> +			      <0x0 0xdfffe000 0x0 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			ppi-partitions {
> +				ppi_cluster0: interrupt-partition-0 {
> +					affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
> +				};
> +			};
> +		};
> +	};
> +
> +	ahb {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		rstc: rstc@f0801000 {

Generic node names.

> +			compatible = "nuvoton,npcm845-reset";
> +			reg = <0x0 0xf0801000 0x0 0x78>;
> +			#reset-cells = <2>;
> +			syscon = <&gcr>;
> +		};
> +
> +		clk: clock-controller@f0801000 {
> +			compatible = "nuvoton,npcm845-clk";
> +			#clock-cells = <1>;
> +			reg = <0x0 0xf0801000 0x0 0x1000>;
> +			clock-names = "refclk", "sysbypck", "mcbypck";
> +			clocks = <&clk_refclk>, <&clk_sysbypck>, <&clk_mcbypck>;
> +		};
> +
> +		apb {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "simple-bus";
> +			interrupt-parent = <&gic>;
> +			ranges = <0x0 0x0 0xf0000000 0x00300000>,
> +				<0xfff00000 0x0 0xfff00000 0x00016000>;
> +
> +			timer0: timer@8000 {
> +				compatible = "nuvoton,npcm845-timer";
> +				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x8000 0x1C>;
> +				clocks	= <&clk_refclk>;
> +				clock-names = "refclk";
> +			};
> +
> +			serial0: serial@0 {
> +				compatible = "nuvoton,npcm845-uart";
> +				reg = <0x0 0x1000>;
> +				clocks = <&clk NPCM8XX_CLK_UART>;
> +				interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			serial1: serial@1000 {
> +				compatible = "nuvoton,npcm845-uart";
> +				reg = <0x1000 0x1000>;
> +				clocks = <&clk NPCM8XX_CLK_UART>;
> +				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			serial2: serial@2000 {
> +				compatible = "nuvoton,npcm845-uart";
> +				reg = <0x2000 0x1000>;
> +				clocks = <&clk NPCM8XX_CLK_UART>;
> +				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			serial3: serial@3000 {
> +				compatible = "nuvoton,npcm845-uart";
> +				reg = <0x3000 0x1000>;
> +				clocks = <&clk NPCM8XX_CLK_UART>;
> +				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			serial4: serial@4000 {
> +				compatible = "nuvoton,npcm845-uart";
> +				reg = <0x4000 0x1000>;
> +				clocks = <&clk NPCM8XX_CLK_UART>;
> +				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			serial5: serial@5000 {
> +				compatible = "nuvoton,npcm845-uart";
> +				reg = <0x5000 0x1000>;
> +				clocks = <&clk NPCM8XX_CLK_UART>;
> +				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			serial6: serial@6000 {
> +				compatible = "nuvoton,npcm845-uart";
> +				reg = <0x6000 0x1000>;
> +				clocks = <&clk NPCM8XX_CLK_UART>;
> +				interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			watchdog0: watchdog@801c {
> +				compatible = "nuvoton,npcm845-wdt";
> +				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x801c 0x4>;
> +				status = "disabled";
> +				clocks = <&clk_refclk>;
> +				syscon = <&gcr>;
> +			};
> +
> +			watchdog1: watchdog@901c {
> +				compatible = "nuvoton,npcm845-wdt";
> +				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x901c 0x4>;
> +				status = "disabled";
> +				clocks = <&clk_refclk>;
> +				syscon = <&gcr>;
> +			};
> +
> +			watchdog2: watchdog@a01c {
> +				compatible = "nuvoton,npcm845-wdt";
> +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0xa01c 0x4>;
> +				status = "disabled";
> +				clocks = <&clk_refclk>;
> +				syscon = <&gcr>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
> new file mode 100644
> index 000000000000..900cee112251
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2021 Nuvoton Technology tomer.maimon@nuvoton.com
> +
> +#include "nuvoton-common-npcm8xx.dtsi"
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&gic>;

You do not have gic here, so it's not correct. Do not reference nodes
outsides of the file.

> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			clocks = <&clk NPCM8XX_CLK_CPU>;
> +			reg = <0x0 0x0>;

Why do you have two address cells? A bit more complicated and not
necessary, I think.

> +			next-level-cache = <&l2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			clocks = <&clk NPCM8XX_CLK_CPU>;
> +			reg = <0x0 0x1>;
> +			next-level-cache = <&l2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			clocks = <&clk NPCM8XX_CLK_CPU>;
> +			reg = <0x0 0x2>;
> +			next-level-cache = <&l2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			clocks = <&clk NPCM8XX_CLK_CPU>;
> +			reg = <0x0 0x3>;
> +			next-level-cache = <&l2>;
> +			enable-method = "psci";
> +		};
> +
> +		l2: l2-cache {
> +			compatible = "cache";

Is this a real compatible? What bindings are you using here?

> +		};
> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,cortex-a35-pmu";
> +		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +	psci {
> +		compatible      = "arm,psci-1.0";
> +		method          = "smc";

Weird indentation.

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +};


Best regards,
Krzysztof
