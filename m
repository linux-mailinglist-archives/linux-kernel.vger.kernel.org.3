Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63BC4A629F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiBARiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:38:09 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33468 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiBARiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:38:08 -0500
Received: by mail-oi1-f171.google.com with SMTP id x193so34859337oix.0;
        Tue, 01 Feb 2022 09:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cHoNkQnTJ3Avl2epzJ83yz/QEu+de6O6Uv9XnghOt8M=;
        b=Tg7vx1xe44G+9rWbP8qijAo4jZaqPCKslEjPhTuPUUI0tV1QbITCMcEzKHDBduvjE3
         4rCecH5spCIMac5rdH4wg03X4dgDFNB4NTNZYvM+nKV+D20NhaVryIBc0cdlT8MbYtRd
         Hjfoxs6pt2U5rnPZxu9Qd5MSMugJkLCYCfx/CgArEzR4apsBafqKpMEe4gMO00S1qxhE
         bC2BaeXkBeh+7Hk5iryxj++4QUermJbHX8dceHALJ76VFyAHaBEhEGVgk+38BEk+081e
         S/Xw3ck+j24k4ICp1WJA1MjJ/2A9FQi2dFMsgNED6jXygtr/fuppz7LHfztbJyayLjXM
         0b7g==
X-Gm-Message-State: AOAM530qazOtXckNjpGP6R5UpmQcGmJE/cHAup+1FPT20kYSk8tMCiR1
        LJ3fjwE2PsDFos55HRwfKQ==
X-Google-Smtp-Source: ABdhPJy3PcnRWWExCkA1Q7YaKnJcZpLrButgXajcrq4DsxxKzDjJgnyvsRLQr7eukt+KDcAytPXbYQ==
X-Received: by 2002:a54:4396:: with SMTP id u22mr1980602oiv.249.1643737087578;
        Tue, 01 Feb 2022 09:38:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m26sm12925241ooa.36.2022.02.01.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:38:06 -0800 (PST)
Received: (nullmailer pid 257576 invoked by uid 1000);
        Tue, 01 Feb 2022 17:38:05 -0000
Date:   Tue, 1 Feb 2022 11:38:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: mfd: samsung,exynos5433-lpass: Convert
 to dtschema
Message-ID: <Yflv/RaGyGyyr096@robh.at.kernel.org>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
 <20220129175332.298666-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129175332.298666-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 06:53:31PM +0100, Krzysztof Kozlowski wrote:
