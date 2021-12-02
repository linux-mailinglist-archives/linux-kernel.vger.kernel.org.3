Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B446676E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359329AbhLBQEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhLBQER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:04:17 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB3C06174A;
        Thu,  2 Dec 2021 08:00:54 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id n6so56819328uak.1;
        Thu, 02 Dec 2021 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2sZPQd798weph9knxMPMeinCmRojfS8Pfapl2giXJM=;
        b=jzpN2txMKcqDve7u5vuRi2+S6p2VzSDwNSmwgr2/5gAHntXTVsO8sG16S0sfqGyEUK
         i5x27dvhK+nePQ8Yv1FdSGF/aNukodMSRBjErWtEoehmr5hBVhIJR+8fxfg19jP0VmLF
         kDLyA3Rcf/hL1qOS1mxoSB8r7ot6uNKvV7zfnrN4auV/nXuMVm9ZJkxGibAMDmn/SoBe
         ROrk7jYNBy4vRtneCuKrpYlAlXLqbg6VPDloVm3HCa7hmqiu7kasCokZzPej4vufQLcm
         C103EOF/74+rSPWk4wyF6S+J+jQQ02uAbpL/QaSvdMcka5dyzJ3Tk3nenPYbgspH8T3x
         7IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2sZPQd798weph9knxMPMeinCmRojfS8Pfapl2giXJM=;
        b=HRZ3wB4So2gPSE9p3PGj91dZ32K3lvzrb4NYqR0D3dhitPorDeKlwtxAW7rQW0OMGn
         aijsNxew002ftVOAutuVn3Z3FFYJAYFmUbZQinOWgZqHA7Ucwjb4DOl7WepV6FdPMsVd
         2p+ZLCA+JoMVdY9jFkBwvrqCm/AG45qyX5PKTXmYqhzxTVJK8M/utfFs6iEpnIp1Jhoh
         sjTrwkyU2bhK0o9slrhIt556uW4qUz1DgG36+tjrEwOb14Rd/ZEzvTVcwHKCzeJjotUU
         yWw28KoWYqhGo4K+MN8+jH7A2MdSxIJL5c/Rf5OpcV0fpXNK0BSaQRZY2E7VIxo0ejTS
         44RA==
X-Gm-Message-State: AOAM530hese71zCkqrBBUAZbUNYt/GciqMDW2cJ22x9UMV2CGeebhavF
        ktIsvDhUevpGeD0FvTfafVp21jofAmoM9laPd60=
X-Google-Smtp-Source: ABdhPJybAreaEhSuo2y2Tbo1YdlgTaiMlhDNtXg5D8QWfVW6+flBljZULwo/BbqpU2HaLcu7I83aSoQSfdCygG1zQUs=
X-Received: by 2002:ab0:45a8:: with SMTP id u37mr15834000uau.24.1638460853923;
 Thu, 02 Dec 2021 08:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20211201205110.41656-1-f.fainelli@gmail.com> <20211201205110.41656-6-f.fainelli@gmail.com>
In-Reply-To: <20211201205110.41656-6-f.fainelli@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Thu, 2 Dec 2021 08:00:00 -0800
Message-ID: <CADtm3G7wiNdDq2fagWeSDd_RV_dyfrNy+5e-VL9OKjwGAWzNtg@mail.gmail.com>
Subject: Re: [PATCH 05/14] dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

I haven't kept up with the new yaml format, so not entirely sure I
know what I'm talking about yet, but here are a few comments:

On Wed, Dec 1, 2021 at 12:51 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
> validation.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/gpio/brcm,brcmstb-gpio.txt       |  83 --------------
>  .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 104 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 105 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
>
> diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
> deleted file mode 100644
> index 5d468ecd1809..000000000000
> --- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
> +++ /dev/null
> @@ -1,83 +0,0 @@
> [snip]
> -
> -- interrupts-extended:
> -    Alternate form of specifying interrupts and parents that allows for
> -    multiple parents.  This takes precedence over 'interrupts' and
> -    'interrupt-parent'.  Wakeup-capable GPIO controllers often route their
> -    wakeup interrupt lines through a different interrupt controller than the
> -    primary interrupt line, making this property necessary.

