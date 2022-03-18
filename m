Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652F84DDB76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiCROVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiCROVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:21:38 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E3B9156C;
        Fri, 18 Mar 2022 07:20:17 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id bn33so11491514ljb.6;
        Fri, 18 Mar 2022 07:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K/WqZr6twVR2cqnlcAUNBvfW3vIrSHeDHjJ8y0zQFXM=;
        b=QwhzFh0lnmJiwSxbeoxcJ2rbxjSgHnSEigsHBPHz21boj98RMAVv88XWo3souM+O0a
         JyM4qZvUHR/9xnXUb7UlJl1gA/6wa5OshovsjgDiMkPJBob0m3gWRducu1mjhEQCpd9L
         Vt0PXqrLX/g2K2ZLVqJhIN8KJllW3hzzI9Um1Sx0XH6rqXWBv4nfM3d1SlFSOVWqEZHV
         xyXKeDYcAmUVjeJclxvgssT71zyuXyhM7ha8udsk5N7J1Sn0KBHAMXd10Fo0uvIbFzhr
         uQ0vePRhGwwCeUYj0YB3QrJz9RXAOtlxWdvuU/0sfvoXfjd8Sh0qY7A5EMz8wZEIiBco
         3dSw==
X-Gm-Message-State: AOAM531WPsSaPjFrYRN2iJ0KJuihP2HiJYkrov6apH2GvBGbSdVmT4MR
        FIYIDIDWD9Lbknu12xrDBBvo7V76xWayEA==
X-Google-Smtp-Source: ABdhPJy22Jeavb2h7u33YGBABvu6n9/AE6XV/Q77Mt7s4HKEn/RB4iOGFja0WpW7bdgKshKyzPC5tA==
X-Received: by 2002:a2e:808d:0:b0:245:a501:241 with SMTP id i13-20020a2e808d000000b00245a5010241mr6259832ljg.479.1647613214295;
        Fri, 18 Mar 2022 07:20:14 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id k15-20020a2e92cf000000b002493cc687f3sm987993ljh.45.2022.03.18.07.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:20:13 -0700 (PDT)
Message-ID: <91b6660d-c22b-0679-4cb9-6ebba9066545@kernel.org>
Date:   Fri, 18 Mar 2022 15:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: mmc: xenon: Convert to JSON schema
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        huziji@marvell.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220318033521.1432767-1-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318033521.1432767-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 04:35, Chris Packham wrote:
> Convert the marvell,xenon-sdhci binding to JSON schema. This is a fairly
> direct conversion so there are some requirements that are documented in
> prose but not currently enforced.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Thanks for the change. Several comments below.

> ---
>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 ------------
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 252 ++++++++++++++++++

Invalid path in maintainers, please update the maintainers file.

>  2 files changed, 252 insertions(+), 173 deletions(-)
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
> -	sdhci@aa0000 {
> -		compatible = "marvell,armada-ap806-sdhci";
> -		reg = <0xaa0000 0x1000>;
> -		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> -		clocks = <&emmc_clk>,<&axi_clk>;
> -		clock-names = "core", "axi";
> -		bus-width = <4>;
> -		marvell,xenon-phy-slow-mode;
> -		marvell,xenon-tun-count = <11>;
> -		non-removable;
> -		no-sd;
> -		no-sdio;
> -
> -		/* Vmmc and Vqmmc are both fixed */
> -	};
> -
> -- For SD/SDIO:
> -
> -	sdhci@ab0000 {
> -		compatible = "marvell,armada-cp110-sdhci";
> -		reg = <0xab0000 0x1000>;
> -		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> -		vqmmc-supply = <&sd_vqmmc_regulator>;
> -		vmmc-supply = <&sd_vmmc_regulator>;
> -		clocks = <&sdclk>, <&axi_clk>;
> -		clock-names = "core", "axi";
> -		bus-width = <4>;
> -		marvell,xenon-tun-count = <9>;
> -	};
> -
> -- For eMMC with compatible "marvell,armada-3700-sdhci":
> -
> -	sdhci@aa0000 {
> -		compatible = "marvell,armada-3700-sdhci";
> -		reg = <0xaa0000 0x1000>,
> -		      <phy_addr 0x4>;
> -		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> -		clocks = <&emmcclk>;
> -		clock-names = "core";
> -		bus-width = <8>;
> -		mmc-ddr-1_8v;
> -		mmc-hs400-1_8v;
> -		non-removable;
> -		no-sd;
> -		no-sdio;
> -
> -		/* Vmmc and Vqmmc are both fixed */
> -
> -		marvell,pad-type = "fixed-1-8v";
> -	};
> -
> -- For SD/SDIO with compatible "marvell,armada-3700-sdhci":
> -
> -	sdhci@ab0000 {
> -		compatible = "marvell,armada-3700-sdhci";
> -		reg = <0xab0000 0x1000>,
> -		      <phy_addr 0x4>;
> -		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> -		vqmmc-supply = <&sd_regulator>;
> -		/* Vmmc is fixed */
> -		clocks = <&sdclk>;
> -		clock-names = "core";
> -		bus-width = <4>;
> -
> -		marvell,pad-type = "sd";
> -	};
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> new file mode 100644
> index 000000000000..22d5cbf28042
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -0,0 +1,252 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Xenon SDHCI Controller device tree bindings

