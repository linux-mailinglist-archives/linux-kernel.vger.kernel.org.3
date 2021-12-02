Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C3466BA2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377071AbhLBV1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbhLBV1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:27:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9ACC06174A;
        Thu,  2 Dec 2021 13:24:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so3526165pju.3;
        Thu, 02 Dec 2021 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+BkUAqxoN5Fy8yjLt+FU0EZ0cX0yYjSMs8+EtuSBhk0=;
        b=Cd6RK4cQTZRM/IqvHQkZhLCqCs/8jMcF4lppy7tucbr5Vp+FR3+HUnoFq4tqBtf/D1
         Kev3XDjfu5qg71ZDDrO+4/H+O7T81BV9RXOmklrDVL82HW7YhD/aw26FBAPMTtAlPDcd
         c6GUG5i/ZaWpi0KH/rW6w/88XjB1cl94v3vN9eKoSMEPaAwHLZNuq/XUPlHCn7AYgx21
         swoaFqRhA93KhPICqW/XVxobDUglQqVH6mgpQovw3rJOtSbwe2asZcHjLteUP/swflpp
         9PGMgk31ZwykW6bqfotRQbIgFtc5UD4JJ6J7XrU8U38PzhO+MIoVWG1A10pdfBOFKlT4
         pRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+BkUAqxoN5Fy8yjLt+FU0EZ0cX0yYjSMs8+EtuSBhk0=;
        b=7+4xXSshssLvb+DGgS7Kq0ica3kufMQskUJw+4GP4cLADIw0OdQ2rJEazSURz8lA0D
         P9KNZ2HMgx+vH00vcNeL6c6AcPBA7zXkYmLKCPrEnK74XN2rUoP1zt0x9nwN8Z48fHhQ
         vyTG0OAx3++jtsiCDguXEnwdYvQOhBi25yIA1cKH5MvMa8+gvgAAO7tXAPe1MUVUDNDs
         +G0JGp/PhwE9lESE1KKeJPYCCHwwqa4NW1z1sJjnB8jRaOkMYWZE7/nTGPpDKiKi5W7i
         LUn01fxkKMghwxgIQGhethM7WSANOeG11FNenRMyvy5yTd8QSq6QLTyVbtWbP1U4D5Y6
         pjEA==
X-Gm-Message-State: AOAM532oG9ERPaBB8DsWIMaWCyaq/g96kOxHOI+rml2or8MfbomWlYjY
        BKIQLRdDewcWl5Hd80nzc/31FveAJMA=
X-Google-Smtp-Source: ABdhPJzQfHwdite6wq1wX6654rl7VFWnhrkbBLVs9Lw+py7iIKCDVj2Guu8Qn+ylTh2ccdjXn0MrpQ==
X-Received: by 2002:a17:902:e88a:b0:141:dfde:eed7 with SMTP id w10-20020a170902e88a00b00141dfdeeed7mr18172144plg.17.1638480267230;
        Thu, 02 Dec 2021 13:24:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mr2sm402399pjb.25.2021.12.02.13.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 13:24:26 -0800 (PST)
Subject: Re: [PATCH 05/14] dt-bindings: gpio: Convert Broadcom STB GPIO to
 YAML
To:     Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
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
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
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
References: <20211201205110.41656-1-f.fainelli@gmail.com>
 <20211201205110.41656-6-f.fainelli@gmail.com>
 <CADtm3G7wiNdDq2fagWeSDd_RV_dyfrNy+5e-VL9OKjwGAWzNtg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f96c346a-0d17-6148-0924-72744dd5c34d@gmail.com>
Date:   Thu, 2 Dec 2021 13:24:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CADtm3G7wiNdDq2fagWeSDd_RV_dyfrNy+5e-VL9OKjwGAWzNtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 8:00 AM, Gregory Fong wrote:
> Hi Florian,
> 
> I haven't kept up with the new yaml format, so not entirely sure I
> know what I'm talking about yet, but here are a few comments:
> 
> On Wed, Dec 1, 2021 at 12:51 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
>> validation.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../bindings/gpio/brcm,brcmstb-gpio.txt       |  83 --------------
>>  .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 104 ++++++++++++++++++
>>  MAINTAINERS                                   |   2 +-
>>  3 files changed, 105 insertions(+), 84 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
>>  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
>> deleted file mode 100644
>> index 5d468ecd1809..000000000000
>> --- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
>> +++ /dev/null
>> @@ -1,83 +0,0 @@
>> [snip]
>> -
>> -- interrupts-extended:
>> -    Alternate form of specifying interrupts and parents that allows for
>> -    multiple parents.  This takes precedence over 'interrupts' and
>> -    'interrupt-parent'.  Wakeup-capable GPIO controllers often route their
>> -    wakeup interrupt lines through a different interrupt controller than the
>> -    primary interrupt line, making this property necessary.
> 
> It looks like interrupts-extended was removed from the new docs, I'm
> assuming that was intentional?

