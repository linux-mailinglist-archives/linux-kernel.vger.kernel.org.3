Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE144856C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiAEQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:39:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56836 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiAEQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:39:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2B761807;
        Wed,  5 Jan 2022 16:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF7EC36AF6;
        Wed,  5 Jan 2022 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641400756;
        bh=x1d4jr/+fx6ugz5GA/Jkyo7ittb6atO1cNRYg8TyyoU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q4B8H4Kxi1NqUvGtv7KQQ1pHjjLQRWWpMjMcjBa+/9HWY9Qs0GSMCRP73R2G1q+Jr
         eCfVA/y6l9v4B6WgcaFrWQ1R4yWwhK6IxV+tS4X2TiB1Zf2K6V2OGjqm8nB9tJyO5i
         sfSjdJs6/y0jPBCifqHsQZiYNuBOv35Ro+2auUg+b8E1K7s2959IWujJBlyVz+90UG
         ++d8U4ll4VE3MwszIsp5BOKuIBet75Ag1+/dOAPoe27YNLKJSJm28Tih3wHOSgjwPe
         fVNvgmmYJfviX7Y1sJi02S1MFqJjAqfXxXPe0wmPUsjcpWabgPIY6L5SAioHAoRVu0
         VisTHJ8Sv2VZA==
Received: by mail-ed1-f50.google.com with SMTP id j6so164245810edw.12;
        Wed, 05 Jan 2022 08:39:15 -0800 (PST)
X-Gm-Message-State: AOAM533vxfaB9ntbOmdyb3cQk5OA687cM+yyhM4obvmX0FX+QgUGsWGv
        0tufWhmDtRYlQwzXb4DrxS9FMGinak+uMLJxiQ==
X-Google-Smtp-Source: ABdhPJx0xFMDNamZPUImxbepZLgOYZlha4IHe2F7Hkoj3uMjPftdotFuxc2dp8/E2n3dnwtfRNVsYRDwLcPhykr5Ej4=
X-Received: by 2002:a17:906:5284:: with SMTP id c4mr42991464ejm.423.1641400754134;
 Wed, 05 Jan 2022 08:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20211208003727.3596577-1-f.fainelli@gmail.com> <20211208003727.3596577-2-f.fainelli@gmail.com>
In-Reply-To: <20211208003727.3596577-2-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 5 Jan 2022 10:39:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0E8CPeAegp0mV_qBTVcoLuywppRiOvCtHGp6_cOxH3Q@mail.gmail.com>
Message-ID: <CAL_Jsq+0E8CPeAegp0mV_qBTVcoLuywppRiOvCtHGp6_cOxH3Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] dt-bindings: mmc: Convert Broadcom STB SDHCI
 binding to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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

On Tue, Dec 7, 2021 at 6:37 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Convert the Broadcom STB SDHCI controller Device Tree binding to YAML.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/mmc/brcm,sdhci-brcmstb.txt       |  53 ----------
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 100 ++++++++++++++++++
>  2 files changed, 100 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
> deleted file mode 100644
> index ae2074184528..000000000000
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -* BROADCOM BRCMSTB/BMIPS SDHCI Controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci-brcmstb driver.
> -
> -NOTE: The driver disables all UHS speed modes by default and depends
> -on Device Tree properties to enable them for SoC/Board combinations
> -that support them.
> -
> -Required properties:
> -- compatible: should be one of the following
> -  - "brcm,bcm7425-sdhci"
> -  - "brcm,bcm7445-sdhci"
> -  - "brcm,bcm7216-sdhci"
> -
> -Refer to clocks/clock-bindings.txt for generic clock consumer properties.
> -
> -Example:
> -
> -       sdhci@84b0000 {
> -               sd-uhs-sdr50;
> -               sd-uhs-ddr50;
> -               sd-uhs-sdr104;
> -               sdhci,auto-cmd12;
> -               compatible = "brcm,bcm7216-sdhci",
> -                          "brcm,bcm7445-sdhci",
> -                          "brcm,sdhci-brcmstb";
> -               reg = <0x84b0000 0x260 0x84b0300 0x200>;
> -               reg-names = "host", "cfg";
> -               interrupts = <0x0 0x26 0x4>;
> -               interrupt-names = "sdio0_0";
> -               clocks = <&scmi_clk 245>;
> -               clock-names = "sw_sdio";
> -       };
> -
> -       sdhci@84b1000 {
> -               mmc-ddr-1_8v;
> -               mmc-hs200-1_8v;
> -               mmc-hs400-1_8v;
> -               mmc-hs400-enhanced-strobe;
> -               supports-cqe;
> -               non-removable;
> -               bus-width = <0x8>;
> -               compatible = "brcm,bcm7216-sdhci",
> -                          "brcm,bcm7445-sdhci",
> -                          "brcm,sdhci-brcmstb";
> -               reg = <0x84b1000 0x260 0x84b1300 0x200>;
> -               reg-names = "host", "cfg";
> -               interrupts = <0x0 0x27 0x4>;
> -               interrupt-names = "sdio1_0";
> -               clocks = <&scmi_clk 245>;
> -               clock-names = "sw_sdio";
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> new file mode 100644
> index 000000000000..dccd5ad96981
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/brcm,sdhci-brcmstb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BRCMSTB/BMIPS SDHCI Controller binding
> +
> +maintainers:
> +  - Al Cooper <alcooperx@gmail.com>
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm7216-sdhci
> +          - const: brcm,bcm7445-sdhci
> +          - const: brcm,sdhci-brcmstb
> +      - items:
> +          - enum:
> +              - brcm,bcm7445-sdhci
> +          - const: brcm,sdhci-brcmstb
> +      - items:
> +          - enum:
> +              - brcm,bcm7425-sdhci
> +          - const: brcm,sdhci-brcmstb
> +
> +  reg:
> +    minItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: host
> +      - const: cfg
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      handle to core clock for the sdhci controller.
> +
> +  clock-names:
> +    items:
> +      - const: sw_sdio
> +
> +  sdhci,auto-cmd12:
> +    type: boolean
> +    description: Specifies that controller should use auto CMD12
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc@84b0000 {
> +      sd-uhs-sdr50;
> +      sd-uhs-ddr50;
> +      sd-uhs-sdr104;
> +      sdhci,auto-cmd12;
> +      compatible = "brcm,bcm7216-sdhci",
> +                   "brcm,bcm7445-sdhci",
> +                   "brcm,sdhci-brcmstb";
> +      reg = <0x84b0000 0x260>, <0x84b0300 0x200>;
> +      reg-names = "host", "cfg";
> +      interrupts = <0x0 0x26 0x4>;
> +      interrupt-names = "sdio0_0";

Not documented.

Rob
