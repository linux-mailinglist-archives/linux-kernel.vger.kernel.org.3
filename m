Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9284E5688
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiCWQeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbiCWQeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:34:13 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB91F7CDDD;
        Wed, 23 Mar 2022 09:32:42 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id dr20so3954934ejc.6;
        Wed, 23 Mar 2022 09:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E7akCe8lBAqH23pOndxll2BXioVgSP/wXYmgr1zmhUY=;
        b=6Mo0bqBL7ls7DyxLKzJPTXCIR3SA5HFJMPV5LYqYRH5XItTXV52mLaacfK8OpqsVok
         bHgrGfpD0M4+HE/0wfoTzUrUb0GaVUs9EInkfHCTQHCld0xq0yygNoUwO7ZJL0PFJ9fp
         Yp0buwXH1fVvG5q+NRD/dcBlh1sQVv+jDTxvwbpHvFTXRIoKb3TGDHll5iMNvS+o1rxr
         TtoykMgquoHPPWsg+mZdULEyParcfuZzjXR69+wsRwSzFt2ElZbWSBZ7CN3s/OK0L73J
         L6rN0JWI0dV+ZtbVcr+SsHgOnc5k/VbTRtyUCeFKX+4nQ/daK39+ZfIZ3JmkDgNu5ggn
         CJMw==
X-Gm-Message-State: AOAM532OI5pvYDQ2w5d7040lgTIAQa4XfaeIUcGmOR1IRcVHUvlgQzvG
        e2LUDH9XQhWtEbZY2a/EuhzqxFw357FtNQ==
X-Google-Smtp-Source: ABdhPJwiqMCLHEjPl7sBX1A7y17nAGLs1ckQHMAh8ME1OQ1VF4Fy+YeiPaF+nD848Ecgy7OPbBiASQ==
X-Received: by 2002:a17:906:4996:b0:6df:f6da:fbef with SMTP id p22-20020a170906499600b006dff6dafbefmr968259eju.68.1648053161140;
        Wed, 23 Mar 2022 09:32:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id x12-20020a50d9cc000000b0040f70fe78f3sm193534edj.36.2022.03.23.09.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:32:40 -0700 (PDT)
Message-ID: <f696fb7a-6bb1-9a44-2aa4-df728ebc965e@kernel.org>
Date:   Wed, 23 Mar 2022 17:32:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dt-bindings: mmc: xenon: Convert to JSON schema
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, huziji@marvell.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220320234938.1946259-1-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220320234938.1946259-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 00:49, Chris Packham wrote:
> Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
> in-tree dts files don't validate because they use sdhci@ instead of mmc@
> as required by the generic mmc-controller schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Patches fixing the DTS (in the same series, before this one) are highly
welcomed. Otherwise Rob's bot might soon complain...

> ---
> 
> Notes:
>     Changes in v2:
>     - Update MAINTAINERS entry
>     - Incorporate feedback from Krzysztof
> 
>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 272 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 273 insertions(+), 174 deletions(-)
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
> index 000000000000..eae7498686af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -0,0 +1,272 @@
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
> +          - marvell,armada-3700-sdhci
> +          - marvell,armada-cp110-sdhci
> +          - marvell,armada-ap807-sdhci

Since ap807 is compatible with ap806 I do not expect it to be alone. The
previous bindings did not specify this exactly and existing DTS seems to
use case below (ap807+ap806).

Someone should confirm whether ap807 hardware is really compatible with
ap806 (the driver just sets one more quirk for ap806) and fix it here.
In such case please explain the change of compatibles in commit msg.

> +          - marvell,armada-ap806-sdhci
> +
> +      - items:
> +          - const: marvell,armada-ap807-sdhci
> +          - const: marvell,armada-ap806-sdhci
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

You need here ref to string as well.

Rest looks ok.


Best regards,
Krzysztof