Drop "device tree bindings". Title is about hardware.

> +
> +description: |
> +  This file documents differences between the core mmc properties described by

s/mmc/MMC/

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
> +patternProperties:
> +  "^sdhci@[0-9a-f]+$":
> +    type: object
> +    $ref: mmc-controller.yaml

This is unusual schema... What are you matching here? Are these children
of this device?

Looks like you wanted allOf. See some existing examples, like:
Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml

> +
> +    properties:
> +      compatible:
> +        oneOf:
> +          - const: marvell,armada-3700-sdhci
> +            description: |
> +              Must provide a second register area and marvell,pad-type
> +          - const: marvell,armada-ap806-sdhci
> +          - const: marvell,armada-ap807-sdhci

This looks wrong. Either these can be standalone properties or in a list
like in your last items below.

> +          - const: marvell,armada-cp110-sdhci
> +          - const: marvell,sdhci-xenon


This did not exist before. Separate patches please for additions (with
explanation why). Maybe some DTS lists this, but then it should be
individually judged whether the DTS is correct.

> +          - items:
> +            - const: marvell,armada-3700-sdhci
> +            - const: marvell,sdhci-xenon
> +          - items:
> +            - const: marvell,armada-ap807-sdhci
> +            - const: marvell,armada-ap806-sdhci

> +
> +      reg:
> +        minItems: 1
> +        maxItems: 2
> +        description: |
> +          For "marvell,armada-3700-sdhci", two register areas.  The first one
> +          for Xenon IP register. The second one for the Armada 3700 SoC PHY PAD
> +          Voltage Control register.  Please follow the examples with compatible
> +          "marvell,armada-3700-sdhci" in below.
> +          Please also check property marvell,pad-type in below.

For this condition and similar one in clocks/clock-names, you need
if:then:" inside allOf. See for example:
https://elixir.bootlin.com/linux/v5.17-rc8/source/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml#L56

> +
> +          For other compatible strings, one register area for Xenon IP.
> +
> +      clocks:
> +        minItems: 1
> +        maxItems: 2
> +
> +      clock-names:
> +        minItems: 1
> +        items:
> +          - const: core
> +          - const: axi
> +
> +      marvell,xenon-sdhc-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 7
> +        description: |
> +          Indicate the corresponding bit index of current SDHC in SDHC System
> +          Operation Control Register Bit[7:0].  Set/clear the corresponding bit to
> +          enable/disable current SDHC.  If Xenon IP contains only one SDHC, this
> +          property is optional.

Skip all the "this property is optional" because it is obvious from
"required:" part.

> +
> +      marvell,xenon-phy-type:
> +        enum:
> +          - "emmc 5.1 phy"
> +          - "emmc 5.0 phy"

ref: string.

