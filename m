Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DEE51A407
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352422AbiEDPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352366AbiEDPa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:30:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EFF44747;
        Wed,  4 May 2022 08:27:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z2so2001204ejj.3;
        Wed, 04 May 2022 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYFoLCO4z/AXfy0dzZv1SpkW15aDzmCkgPkzwFJmvu0=;
        b=SX2lyqgSVvDJfWSLQ8kNc3HGPei9NiFMoxRqGlEpX8YgdljKrWHpecZb2u84YjhF+R
         w79obhpJ0H3gY1FkGC6wUXxR2Cd37Ka4kz9Gfb6HJlw39p/Qa+hdUCbbFv4YD/2paARy
         C/iN2IjrSRGvdjqt6krfPVrz6EyuLpZk7/9eTj4JfIh/+RnCdPk7HLWRJWx6uAIq3uHE
         hBkN+CgXK9AmZNDWH2+EAavNgpViblzwBUA8KnjcFZUL1SdmWf+IZbosFNl6XY+Z92lW
         9hYtftzz5LJ56w9DK15CFC79WYS6/Gp704f7hnjmFI+hZ7jFpBihPGZ7F6KE7MVp6Wuv
         EA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYFoLCO4z/AXfy0dzZv1SpkW15aDzmCkgPkzwFJmvu0=;
        b=8Iqx3Rwd0mp5iW5Rkoei0D8mDDPV7o0gthoUDiYUiVPJmXN7hAm3pRx17qg9C1qMo1
         gcuWfGHPf4yIyU7JRxaIRSPY76XsjnxtKJP7g9plP+QMJkKRnX6qgNKOUf4jYMY7ORMe
         te1aAuiAWcc9AjBV68GN/XjxApPeFLkBnJZO/vx1krK1p43qgS+LJibdyWAcuI2n4RCu
         7NIiwI0WFJqVAR4V2x/XOKP6JCRUE+Z8k3CyXhMr+3L+V8hfT1Io6Pl9wP+cCg653R1X
         hqKnQO2/1ihIp5LzrwPWU1k1y1ZrL49RSuiiLtMOnHEIF5rRLWd35TvcZQyjbI1jFRao
         n3oA==
X-Gm-Message-State: AOAM532GryRvVw/GdpDkfREIb37tAPrrBrtBeidFWnn7nM0gczIbMLy9
        xollFTJc3/oB3VbPumSKxfZSqfrivtAWLqq/r2A=
X-Google-Smtp-Source: ABdhPJyuidrDSbdfqIISfeZvZGVBLq0p/ftlSGearsMWlhfLcq/6OHemEIpjB2pohyOmjWvNppBEuqq/BcikHauaJ4Y=
X-Received: by 2002:a17:907:86a1:b0:6f4:63ae:768 with SMTP id
 qa33-20020a17090786a100b006f463ae0768mr12410161ejc.639.1651678041033; Wed, 04
 May 2022 08:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220504150457.5626-1-markuss.broks@gmail.com> <20220504150457.5626-2-markuss.broks@gmail.com>
In-Reply-To: <20220504150457.5626-2-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 May 2022 17:26:45 +0200
Message-ID: <CAHp75VfJ_yNoNAZ0guf0WtOaoH2jKJfFoVu3+jdSC2DZGFzmiQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 1/2] dt-bindings: leds: convert ktd2692 bindings
 to yaml
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 5:06 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> This patch converts the leds-ktd2692.txt bindings to modern yaml
> style device-tree bindings.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

There must be no blank lines in the tag block.