> Convert the Exynos5433 LPASS bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/mfd/samsung,exynos5433-lpass.txt |  72 -----------
>  .../mfd/samsung,exynos5433-lpass.yaml         | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> deleted file mode 100644
> index 30ea27c3936d..000000000000
> --- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -Samsung Exynos SoC Low Power Audio Subsystem (LPASS)
> -
> -Required properties:
> -
> - - compatible		: "samsung,exynos5433-lpass"
> - - reg			: should contain the LPASS top SFR region location
> -			  and size
> - - clock-names		: should contain following required clocks: "sfr0_ctrl"
> - - clocks		: should contain clock specifiers of all clocks, which
> -			  input names have been specified in clock-names
> -			  property, in same order.
> - - #address-cells	: should be 1
> - - #size-cells		: should be 1
> - - ranges		: must be present
> -
> -Each IP block of the Low Power Audio Subsystem should be specified as
> -an optional sub-node. For "samsung,exynos5433-lpass" compatible this includes:
> -UART, SLIMBUS, PCM, I2S, DMAC, Timers 0...4, VIC, WDT 0...1 devices.
> -
> -Bindings of the sub-nodes are described in:
> -  ../serial/samsung_uart.yaml
> -  ../sound/samsung-i2s.txt
> -  ../dma/arm-pl330.txt
> -
> -
> -Example:
> -
> -audio-subsystem {
> -	compatible = "samsung,exynos5433-lpass";
> -	reg = <0x11400000 0x100>, <0x11500000 0x08>;
> -	clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
> -	clock-names = "sfr0_ctrl";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges;
> -
> -	adma: adma@11420000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x11420000 0x1000>;
> -		interrupts = <0 73 0>;
> -		clocks = <&cmu_aud CLK_ACLK_DMAC>;
> -		clock-names = "apb_pclk";
> -		#dma-cells = <1>;
> -		#dma-channels = <8>;
> -		#dma-requests = <32>;
> -	};
> -
> -	i2s0: i2s0@11440000 {
> -		compatible = "samsung,exynos7-i2s";
> -		reg = <0x11440000 0x100>;
> -		dmas = <&adma 0 &adma 2>;
> -		dma-names = "tx", "rx";
> -		interrupts = <0 70 0>;
> -		clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
> -			 <&cmu_aud CLK_SCLK_AUD_I2S>,
> -			 <&cmu_aud CLK_SCLK_I2S_BCLK>;
> -		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s0_bus>;
> -	};
> -
> -	serial_3: serial@11460000 {
> -		compatible = "samsung,exynos5433-uart";
> -		reg = <0x11460000 0x100>;
> -		interrupts = <0 67 0>;
> -		clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
> -			 <&cmu_aud CLK_SCLK_AUD_UART>;
> -		clock-names = "uart", "clk_uart_baud0";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&uart_aud_bus>;
> -	};
> - };
> diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
> new file mode 100644
> index 000000000000..96ef6113c8bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/samsung,exynos5433-lpass.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC Low Power Audio Subsystem (LPASS)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: samsung,exynos5433-lpass
> +
> +  '#address-cells':
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: sfr0_ctrl
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +
> +  '#size-cells':
> +    const: 1
> +
> +patternProperties:
> +  "^dma-controller@[0-9a-f]+$":
> +    $ref: /schemas/dma/arm,pl330.yaml
> +
> +  "^i2s@[0-9a-f]+$":
> +    $ref: /schemas/sound/samsung-i2s.yaml
> +
> +  "^serial@[0-9a-f]+$":
> +    $ref: /schemas/serial/samsung_uart.yaml
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - clocks
> +  - clock-names
> +  - ranges
> +  - reg
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/exynos5433.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    audio-subsystem@11400000 {
> +        compatible = "samsung,exynos5433-lpass";
> +        reg = <0x11400000 0x100>, <0x11500000 0x08>;
> +        clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
> +        clock-names = "sfr0_ctrl";
> +        power-domains = <&pd_aud>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        dma-controller@11420000 {
> +            compatible = "arm,pl330", "arm,primecell";
> +            reg = <0x11420000 0x1000>;
> +            interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cmu_aud CLK_ACLK_DMAC>;
> +            clock-names = "apb_pclk";
> +            #dma-cells = <1>;
> +            #dma-channels = <8>;
> +            #dma-requests = <32>;
> +            power-domains = <&pd_aud>;
> +        };
> +
> +        i2s@11440000 {
> +            compatible = "samsung,exynos7-i2s";
> +            reg = <0x11440000 0x100>;
> +            dmas = <&adma 0>, <&adma 2>;
> +            dma-names = "tx", "rx";
> +            interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
> +                     <&cmu_aud CLK_SCLK_AUD_I2S>,
> +                     <&cmu_aud CLK_SCLK_I2S_BCLK>;
> +            clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
> +            #clock-cells = <1>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&i2s0_bus>;
> +            power-domains = <&pd_aud>;
> +            #sound-dai-cells = <1>;
> +            status = "disabled";

Drop 'status'.

> +        };
> +
> +        serial@11460000 {
> +            compatible = "samsung,exynos5433-uart";
> +            reg = <0x11460000 0x100>;
> +            interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
> +                     <&cmu_aud CLK_SCLK_AUD_UART>;
> +            clock-names = "uart", "clk_uart_baud0";
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&uart_aud_bus>;
> +            power-domains = <&pd_aud>;
> +            status = "disabled";

Ditto.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
