Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0644C051C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiBVXOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiBVXOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:14:09 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55D8BF46;
        Tue, 22 Feb 2022 15:13:43 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id j24so14148211oii.11;
        Tue, 22 Feb 2022 15:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y7D2c950mJMLPhqEP8ZV4iGxo56zlIe4ISy0zIYcXP0=;
        b=NiQMvycvwOMnD+9KV1AhxU0J/TRcJpYjT14P696JN3WNdryePw7vTUfi0V0nALWfOd
         mOJAlmH8oxn1EYvwj25M6K5PlyUf2pYCM/exKYeYjTNipf6ZS0tt2xt/oW5cW587N0Ix
         5khTK5r5BAYNKo0wU8WXCK15btbCDKpkls63YqL27gSFxVSf73nTbKNWH+wxk8GEfv8d
         ypS/LrKxmuy32vQQ0jW8ABEEhnZYhycZ9BQXoI0CF7ULs4pM4vG1iCCwh5uc3juGm3l7
         nQPWnJ2asGRM2GfyjIJ5SYq8Ssd6EEvs1I5Ny6SO7Jz35+TlTP1OYwJAmPqdwxL+5kcg
         tLWg==
X-Gm-Message-State: AOAM5324ggtMrha5E4vFQXjaq0btZNopkb93MnxfHrrbQk+wiGeZqMvO
        D4W1wvD5RaKFs8Cz5hFYvJ91Yybg5w==
X-Google-Smtp-Source: ABdhPJywOIQkIVJN4FCSXfgXIQImYDaU95pu/b9MYalgkSjg58/P7rqPkKl6uWKkBvbO06ouAPQLVQ==
X-Received: by 2002:a05:6808:120f:b0:2d4:9ce3:a769 with SMTP id a15-20020a056808120f00b002d49ce3a769mr3371746oil.277.1645571622594;
        Tue, 22 Feb 2022 15:13:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t5sm7604330otp.67.2022.02.22.15.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:13:42 -0800 (PST)
Received: (nullmailer pid 3775935 invoked by uid 1000);
        Tue, 22 Feb 2022 23:13:41 -0000
Date:   Tue, 22 Feb 2022 17:13:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     shruthi.sanil@intel.com
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <YhVuJaf3AJ1c6TpT@robh.at.kernel.org>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-2-shruthi.sanil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222095654.9097-2-shruthi.sanil@intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 03:26:53PM +0530, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> Add Device Tree bindings for the Timer IP, which can be used as
> clocksource and clockevent device in the Intel Keem Bay SoC.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> ---
>  .../bindings/timer/intel,keembay-timer.yaml   | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> new file mode 100644
> index 000000000000..9e6d46ecc2dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> @@ -0,0 +1,128 @@
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
> +  The Intel Keem Bay timer driver supports 1 free running counter and 8 timers.

Bindings describe the h/w, not what drivers support.

> +  Each timer is capable of generating inividual interrupt.
> +  Both the features are enabled through the timer general config register.
> +
> +  The parent node represents the common general configuration details and
> +  the child nodes represents the counter and timers.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

Don't need oneOf with only 1 entry.

> +          - enum:
> +              - intel,keembay-gpt-creg
> +          - const: simple-mfd
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
> +        oneOf:

Don't need oneOf.

> +          - items:
> +              - enum:
> +                  - intel,keembay-counter
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
> +        oneOf:
> +          - items:
> +              - enum:
> +                  - intel,keembay-timer
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

It looks like you are splitting things based on Linux implementation 
details. Does this h/w block have different combinations of timers and 
counters? If not, then you don't need the child nodes at all. There's 
plenty of h/w blocks that get used as both a clocksource and clockevent.

Maybe I already raised this, but assume I don't remember and this patch 
needs to address any questions I already asked.

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
> -- 
> 2.17.1
> 
> 
