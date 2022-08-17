Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A7596B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiHQIR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiHQIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:15:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF67E30C;
        Wed, 17 Aug 2022 01:15:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 754205C026E;
        Wed, 17 Aug 2022 04:15:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 17 Aug 2022 04:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660724115; x=
        1660810515; bh=9a/TQoxruiG9hZLDHJejrNpQAuP/IxZ7P05QpiGXpeM=; b=v
        nY7jOaW2hO1FlsfkFPoAOcsNbsp5wgWX7QbCEOrVO++bI9ueRQDuDn4cN34FF/+e
        rbek5nW/OkbPFVz19IPkV8yPBt+lXd8F9m3qsaLh8CHDFF6nVbwnU7EyWt20zEbN
        4RTUuxpw+eBarHmHYKVDck+4h+KrkOCe7KklRzt3Bd6h39iaBIs0Yj7zw/qB9OXB
        /rhvGCtdslUpQ3RrGQU5EbZSlCdAor8VmLxRFinnZFU03m42ZPimA4WuroXKcDbM
        5+1hoMSksQG/ZwHPq/70QZxvCsXymWdcGi3BhE3VT7QW17eSGvt+YkCaadWZ6PDB
        283b6QDs9/RCjAbEThBlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660724115; x=
        1660810515; bh=9a/TQoxruiG9hZLDHJejrNpQAuP/IxZ7P05QpiGXpeM=; b=F
        QwribRhA9ktEL0LhmvWm6UyJO61N7n1m3P9kaDUDBlOowopI68ew7jsrnKUTI7qK
        MpBTWpyLokKmngqFl9iUi5q0qolBSsoimsseD71AF+vlhQQSw2+hjQFlUxnBjNDw
        maD9v+efoURPKWCGE/clLrkJc9HjPcxt8zF8KLG7ffF9Y71gL9jpek3PTlQXBYt1
        RIo31EpFz8LNctSNTsGUj7us5pVFyddOFpAZJV63h2kTMXSYilWS4MP2L3kCo7T9
        FnV4LsLyhQBlOs8rcTTIDaiwmHCVw1YRAu+ApAs+YzLzvMeZMSvpsP0CpG6dnrPa
        +F4NO/Km7I21ZwXUk0XlQ==
X-ME-Sender: <xms:k6P8YmCblG9dlf80cI3nt6y8X5D40ve_BNzd-gIWZ8-50vJtoXf8cQ>
    <xme:k6P8YgiEVMq2chSxX0vIZ9-ONnAQoh30xb6EgGzQEEHoJr36CGHt6x7fso98OBfhk
    R0c9Nd37LyQfy-Mwg>
X-ME-Received: <xmr:k6P8Ypm_W7MqqIC9H34SKa4q2taB_k3GJauH3qoBSLhv-euYtql2lsU5kfARWR-fQhjsy23w1jY5O7_74VlnEekrFPWZinqoBYcwurZT5Wx_PCidVC3RRatmjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduvedtvdduvdeghfevtddvveffjefffeetheegiedtjeffhedt
    kedvveffleehkeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehs
    hhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:k6P8Ykx2I2BM-hqV8EQuOfRlnmLDB58z1ln3eOdu7lFS6LdDdyMpHA>
    <xmx:k6P8YrRqtf3msnlFH33HKAjFr2ffnzFnFKRUWPDjtFtwWxr3xAuB2w>
    <xmx:k6P8YvbC8vpQCUIaHxQVqXJYLaOJT7F1KU3EOpPR9WtfMpr0SC-jVg>
    <xmx:k6P8YgIS3D-M3xLBij2vB1VImADboGjKkixZTGZ9lbMsjPjxHeM1Ew>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 04:15:14 -0400 (EDT)
Subject: Re: [PATCH v3 1/4] regulator: dt-bindings: Add Allwinner D1 LDOs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-2-samuel@sholland.org>
 <c4ec080a-b8b1-e3a9-c9d7-063e138c9bb8@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <03de0f7b-9251-a5c0-91a1-5f2b5d41d8a0@sholland.org>
