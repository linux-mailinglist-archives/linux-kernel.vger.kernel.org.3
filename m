Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE82F4AD9EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245678AbiBHNah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354305AbiBHNaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:30:22 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005DC03FEEE;
        Tue,  8 Feb 2022 05:29:29 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso13203941otl.8;
        Tue, 08 Feb 2022 05:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=koYRbcn/WtPykkXZwC6+c60bzwoEa0n7FLjAaj0dTE4=;
        b=wM/l1cAjyIjFdSrtEsNeN6bE8UF24ES7fi6Ps3b5gVl5rhHVkPt3z1SDMqJxQYnkGt
         cXaafvOiQRtRk9qDr9/3RzF/DAysIiItYIfrFKryrU3yldperD3pjOsqX00MaNeRRPXn
         XfWIDcRNqBdxgXdm9R5SFIj67UGTq+fgYsb1YyMoKAzA45OMD/zyZWKsDRc1BQDm0UoE
         LN+OxnOmTUN2c85HJjKt8uM015eF90/3gqr4Tcb1DXI4VN1rPSy8UMSj/ksZV3mo4PyU
         SEzcM/6g3/qG8P+kJI0p5orH7fwT99xxKynPdfg2npwyNOI4pIprHBoBsPi0IV2AGewE
         Blug==
X-Gm-Message-State: AOAM530/7v6EGvC0VAvPhy6G6D9kx/B8gheEYdISM5dDWNQ/uoHAogKk
        sdshYvFFVKi7wIaMZ2PIapo8sExZyw==
X-Google-Smtp-Source: ABdhPJyZFU8bWgpGlIsuTglztN69AiTBJAywOqGi6K3n7XGhYjfOE32vYlxk6R8h84ooKozFLJaFAg==
X-Received: by 2002:a9d:22a6:: with SMTP id y35mr1797608ota.212.1644326968365;
        Tue, 08 Feb 2022 05:29:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 23sm3286332oac.20.2022.02.08.05.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:29:27 -0800 (PST)
Received: (nullmailer pid 2288492 invoked by uid 1000);
        Tue, 08 Feb 2022 13:29:26 -0000
Date:   Tue, 8 Feb 2022 07:29:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: timer: Convert faraday,fttmr010 to yaml
Message-ID: <YgJwNuas1D/NVjGU@robh.at.kernel.org>
References: <20220126160021.3537591-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126160021.3537591-1-clabbe@baylibre.com>
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

On Wed, Jan 26, 2022 at 04:00:21PM +0000, Corentin Labbe wrote:
> Converts timer/faraday,fttmr010.txt to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - added moxart example
> - relaxed some contraints as driver only support one clock and one
>   interrupt (as used by moxa,moxart-timer)
> 
>  .../bindings/timer/faraday,fttmr010.txt       | 38 --------
>  .../bindings/timer/faraday,fttmr010.yaml      | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
> deleted file mode 100644
> index 3cb2f4c98d64..000000000000
> --- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -Faraday Technology timer
> -
> -This timer is a generic IP block from Faraday Technology, embedded in the
> -Cortina Systems Gemini SoCs and other designs.
> -
> -Required properties:
> -
> -- compatible : Must be one of
> -  "faraday,fttmr010"
> -  "cortina,gemini-timer", "faraday,fttmr010"
> -  "moxa,moxart-timer", "faraday,fttmr010"
> -  "aspeed,ast2400-timer"
> -  "aspeed,ast2500-timer"
> -  "aspeed,ast2600-timer"
> -
> -- reg : Should contain registers location and length
> -- interrupts : Should contain the three timer interrupts usually with
> -  flags for falling edge
> -
> -Optionally required properties:
> -
> -- clocks : a clock to provide the tick rate for "faraday,fttmr010"
> -- clock-names : should be "EXTCLK" and "PCLK" for the external tick timer
> -  and peripheral clock respectively, for "faraday,fttmr010"
> -- syscon : a phandle to the global Gemini system controller if the compatible
> -  type is "cortina,gemini-timer"
> -
> -Example:
> -
> -timer@43000000 {
> -	compatible = "faraday,fttmr010";
> -	reg = <0x43000000 0x1000>;
> -	interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
> -		   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
> -		   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
> -	clocks = <&extclk>, <&pclk>;
> -	clock-names = "EXTCLK", "PCLK";
> -};
> diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
> new file mode 100644
> index 000000000000..db9fb171ea49
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/faraday,fttmr010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology timer
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |

Don't need '|' if there's no formatting.

> +  This timer is a generic IP block from Faraday Technology, embedded in the
> +  Cortina Systems Gemini SoCs and other designs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,fttmr010
> +      - items:
> +          - const: cortina,gemini-timer
> +          - const: faraday,fttmr010
> +      - items:
> +          - const: moxa,moxart-timer
> +          - const: faraday,fttmr010
> +      - const: aspeed,ast2400-timer
> +      - const: aspeed,ast2500-timer
> +      - const: aspeed,ast2600-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 3
> +    description: Should contain the three timer interrupts usually with flags for falling edge
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: "PCLK"
> +      - const: "EXTCLK"

Don't need quotes here.

> +
> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1

'phandle' is already 1 item. so drop.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    /* taken from arch/arm/boot/dts/gemini.dtsi */

Drop

> +    timer@43000000 {
> +      compatible = "faraday,fttmr010";
> +      reg = <0x43000000 0x1000>;
> +      interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
> +                   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
> +                   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
> +      clocks = <&extclk>, <&pclk>;
> +      clock-names = "PCLK", "EXTCLK";
> +      syscon = <&syscon>;
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    /* taken from arch/arm/boot/dts/moxart.dtsi */

Drop

> +    timer: timer@98400000 {

Drop unused labels.

> +      compatible = "moxa,moxart-timer", "faraday,fttmr010";
> +      reg = <0x98400000 0x42>;
> +      interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
> +      clocks = <&clk_apb>;
> +      clock-names = "PCLK";
> +    };
> +...
> -- 
> 2.34.1
> 
> 
