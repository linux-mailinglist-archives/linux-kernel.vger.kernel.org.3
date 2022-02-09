Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46D4AE88D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiBIEPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347699AbiBIECm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:02:42 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91520C061578;
        Tue,  8 Feb 2022 20:02:40 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so1075784ooa.11;
        Tue, 08 Feb 2022 20:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SmAPXZKckaZ6dH+DTdhtKGAYyYnz21UexfWGc9HyiWI=;
        b=5nU1U5ye37nhURhlOmTXyOgkcon1BE9ccAEWfQtc4U2upooTuXNHFETNf53C1d6Eoc
         On4JUrDcc4uOeX5HkFsoFduQLKks2+/+CPirLq7LojTX1G0rew7oRZVMi+QZXFgyX+lD
         b2OFBLzuDpBsUqn8IpdpBqVrqvFLwYEf0lWqafb+Cnbmca++hegR9sGSr/FNld/RWqmW
         JqOfBl1nHtmAR0hOQnZTQ+q/Icw3lYT/6rwSR9GS53XWq9twxwdf4qI44OAIRpVHUX9v
         ie9Ybk6wshWahan2PSGwx2V6o9HUe4uEHrqbTP2e5Y+sesNSxXVKfVSCsiltGeonctol
         hU3g==
X-Gm-Message-State: AOAM530D2vTTFBT7tLfeD5Jt2gMPHet8IloPoRKt20v0FkFjSS+59kOY
        3vsOx3GPL1mjuOzOHrU6Wf03+V/Lgw==
X-Google-Smtp-Source: ABdhPJyLhQb7fx1xvUdR+Mt6U6PJoLnqQKAOqE0ef2RvE0J8MScHsEiQ0aQ4u+IvDD3ryPh2KjRUnQ==
X-Received: by 2002:a05:6870:ee0c:: with SMTP id ga12mr151021oab.343.1644379359888;
        Tue, 08 Feb 2022 20:02:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u5sm6310855ooo.46.2022.02.08.20.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:02:39 -0800 (PST)
Received: (nullmailer pid 3629635 invoked by uid 1000);
        Wed, 09 Feb 2022 04:02:38 -0000
Date:   Tue, 8 Feb 2022 22:02:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     brgl@bgdev.pl, conleylee@foxmail.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: convert faraday,ftgpio01 to yaml
Message-ID: <YgM83n5moACXZe7j@robh.at.kernel.org>
References: <20220127123028.3992288-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127123028.3992288-1-clabbe@baylibre.com>
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

On Thu, Jan 27, 2022 at 12:30:28PM +0000, Corentin Labbe wrote:
> Converts gpio/faraday,ftgpio010.txt to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> 
> This commit will cause arch/arm/boot/dts/moxart-uc7112lx.dts to fail DT validation,
> but the GPIO driver need an interrupt so the current moxart DT is incomplete and the error is appropriate.
> 
>  .../bindings/gpio/faraday,ftgpio010.txt       | 27 ---------
>  .../bindings/gpio/faraday,ftgpio010.yaml      | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt b/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
> deleted file mode 100644
> index d04236558619..000000000000
> --- a/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Faraday Technology FTGPIO010 GPIO Controller
> -
> -Required properties:
> -
> -- compatible : Should be one of
> -  "cortina,gemini-gpio", "faraday,ftgpio010"
> -  "moxa,moxart-gpio", "faraday,ftgpio010"
> -  "faraday,ftgpio010"
> -- reg : Should contain registers location and length
> -- interrupts : Should contain the interrupt line for the GPIO block
> -- gpio-controller : marks this as a GPIO controller
> -- #gpio-cells : Should be 2, see gpio/gpio.txt
> -- interrupt-controller : marks this as an interrupt controller
> -- #interrupt-cells : a standard two-cell interrupt flag, see
> -  interrupt-controller/interrupts.txt
> -
> -Example:
> -
> -gpio@4d000000 {
> -	compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
> -	reg = <0x4d000000 0x100>;
> -	interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
> -	gpio-controller;
> -	#gpio-cells = <2>;
> -	interrupt-controller;
> -	#interrupt-cells = <2>;
> -};
> diff --git a/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml b/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml
> new file mode 100644
> index 000000000000..dfd10b76c9d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/faraday,ftgpio010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology FTGPIO010 GPIO Controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: "cortina,gemini-gpio"
> +          - const: "faraday,ftgpio010"
> +      - items:
> +          - const: "moxa,moxart-gpio"
> +          - const: "faraday,ftgpio010"
> +      - const: "faraday,ftgpio010"

Don't need quotes.

> +  reg:
> +    maxItems: 1

blank line between DT properties

With those fixes,

Reviewed-by: Rob Herring <robh@kernel.org>

> +  resets:
> +    maxItems: 1
> +  clocks:
> +    maxItems: 1
> +  interrupts:
> +    maxItems: 1
> +    description: Should contain the interrupt line for the GPIO block
> +  gpio-controller: true
> +  "#gpio-cells":
> +    const: 2
> +  interrupt-controller: true
> +  "#interrupt-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#gpio-cells"
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    gpio@4d000000 {
> +      compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
> +      reg = <0x4d000000 0x100>;
> +      interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };
> -- 
> 2.34.1
> 
> 