Date:   Wed, 17 Aug 2022 03:15:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c4ec080a-b8b1-e3a9-c9d7-063e138c9bb8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 4:55 AM, Krzysztof Kozlowski wrote:
> On 15/08/2022 07:34, Samuel Holland wrote:
>> The Allwinner D1 SoC contains two pairs of in-package LDOs. One pair is
>> for general purpose use. LDOA generally powers the board's 1.8 V rail.
>> LDOB generally powers the in-package DRAM, where applicable.
>>
>> The other pair of LDOs powers the analog power domains inside the SoC,
>> including the audio codec, thermal sensor, and ADCs. These LDOs require
>> a 0.9 V bandgap voltage reference. The calibration value for the voltage
>> reference is stored in an eFuse, accessed via an NVMEM cell.
>>
>> Neither LDO control register is in its own MMIO range; instead, each
>> regulator device relies on a regmap/syscon exported by its parent.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> Changes in v3:
>>  - Add "reg" property to bindings
>>  - Add "unevaluatedProperties: true" to regulator nodes
>>  - Minor changes to regulator node name patterns
>>  - Remove system-ldos example (now added in patch 3)
>>
>> Changes in v2:
>>  - Remove syscon property from bindings
>>  - Update binding examples to fix warnings and provide context
>>
>>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 74 +++++++++++++++++++
>>  .../allwinner,sun20i-d1-system-ldos.yaml      | 37 ++++++++++
>>  2 files changed, 111 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>> new file mode 100644
>> index 000000000000..d6964b44ef21
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-analog-ldos.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allwinner D1 Analog LDOs
>> +
>> +description:
>> +  Allwinner D1 contains a set of LDOs which are designed to supply analog power
>> +  inside and outside the SoC. They are controlled by a register within the audio
>> +  codec MMIO space, but which is not part of the audio codec clock/reset domain.
>> +
>> +maintainers:
>> +  - Samuel Holland <samuel@sholland.org>
> 
> Please follow the example schema. Order is: title, maintainers, description.
> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - allwinner,sun20i-d1-analog-ldos
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  nvmem-cells:
>> +    items:
>> +      - description: NVMEM cell for the calibrated bandgap reference trim value
>> +
>> +  nvmem-cell-names:
>> +    items:
>> +      - const: bg_trim
>> +
>> +patternProperties:
>> +  "^(a|hp)ldo$":
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - nvmem-cells
>> +  - nvmem-cell-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    audio-codec@2030000 {
>> +        compatible = "simple-mfd", "syscon";
> 
> This cannot be on its own. Both require device specific compatible.

Again, the device-specific compatible does not exist, because the binding for
the audio codec has not been written (and it will be quite nontrivial).

So I can:
  1) Leave the example as-is until the audio codec binding gets written,
     and fill in the specific compatible at that time.
  2) Remove the example, with the reasoning that the example really
     belongs with the MFD parent (like for the other regulator). Then
     there will be no example until the audio codec binding is written.
  3) Drop the analog LDOs from this series entirely, and some parts
     of the SoC (like thermal monitoring) cannot be added to the DTSI
     until the audio codec binding is written.

What do you think?

The same question applies for the D1 SoC DTSI, where I use this same construct.

(And technically this does validate with the current schema.)

>> +        reg = <0x2030000 0x1000>;
>> +        ranges;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        regulators@2030348 {
>> +            compatible = "allwinner,sun20i-d1-analog-ldos";
>> +            reg = <0x2030348 0x4>;
>> +            nvmem-cells = <&bg_trim>;
>> +            nvmem-cell-names = "bg_trim";
>> +
>> +            reg_aldo: aldo {
>> +                regulator-min-microvolt = <1800000>;
>> +                regulator-max-microvolt = <1800000>;
>> +            };
>> +
>> +            reg_hpldo: hpldo {
>> +                regulator-min-microvolt = <1800000>;
>> +                regulator-max-microvolt = <1800000>;
>> +            };
>> +        };
>> +    };
>> +
>> +...
>> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
>> new file mode 100644
>> index 000000000000..e3e2810fb3d7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allwinner D1 System LDOs
>> +
>> +description:
>> +  Allwinner D1 contains a pair of general-purpose LDOs which are designed to
>> +  supply power inside and outside the SoC. They are controlled by a register
>> +  within the system control MMIO space.
> 
> Fix order.
> 
> 
>> +
>> +maintainers:
>> +  - Samuel Holland <samuel@sholland.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - allwinner,sun20i-d1-system-ldos
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^ldo[ab]$":
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
> 
> 
> Example please.

Rob asked me to move the example to the parent binding, so I did. The example is
added in patch 3.

Regards,
Samuel
