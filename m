Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5603B5AEE82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiIFPT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiIFPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:19:24 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB6616E;
        Tue,  6 Sep 2022 07:31:48 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-11ee4649dfcso28658738fac.1;
        Tue, 06 Sep 2022 07:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Kvz3JZaluvKrbLtBoEI5XWsSUd5pzncK9jiRn5usyvY=;
        b=EIkwya1qVrocCS0LlT8FUmzghGmRY8IFBsf6LbcMwE9u+u3VwGPvzs1Z4fYeDjwwKq
         lXn2KneZ9BI4gvT+foRZUxlKM0R3PE2naFKuJmS9rCOXPsjS7VRklYyI4JGAxmOu2RqC
         388N2NBukhXgR27ZqzLdU56yUg3fWdDlvVUgCsX4sF7asQZXZoIxRk7pvjJsjknbI/Zm
         LqmFeU03qoiaOCZlct3Pq2FvKijM+xh4t9JF8bACBgCP+UP6NSZW24Y7KmO0PEYzYneY
         osZyN33cBPBdQ2bmPZ1svL3TMKTYrE4aoADY44cZ6JDV858ITON1HfW0DHpwuvODS+hJ
         Q46g==
X-Gm-Message-State: ACgBeo0SWaxoXk/dfzFsGFCpEpnS1eLXXoPAN/P3FZcCDQWrh30+XuGN
        5XMr3jKcPq6EiCwXo9YdwQ==
X-Google-Smtp-Source: AA6agR43AUBcRTnH2EnVkNSTDxBoJmwXP6jICsOo+4xmljoEm6BkouioCzUZ8nvJiOcT3vVuNYoAzQ==
X-Received: by 2002:a05:6870:c386:b0:102:fcb:86cd with SMTP id g6-20020a056870c38600b001020fcb86cdmr11886020oao.296.1662474623287;
        Tue, 06 Sep 2022 07:30:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f7-20020a9d5e87000000b00638cea5947esm6011078otl.25.2022.09.06.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:30:22 -0700 (PDT)
Received: (nullmailer pid 444558 invoked by uid 1000);
        Tue, 06 Sep 2022 14:30:21 -0000
Date:   Tue, 6 Sep 2022 09:30:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v8 4/5] dt-bindings: nand: meson: convert txt to
 yaml
Message-ID: <20220906143021.GA439874-robh@kernel.org>
References: <20220906060034.2528-1-liang.yang@amlogic.com>
 <20220906060034.2528-5-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906060034.2528-5-liang.yang@amlogic.com>
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

On Tue, Sep 06, 2022 at 02:00:32PM +0800, Liang Yang wrote:
> convert the amlogic,meson-name.txt to amlogic,meson-nand.yaml
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 55 ------------
>  .../bindings/mtd/amlogic,meson-nand.yaml      | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> deleted file mode 100644
> index 5d5cdfef417f..000000000000
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> -
> -This file documents the properties in addition to those available in
> -the MTD NAND bindings.
> -
> -Required properties:
> -- compatible : contains one of:
> -  - "amlogic,meson-gxl-nfc"
> -  - "amlogic,meson-axg-nfc"
> -
> -- reg        : Offset and length of the register set
> -
> -- reg-names  : "nfc" is the register set for NFC controller and "emmc"
> -		is the register set for MCI controller.
> -
> -- clocks     :
> -	A list of phandle + clock-specifier pairs for the clocks listed
> -	in clock-names.
> -
> -- clock-names: Should contain the following:
> -	"core" - NFC module gate clock
> -	"device" - parent clock for internal NFC
> -
> -Optional children nodes:
> -Children nodes represent the available nand chips.
> -
> -Other properties:
> -see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindings.
> -
> -Example demonstrate on AXG SoC:
> -
> -	nand-controller@7800 {
> -		compatible = "amlogic,meson-axg-nfc";
> -		reg = <0x0 0x7800 0x0 0x100>,
> -		      <0x0 0x7000 0x0 0x800>;
> -		reg-names = "nfc", "emmc";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> -
> -		clocks = <&clkc CLKID_SD_EMMC_C>,
> -			 <&clkc CLKID_FCLK_DIV2>;
> -		clock-names = "core", "device";
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&nand_pins>;
> -
> -		nand@0 {
> -			reg = <0>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			nand-on-flash-bbt;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> new file mode 100644
> index 000000000000..42634e9c0d3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/amlogic,meson-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> +
> +allOf:
> +  - $ref: "nand-controller.yaml"

Don't need quotes

> +
> +maintainers:
> +  - liang.yang@amlogic.com
> +
> +properties:
> +  compatible:
> +    enum:
> +      - "amlogic,meson-gxl-nfc"
> +      - "amlogic,meson-axg-nfc"

Don't need quotes

> +
> +  reg:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: device
> +
> +patternProperties:
> +  "^nand@[0-7]$":
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 1
> +
> +      nand-ecc-mode:
> +        const: hw
> +
> +      nand-ecc-step-size:
> +        const: 1024
> +
> +      nand-ecc-strength:
> +        enum: [8, 16, 24, 30, 40, 50, 60]
> +        description: |
> +          The ECC configurations that can be supported are as follows.
> +            meson-gxl-nfc 8, 16, 24, 30, 40, 50, 60
> +            meson-axg-nfc 8
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/axg-clkc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    nand-controller@ffe07800 {
> +      compatible = "amlogic,meson-axg-nfc";
> +      reg = <0xffe07800 0x100>, <0xffe07000 0x800>;
> +      reg-names = "nfc", "emmc";
> +      interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +      clocks = <&clkc CLKID_SD_EMMC_C>,  <&clkc CLKID_FCLK_DIV2>;
> +      clock-names = "core", "device";
> +
> +      pinctrl-0 = <&nand_pins>;
> +      pinctrl-names = "default";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      nand@0 {
> +        reg = <0>;
> +      };
> +    };
> +
> +...
> -- 
> 2.34.1
> 
> 
