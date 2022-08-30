Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80785A5FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiH3J5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiH3J4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:56:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC58674CE3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:56:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m2so11008386lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+xLHUDTYBc3UaJkFgsG8PBcHuZM2edqL26WhGuAdRJU=;
        b=Prwdn44F4/FDwx6yd4rKKr8AGvuL920Qsh5GKkCUTxB7QfBjc/Sm5EtDm9kHpDppjX
         dEZuHqJ0VQlsEHmVCYYsPgq2eICAZdThWNd1xNW6YEvyQTmYUaz2NMKYjj3iyzjs5Ewg
         qjJZJ+SunRTJdVyOuhw9vpVq9TS0n36I20hYv8n43REv4rBfVyWY3fikV1TFXfLpgVS6
         DpnDo2UxBC7kusFSWEBJ1ATHpZCsGbibqJpm+aMOz2LdphdWGIirohu+4gRD6breaiFO
         6HzPOA7m/zInHjZNdH4Ar2m/x/CzGtXD1wpGKJeD+KpUy6xcpkNQKJLJNF/TgzSM7Gcr
         2XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+xLHUDTYBc3UaJkFgsG8PBcHuZM2edqL26WhGuAdRJU=;
        b=MhyUrXb78bFSuWVfd4UjQcLIIV11DzP9wyrVK932/NnWSqzTu3a58q1pUqjLhbF5EL
         8VaiCy+qkfGSYoFMn13vjul2VauheuFEmE0S2aA0fGm1mlclXfukBZ9ptbJnO9fOlkx9
         SY7A7nPUddlkt+eHfSPIA6X1alXygai/Cz3d2mJjMZA+MxKhb/1fBS+RtjfKwzgP1bEd
         lPENokwBsUXmV/BjhcrmgxoAY26L6neWyz/AwM+VaUVzTkOZ36iWhIjrjlhtwobCX08h
         mV/EU82vh2YEJTGYgNwKPELggVM1KjRwOTGlCtc82ttg8Zy4iZw/DUNpfegCHOTdFUmy
         y2lw==
X-Gm-Message-State: ACgBeo1+LXPsUn0Bc9Ryt8/TCFHcASJDxXyTs7Jq97A+kmsphlvluRjP
        zMhiI84iMlpkIZ00kN5gdAnDqw==
X-Google-Smtp-Source: AA6agR7DZ5T653+lqX5nzOG1ANUp2esh0yQ4JBCPVnRcL5voskEe1tpg253c3IkeR3cdOVGADL4wbA==
X-Received: by 2002:ac2:4465:0:b0:493:b4:c4ac with SMTP id y5-20020ac24465000000b0049300b4c4acmr7164310lfl.446.1661853375162;
        Tue, 30 Aug 2022 02:56:15 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id q16-20020a0565123a9000b00492a0f02758sm1564316lfu.28.2022.08.30.02.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:56:14 -0700 (PDT)
Message-ID: <dc971b60-c2be-aabb-20d6-181ea34d55c4@linaro.org>
Date:   Tue, 30 Aug 2022 12:56:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/4] arm64: dts: ti: Introduce AM62A7 family of SoCs
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bryan Brattlof <bb@ti.com>
References: <20220829082200.241653-1-vigneshr@ti.com>
 <20220829082200.241653-4-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829082200.241653-4-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 11:21, Vignesh Raghavendra wrote:

(...)

