Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232FB4CC9E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiCCXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCCXSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:18:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0E72A70E;
        Thu,  3 Mar 2022 15:18:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 455B761532;
        Thu,  3 Mar 2022 23:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F7EC340F1;
        Thu,  3 Mar 2022 23:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646349482;
        bh=tlOHNfyRtXEFJ6xoJ1AtsupQm9XzW3NADGZEF72E09I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FSEdEhsphzeP07HC7WHYwdul0B2vKlmEIrKvi0FwBCC+QJLQQ6mr4OX0OMQOp6FYW
         tigRGG0MyZbrzSM66O2k5FQMbyZdAlUSNdK7RVosG2TvW2RTMY5GFQ5Ln6e20z+JPF
         ozi0nuP16NZZsa1lCfilUB9asttLe71PTDN7GxXuGLYyyU6dnWwRjlZowT4OTGARQW
         2a3pRbPncrYYKmQgP69WtBPOimN3Xuusbgks8+l51Y4asforlD5I0/LmGZ0IJx8AkV
         JQnWJ0YMf6rsSviWCZigheHA1NOYMJvD054gRPpMh+SPuqOyJ7Al+YaYrvlwqxQEs7
         faLc08eacbILA==
Received: by mail-ed1-f46.google.com with SMTP id o1so7530082edc.3;
        Thu, 03 Mar 2022 15:18:02 -0800 (PST)
X-Gm-Message-State: AOAM530hsYMDr16amKWivENSDcLRzJMUF4HduiBSGBsnWoBFzxqHemNN
        tyxhCx1UOhiQQjkO1LhTCYLcqed+QXkkwc4MFA==
X-Google-Smtp-Source: ABdhPJzvyLJfhUCl0fo8/owb0CYZcEj2xeWHM6SoIUh0U5eB5kzm5d1D+Kv+qFcoK6fL5nAJQT70EZLXKwscis5r5DA=
X-Received: by 2002:a05:6402:4384:b0:413:9e36:b56f with SMTP id
 o4-20020a056402438400b004139e36b56fmr25916622edc.280.1646349480795; Thu, 03
 Mar 2022 15:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20220303211620.32456-1-david@ixit.cz>
In-Reply-To: <20220303211620.32456-1-david@ixit.cz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Mar 2022 17:17:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXwfKRooYmUB7HQwOi49P6Fd9sOqbxMa9TRnp6WqiYnw@mail.gmail.com>
Message-ID: <CAL_JsqKXwfKRooYmUB7HQwOi49P6Fd9sOqbxMa9TRnp6WqiYnw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: timer: Tegra: Convert text bindings to yaml
To:     David Heidelberg <david@ixit.cz>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        ~okias/devicetree@lists.sr.ht,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 3:16 PM David Heidelberg <david@ixit.cz> wrote:
>
> Convert Tegra timer binding into yaml format.
>
> This commit also merge 3 text bindings with almost
> identical content (differens in number of registers).
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - reg: true -> reg: maxItems: 1
> ---
>  .../bindings/timer/nvidia,tegra-timer.yaml    | 150 ++++++++++++++++++
>  .../bindings/timer/nvidia,tegra20-timer.txt   |  24 ---
>  .../bindings/timer/nvidia,tegra210-timer.txt  |  36 -----
>  .../bindings/timer/nvidia,tegra30-timer.txt   |  28 ----
>  4 files changed, 150 insertions(+), 88 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
>  delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
>  delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>  delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
> new file mode 100644
> index 000000000000..f0b401f80aff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/timer/nvidia,tegra-timer.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra timer
> +
> +maintainers:
> +  - Stephen Warren <swarren@nvidia.com>
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra210-timer
> +    then:
> +      properties:
> +        interrupts:
> +          # Either a single combined interrupt or up to 14 individual interrupts
> +          minItems: 1
> +          maxItems: 14
> +          description: >
> +            A list of 14 interrupts; one per each timer channels 0 through 13
> +
> +  - if:
> +      properties:
> +        compatible:
> +          oneOf:
> +            - items:
> +                - enum:
> +                    - nvidia,tegra114-timer
> +                    - nvidia,tegra124-timer
> +                    - nvidia,tegra132-timer
> +                - const: nvidia,tegra30-timer
> +            - items:
> +                - const: nvidia,tegra30-timer
> +                - const: nvidia,tegra20-timer
> +    then:
> +      properties:
> +        interrupts:
> +          # Either a single combined interrupt or up to 6 individual interrupts
> +          minItems: 1
> +          maxItems: 6
> +          description: >
> +            A list of 6 interrupts; one per each of timer channels 1 through 5,
> +            and one for the shared interrupt for the remaining channels.
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: nvidia,tegra20-timer
> +    then:
> +      properties:
> +        interrupts:
> +          # Either a single combined interrupt or up to 4 individual interrupts
> +          minItems: 1
> +          maxItems: 4
> +          description: |
> +            A list of 4 interrupts; one per timer channel.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra210-timer
> +        description: >
> +          The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
> +          timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
> +          from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
> +          (TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
> +          or watchdog interrupts.
> +      - items:
> +          - enum:
> +              - nvidia,tegra114-timer
> +              - nvidia,tegra124-timer
> +              - nvidia,tegra132-timer
> +          - const: nvidia,tegra30-timer
> +      - items:
> +          - const: nvidia,tegra30-timer
> +          - const: nvidia,tegra20-timer
> +        description: >
> +          The Tegra30 timer provides ten 29-bit timer channels, a single 32-bit free
> +          running counter, and 5 watchdog modules. The first two channels may also
> +          trigger a legacy watchdog reset.
> +      - const: nvidia,tegra20-timer
> +        description: >
> +          The Tegra20 timer provides four 29-bit timer channels and a single 32-bit free
> +          running counter. The first two channels may also trigger a watchdog reset.
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: timer
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    timer@60005000 {
> +        compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
> +        reg = <0x60005000 0x400>;
> +        interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH
> +                      0 1 IRQ_TYPE_LEVEL_HIGH
> +                      0 41 IRQ_TYPE_LEVEL_HIGH
> +                      0 42 IRQ_TYPE_LEVEL_HIGH
> +                      0 121 IRQ_TYPE_LEVEL_HIGH
> +                      0 122 IRQ_TYPE_LEVEL_HIGH>;

The unhelpful bot warning is a new thing. 'interrupts' here must now
have brackets around each entry to figure out the interrupt cell size.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +        clocks = <&tegra_car 214>;
> +    };
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    timer@60005000 {
> +        compatible = "nvidia,tegra210-timer";
> +        reg = <0x60005000 0x400>;
> +        interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&tegra_car TEGRA210_CLK_TIMER>;
> +        clock-names = "timer";
> +    };
