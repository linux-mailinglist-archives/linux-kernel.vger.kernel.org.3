Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96D4B02D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiBJB6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:58:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiBJB5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:57:22 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A53027D4C;
        Wed,  9 Feb 2022 17:34:18 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so4657239oot.4;
        Wed, 09 Feb 2022 17:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XNiOWPd36obXvgkEnxsQWaURMDInYrYIQkiEeqpKVQA=;
        b=w4KGe1YvxshAcnK70ia1WX59OOtFo8YOs5a015MLNg9nmHEYtu4V7Z4c9WffagoaJ8
         Wi4rAK5BwC5KiApC1o21aeaMOudCyhSTwSAzbIIcct7NExmi7m7ZGBNE4nsmRPfz8yFd
         YlRE3ZYNlIwxwIrRUcDTNd2OMHFPzFAxqCU25eJ508Y/zZuYrWEdH/wcb+HabZxWirtm
         R4oKRXEgc0fZCP4IzK7jCUpdNwrNFXsTSOagatOeby8VrC8nZpasuz4FVpk65LUDP4Ub
         NPHDmJFcsMMpdwCly6VtUlVCg1Xu4ppIVqee3F4xMreBzfqM5vnTcZdMVqdCFM1qdzCd
         NqpQ==
X-Gm-Message-State: AOAM5305Kd2S1NvoIAy+KniFAmBEB4tJRSPOW10zN+RJcaxN023TkOwo
        UVfrUOMr0qZzMe3P22mm9dNIasN8MVvo
X-Google-Smtp-Source: ABdhPJyzaCGC5eLQBASxyTGmEs5hjG9Z5P2Np9DRVceWLWDDoZhFzxyTV+VDN+pMiqQnGuiyEqs6xw==
X-Received: by 2002:a05:6871:581:: with SMTP id u1mr1833250oan.5.1644453499047;
        Wed, 09 Feb 2022 16:38:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c13sm7199740otf.5.2022.02.09.16.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:38:18 -0800 (PST)
Received: (nullmailer pid 1270516 invoked by uid 1000);
        Thu, 10 Feb 2022 00:38:17 -0000
Date:   Wed, 9 Feb 2022 18:38:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux@roeck-us.net, linus.walleij@linaro.org,
        wim@linux-watchdog.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: convert faraday,ftwdt010 to yaml
Message-ID: <YgReeZX3pc9G8yWp@robh.at.kernel.org>
References: <20220128204856.494643-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128204856.494643-1-clabbe@baylibre.com>
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

On Fri, Jan 28, 2022 at 08:48:56PM +0000, Corentin Labbe wrote:
> Converts watchdog/faraday,ftwdt010.txt to yaml.
> This permits to detect missing properties like clocks and resets or
> compatible like moxa,moxart-watchdog.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../bindings/watchdog/faraday,ftwdt010.txt    | 22 -------
>  .../bindings/watchdog/faraday,ftwdt010.yaml   | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
> deleted file mode 100644
> index 9ecdb502e605..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -Faraday Technology FTWDT010 watchdog
> -
> -This is an IP part from Faraday Technology found in the Gemini
> -SoCs and others.
> -
> -Required properties:
> -- compatible : must be one of
> -  "faraday,ftwdt010"
> -  "cortina,gemini-watchdog", "faraday,ftwdt010"
> -- reg : shall contain base register location and length
> -- interrupts : shall contain the interrupt for the watchdog
> -
> -Optional properties:
> -- timeout-sec : the default watchdog timeout in seconds.
> -
> -Example:
> -
> -watchdog@41000000 {
> -	compatible = "faraday,ftwdt010";
> -	reg = <0x41000000 0x1000>;
> -	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> -};
> diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> new file mode 100644
> index 000000000000..377529b21267
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/faraday,ftwdt010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology FTWDT010 watchdog
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  This is an IP part from Faraday Technology found in the Gemini
> +  SoCs and others.
> +

Need a $ref to watchdog.yaml

> +properties:
> +  compatible:
> +    oneOf:
> +      - const: "faraday,ftwdt010"
> +      - items:
> +          - const: "cortina,gemini-watchdog"
> +          - const: "faraday,ftwdt010"
> +      - items:
> +          - const: "moxa,moxart-watchdog"
> +          - const: "faraday,ftwdt010"

Don't need quotes

blank line

> +  reg:
> +    maxItems: 1

blank line...

> +  resets:
> +    maxItems: 1
> +  clocks:
> +    maxItems: 1
> +  clock-names:
> +    const: PCLK
> +  interrupts:
> +    maxItems: 1
> +  timeout-sec:
> +    description: the default watchdog timeout in seconds.

Don't need to describe common properties.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    watchdog@41000000 {
> +      compatible = "faraday,ftwdt010";
> +      reg = <0x41000000 0x1000>;
> +      interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +  - |
> +    watchdog: watchdog@98500000 {
> +      compatible = "moxa,moxart-watchdog", "faraday,ftwdt010";
> +      reg = <0x98500000 0x10>;
> +      clocks = <&clk_apb>;
> +      clock-names = "PCLK";
> +    };
> +...
> -- 
> 2.34.1
> 
> 
