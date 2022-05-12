Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F74524F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355065AbiELOMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355066AbiELOKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:10:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5823818A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:10:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k126so3115479wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vn7/TcXZx/YPKou36lJ5SmtraXVwL0/BIRBykC2c2Cc=;
        b=ELpy5XjveqTbQ4ADroA70GtG1vEajwTq8gcfIQB+I1nxFpX931aWSnoFQx+h571n++
         yd0fNUi9/fTlPLS57mNb59AkoMA/W5Smp2uJvCki/46uvU7xFFsMClq736XF2e1XJviL
         MD6+7e02pF6Tw628pSOEZ0yseQBub9uk0RL/FDLTgufH/y0UqUqRhS6ai6wpdbu6PmqP
         VMgi8+Pnybu4Af6vZydhwDMbp9dGPytUTX1ZqhhOECd7IWbhgpoobOCYR9dZhMGrRaw1
         eAwZ+6aiNmdIlnsQ+7Vsj6sARBD/c8mN+DrlJuG4arrQto4jDONePgcfP6b7weDDAFov
         TJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vn7/TcXZx/YPKou36lJ5SmtraXVwL0/BIRBykC2c2Cc=;
        b=qUbtZH4c8dTsqNQBBkOhV+x511A28xbOgiaKxi8/l6gQGt4MSAgqie8so+inYvjqn+
         tiDsv6G6CgPlGZtlhb7wyQUTmApzaEy3j8XbAywYm/DmEIcVKZ0Siq3Vc3Eask4vEfm7
         dTHy7HwQBEvYYSGQuXlsV/Ftqr1aim3Jl4OUpZBOnFW+8W7X6vmWdkQsX9HqOeWfCSZY
         jIKVLqv1R6YL+Chm0BzzeIRQ6rahb6P7L861YhFIq0uevtcB2uApB0Koh+oU38goOA82
         Egp5nddcrjgNA9ixS0TdivMpwlQA1m0Zh4onFePcT5gRDPjIzJQZV3+1esdNeaZrUY92
         qiWg==
X-Gm-Message-State: AOAM5317Xn4ZZqrhtpzbMU1dibRiNQBarb/H8kFkqy8D/1Se1wCWXalN
        sC3b7CoqopmQs4Fpky76CJxpKA==
X-Google-Smtp-Source: ABdhPJwsTL8QgcQKZq0wtbtNwGv44FIHOTOX3N5Tmf13Z//DkzY60DPj3KlFflGFpzZV2EIzFfLy5A==
X-Received: by 2002:a1c:f30b:0:b0:37b:b5de:c804 with SMTP id q11-20020a1cf30b000000b0037bb5dec804mr10411340wmq.166.1652364650173;
        Thu, 12 May 2022 07:10:50 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600018d100b0020c5253d90asm4503374wrq.86.2022.05.12.07.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 07:10:49 -0700 (PDT)
Message-ID: <03ac0a67-bd1f-12ca-74f7-8d5b05857ea7@linaro.org>
Date:   Thu, 12 May 2022 16:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V4 3/5] arm64: dts: nuvoton: Add initial support for
 MA35D1
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ychuang570808@gmail.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, soc@kernel.org, cfli0@nuvoton.com
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
 <20220510032558.10304-4-ychuang3@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510032558.10304-4-ychuang3@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 05:25, Jacky Huang wrote:
> Add the initial device tree files for Nuvoton MA35D1 Soc.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  arch/arm64/boot/dts/Makefile               |   1 +
>  arch/arm64/boot/dts/nuvoton/Makefile       |   2 +
>  arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts |  24 +++++
>  arch/arm64/boot/dts/nuvoton/ma35d1.dtsi    | 120 +++++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
>  create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>  create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
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
> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
> new file mode 100644
> index 000000000000..e1e0c466bf5e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-evb.dtb
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
> new file mode 100644
> index 000000000000..95f0facb0476
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for MA35D1 Evaluation Board (EVB)
> + *
> + * Copyright (C) 2022 Nuvoton Technology Corp.
> + */
> +
> +/dts-v1/;
> +#include "ma35d1.dtsi"
> +
> +/ {
> +	model = "Nuvoton MA35D1-EVB";
> +	compatible = "nuvoton,ma35d1-evb", "nuvoton,ma35d1";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x10000000>;
> +	};
> +};
> +


.git/rebase-apply/patch:60: new blank line at EOF.

+

warning: 1 line adds whitespace errors.



> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> new file mode 100644
> index 000000000000..7212f8de6906
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2022 Nuvoton Technology Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +/ {
> +	compatible = "nuvoton,ma35d1";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	hxt_24m: hxt_24mhz {

No underscores in node name. Generic node names, so "clock-X" or
"clock-some-suffix"

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;

This does not look like property of SoC. Where is this clock defined? In
the SoC or on the board?

> +		clock-output-names = "HXT_24MHz";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <12000000>;
> +	};
> +
> +	sys: system-controller@40460000 {
> +		compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";

Why is this a simple-mfd if there are no children here? What do you want
to instantiate here?

Where is the nuvoton,ma35d1-sys compatible documented?

> +		reg = <0x0 0x40460000 0x0 0x400>;
> +	};
> +
> +	reset: reset-controller {
> +		compatible = "nuvoton,ma35d1-reset";

Also not documented.

> +		nuvoton,ma35d1-sys = <&sys>;
> +		#reset-cells = <1>;
> +	};
> +
> +	clk: clock-controller@40460200 {
> +		compatible = "nuvoton,ma35d1-clk";
> +		reg = <0x0 0x40460200 0x0 0x100>;
> +		#clock-cells = <1>;
> +		clocks = <&hxt_24m>;
> +		clock-names = "HXT_24MHz";

Please test your DTS with make dtbs_check.

Don't send DTS which does not pass the checks. It is unnecessary use of
reviewers time when the same job can be done by automated tools.

Best regards,
Krzysztof