> +        description: |
> +          Xenon support multiple types of PHYs. To select eMMC 5.1 PHY, set:
> +          marvell,xenon-phy-type = "emmc 5.1 phy" eMMC 5.1 PHY is the default
> +          choice if this property is not provided.  To select eMMC 5.0 PHY, set:
> +          marvell,xenon-phy-type = "emmc 5.0 phy"
> +
> +          All those types of PHYs can support eMMC, SD and SDIO. Please note that
> +          this property only presents the type of PHY.  It doesn't stand for the
> +          entire SDHC type or property.  For example, "emmc 5.1 phy" doesn't mean
> +          that this Xenon SDHC only supports eMMC 5.1.
> +
> +      marvell,xenon-phy-znr:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 0x1f
> +        default: 0xf
> +        description: |
> +          Set PHY ZNR value.
> +          Only available for eMMC PHY.
> +          Valid range = [0:0x1F].

Skip "valid range". It's obvious. Same in all other places. In general,
trim the description from any parts which are now defined in the
bindings. Previously (in TXT) this has to be mentioned in description,
but now we have better way - through DT schema.

> +          ZNR is set as 0xF by default if this property is not provided.
> +
> +      marvell,xenon-phy-zpr:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 0x1f
> +        default: 0xf
> +        description: |
> +          Set PHY ZPR value.
> +          Only available for eMMC PHY.
> +          Valid range = [0:0x1F].
> +          ZPR is set as 0xF by default if this property is not provided.
> +
> +      marvell,xenon-phy-nr-success-tun:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 1
> +        maximum: 7
> +        default: 0x4
> +        description: |
> +          Set the number of required consecutive successful sampling points
> +          used to identify a valid sampling window, in tuning process.
> +          Valid range = [1:7].
> +          Set as 0x4 by default if this property is not provided.
> +
> +      marvell,xenon-phy-tun-step-divider:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Set the divider for calculating TUN_STEP.
> +          Set as 64 by default if this property is not provided.

default: 64

> +
> +      marvell,xenon-phy-slow-mode:
> +        type: boolean
> +        description: |
> +          If this property is selected, transfers will bypass PHY.
> +          Only available when bus frequency lower than 55MHz in SDR mode.
> +          Disabled by default. Please only try this property if timing issues
> +          always occur with PHY enabled in eMMC HS SDR, SD SDR12, SD SDR25,
> +          SD Default Speed and HS mode and eMMC legacy speed mode.
> +
> +      marvell,xenon-tun-count:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Xenon SDHC SoC usually doesn't provide re-tuning counter in
> +          Capabilities Register 3 Bit[11:8].
> +          This property provides the re-tuning counter.
> +          If this property is not set, default re-tuning counter will
> +          be set as 0x9 in driver.> +
> +      marvell,pad-type:
> +        enum:
> +          - sd
> +          - fixed-1-8v
> +        description: |
> +          Type of Armada 3700 SoC PHY PAD Voltage Controller register.
> +          Only valid when "marvell,armada-3700-sdhci" is selected.
> +          Two types: "sd" and "fixed-1-8v".
> +          If "sd" is selected, SoC PHY PAD is set as 3.3V at the beginning and is
> +          switched to 1.8V when later in higher speed mode.
> +          If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such as for eMMC.
> +          Please follow the examples with compatible "marvell,armada-3700-sdhci"
> +          in below.
> +
> +    required:
> +      - compatible
> +      - reg
> +      - clocks
> +      - clock-names
> +
> +    unevaluatedProperties: false
> +
> +additionalProperties: false

This will be gone once you remove this incorrect patternProperties

> +
> +examples:
> +  - |
> +    // For eMMC
> +

Blank line rather after includes, not before.

> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    sdhci@aa0000 {
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
> +
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    sdhci@ab0000 {
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
> +
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    sdhci@aa0000 {
> +      compatible = "marvell,armada-3700-sdhci";
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
> +
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    sdhci@ab0000 {
> +      compatible = "marvell,armada-3700-sdhci";
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

It looks the same as previous example for SD. Maybe just remove it?

> +    };


Best regards,
Krzysztof
