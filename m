Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F354D3D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiCIXWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCIXWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:22:14 -0500
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8649F3B2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:21:14 -0800 (PST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 51D643C202
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:21:14 -0600 (CST)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id S5cIn5uONXvvJS5cInRF1O; Wed, 09 Mar 2022 17:21:14 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4sY1MYouI2yDENvehlFaI2WACHcKwdLFIJ9kPx6lQQE=; b=5eS9fEZjHpnSTPBA77XG4fIq1G
        CZ/FGLeEdjmGw3krFFank3f0iIGARfEeDGtmyt8mF5/hWcKgaA1jkqv+y1Iv/DB/8iXkm4oYzfq5+
        10kei1w4874hur3ogx8Ti4WGNlzFPP1qf5oLYzpjHjHN2GOH8NoWf2kkkAqRwqG2I37PZZBhhYnV5
        +DQv47TLhCbGjEWWETIXbuxv7RwoTC9pL8Xr2pr5FKGpqMtWpmzfWxe6hxkPJ5tPeZJVGG4rQXX6t
        1rGWfSczImgRN3zP88dXUVbgMXQYy3I/TgIo6+ypxnFSSdko+cO2ve1rGy90Nr+/g9TiaYzvVwG/W
        gOxux2SQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57412 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nS5cH-000Sd7-MC; Wed, 09 Mar 2022 23:21:13 +0000
Date:   Wed, 9 Mar 2022 15:21:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        wim@linux-watchdog.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: watchdog: convert faraday,ftwdt010 to
 yaml
Message-ID: <20220309232112.GA3803602@roeck-us.net>
References: <20220211115528.3382374-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211115528.3382374-1-clabbe@baylibre.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nS5cH-000Sd7-MC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57412
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 75
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 11:55:28AM +0000, Corentin Labbe wrote:
> Converts watchdog/faraday,ftwdt010.txt to yaml.
> This permits to detect missing properties like clocks and resets or
> compatible like moxa,moxart-watchdog.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
> - Added myself as maintainer as requested by Linus
> - Added $ref to watchdog.yaml
> - Removed useless quotes
> - Added blank lines between properties
> - Removed timeout-secs as already provided by watchdog.yaml
> 
> Change since v2:
> - rewrite compatible section
> 
> Changes since v3:
> - Fix indent errors reported by yamllint
> - Change additionalProperties to unevaluatedProperties
> - Added timeout-secs in example
> 
>  .../bindings/watchdog/faraday,ftwdt010.txt    | 22 ------
>  .../bindings/watchdog/faraday,ftwdt010.yaml   | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 22 deletions(-)
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
> index 000000000000..ca9e1beff76b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> @@ -0,0 +1,67 @@
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
> +  - Corentin Labbe <clabbe@baylibre.com>
> +
> +description: |
> +  This is an IP part from Faraday Technology found in the Gemini
> +  SoCs and others.
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,ftwdt010
> +      - items:
> +          - enum:
> +              - cortina,gemini-watchdog
> +              - moxa,moxart-watchdog
> +          - const: faraday,ftwdt010
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: PCLK
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    watchdog@41000000 {
> +      compatible = "faraday,ftwdt010";
> +      reg = <0x41000000 0x1000>;
> +      interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +      timeout-secs = <5>;
> +    };
> +  - |
> +    watchdog: watchdog@98500000 {
> +      compatible = "moxa,moxart-watchdog", "faraday,ftwdt010";
> +      reg = <0x98500000 0x10>;
> +      clocks = <&clk_apb>;
> +      clock-names = "PCLK";
> +    };
> +...