> ---
>  .../bindings/leds/kinetic,ktd2692.yaml        | 87 +++++++++++++++++++
>  .../devicetree/bindings/leds/leds-ktd2692.txt | 50 -----------
>  2 files changed, 87 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt
>
> diff --git a/Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml b/Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
> new file mode 100644
> index 000000000000..bac95a51afa1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/kinetic,ktd2692.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: KTD2692 Flash LED Driver from Kinetic Technologies
> +
> +maintainers:
> +  - Markuss Broks <markuss.broks@gmail.com>
> +
> +description: |
> +  KTD2692 is the ideal power solution for high-power flash LEDs.
> +  It uses ExpressWire single-wire programming for maximum flexibility.
> +
> +  The ExpressWire interface through CTRL pin can control LED on/off and
> +  enable/disable the IC, Movie(max 1/3 of Flash current) / Flash mode current,
> +  Flash timeout, LVP(low voltage protection).
> +
> +  Also, When the AUX pin is pulled high while CTRL pin is high,
> +  LED current will be ramped up to the flash-mode current level.
> +
> +properties:
> +  compatible:
> +    const: kinetic,ktd2692
> +
> +  ctrl-gpios:
> +    maxItems: 1
> +    description: Specifier of the GPIO connected to CTRL pin.
> +
> +  aux-gpios:
> +    maxItems: 1
> +    description: Specifier of the GPIO connected to CTRL pin.
> +
> +  vin-supply:
> +    description: LED supply (2.7V to 5.5V).
> +
> +  led:
> +    type: object
> +    $ref: common.yaml#
> +    description: Properties for the LED.
> +    properties:
> +      function: true
> +      color: true
> +      flash-max-timeout-us:
> +        description: Flash LED maximum timeout.
> +
> +      led-max-microamp:
> +        maximum: 300000
> +        description: Minimum Threshold for Timer protection
> +          is defined internally (Maximum 300mA).
> +
> +      flash-max-microamp:
> +        maximum: 300000
> +        description: Flash LED maximum current
> +          Formula - I(uA) = 15000000 / Rset.
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - ctrl-gpios
> +  - led
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    ktd2692 {
> +      compatible = "kinetic,ktd2692";
> +      ctrl-gpios = <&gpc0 1 0>;
> +      aux-gpios = <&gpc0 2 0>;
> +      vin-supply = <&vbat>;
> +
> +      led {
> +        function = LED_FUNCTION_FLASH;
> +        color = <LED_COLOR_ID_WHITE>;
> +        flash-max-timeout-us = <250000>;
> +        flash-max-microamp = <150000>;
> +        led-max-microamp = <25000>;
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/leds/leds-ktd2692.txt b/Documentation/devicetree/bindings/leds/leds-ktd2692.txt
> deleted file mode 100644
> index 853737452580..000000000000
> --- a/Documentation/devicetree/bindings/leds/leds-ktd2692.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Kinetic Technologies - KTD2692 Flash LED Driver
> -
> -KTD2692 is the ideal power solution for high-power flash LEDs.
> -It uses ExpressWire single-wire programming for maximum flexibility.
> -
> -The ExpressWire interface through CTRL pin can control LED on/off and
> -enable/disable the IC, Movie(max 1/3 of Flash current) / Flash mode current,
> -Flash timeout, LVP(low voltage protection).
> -
> -Also, When the AUX pin is pulled high while CTRL pin is high,
> -LED current will be ramped up to the flash-mode current level.
> -
> -Required properties:
> -- compatible : Should be "kinetic,ktd2692".
> -- ctrl-gpios : Specifier of the GPIO connected to CTRL pin.
> -- aux-gpios : Specifier of the GPIO connected to AUX pin.
> -
> -Optional properties:
> -- vin-supply : "vin" LED supply (2.7V to 5.5V).
> -  See Documentation/devicetree/bindings/regulator/regulator.txt
> -
> -A discrete LED element connected to the device must be represented by a child
> -node - See Documentation/devicetree/bindings/leds/common.txt
> -
> -Required properties for flash LED child nodes:
> -  See Documentation/devicetree/bindings/leds/common.txt
> -- led-max-microamp : Minimum Threshold for Timer protection
> -  is defined internally (Maximum 300mA).
> -- flash-max-microamp : Flash LED maximum current
> -  Formula : I(mA) = 15000 / Rset.
> -- flash-max-timeout-us : Flash LED maximum timeout.
> -
> -Optional properties for flash LED child nodes:
> -- label : See Documentation/devicetree/bindings/leds/common.txt
> -
> -Example:
> -
> -ktd2692 {
> -       compatible = "kinetic,ktd2692";
> -       ctrl-gpios = <&gpc0 1 0>;
> -       aux-gpios = <&gpc0 2 0>;
> -       vin-supply = <&vbat>;
> -
> -       flash-led {
> -               label = "ktd2692-flash";
> -               led-max-microamp = <300000>;
> -               flash-max-microamp = <1500000>;
> -               flash-max-timeout-us = <1835000>;
> -       };
> -};
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