Yes that is intentional, since this is a core property there is an
expectation that it is documented and used outside of the scope of this
binding.

> 
>> [snip]
>> diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
>> new file mode 100644
>> index 000000000000..4b7309dc74dc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
>> @@ -0,0 +1,104 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Broadcom STB "UPG GIO" GPIO controller
>> +
>> +description: >
>> +  The controller's registers are organized as sets of eight 32-bit
>> +  registers with each set controlling a bank of up to 32 pins.  A single
>> +  interrupt is shared for all of the banks handled by the controller.
>> +
>> +maintainers:
>> +  - Doug Berger <opendmb@gmail.com>
>> +  - Florian Fainelli <f.fainelli@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - brcm,bcm7445-gpio
>> +          - const: brcm,brcmstb-gpio
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description:
> 
> Missing folded block scalar marker ('>') above

Done.

> 
>> +      Define the base and range of the I/O address space containing
>> +      the brcmstb GPIO controller registers
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +    description: >
>> +      The first cell is the pin number (within the controller's
>> +      pin space), and the second is used for the following:
>> +      bit[0]: polarity (0 for active-high, 1 for active-low)
>> +
>> +  gpio-controller: true
>> +
>> +  "brcm,gpio-bank-widths":
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
> 
> Same here
> 
>> +      Number of GPIO lines for each bank.  Number of elements must
>> +      correspond to number of banks suggested by the 'reg' property.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
> 
> While it's not necessary while this is only one line, consider adding
> '>' here too.
> 
>> +      The interrupt shared by all GPIO lines for this controller.
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +    description: >
> 
> This next block could get formatted strangely with '>'; recommend
> using '|' instead

Yes good point.

> 
>> +      The first cell is the GPIO number, the second should specify
>> +      flags.  The following subset of flags is supported:
>> +      - bits[3:0] trigger type and level flags
>> +        1 = low-to-high edge triggered
>> +        2 = high-to-low edge triggered
>> +        4 = active high level-sensitive
>> +        8 = active low level-sensitive
>> +      Valid combinations are 1, 2, 3, 4, 8.
>> +
>> +  interrupt-controller: true
>> +
>> +  wakeup-source:
>> +    type: boolean
>> +    description: >
>> +      GPIOs for this controller can be used as a wakeup source
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - gpio-controller
>> +  - "#gpio-cells"
> 
> Need to add required property "brcm,gpio-bank-widths"

Indeed, done.

> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    upg_gio: gpio@f040a700 {
>> +        #gpio-cells = <2>;
>> +        #interrupt-cells = <2>;
>> +        compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
>> +        gpio-controller;
>> +        interrupt-controller;
>> +        reg = <0xf040a700 0x80>;
>> +        interrupt-parent = <&irq0_intc>;
>> +        interrupts = <0x6>;
>> +        brcm,gpio-bank-widths = <32 32 32 24>;
>> +    };
>> +
>> +    upg_gio_aon: gpio@f04172c0 {
>> +        #gpio-cells = <2>;
>> +        #interrupt-cells = <2>;
>> +        compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
>> +        gpio-controller;
>> +        interrupt-controller;
>> +        reg = <0xf04172c0 0x40>;
>> +        interrupt-parent = <&irq0_aon_intc>;
>> +        interrupts = <0x6>;
>> +        wakeup-source;
>> +        brcm,gpio-bank-widths = <18 4>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 913856599623..78161abc384f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3772,7 +3772,7 @@ BROADCOM BRCMSTB GPIO DRIVER
>>  M:     Gregory Fong <gregory.0xf0@gmail.com>
> 
> Not really related to this patch, but I should probably update this
> entry to reflect current reality. Should that be you and/or Doug?

If you could add both of us that would be great, thanks!
-- 
Florian
