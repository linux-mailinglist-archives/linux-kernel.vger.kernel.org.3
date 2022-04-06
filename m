Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1304F6680
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbiDFQzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiDFQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:55:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA571ACA48
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:55:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 5so4587655lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0C41vlFJi00ZdNTdz0449+mYOO6g/uV3hRmQuYjWNMQ=;
        b=fQ/Wc0G3HdtZYYG/KkKqfT2XIzJXHq9RtSAJ1wrwsqWVmXiBhdK75Q/yDW6UI1V0fK
         2GVhHAYwbnFDiVRmOx47xyT4MarntusEpjJ9wcBHAjOfz1CUx2UXYJO/BF3//j2Y9qPe
         6NYfj8034lPYOQh6W+ytZwDxs9cApkYXvXoWS5n+Iy8sEeLK0RiCGKVJJ4y5T4VguQ8d
         fU97Sq4b9cyu27cpqi6CvyDfBvmvW1UcsPGQtasfNAeKiH3mQfVdc+1efIwductqFayb
         SkpJohu+WmK4bZGbNXqwwWvXoXn+ue9Qz0CoYJ2R2odcHMoijIOuDireRdU8S89r64/M
         7p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0C41vlFJi00ZdNTdz0449+mYOO6g/uV3hRmQuYjWNMQ=;
        b=YXDyTOSrCxCo3naMlR5xfZUxnpc/1ib//RkaDBWeoM/7TpnRkwYv/41PuknxgGJodJ
         MUbb4F8n47jXgOdvvYtRnLu1e6FRGvzi1OTbrhPRl5oYObgQyRyqqKLH4Wf49Ctxfc9o
         Zpps4P52gfsCZWMbQyM2dAAbUjKaGyg6r4wj3wxXuTXQMPb7ZTurzZu/0C01BNTxDpW8
         jR9gnv8eLbfjIkeowHkmIVZVhMiApXx09035cvz/M+vgNlmqWubSdy/prYdR/MbJJyUk
         8yhpZ4P6E/D1wKWDlnMddyYchtYco2X5vWYFGYKlXPWlmoxa5mRWBH4PzKpEqEJghDL/
         psGw==
X-Gm-Message-State: AOAM533ch6DeSOd8sU+ecwe9Vu8t1Qy3cxrSVbqiXD69/1/5vXmPqp6t
        dJ3KRlFPJJcEsbffCTc3trJtIW3HMnC5EoDev2Y6mMh7ztA=
X-Google-Smtp-Source: ABdhPJyxN66HGw4d58E0wkOLj+bLblzF2bGjppGKpAKyUoyND9IgMLwVCwCiQ6P+QUhlqeuYAbOqkyna8gdO6eEUMow=
X-Received: by 2002:a05:6512:108b:b0:44a:6dc2:ffeb with SMTP id
 j11-20020a056512108b00b0044a6dc2ffebmr6369639lfg.184.1649256944218; Wed, 06
 Apr 2022 07:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220329220544.2132135-1-chris.packham@alliedtelesis.co.nz> <20220329220544.2132135-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20220329220544.2132135-3-chris.packham@alliedtelesis.co.nz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 16:55:06 +0200
