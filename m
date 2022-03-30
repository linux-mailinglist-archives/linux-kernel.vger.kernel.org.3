Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A804EBFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbiC3Lpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiC3Lpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:45:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2379B2BB0E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:44:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r13so28840413wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pM4acL2cBdHAr8ol04MCfm0Zf2dmck5bVZ4hNfSR+BA=;
        b=N5djGtqB6GsbaIdVnSTJ/9wjluukujSK8ZFL+tEB7r0P5dnj/LGmzH6N4owGg5FC/F
         KUH6CANIz2Sf7fq3LJGwh6PF4pf5CwcGi5lhWmvV8I3x4L4jDKyNfV0d6NWzQrjHU1cT
         Glb72JPo/LWW+XsnGjaza+4TTKkpDrAZ7eYqEsy85wNYVFY+rCtmNN8v38Efbs8IZSWj
         mBrQ0BjEYGlEIk8Z+XwvEZfUDMA/+J/PEU/+Bw+8aepFmHrulYkmhJ5/vr8raoZEt4l9
         4aoCf07OVqpihvLB3NfIoCa2RjqfmfapuCR+Oz5c6smA0ZitvULsEMd8vPAbYsz96yv5
         +9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pM4acL2cBdHAr8ol04MCfm0Zf2dmck5bVZ4hNfSR+BA=;
        b=jWCC1eGZC9W/pFH+z+cA+CJllI0DsBAFIDN8hpmvvv9p5tm4+/lAOa6rQTfuhb0TEL
         wENbg3nf1QJrMWO/98AvJlf4fGQTuszLxK7GmJmhSy3hFgmvlTkkRKKR2Wpvkm1Mgb8U
         aWSjmTrPXIjAPS00a9HbA4E/EvoV+/WMgW57V0XMgzMVNAdvLSMHAxj3S8OhiEvs2dcL
         8II/ukZVMC7wCxjc+b6Vly1f91OfxwQcVxbygjHPMo9i065FWONOFckIiycElz56xVtz
         42A76gvw6FfZsLJhdkQxsz9a3QHQdNgUkRML4sjcAOXkd+vOSWPFBTvffhG0Pu5dINXW
         7sJA==
X-Gm-Message-State: AOAM530xOxe6KmHhf+90/PySQ0O+gohn6aq97TLOQboipNVEE/uMzHh7
        zeJu97poDq7oShEVhemkNiVjCA==
X-Google-Smtp-Source: ABdhPJx5gWaOjg6IOR1iCpF0iDWtebpvzCtOYQvZtcm6O4a54s4tXnsgJ19/ZmlXPvWU3jHYe1fUbQ==
X-Received: by 2002:adf:da50:0:b0:204:7d8:b654 with SMTP id r16-20020adfda50000000b0020407d8b654mr36294585wrl.607.1648640642526;
        Wed, 30 Mar 2022 04:44:02 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8? ([2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d4309000000b00205b90434e2sm10107459wrq.114.2022.03.30.04.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 04:44:01 -0700 (PDT)
Message-ID: <7e711327-bcb8-4c7f-5537-425ba1a79e62@linaro.org>
Date:   Wed, 30 Mar 2022 13:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v10 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Content-Language: en-US
To:     shruthi.sanil@intel.com, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
References: <20220322130005.16045-1-shruthi.sanil@intel.com>
 <20220322130005.16045-2-shruthi.sanil@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220322130005.16045-2-shruthi.sanil@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 14:00, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> Add Device Tree bindings for the Timer IP, which can be used as
> clocksource and clockevent device in the Intel Keem Bay SoC.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>


In order to pick this binding I need an ack from Rob or Krzysztof (added 
to the recipients)



> ---
>   .../bindings/timer/intel,keembay-timer.yaml   | 125 ++++++++++++++++++
>   1 file changed, 125 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> new file mode 100644
> index 000000000000..333f137e39e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/intel,keembay-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Keem Bay SoC Timers
> +
> +maintainers:
> +  - Shruthi Sanil <shruthi.sanil@intel.com>
> +
> +description: |
> +  The Intel Keem Bay timer IP supports 1 free running counter and 8 timers.
> +  Each timer is capable of generating inividual interrupt.
> +  Both the features are enabled through the timer general config register.
> +
> +  The parent node represents the common general configuration details and
> +  the child nodes represents the counter and timers.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - intel,keembay-gpt-creg
> +      - const: simple-mfd
> +
> +  reg:
> +    description: General configuration register address and length.
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +patternProperties:
> +  "^counter@[0-9a-f]+$":
> +    description: Properties for Intel Keem Bay counter.
> +    type: object
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - intel,keembay-counter
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - clocks
> +
> +  "^timer@[0-9a-f]+$":
> +    description: Properties for Intel Keem Bay timer
> +    type: object
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - intel,keembay-timer
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #define KEEM_BAY_A53_TIM
> +
> +    soc {
> +        #address-cells = <0x2>;
> +        #size-cells = <0x2>;
> +
> +        gpt@20331000 {
> +            compatible = "intel,keembay-gpt-creg", "simple-mfd";
> +            reg = <0x0 0x20331000 0x0 0xc>;
> +            ranges = <0x0 0x0 0x20330000 0xF0>;
> +            #address-cells = <0x1>;
> +            #size-cells = <0x1>;
> +
> +            counter@e8 {
> +                compatible = "intel,keembay-counter";
> +                reg = <0xe8 0x8>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@30 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x30 0xc>;
> +                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +        };
> +    };
> +
> +...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
