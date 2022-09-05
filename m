Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF35ACD04
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiIEHhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiIEHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:37:11 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172010549
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:37:09 -0700 (PDT)
Received: from [10.28.39.72] (10.28.39.72) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server id 15.1.2507.6; Mon, 5 Sep 2022 15:37:06 +0800
Message-ID: <9119f4d6-f9d4-e5e0-3536-95d5a6405cbe@amlogic.com>
Date:   Mon, 5 Sep 2022 15:37:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RESEND v8 4/5] dt-bindings: nand: meson: convert txt to
 yaml
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220822091838.18528-1-liang.yang@amlogic.com>
 <20220822091838.18528-5-liang.yang@amlogic.com>
 <0ad6a792-74c2-9957-ee56-f183dcd75c58@baylibre.com>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <0ad6a792-74c2-9957-ee56-f183dcd75c58@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.72]
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thanks for your remind.
I will add the ML in next resend version quickly.

On 2022/9/5 15:22, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> +CC [devicetree@vger.kernel.org]
> 
> Please Add this ML to CC if you resend, it's the last patch of the serie 
> that haven't got a proper review.
> 
> On 22/08/2022 11:18, Liang Yang wrote:
>> convert the amlogic,meson-name.txt to amlogic,meson-nand.yaml
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> ---
>>   .../bindings/mtd/amlogic,meson-nand.txt       | 55 ------------
>>   .../bindings/mtd/amlogic,meson-nand.yaml      | 88 +++++++++++++++++++
>>   2 files changed, 88 insertions(+), 55 deletions(-)
>>   delete mode 100644 
>> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>   create mode 100644 
>> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt 
>> b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> deleted file mode 100644
>> index 5d5cdfef417f..000000000000
>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> +++ /dev/null
>> @@ -1,55 +0,0 @@
>> -Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
>> -
>> -This file documents the properties in addition to those available in
>> -the MTD NAND bindings.
>> -
>> -Required properties:
>> -- compatible : contains one of:
>> -  - "amlogic,meson-gxl-nfc"
>> -  - "amlogic,meson-axg-nfc"
>> -
>> -- reg        : Offset and length of the register set
>> -
>> -- reg-names  : "nfc" is the register set for NFC controller and "emmc"
>> -        is the register set for MCI controller.
>> -
>> -- clocks     :
>> -    A list of phandle + clock-specifier pairs for the clocks listed
>> -    in clock-names.
>> -
>> -- clock-names: Should contain the following:
>> -    "core" - NFC module gate clock
>> -    "device" - parent clock for internal NFC
>> -
>> -Optional children nodes:
>> -Children nodes represent the available nand chips.
>> -
>> -Other properties:
>> -see Documentation/devicetree/bindings/mtd/nand-controller.yaml for 
>> generic bindings.
>> -
>> -Example demonstrate on AXG SoC:
>> -
>> -    nand-controller@7800 {
>> -        compatible = "amlogic,meson-axg-nfc";
>> -        reg = <0x0 0x7800 0x0 0x100>,
>> -              <0x0 0x7000 0x0 0x800>;
>> -        reg-names = "nfc", "emmc";
>> -        #address-cells = <1>;
>> -        #size-cells = <0>;
>> -        interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> -
>> -        clocks = <&clkc CLKID_SD_EMMC_C>,
>> -             <&clkc CLKID_FCLK_DIV2>;
>> -        clock-names = "core", "device";
>> -
>> -        pinctrl-names = "default";
>> -        pinctrl-0 = <&nand_pins>;
>> -
>> -        nand@0 {
>> -            reg = <0>;
>> -            #address-cells = <1>;
>> -            #size-cells = <1>;
>> -
>> -            nand-on-flash-bbt;
>> -        };
>> -    };
>> diff --git 
>> a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml 
>> b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> new file mode 100644
>> index 000000000000..42634e9c0d3c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> @@ -0,0 +1,88 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mtd/amlogic,meson-nand.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
>> +
>> +allOf:
>> +  - $ref: "nand-controller.yaml"
>> +
>> +maintainers:
>> +  - liang.yang@amlogic.com
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - "amlogic,meson-gxl-nfc"
>> +      - "amlogic,meson-axg-nfc"
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: device
>> +
>> +patternProperties:
>> +  "^nand@[0-7]$":
>> +    type: object
>> +    properties:
>> +      reg:
>> +        minimum: 0
>> +        maximum: 1
>> +
>> +      nand-ecc-mode:
>> +        const: hw
>> +
>> +      nand-ecc-step-size:
>> +        const: 1024
>> +
>> +      nand-ecc-strength:
>> +        enum: [8, 16, 24, 30, 40, 50, 60]
>> +        description: |
>> +          The ECC configurations that can be supported are as follows.
>> +            meson-gxl-nfc 8, 16, 24, 30, 40, 50, 60
>> +            meson-axg-nfc 8
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/axg-clkc.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    nand-controller@ffe07800 {
>> +      compatible = "amlogic,meson-axg-nfc";
>> +      reg = <0xffe07800 0x100>, <0xffe07000 0x800>;
>> +      reg-names = "nfc", "emmc";
>> +      interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> +      clocks = <&clkc CLKID_SD_EMMC_C>,  <&clkc CLKID_FCLK_DIV2>;
>> +      clock-names = "core", "device";
>> +
>> +      pinctrl-0 = <&nand_pins>;
>> +      pinctrl-names = "default";
>> +
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      nand@0 {
>> +        reg = <0>;
>> +      };
>> +    };
>> +
>> +...
> 
> Thanks,
> Neil
> 
> .
