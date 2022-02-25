Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B364C4F84
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiBYUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiBYUUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:20:20 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF8F203BFE;
        Fri, 25 Feb 2022 12:19:46 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so7889946oob.8;
        Fri, 25 Feb 2022 12:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ccql33Ag59okO8wJbmy2yb5zojyXK8SloaE5dJZF2/8=;
        b=ecjNqfW1sCAKi7sYlj75pzw7Du2FwZPKIhHuAmUmnpPrwtdj3CJfVEtEfYwB4fHvry
         t5OwA9zAJcA9s1tC8ZtFzi+NEciIv8uoH/O2jTM1+wSMRnhJQ7aFDlaWmLXzpu+SQnUj
         ivQW1tYSRFn3x1M3GqBYaxAInqSEz0nFrke5xN4GkBf0e/FmFdXhHOU4/WQnLlobXwSL
         aXr0tU2xL9S5clHrg8G8O9VI8tBODO+flolutlDvRJc39YOE1b9PXLDio8QowmaDTITI
         ewRaHx7Fooa2P30CKoV2bsFGbB+k8QzoBOEBalg7rRYeRq8HpezeD4p14uADzKuAiiOU
         My1w==
X-Gm-Message-State: AOAM5312LP9Hfy4aQniJiXUTocBJ4zkp3Kfu+7KdBAx1vQ/O84yENGKO
        qNaljX87aWewdx22GgLZTw==
X-Google-Smtp-Source: ABdhPJy03N8sBibAc7P4Gz7DEVKTwaXlPsC0Py5PFgUSKHOgj0z0ciD0JmAE0YgQ8Jc5z0WK7i/Z6g==
X-Received: by 2002:a05:6870:ea02:b0:d3:5691:f0ea with SMTP id g2-20020a056870ea0200b000d35691f0eamr2195245oap.22.1645820385732;
        Fri, 25 Feb 2022 12:19:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u15-20020a056870700f00b000d180722f8dsm1611330oae.36.2022.02.25.12.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:19:45 -0800 (PST)
Received: (nullmailer pid 1365596 invoked by uid 1000);
        Fri, 25 Feb 2022 20:19:44 -0000
Date:   Fri, 25 Feb 2022 14:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: interrupt-controller: apple,aic2:
 New binding for AICv2
Message-ID: <Yhk54H989MfhGMcu@robh.at.kernel.org>
References: <20220224130741.63924-1-marcan@marcan.st>
 <20220224130741.63924-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224130741.63924-3-marcan@marcan.st>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 10:07:36PM +0900, Hector Martin wrote:
> This new incompatible revision of the AIC peripheral introduces
> multi-die support. This binding is based on apple,aic, but
> changes interrupt-cells to add a new die argument.
> 
> Also adds an apple,event-reg property to specify the offset of the event
> register. Inexplicably, the capability registers allow us to compute
> other register offsets, but not this one. This allows us to keep
> forward-compatibility with future SoCs that will likely implement
> different die counts, thus shifting the event register. Apple do the
> same thing in their device tree...
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../interrupt-controller/apple,aic2.yaml      | 99 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> new file mode 100644
> index 000000000000..311900613b9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/apple,aic2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Interrupt Controller 2
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  The Apple Interrupt Controller 2 is a simple interrupt controller present on
> +  Apple ARM SoC platforms starting with t600x (M1 Pro and Max).
> +
> +  It provides the following features:
> +
> +  - Level-triggered hardware IRQs wired to SoC blocks
> +    - Single mask bit per IRQ
> +    - Automatic masking on event delivery (auto-ack)
> +    - Software triggering (ORed with hw line)
> +  - Automatic prioritization (single event/ack register per CPU, lower IRQs =
> +    higher priority)
> +  - Automatic masking on ack
> +  - Support for multiple dies
> +
> +  This device also represents the FIQ interrupt sources on platforms using AIC,
> +  which do not go through a discrete interrupt controller. It also handles
> +  FIQ-based Fast IPIs.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: apple,t6000-aic
> +      - const: apple,aic2

I feel I was sold on Apple doesn't change h/w and we're the 2nd chip in 
and the h/w changed. Just my musings, but aic3 will be rejected. :(

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 4
> +    description: |
> +      The 1st cell contains the interrupt type:
> +        - 0: Hardware IRQ
> +        - 1: FIQ
> +
> +      The 2nd cell contains the die ID.
> +
> +      The next cell contains the interrupt number.
> +        - HW IRQs: interrupt number
> +        - FIQs:
> +          - 0: physical HV timer
> +          - 1: virtual HV timer
> +          - 2: physical guest timer
> +          - 3: virtual guest timer
> +
> +      The last cell contains the interrupt flags. This is normally
> +      IRQ_TYPE_LEVEL_HIGH (4).
> +
> +  reg:
> +    description: |
> +      Specifies base physical address and size of the AIC registers.
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  apple,event-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Specifies the offset of the event register, which lies after all the
> +      implemented die register sets, page aligned. This is not computable from
> +      capability register values, so we have to specify it explicitly.

If this is last, then couldn't it be a 2nd 'reg' entry?

'page aligned' is ambiguous. I assume that means 16K since that's what 
Apple uses, but I might assume 4K not knowing that.

> +
> +required:
> +  - compatible
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +  - reg
> +  - apple,event-reg
> +
> +additionalProperties: false
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        aic: interrupt-controller@28e100000 {
> +            compatible = "apple,t6000-aic", "apple,aic2";
> +            #interrupt-cells = <4>;
> +            interrupt-controller;
> +            reg = <0x2 0x8e100000 0x0 0x10000>;
> +            apple,event-reg = <0xc000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa0f6cbb634e..ad887ec7e96b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1806,7 +1806,7 @@ T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/apple.yaml
>  F:	Documentation/devicetree/bindings/arm/apple/*
>  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
> -F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
>  F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> -- 
> 2.33.0
> 
> 