It looks like interrupts-extended was removed from the new docs, I'm
assuming that was intentional?

> [snip]
> diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
> new file mode 100644
> index 000000000000..4b7309dc74dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom STB "UPG GIO" GPIO controller
> +
> +description: >
> +  The controller's registers are organized as sets of eight 32-bit
> +  registers with each set controlling a bank of up to 32 pins.  A single
> +  interrupt is shared for all of the banks handled by the controller.
> +
> +maintainers:
> +  - Doug Berger <opendmb@gmail.com>
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm7445-gpio
> +          - const: brcm,brcmstb-gpio
> +
> +  reg:
> +    maxItems: 1
> +    description:

Missing folded block scalar marker ('>') above

> +      Define the base and range of the I/O address space containing
> +      the brcmstb GPIO controller registers
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: >
> +      The first cell is the pin number (within the controller's
> +      pin space), and the second is used for the following:
> +      bit[0]: polarity (0 for active-high, 1 for active-low)
> +
> +  gpio-controller: true
> +
> +  "brcm,gpio-bank-widths":
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:

Same here

> +      Number of GPIO lines for each bank.  Number of elements must
> +      correspond to number of banks suggested by the 'reg' property.
> +
> +  interrupts:
> +    maxItems: 1
> +    description:

While it's not necessary while this is only one line, consider adding
'>' here too.

> +      The interrupt shared by all GPIO lines for this controller.
> +
> +  "#interrupt-cells":
> +    const: 2
> +    description: >

This next block could get formatted strangely with '>'; recommend
using '|' instead

> +      The first cell is the GPIO number, the second should specify
> +      flags.  The following subset of flags is supported:
> +      - bits[3:0] trigger type and level flags
> +        1 = low-to-high edge triggered
> +        2 = high-to-low edge triggered
> +        4 = active high level-sensitive
> +        8 = active low level-sensitive
> +      Valid combinations are 1, 2, 3, 4, 8.
> +
> +  interrupt-controller: true
> +
> +  wakeup-source:
> +    type: boolean
> +    description: >
> +      GPIOs for this controller can be used as a wakeup source
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - "#gpio-cells"

Need to add required property "brcm,gpio-bank-widths"

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    upg_gio: gpio@f040a700 {
> +        #gpio-cells = <2>;
> +        #interrupt-cells = <2>;
> +        compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
> +        gpio-controller;
> +        interrupt-controller;
> +        reg = <0xf040a700 0x80>;
> +        interrupt-parent = <&irq0_intc>;
> +        interrupts = <0x6>;
> +        brcm,gpio-bank-widths = <32 32 32 24>;
> +    };
> +
> +    upg_gio_aon: gpio@f04172c0 {
> +        #gpio-cells = <2>;
> +        #interrupt-cells = <2>;
> +        compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
> +        gpio-controller;
> +        interrupt-controller;
> +        reg = <0xf04172c0 0x40>;
> +        interrupt-parent = <&irq0_aon_intc>;
> +        interrupts = <0x6>;
> +        wakeup-source;
> +        brcm,gpio-bank-widths = <18 4>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 913856599623..78161abc384f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3772,7 +3772,7 @@ BROADCOM BRCMSTB GPIO DRIVER
>  M:     Gregory Fong <gregory.0xf0@gmail.com>

Not really related to this patch, but I should probably update this
entry to reflect current reality. Should that be you and/or Doug?

>  L:     bcm-kernel-feedback-list@broadcom.com
>  S:     Supported
> -F:     Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
> +F:     Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
>  F:     drivers/gpio/gpio-brcmstb.c
>
>  BROADCOM BRCMSTB I2C DRIVER
> --
> 2.25.1
>

Best regards,
Gregory
