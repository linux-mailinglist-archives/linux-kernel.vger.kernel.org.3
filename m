Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E958965B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiHDDDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiHDDDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:03:13 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1706E45073;
        Wed,  3 Aug 2022 20:03:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C2DE5C012E;
        Wed,  3 Aug 2022 23:03:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 03 Aug 2022 23:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1659582189; x=
        1659668589; bh=eLG06nwS2ZUKnS4kR0OTK7J+RzEFBqycarAkhIxqeiI=; b=F
        krtEy6XSI65sPt93iOQIIpMo703BA1O2XUB90LAesPzLkRZ27ZQvRyjlGVlJqML0
        ufIWoCF3eDTfZ2CYqlclEoGPbkuEunX4i1ybX3Rqlb1RAdqcBJgd8MBP/YB6ngsx
        nNPErmAwP6l7/Nwd0r5DFJUlsrb6d+xmkLRwYE1ydlJABK93MERBDi1ukWlrvEC7
        sRNTssda4wIQuPV9i0o8VeheUhMb48r9Tdiwe1YegBfwCCMV5JzPc/eD18DURWZp
        6cFKnCXLyDrsXp6Vh5oc8O/i9PMjAu/IZd0nj5VI9L7eR5Xh/Ho/lDRf0YodZIFl
        WeaCA8w4TS21K8pildbRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659582189; x=
        1659668589; bh=eLG06nwS2ZUKnS4kR0OTK7J+RzEFBqycarAkhIxqeiI=; b=M
        /csLs5X3ibKrGkY2HFlm/GUPtn/MC2NjGJpW7wRTC8PF5BBWVQuw4TEMFJC9Q10k
        PbqSskwiUK74WchmFpfuWfB34u5RlkhfzRq4AtnwoT8TkD58DPN8zmU1aACEO/uT
        ULYecIPqAQwZJgSdbXzREzhkfcrsKVn2Z7bH1v32MDcSsF21uinIN1jC5c01ocfx
        k+gmUN0K6VyRqB4AXIWub/b5LcOjmDrKK/HvYG6xvevZL0s2yW6p44a0BIP0UkyY
        8oPBeIzon42CMutZDhvWch71VExaemQz80YOmecgcNxtZM/8M5TCjunOrJtWfebu
        XFUZixYtGUK0mWZbaV0mQ==
X-ME-Sender: <xms:7DbrYmPbAj0eEDnsvqNx-irHfz8BzywBIkx1JGKKeodklzEBaI6B5A>
    <xme:7DbrYk93jOzXt7fdpsUD6fN_COhL_GNAwpDaLRykgmLDagiZL69GsdlLHSCnN1Cqv
    gFduPtSDt7i2k5M1g>
X-ME-Received: <xmr:7DbrYtQeNGGS9GlrV56Od4B6w81Hg0xU-hd9DTt_xjrkabGgj2qmp4HunMEfQ5dBinWoEovYGhWa7LJ-BEXjV9fgaHf9nrrhrQ24AE9_rYWeYAbJTyFxvFtefQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvkedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduvedtvdduvdeghfevtddvveffjefffeetheegiedtjeffhedt
    kedvveffleehkeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehs
    hhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:7TbrYmsEN7-PCuYeNMLcRqZMD_CGoUpCU2xQN539FQRxJlLBaqT8sg>
    <xmx:7TbrYufHTPFHV9A6vO2pmkHp41BLrVfA7GBCRUha9V5aXwOcsndPZQ>
    <xmx:7TbrYq1DJdXI-CWy32QOOdt0v6nd4ma1M4xbxsCfYVM-IY75o8FTqw>
    <xmx:7TbrYu4VkjhAm8PvNZrPnDdYw-7gEED5xPmrGcO1u26IL40IatxE0w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 23:03:08 -0400 (EDT)
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: Add Allwinner D1 LDOs
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220802053213.3645-1-samuel@sholland.org>
 <20220802053213.3645-4-samuel@sholland.org>
 <20220802150452.GA86158-robh@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <918a83a7-1b8d-04b1-4f7b-386fc800e653@sholland.org>
Date:   Wed, 3 Aug 2022 22:03:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220802150452.GA86158-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks again for your review.

On 8/2/22 10:04 AM, Rob Herring wrote:
> On Tue, Aug 02, 2022 at 12:32:12AM -0500, Samuel Holland wrote:
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
>> Changes in v2:
>>  - Remove syscon property from bindings
>>  - Update binding examples to fix warnings and provide context
>>
>>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 65 +++++++++++++++++++
>>  .../allwinner,sun20i-d1-system-ldos.yaml      | 57 ++++++++++++++++
>>  2 files changed, 122 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>> new file mode 100644
>> index 000000000000..19c984ef4e53
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>> @@ -0,0 +1,65 @@
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
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - allwinner,sun20i-d1-analog-ldos
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
>> +  "^(aldo|hpldo)$":
> 
> '^(a|hp)ldo$'
> 
>> +    type: object
>> +    $ref: regulator.yaml#
> 
>        unevaluatedProperties: false
> 
>> +
>> +required:
>> +  - compatible
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
> Needs a specific compatible. Obviously there's some other functionality 
> here if this is an 'audio-codec'.

I am not yet ready to submit the binding or driver for the audio codec, as I
still need to work out the details for jack detection (and some other issues).
If I added the specific audio codec compatible now, without the properties
required for the sound driver, that would create backward compatibility issues,
right?

My intention is to add the specific compatible along with the ASoC support.

> 'simple-mfd' also means the child nodes have zero dependence on the 
> parent node and its resources.

That is correct. The regulators have zero dependencies on the audio codec
resources (clocks/resets/etc.). The _only_ relationship is the overlapping
address of the MMIO register.

>> +        reg = <0x2030000 0x1000>;
>> +
>> +        regulators {
>> +            compatible = "allwinner,sun20i-d1-analog-ldos";
> 
> Is there a defined set of registers for these regulators? If so, put 
> them into 'reg'.

What do you suggest for 'ranges' in the parent device? I ask because the
SRAM/system controller binding requires an empty 'ranges' property.

With empty 'ranges', the child has to compute the relative address for use with
the parent's regmap, but maybe that is okay?

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
>> index 000000000000..c95030a827d6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
>> @@ -0,0 +1,57 @@
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
>> +
>> +maintainers:
>> +  - Samuel Holland <samuel@sholland.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - allwinner,sun20i-d1-system-ldos
>> +
>> +patternProperties:
>> +  "^(ldoa|ldob)$":
> 
> '^ldo[ab]$'
> 
> Any reason the naming is not consistent with 'ldo' as the prefix or 
> suffix?

All four names match the pin names from the SoC datasheet.

>> +    type: object
>> +    $ref: regulator.yaml#
> 
>        unevaluatedProperties: false

I will fix these for v3.

Regards,
Samuel

>> +
>> +required:
>> +  - compatible
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    syscon@3000000 {
>> +        compatible = "allwinner,sun20i-d1-system-control";
>> +        reg = <0x3000000 0x1000>;
>> +        ranges;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        regulators {
>> +            compatible = "allwinner,sun20i-d1-system-ldos";
>> +
>> +            reg_ldoa: ldoa {
>> +                regulator-min-microvolt = <1800000>;
>> +                regulator-max-microvolt = <1800000>;
>> +            };
>> +
>> +            reg_ldob: ldob {
>> +                regulator-name = "vcc-dram";
>> +                regulator-min-microvolt = <1500000>;
>> +                regulator-max-microvolt = <1500000>;
>> +            };
>> +        };
>> +    };
>> +
>> +...
>> -- 
>> 2.35.1
>>
>>

