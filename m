Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9325ACC94
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiIEHZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbiIEHZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:25:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B019240564
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:22:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w5so10037261wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=0Zlv2noXrggmLQ5O5f0vmSBw3PaAlyCeKLqu2TrFOSI=;
        b=gbjY3IwFu+AGJ8HI6f3xIw+YnlYzWWjlNzSJ2xpCv3g1YWG03AC3D0FrZib6OKWJll
         ylTGHZwR7RIU0BomwiviKRNNqwmjGFwO5CQKD+AmPnsUQHPe6jUYC4oWlcNS9yDh3RRA
         luxlXRbMCb1JDMWFEWD8lTZ7CROpBDFuCot/rNnBEpZkYiIiev3sZEbp8WLUWLSx0yhA
         SoB+y87LW0OmFCY2JH3q/bhzlR898s2BKQQvo1/efzIVQUJvj1WK9RsBFEF54rWHsV7g
         xq1EGCw03kG2DlugfYgKOCOxIusttwVKoj/EQGK3sek5Y2EY3izF0A8aDN7nnmkyeW14
         tg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=0Zlv2noXrggmLQ5O5f0vmSBw3PaAlyCeKLqu2TrFOSI=;
        b=Poo00a3I08uqfpyKoSEhCYvRjCoripuPmR+dTX8nIdBjjbroblRogmzeuikthDbloO
         pvV/v5Dcp0vFGdv2dUk18sHnKkEROEMP1vo6kSViITrCVAgfaLrlqSd0wwmE2ByuhvoK
         WhPGcc5fCYUFeNmo4izoKxEOn6Z0NYUs/lyAB1jT4Xq+9g/KL6p9AyHBaiZk9yzOtvon
         hUtxj1ckSxOY4GNDKdDaGhocfGyEY293dFG8rHlhlH8+KVTvaG1PtvDjSnVzKBD2A3aH
         wPxmNuGNqJxZci5jLwfbllN0Y6t84OMDv4rhq7VDIW353XtBfffVYJonwmG+qPysFanx
         qK6g==
X-Gm-Message-State: ACgBeo2WHJt7TcKw+TDVg2AO5mtMFIzimCCDPvgh9rpYvaKjs9uChZz1
        a9ms6TXGvzRmY+El1CUZJGmQhQ==
X-Google-Smtp-Source: AA6agR4To6jQmPD+FVrLSDWzA4HTSJc+DW9e5B3mD20LG4LnNacMcgXLafLQtWGZ/qRMNWiVa5DpOw==
X-Received: by 2002:a5d:6daa:0:b0:228:6323:3bca with SMTP id u10-20020a5d6daa000000b0022863233bcamr3778885wrs.544.1662362528052;
        Mon, 05 Sep 2022 00:22:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f365:27e9:453c:4c15? ([2a01:e0a:982:cbb0:f365:27e9:453c:4c15])
        by smtp.gmail.com with ESMTPSA id co4-20020a0560000a0400b0021eed2414c9sm8224965wrb.40.2022.09.05.00.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 00:22:07 -0700 (PDT)
Message-ID: <0ad6a792-74c2-9957-ee56-f183dcd75c58@baylibre.com>
Date:   Mon, 5 Sep 2022 09:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND v8 4/5] dt-bindings: nand: meson: convert txt to
 yaml
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220822091838.18528-1-liang.yang@amlogic.com>
 <20220822091838.18528-5-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220822091838.18528-5-liang.yang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC [devicetree@vger.kernel.org]

Please Add this ML to CC if you resend, it's the last patch of the serie that haven't got a proper review.

On 22/08/2022 11:18, Liang Yang wrote:
> convert the amlogic,meson-name.txt to amlogic,meson-nand.yaml
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>   .../bindings/mtd/amlogic,meson-nand.txt       | 55 ------------
>   .../bindings/mtd/amlogic,meson-nand.yaml      | 88 +++++++++++++++++++
>   2 files changed, 88 insertions(+), 55 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>   create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
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
> +
> +maintainers:
> +  - liang.yang@amlogic.com
> +
> +properties:
> +  compatible:
> +    enum:
> +      - "amlogic,meson-gxl-nfc"
> +      - "amlogic,meson-axg-nfc"
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

Thanks,
Neil
