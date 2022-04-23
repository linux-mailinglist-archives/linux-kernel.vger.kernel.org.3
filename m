Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1CF50C8DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiDWJ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiDWJ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:59:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9223C66AF3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:56:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so20693455ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ye7FEJvbqpesY+f8aUl7DqeqnxIvcFooZ124Ru+3I/Y=;
        b=nmUiwBkb3tC1ezD/BxZUtmvYP5fs7ZhtFbrFpeaJKp2Hn/tOnjJj5Uape0WbG+g11x
         ykuzLD8KrmJnSZEhbeKTpyNw2OfrGL4Grp3wTXWQ9D7vUmHmraU/5q18S4Zx7IIK/fyi
         McaLwqRNr6kDRFin6mXdxgJqRH2oaCwv/zNwrsDuAFo6A3096CfuIDiQKs4RrtoK35si
         VAgXAIXgTOAFRbdvmJTBiR8atHhOeoTzHdNxWXIvjbXOUUm45AJDRJooNb1dcJZitfD9
         um852y6vfr1bHqfyFzGHHpAIFDpInEN/yrVhfWE+0XUdpiesM6lN66JsRKR2AiZeM6fB
         E8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ye7FEJvbqpesY+f8aUl7DqeqnxIvcFooZ124Ru+3I/Y=;
        b=T8JReTPIerZ5K1vHajIL/BGq0zE+5/FS2TH/vm6jRfmW8fgvto7hEdiJvI4Ss2UBiE
         Chl/NAHDLeWowJBYpAI5Ip2Q58szwsSWpxATyjY/SlvcMgXsz0eStgH4mHfX9dsO/jRu
         6+b8aSAxw2HbhO/3Oi3xDK5i2E8o36wLcae04gjm3OeHW2Lbd2GYdy8B13YfvEGJR/Ld
         +UxQNlvnjyear+s3tzDlweJjKZEqa7jNv/qSrmsZ/h0JheLGN6x/jPsGGPeL8Xa8Kvvo
         ZD6knzOaSKMBxF8A1MHas/XUG6jxJ5k56Dc0zQix0jXVh/HusrbW2sWJLT8WQUuuVKbO
         Hlyw==
X-Gm-Message-State: AOAM530iDQv/ZkXBwZDagFr2gJtRqOAcWiphZcyEsTWs3JgceObSneLl
        k1eJmjzTOlriuEvXyYYkFMMxlg==
X-Google-Smtp-Source: ABdhPJzB6qbgb3c3xbdlQDja+xMeNlUO+nTWQs3OrXt4ChFUcK6GTqPrfgSvIW51c4I1jSfTUMUHcA==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr7446605ejn.278.1650707804166;
        Sat, 23 Apr 2022 02:56:44 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bw3-20020a170906c1c300b006e88cdfbc32sm1547048ejb.45.2022.04.23.02.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 02:56:43 -0700 (PDT)
Message-ID: <31cb9af1-173d-bef5-64da-ccf5a01f2485@linaro.org>
Date:   Sat, 23 Apr 2022 11:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/7] dt-bindings: clock: Add Nuvoton WPCM450 clock/reset
 controller
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
 <20220422183012.444674-5-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422183012.444674-5-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 20:30, Jonathan Neuschäfer wrote:
> The Nuvoton WPCM450 SoC has a combined clock and reset controller.
> Add a devicetree binding for it, as well as definitions for the bit
> numbers used by it.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---

Thank you for your patch. There is something to discuss/improve.

>  .../bindings/clock/nuvoton,wpcm450-clk.yaml   | 74 +++++++++++++++++++
>  .../dt-bindings/clock/nuvoton,wpcm450-clk.h   | 67 +++++++++++++++++
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
>  create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
> new file mode 100644
> index 0000000000000..0fffa8a68dee4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nuvoton,wpcm450-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton WPCM450 clock controller binding

s/binding//

> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> +
> +description:
> +  This binding describes the clock controller of the Nuvoton WPCM450 SoC, which
> +  supplies clocks and resets to the rest of the chip.

s/This binding describes//

Just describe the hardware.

> +
> +properties:
> +  compatible:
> +    const: nuvoton,wpcm450-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference clock oscillator (should be 48 MHz)
> +
> +  clock-names:
> +    items:
> +      - const: refclk
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    refclk: clock-48mhz {
> +      /* 48 MHz reference oscillator */
> +      compatible = "fixed-clock";
> +      clock-output-names = "refclk";
> +      clock-frequency = <48000000>;
> +      #clock-cells = <0>;
> +    };
> +
> +    clk: clock-controller@b0000200 {
> +      reg = <0xb0000200 0x100>;
> +      compatible = "nuvoton,wpcm450-clk";
> +      clocks = <&refclk>;
> +      clock-names = "refclk";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +
> +    serial@b8000000 {
> +      compatible = "nuvoton,wpcm450-uart";
> +      reg = <0xb8000000 0x20>;
> +      reg-shift = <2>;
> +      interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&clk WPCM450_CLK_UART0>;
> +    };

Skip the consumer example, it's obvious/trivial/duplicating.

> diff --git a/include/dt-bindings/clock/nuvoton,wpcm450-clk.h b/include/dt-bindings/clock/nuvoton,wpcm450-clk.h
> new file mode 100644
> index 0000000000000..86e1c895921b7
> --- /dev/null
> +++ b/include/dt-bindings/clock/nuvoton,wpcm450-clk.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
> +#define _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
> +
> +/* Clocks based on CLKEN bits */
> +#define WPCM450_CLK_FIU            0
> +#define WPCM450_CLK_XBUS           1
> +#define WPCM450_CLK_KCS            2
> +#define WPCM450_CLK_SHM            4
> +#define WPCM450_CLK_USB1           5
> +#define WPCM450_CLK_EMC0           6
> +#define WPCM450_CLK_EMC1           7
> +#define WPCM450_CLK_USB0           8
> +#define WPCM450_CLK_PECI           9
> +#define WPCM450_CLK_AES           10
> +#define WPCM450_CLK_UART0         11
> +#define WPCM450_CLK_UART1         12
> +#define WPCM450_CLK_SMB2          13
> +#define WPCM450_CLK_SMB3          14
> +#define WPCM450_CLK_SMB4          15
> +#define WPCM450_CLK_SMB5          16
> +#define WPCM450_CLK_HUART         17
> +#define WPCM450_CLK_PWM           18
> +#define WPCM450_CLK_TIMER0        19
> +#define WPCM450_CLK_TIMER1        20
> +#define WPCM450_CLK_TIMER2        21
> +#define WPCM450_CLK_TIMER3        22
> +#define WPCM450_CLK_TIMER4        23
> +#define WPCM450_CLK_MFT0          24
> +#define WPCM450_CLK_MFT1          25
> +#define WPCM450_CLK_WDT           26
> +#define WPCM450_CLK_ADC           27
> +#define WPCM450_CLK_SDIO          28
> +#define WPCM450_CLK_SSPI          29
> +#define WPCM450_CLK_SMB0          30
> +#define WPCM450_CLK_SMB1          31
> +
> +/* Other clocks */
> +#define WPCM450_CLK_USBPHY        32
> +
> +#define WPCM450_NUM_CLKS          33
> +
> +/* Resets based on IPSRST bits */

All these defines should be in second header in dt-bindings/reset/...

> +#define WPCM450_RESET_FIU          0


Best regards,
Krzysztof
