Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC229542DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiFHKbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiFHK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:29:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C1E8A074
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:21:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so40527520eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+bPvkCIqs6A3Lw8cRRemx4/EkW0G1asPn8kHboHtVJY=;
        b=wDIlVKTWdiWhZ8wBWJY6cKiaQFw8rDj207bvbTp/h11ey3tP6nET1Ax/CdHjZfLIEV
         bWnJx67yUwmZnAjjjd5Pnmh8VhMfnKk9ZGg+xoCyY9GLA3nn7mGO8lVMAqq0oiDn/3Gb
         RdEmlcoDLk/NATza/gALLbwlAadFQrZRy9MfXKJk8j2q4AuOEEZ+zY7bealsPyXM8b4Y
         ih+WRBDp4jQzRDyApQ0uO+L54w+TGVWPyUYM9CH3Ot8Y/Q0bHkVx4jxyiDXFnpuvcBiT
         7waY/rXX63WmY9xsunaYaDRWKXRiJMMbWedZPkAKAn6m/lwDnhiKftwSsfbgmiXgBvuN
         pGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+bPvkCIqs6A3Lw8cRRemx4/EkW0G1asPn8kHboHtVJY=;
        b=Jp3czPCD+QHtsCAr4ZE0x9CiFPKsnHAOieLPPgdvDeMlUPMBj1r/cX0JeghgRXWxhY
         P+3oeqdf6HpWmsux9mDoQQte7lIKW97AkAFYtMBJ2UbDsXL9W07c/RYgrUyD7Ur+t+RM
         Lqn2z2sMQWUeNpZZuX4GuIIqwH6hby5PJwG7iledg94P3qoEiZNclPVU5ebvETzfk45I
         emRHg+O4PjLugUb2xiAZo5hzq8qPJavREojKL1ONaM5VELnyUyM9jjiS0uQx/VxZYXHc
         NdjgmQ1cwPWVyhNA551wctvDYHSLJ8JidMrN3m+oxAgSn8v+5QgQ7Z3/QOdloePDC7Sj
         KO/Q==
X-Gm-Message-State: AOAM532mJY36Fw8LN+pcZR0iZJ/InLa/3EnvIqv+FH4uGkjn+YN3Q6jw
        zv2yMO52Y7oVQXF3pE7rgKFgjw==
X-Google-Smtp-Source: ABdhPJw4saSPhMUohzNzjdscZN0KDbM9WKgE0UI3Y2mk91NtDGFQsXLJsTcltgv6Da2VMwekYNeMFA==
X-Received: by 2002:a17:906:8416:b0:705:6a1b:e8ef with SMTP id n22-20020a170906841600b007056a1be8efmr30244309ejx.614.1654683716491;
        Wed, 08 Jun 2022 03:21:56 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7dd83000000b0042bc5a536edsm11883683edv.28.2022.06.08.03.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:21:55 -0700 (PDT)
Message-ID: <24ad8ba0-4244-1159-328d-12d0e67951e1@linaro.org>
Date:   Wed, 8 Jun 2022 12:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 18/20] arm64: dts: nuvoton: Add initial NPCM8XX device
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
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-19-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220608095623.22327-19-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 11:56, Tomer Maimon wrote:
> This adds initial device tree support for the
> Nuvoton NPCM845 Board Management controller (BMC) SoC family.
> 
> The NPCM845 based quad-core Cortex-A35 ARMv8 architecture and
> have various peripheral IPs.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 197 ++++++++++++++++++
>  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  76 +++++++
>  3 files changed, 274 insertions(+)
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
> index 000000000000..97e108c50760
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
> +		clock-frequency = <25000000>;

Ignored comment.

> +		clock-output-names = "refclk";
> +	};
> +
> +	/* external reference clock for cpu. float in normal operation */
> +	clk_sysbypck: clk-sysbypck {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1000000000>;

Ignored comment.

> +		clock-output-names = "sysbypck";
> +	};
> +
> +	/* external reference clock for MC. float in normal operation */
> +	clk_mcbypck: clk-mcbypck {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1050000000>;
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

Ignored comment.

> +			compatible = "nuvoton,npcm845-gcr", "syscon",
> +				"simple-mfd";

This is not a simple-mfd... I see original bindings defined it that way,
but why? I think they should be corrected - remove simple-mfd from the
bindings and DTS.


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

Ignored comment.

Four comments from v1 ignored in this patch alone.

I'll stop reviewing, it is a waste of my time.

NAK for this change.

Best regards,
Krzysztof
