Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04246E634
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhLIKKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhLIKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:10:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8EC061A32
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:06:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m27so10897331lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rR9HkzFTP4grkP6sg2UeJ3/DfSt5b0pBlUV4udB0Wac=;
        b=IuTimkarfAf0OIwVa8DtZn2VMHFohSoEHB/6rR8h0PyKU00F0LvQfoIg20ew/3Ab7S
         vZ6BR1Wt8CbkMEEKbToSFvc0EfxZ0YApVqFJBL7U//rCTjqVzxH+16As2m8alXUQcGHM
         A+meSWcvJZU/BrDFFfomiiuaxu62dAInCU4w5KanxSvQOZiFsC9NbcJv9kFAV6OQ1dxb
         43iUtyLNmDjKki7sIU9Ex4YftMq1UADsNvNrG496r1vILRaY3paQTwfy4z+nlseLVYpV
         pSi3kU1pNxf93HbjcWyjQ8NzLfLcK6U492aOsvmt9ca/qen88qeMSBNr84CYQCevrdAq
         cG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rR9HkzFTP4grkP6sg2UeJ3/DfSt5b0pBlUV4udB0Wac=;
        b=oP2dQq7sUxp6dJditkPcnrvEqSgh2TTpDFP81KdEvSGtPCG23ADPuZm7aJm7B1HivD
         dx8ZK72RVhmOfavxPQIcfaeHMjz/vp25FpPMDrXNHaxcWGfF2Qg2++qsROyGjHRrWyzo
         uATPog0DchI33MWU6vMsgIAqovWcIOOl2EdX7DnVjnBxibvXIQbuN6uQH5gLtxGNjduW
         XtEv9QzH9FubJZ7Qt0l/Sakn5vV0skXZkSsgnNBSkHo/VSy+/7rsQzmJLG+3yz6uopNe
         QzTkxGYvUWmO0R4ZyLBZzFCMyE//5vJ2V4HYceg6QCD2/cwM7cUrvZlOjxLIjOYP+5ag
         r57A==
X-Gm-Message-State: AOAM530q1ZGhrYYRKhNZpOnaufYDu9X25Vvnt4VYpkHWbL2hnRZX7iVc
        gicBrxM8EMWmiuspwJ95S88//gK81XhBBtcanMbxbQ==
X-Google-Smtp-Source: ABdhPJwkdd82JBnjFtUXNmkhka2mBRwmZxvRO/lV8z12CK7y93SxJBpsK1/sKP0IR7oMTYn2fkm07zk+qba6CB2bh1A=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr5146148lfq.254.1639044399304;
 Thu, 09 Dec 2021 02:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20211208003727.3596577-1-f.fainelli@gmail.com> <20211208003727.3596577-2-f.fainelli@gmail.com>
In-Reply-To: <20211208003727.3596577-2-f.fainelli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 11:06:02 +0100
Message-ID: <CAPDyKFqHCUcEPOy80x-5Mx9fC-jrfme9B2kaANtapdnzFj7qLw@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] dt-bindings: mmc: Convert Broadcom STB SDHCI
 binding to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- trimmed cc list

On Wed, 8 Dec 2021 at 01:37, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Convert the Broadcom STB SDHCI controller Device Tree binding to YAML.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


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
> +      clocks = <&scmi_clk 245>;
> +      clock-names = "sw_sdio";
> +    };
> +
> +    mmc@84b1000 {
> +      mmc-ddr-1_8v;
> +      mmc-hs200-1_8v;
> +      mmc-hs400-1_8v;
> +      mmc-hs400-enhanced-strobe;
> +      supports-cqe;
> +      non-removable;
> +      bus-width = <0x8>;
> +      compatible = "brcm,bcm7216-sdhci",
> +           "brcm,bcm7445-sdhci",
> +            "brcm,sdhci-brcmstb";
> +      reg = <0x84b1000 0x260>, <0x84b1300 0x200>;
> +      reg-names = "host", "cfg";
> +      interrupts = <0x0 0x27 0x4>;
> +      interrupt-names = "sdio1_0";
> +      clocks = <&scmi_clk 245>;
> +      clock-names = "sw_sdio";
> +    };
> --
> 2.25.1
>
