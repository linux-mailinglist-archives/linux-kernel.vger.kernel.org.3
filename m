Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7910B524A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352603AbiELK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiELK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:28:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D233CA75
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:28:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so9297399ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GPIjrgvs4BQNA9eCtoSaAMxO4nClRBlQSuiV6w2t7iw=;
        b=u7QsPViOON0my/3Vld/mwSoBJb7PZwySeGRnOJ3yY24HRVfpYdp7uLLQxmI3PtDrhr
         udw+fHERr5nBaDWToCkIOcvYPBrd5Rz08CCqtBhNePRwdkbzaFDt+YXqySK15s2BYJ38
         /sOud++DWMkozAm1jJ3hyXQeU9ZwJVZfm0iBNH02h/TmTDE59fJ1rMhyAwM5wnNijwHD
         sb+n/ofSHeEezWiLWrmTPUH7hm1Ou7DBFkgEFWwVVN/s68UZx6BP6vut/3e+E5HandL6
         Dl3Q7pDovpFzmqQxwz8IAe7G07GS0YfatOAkvHq3uJVgau5Y2YEVQokCGDkvm3Gf+efb
         XIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GPIjrgvs4BQNA9eCtoSaAMxO4nClRBlQSuiV6w2t7iw=;
        b=g1l5A4HtN15j3rJ+0eKgQhnb0Lmlhe1/+R3fCUx4GKArKyYRJAPSMNuX3wclzqkgc8
         RzGpH4fEy1N6l/GQDJogtsHinA9DmJB4jTH5I5Lo0haUZY9lg92yQmgdRzGknzl4KkwR
         eEJuqvtlKuWrp7hnriwBOdaCvRwMTxE1T6Ae3l2lXPdpFSXDWzrClBwNBi4ZB8jByl3F
         vNjBY/blLS+TtlC5nOSzpmei3ucc5S9D4mvTqDaHlbsahZoP1GqdzqwnkmLqjAOIL1zi
         y+xeA0O63dAKwJslL9QlsRi/DNqEcfAmRDPQEXBO/cBa+C65PSrWbvoZdrClRFfAXFet
         OIBg==
X-Gm-Message-State: AOAM530e0C72mob03BCVMmNMPOAnnrN4x9aVLOOvLfZz5wo1IspW1oF5
        7+AwkgUPzwLnINNa9msZVmhXCg==
X-Google-Smtp-Source: ABdhPJz6C1/W+PiAfKbM9TB2mSR6hgAMj4ZX8G5/UhG7wrslGlftRqkvDmWlYsTJem5hepeesEMzQA==
X-Received: by 2002:a17:906:a188:b0:6f4:f5cd:27bd with SMTP id s8-20020a170906a18800b006f4f5cd27bdmr29318356ejy.406.1652351281599;
        Thu, 12 May 2022 03:28:01 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709064cd200b006f3ef214e23sm1911302ejt.137.2022.05.12.03.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 03:28:01 -0700 (PDT)
Message-ID: <32c80a79-abd5-3fd2-cbb4-e2ae93c539da@linaro.org>
Date:   Thu, 12 May 2022 12:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v15 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <daeccdfb9655e549656af0af955a4697871e3ab0.1652329411.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <daeccdfb9655e549656af0af955a4697871e3ab0.1652329411.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 08:31, Qin Jian wrote:
> Add the basic support for Sunplus SP7021-Demo-V3 board.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  MAINTAINERS                                  |   1 +
>  arch/arm/boot/dts/sunplus-sp7021-achip.dtsi  |  85 +++++
>  arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts |  27 ++
>  arch/arm/boot/dts/sunplus-sp7021.dtsi        | 369 +++++++++++++++++++
>  4 files changed, 482 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
>  create mode 100644 arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
>  create mode 100644 arch/arm/boot/dts/sunplus-sp7021.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9cf30e776..b55ec0768 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2747,6 +2747,7 @@ F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
>  F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
>  F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
> +F:	arch/arm/boot/dts/sunplus-sp7021*.dts*
>  F:	arch/arm/configs/sp7021_*defconfig
>  F:	arch/arm/mach-sunplus/
>  F:	drivers/clk/clk-sp7021.c
> diff --git a/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi b/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
> new file mode 100644
> index 000000000..1560c95d9
> --- /dev/null
> +++ b/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for Sunplus SP7021
> + *
> + * Copyright (C) 2021 Sunplus Technology Co.
> + */
> +
> +#include "sunplus-sp7021.dtsi"
> +
> +/ {
> +	compatible = "sunplus,sp7021-achip";

This does not match your bindings.

> +	model = "Sunplus SP7021 (CA7)";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&gic>;
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		extclk: clk@osc0 {

This is not a valid device tree. Please run make dtbs_check and compile
dtbs with W=1.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <27000000>;
> +			clock-output-names = "extclk";
> +		};
> +
> +		divextclk: clk@0 {

How is it suppose to pass any automated checks if there is no unit address?

> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +			clocks  = <&extclk>;
> +			clock-mult = <1>;
> +			clock-div = <2>;
> +			clock-output-names = "extdivclk";
> +		};
> +
> +		A_pll0: clk@A_pll0 {

This is not a valid device tree.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <2000000000>;
> +			clock-output-names = "A_pll0";
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <931000000>;
> +		};
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <1>;
> +			clock-frequency = <931000000>;
> +		};
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <2>;
> +			clock-frequency = <931000000>;
> +		};
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <3>;
> +			clock-frequency = <931000000>;
> +		};
> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +};
> diff --git a/arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts b/arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
> new file mode 100644
> index 000000000..05e164115
> --- /dev/null
> +++ b/arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for Sunplus SP7021 Demo V3 SBC board
> + *
> + * Copyright (C) Sunplus Technology Co.
> + */
> +
> +/dts-v1/;
> +
> +#include "sunplus-sp7021-achip.dtsi"
> +
> +/ {
> +	compatible = "sunplus,sp7021-demo-v3";

This does not match your bindings.

Please run make dtbs_check.

> +	model = "SP7021/CA7/Demo_V3";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 loglevel=8 earlycon";

No bootargs.

I'll stop reviewing. This either does not compile, does not work or does
not pass automated checks. There is no point to use reviewers time if
the tools are doing the same job, so use the tools and then submit DTS.

Best regards,
Krzysztof