> +		/*
> +		 * vcpumntirq:
> +		 * virtual CPU interface maintenance interrupt
> +		 */
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		gic_its: msi-controller@1820000 {
> +			compatible = "arm,gic-v3-its";
> +			reg = <0x00 0x01820000 0x00 0x10000>;
> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;
> +			msi-controller;
> +			#msi-cells = <1>;
> +		};
> +	};
> +
> +	main_conf: syscon@100000 {
> +		compatible = "syscon", "simple-mfd";

No, these are not allowed alone.

> +		reg = <0x00 0x00100000 0x00 0x20000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x00100000 0x20000>;
> +	};
> +
> +	dmss: bus@48000000 {
> +		compatible = "simple-mfd";

No. Not allowed alone.

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-ranges;
> +		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06000000>;
> +
> +		ti,sci-dev-id = <25>;
> +
> +		secure_proxy_main: mailbox@4d000000 {
> +			compatible = "ti,am654-secure-proxy";
> +			#mbox-cells = <1>;
> +			reg-names = "target_data", "rt", "scfg";
> +			reg = <0x00 0x4d000000 0x00 0x80000>,
> +			      <0x00 0x4a600000 0x00 0x80000>,
> +			      <0x00 0x4a400000 0x00 0x80000>;
> +			interrupt-names = "rx_012";
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +
> +	dmsc: system-controller@44043000 {
> +		compatible = "ti,k2g-sci";
> +		ti,host-id = <12>;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 12>,
> +			<&secure_proxy_main 13>;
> +		reg-names = "debug_messages";
> +		reg = <0x00 0x44043000 0x00 0xfe0>;

First compatible, then reg, then the reset of properties.  This applies
everywhere.

> +
> +		k3_pds: power-controller {
> +			compatible = "ti,sci-pm-domain";
> +			#power-domain-cells = <2>;
> +		};
> +
> +		k3_clks: clock-controller {
> +			compatible = "ti,k2g-sci-clk";
> +			#clock-cells = <2>;
> +		};
> +
> +		k3_reset: reset-controller {
> +			compatible = "ti,sci-reset";
> +			#reset-cells = <2>;
> +		};
> +	};
> +
> +	main_pmx0: pinctrl@f4000 {
> +		compatible = "pinctrl-single";
> +		reg = <0x00 0xf4000 0x00 0x2ac>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	main_uart0: serial@2800000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02800000 0x00 0x100>;
> +		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 146 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	main_uart1: serial@2810000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02810000 0x00 0x100>;
> +		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 152 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	main_uart2: serial@2820000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02820000 0x00 0x100>;
> +		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 153 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	main_uart3: serial@2830000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02830000 0x00 0x100>;
> +		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 154 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	main_uart4: serial@2840000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02840000 0x00 0x100>;
> +		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 155 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 155 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	main_uart5: serial@2850000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02850000 0x00 0x100>;
> +		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 156 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	main_uart6: serial@2860000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02860000 0x00 0x100>;
> +		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 158 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	main_i2c0: i2c@20000000 {
> +		compatible = "ti,am64-i2c", "ti,omap4-i2c";
> +		reg = <0x00 0x20000000 0x00 0x100>;
> +		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 102 2>;
> +		clock-names = "fck";
> +		status = "disabled";
> +	};
> +
> +	main_i2c1: i2c@20010000 {
> +		compatible = "ti,am64-i2c", "ti,omap4-i2c";
> +		reg = <0x00 0x20010000 0x00 0x100>;
> +		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 103 2>;
> +		clock-names = "fck";
> +		status = "disabled";
> +	};
> +
> +	main_i2c2: i2c@20020000 {
> +		compatible = "ti,am64-i2c", "ti,omap4-i2c";
> +		reg = <0x00 0x20020000 0x00 0x100>;
> +		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 104 2>;
> +		clock-names = "fck";
> +		status = "disabled";
> +	};
> +
> +	main_i2c3: i2c@20030000 {
> +		compatible = "ti,am64-i2c", "ti,omap4-i2c";
> +		reg = <0x00 0x20030000 0x00 0x100>;
> +		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 105 2>;
> +		clock-names = "fck";
> +		status = "disabled";
> +	};
> +
> +	main_gpio_intr: interrupt-controller@a00000 {
> +		compatible = "ti,sci-intr";
> +		reg = <0x00 0x00a00000 0x00 0x800>;
> +		ti,intr-trigger-type = <1>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic500>;
> +		#interrupt-cells = <1>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <3>;
> +		ti,interrupt-ranges = <0 32 16>;
> +		status = "disabled";
> +	};
> +
> +	main_gpio0: gpio@600000 {
> +		compatible = "ti,am64-gpio", "ti,keystone-gpio";
> +		reg = <0x00 0x00600000 0x0 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <190>, <191>, <192>,
> +			     <193>, <194>, <195>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <87>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 77 0>;
> +		clock-names = "gpio";
> +		status = "disabled";
> +	};
> +
> +	main_gpio1: gpio@601000 {
> +		compatible = "ti,am64-gpio", "ti,keystone-gpio";
> +		reg = <0x00 0x00601000 0x0 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <180>, <181>, <182>,
> +			     <183>, <184>, <185>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <88>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 78 0>;
> +		clock-names = "gpio";
> +		status = "disabled";
> +	};
> +
> +	sdhci1: mmc@fa00000 {
> +		compatible = "ti,am62-sdhci";
> +		reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
> +		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		ti,trm-icp = <0x2>;
> +		ti,otap-del-sel-legacy = <0x0>;
> +		ti,otap-del-sel-sd-hs = <0x0>;
> +		ti,otap-del-sel-sdr12 = <0xf>;
> +		ti,otap-del-sel-sdr25 = <0xf>;
> +		ti,otap-del-sel-sdr50 = <0xc>;
> +		ti,otap-del-sel-sdr104 = <0x6>;
> +		ti,otap-del-sel-ddr50 = <0x9>;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-sd-hs = <0x0>;
> +		ti,itap-del-sel-sdr12 = <0x0>;
> +		ti,itap-del-sel-sdr25 = <0x0>;
> +		ti,clkbuf-sel = <0x7>;
> +		bus-width = <4>;
> +		no-1-8-v;
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
> new file mode 100644
> index 000000000000..6d1e501b94ab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for AM625 SoC Family MCU Domain peripherals
> + *
> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_mcu {
> +	mcu_pmx0: pinctrl@4084000 {
> +		compatible = "pinctrl-single";
> +		reg = <0x00 0x04084000 0x00 0x88>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +		status = "disabled";
> +	};
> +
> +	mcu_uart0: serial@4a00000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x04a00000 0x00 0x100>;
> +		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 149 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	mcu_i2c0: i2c@4900000 {
> +		compatible = "ti,am64-i2c", "ti,omap4-i2c";
> +		reg = <0x00 0x04900000 0x00 0x100>;
> +		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 106 2>;
> +		clock-names = "fck";
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> new file mode 100644
> index 000000000000..fe6d682a0f33
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for AM62A SoC Family Wakeup Domain peripherals
> + *
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_wakeup {
> +	wkup_conf: syscon@43000000 {
> +		compatible = "syscon", "simple-mfd";

No. Not allowed alone.

> +		reg = <0x00 0x43000000 0x00 0x20000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x43000000 0x20000>;
> +
> +		chipid: chipid@14 {
> +			compatible = "ti,am654-chipid";
> +			reg = <0x14 0x4>;
> +		};
> +	};
> +


Best regards,
Krzysztof