Message-ID: <CAPDyKFretCT9APJROjkxwS5EGBC=n+FeBKCP0+FEyyT8whkTpw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, huziji@marvell.com,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 at 00:06, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
> in-tree dts files don't validate because they use sdhci@ instead of mmc@
> as required by the generic mmc-controller schema.
>
> The compatible "marvell,sdhci-xenon" was not documented in the old
> binding but it accompanies the of "marvell,armada-3700-sdhci" in the
> armada-37xx SoC dtsi so this combination is added to the new binding
> document.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next (and by using Krzysztof's linaro-email), thanks!

Kind regards
Uffe



> ---
>
> Notes:
>     Changes in v5:
>     - Fix silly error in examples
>     Changes in v4:
>     - Add review from Krzysztof
>     - Squash in addition of marvell,sdhci-xenon with an explanation in the
>       commit message
>     Changes in v3:
>     - Don't accept ap807 without ap806
>     - Add ref: string for pad-type
>     Changes in v2:
>     - Update MAINTAINERS entry
>     - Incorporate feedback from Krzysztof
>
>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 276 insertions(+), 174 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> deleted file mode 100644
> index c51a62d751dc..000000000000
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> +++ /dev/null
> @@ -1,173 +0,0 @@
> -Marvell Xenon SDHCI Controller device tree bindings
> -This file documents differences between the core mmc properties
> -described by mmc.txt and the properties used by the Xenon implementation.
> -
> -Multiple SDHCs might be put into a single Xenon IP, to save size and cost.
> -Each SDHC is independent and owns independent resources, such as register sets,
> -clock and PHY.
> -Each SDHC should have an independent device tree node.
> -
> -Required Properties:
> -- compatible: should be one of the following
> -  - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SoC.
> -  Must provide a second register area and marvell,pad-type.
> -  - "marvell,armada-ap806-sdhci": For controllers on Armada AP806.
> -  - "marvell,armada-ap807-sdhci": For controllers on Armada AP807.
> -  - "marvell,armada-cp110-sdhci": For controllers on Armada CP110.
> -
> -- clocks:
> -  Array of clocks required for SDHC.
> -  Require at least input clock for Xenon IP core. For Armada AP806 and
> -  CP110, the AXI clock is also mandatory.
> -
> -- clock-names:
> -  Array of names corresponding to clocks property.
> -  The input clock for Xenon IP core should be named as "core".
> -  The input clock for the AXI bus must be named as "axi".
> -
> -- reg:
> -  * For "marvell,armada-3700-sdhci", two register areas.
> -    The first one for Xenon IP register. The second one for the Armada 3700 SoC
> -    PHY PAD Voltage Control register.
> -    Please follow the examples with compatible "marvell,armada-3700-sdhci"
> -    in below.
> -    Please also check property marvell,pad-type in below.
> -
> -  * For other compatible strings, one register area for Xenon IP.
> -
> -Optional Properties:
> -- marvell,xenon-sdhc-id:
> -  Indicate the corresponding bit index of current SDHC in
> -  SDHC System Operation Control Register Bit[7:0].
> -  Set/clear the corresponding bit to enable/disable current SDHC.
> -  If Xenon IP contains only one SDHC, this property is optional.
> -
> -- marvell,xenon-phy-type:
> -  Xenon support multiple types of PHYs.
> -  To select eMMC 5.1 PHY, set:
> -  marvell,xenon-phy-type = "emmc 5.1 phy"
> -  eMMC 5.1 PHY is the default choice if this property is not provided.
> -  To select eMMC 5.0 PHY, set:
> -  marvell,xenon-phy-type = "emmc 5.0 phy"
> -
> -  All those types of PHYs can support eMMC, SD and SDIO.
> -  Please note that this property only presents the type of PHY.
> -  It doesn't stand for the entire SDHC type or property.
> -  For example, "emmc 5.1 phy" doesn't mean that this Xenon SDHC only
> -  supports eMMC 5.1.
> -
> -- marvell,xenon-phy-znr:
> -  Set PHY ZNR value.
> -  Only available for eMMC PHY.
> -  Valid range = [0:0x1F].
> -  ZNR is set as 0xF by default if this property is not provided.
> -
> -- marvell,xenon-phy-zpr:
> -  Set PHY ZPR value.
> -  Only available for eMMC PHY.
> -  Valid range = [0:0x1F].
> -  ZPR is set as 0xF by default if this property is not provided.
> -
> -- marvell,xenon-phy-nr-success-tun:
> -  Set the number of required consecutive successful sampling points
> -  used to identify a valid sampling window, in tuning process.
> -  Valid range = [1:7].
> -  Set as 0x4 by default if this property is not provided.
> -
> -- marvell,xenon-phy-tun-step-divider:
> -  Set the divider for calculating TUN_STEP.
> -  Set as 64 by default if this property is not provided.
> -
> -- marvell,xenon-phy-slow-mode:
> -  If this property is selected, transfers will bypass PHY.
> -  Only available when bus frequency lower than 55MHz in SDR mode.
> -  Disabled by default. Please only try this property if timing issues
> -  always occur with PHY enabled in eMMC HS SDR, SD SDR12, SD SDR25,
> -  SD Default Speed and HS mode and eMMC legacy speed mode.
> -
> -- marvell,xenon-tun-count:
> -  Xenon SDHC SoC usually doesn't provide re-tuning counter in
> -  Capabilities Register 3 Bit[11:8].
> -  This property provides the re-tuning counter.
> -  If this property is not set, default re-tuning counter will
> -  be set as 0x9 in driver.
> -
> -- marvell,pad-type:
> -  Type of Armada 3700 SoC PHY PAD Voltage Controller register.
> -  Only valid when "marvell,armada-3700-sdhci" is selected.
> -  Two types: "sd" and "fixed-1-8v".
> -  If "sd" is selected, SoC PHY PAD is set as 3.3V at the beginning and is
> -  switched to 1.8V when later in higher speed mode.
> -  If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such as for eMMC.
> -  Please follow the examples with compatible "marvell,armada-3700-sdhci"
> -  in below.
> -
> -Example:
> -- For eMMC:
> -
> -       sdhci@aa0000 {
> -               compatible = "marvell,armada-ap806-sdhci";
> -               reg = <0xaa0000 0x1000>;
> -               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> -               clocks = <&emmc_clk>,<&axi_clk>;
> -               clock-names = "core", "axi";
> -               bus-width = <4>;
> -               marvell,xenon-phy-slow-mode;
> -               marvell,xenon-tun-count = <11>;
> -               non-removable;
> -               no-sd;
> -               no-sdio;
> -
> -               /* Vmmc and Vqmmc are both fixed */
> -       };
> -
> -- For SD/SDIO:
> -
> -       sdhci@ab0000 {
> -               compatible = "marvell,armada-cp110-sdhci";
> -               reg = <0xab0000 0x1000>;
> -               interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> -               vqmmc-supply = <&sd_vqmmc_regulator>;
> -               vmmc-supply = <&sd_vmmc_regulator>;
> -               clocks = <&sdclk>, <&axi_clk>;
> -               clock-names = "core", "axi";
> -               bus-width = <4>;
> -               marvell,xenon-tun-count = <9>;
> -       };
> -
> -- For eMMC with compatible "marvell,armada-3700-sdhci":
> -
> -       sdhci@aa0000 {
> -               compatible = "marvell,armada-3700-sdhci";
> -               reg = <0xaa0000 0x1000>,
> -                     <phy_addr 0x4>;
> -               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> -               clocks = <&emmcclk>;
> -               clock-names = "core";
> -               bus-width = <8>;
> -               mmc-ddr-1_8v;
> -               mmc-hs400-1_8v;
> -               non-removable;
> -               no-sd;
> -               no-sdio;
> -
> -               /* Vmmc and Vqmmc are both fixed */
> -
> -               marvell,pad-type = "fixed-1-8v";
> -       };
> -
> -- For SD/SDIO with compatible "marvell,armada-3700-sdhci":
> -
> -       sdhci@ab0000 {
> -               compatible = "marvell,armada-3700-sdhci";
> -               reg = <0xab0000 0x1000>,
> -                     <phy_addr 0x4>;
> -               interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> -               vqmmc-supply = <&sd_regulator>;
> -               /* Vmmc is fixed */
> -               clocks = <&sdclk>;
> -               clock-names = "core";
> -               bus-width = <4>;
> -
> -               marvell,pad-type = "sd";
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> new file mode 100644
> index 000000000000..c79639e9027e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -0,0 +1,275 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Xenon SDHCI Controller
> +
> +description: |
> +  This file documents differences between the core MMC properties described by
> +  mmc-controller.yaml and the properties used by the Xenon implementation.
> +
> +  Multiple SDHCs might be put into a single Xenon IP, to save size and cost.
> +  Each SDHC is independent and owns independent resources, such as register
> +  sets, clock and PHY.
> +
> +  Each SDHC should have an independent device tree node.
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - marvell,armada-cp110-sdhci
> +          - marvell,armada-ap806-sdhci
> +
> +      - items:
> +          - const: marvell,armada-ap807-sdhci
> +          - const: marvell,armada-ap806-sdhci
> +
> +      - items:
> +          - const: marvell,armada-3700-sdhci
> +          - const: marvell,sdhci-xenon
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      For "marvell,armada-3700-sdhci", two register areas.  The first one
> +      for Xenon IP register. The second one for the Armada 3700 SoC PHY PAD
> +      Voltage Control register.  Please follow the examples with compatible
> +      "marvell,armada-3700-sdhci" in below.
> +      Please also check property marvell,pad-type in below.
> +
> +      For other compatible strings, one register area for Xenon IP.
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: core
> +      - const: axi
> +
> +  marvell,xenon-sdhc-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    description: |
> +      Indicate the corresponding bit index of current SDHC in SDHC System
> +      Operation Control Register Bit[7:0].  Set/clear the corresponding bit to
> +      enable/disable current SDHC.
> +
> +  marvell,xenon-phy-type:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - "emmc 5.1 phy"
> +      - "emmc 5.0 phy"
> +    description: |
> +      Xenon support multiple types of PHYs. To select eMMC 5.1 PHY, set:
> +      marvell,xenon-phy-type = "emmc 5.1 phy" eMMC 5.1 PHY is the default
> +      choice if this property is not provided.  To select eMMC 5.0 PHY, set:
> +      marvell,xenon-phy-type = "emmc 5.0 phy"
> +
> +      All those types of PHYs can support eMMC, SD and SDIO. Please note that
> +      this property only presents the type of PHY.  It doesn't stand for the
> +      entire SDHC type or property.  For example, "emmc 5.1 phy" doesn't mean
> +      that this Xenon SDHC only supports eMMC 5.1.
> +
> +  marvell,xenon-phy-znr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0x1f
> +    default: 0xf
> +    description: |
> +      Set PHY ZNR value.
> +      Only available for eMMC PHY.
> +
> +  marvell,xenon-phy-zpr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0x1f
> +    default: 0xf
> +    description: |
> +      Set PHY ZPR value.
> +      Only available for eMMC PHY.
> +
> +  marvell,xenon-phy-nr-success-tun:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 7
> +    default: 0x4
> +    description: |
> +      Set the number of required consecutive successful sampling points
> +      used to identify a valid sampling window, in tuning process.
> +
> +  marvell,xenon-phy-tun-step-divider:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 64
> +    description: |
> +      Set the divider for calculating TUN_STEP.
> +
> +  marvell,xenon-phy-slow-mode:
> +    type: boolean
> +    description: |
> +      If this property is selected, transfers will bypass PHY.
> +      Only available when bus frequency lower than 55MHz in SDR mode.
> +      Disabled by default. Please only try this property if timing issues
> +      always occur with PHY enabled in eMMC HS SDR, SD SDR12, SD SDR25,
> +      SD Default Speed and HS mode and eMMC legacy speed mode.
> +
> +  marvell,xenon-tun-count:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x9
> +    description: |
> +      Xenon SDHC SoC usually doesn't provide re-tuning counter in
> +      Capabilities Register 3 Bit[11:8].
> +      This property provides the re-tuning counter.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,armada-3700-sdhci
> +
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Xenon IP registers
> +            - description: Armada 3700 SoC PHY PAD Voltage Control register
> +          minItems: 2
> +
> +        marvell,pad-type:
> +          $ref: /schemas/types.yaml#/definitions/string
> +          enum:
> +            - sd
> +            - fixed-1-8v
> +          description: |
> +            Type of Armada 3700 SoC PHY PAD Voltage Controller register.
> +            If "sd" is selected, SoC PHY PAD is set as 3.3V at the beginning
> +            and is switched to 1.8V when later in higher speed mode.
> +            If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such as for
> +            eMMC.
> +            Please follow the examples with compatible
> +            "marvell,armada-3700-sdhci" in below.
> +
> +      required:
> +        - marvell,pad-type
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - marvell,armada-cp110-sdhci
> +              - marvell,armada-ap807-sdhci
> +              - marvell,armada-ap806-sdhci
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: axi
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // For eMMC
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mmc@aa0000 {
> +      compatible = "marvell,armada-ap807-sdhci", "marvell,armada-ap806-sdhci";
> +      reg = <0xaa0000 0x1000>;
> +      interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&emmc_clk 0>, <&axi_clk 0>;
> +      clock-names = "core", "axi";
> +      bus-width = <4>;
> +      marvell,xenon-phy-slow-mode;
> +      marvell,xenon-tun-count = <11>;
> +      non-removable;
> +      no-sd;
> +      no-sdio;
> +
> +      /* Vmmc and Vqmmc are both fixed */
> +    };
> +
> +  - |
> +    // For SD/SDIO
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mmc@ab0000 {
> +      compatible = "marvell,armada-cp110-sdhci";
> +      reg = <0xab0000 0x1000>;
> +      interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +      vqmmc-supply = <&sd_vqmmc_regulator>;
> +      vmmc-supply = <&sd_vmmc_regulator>;
> +      clocks = <&sdclk 0>, <&axi_clk 0>;
> +      clock-names = "core", "axi";
> +      bus-width = <4>;
> +      marvell,xenon-tun-count = <9>;
> +    };
> +
> +  - |
> +    // For eMMC with compatible "marvell,armada-3700-sdhci":
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mmc@aa0000 {
> +      compatible = "marvell,armada-3700-sdhci", "marvell,sdhci-xenon";
> +      reg = <0xaa0000 0x1000>,
> +            <0x17808 0x4>;
> +      interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&emmcclk 0>;
> +      clock-names = "core";
> +      bus-width = <8>;
> +      mmc-ddr-1_8v;
> +      mmc-hs400-1_8v;
> +      non-removable;
> +      no-sd;
> +      no-sdio;
> +
> +      /* Vmmc and Vqmmc are both fixed */
> +
> +      marvell,pad-type = "fixed-1-8v";
> +    };
> +
> +  - |
> +    // For SD/SDIO with compatible "marvell,armada-3700-sdhci":
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mmc@ab0000 {
> +      compatible = "marvell,armada-3700-sdhci", "marvell,sdhci-xenon";
> +      reg = <0xab0000 0x1000>,
> +            <0x17808 0x4>;
> +      interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +      vqmmc-supply = <&sd_regulator>;
> +      /* Vmmc is fixed */
> +      clocks = <&sdclk 0>;
> +      clock-names = "core";
> +      bus-width = <4>;
> +
> +      marvell,pad-type = "sd";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b555a5e8704f..95921c86aa82 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11706,7 +11706,7 @@ MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
>  M:     Hu Ziji <huziji@marvell.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Supported
> -F:     Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> +F:     Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>  F:     drivers/mmc/host/sdhci-xenon*
>
>  MATROX FRAMEBUFFER DRIVER
> --
> 2.35.1
>
