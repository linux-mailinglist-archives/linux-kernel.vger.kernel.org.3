Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5978255DBB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiF0HpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiF0Ho5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:44:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D32360C6;
        Mon, 27 Jun 2022 00:44:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E35756601824;
        Mon, 27 Jun 2022 08:44:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656315894;
        bh=98ifQbG2wsM55eIgKV0UnH7X42SVzBCwPS6JtUzdqNY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PdCo2C2OuBcV/T11XPWp3z93NWE6k8d2tKMy8CgviMeERazXsNCHqTRs9GyOv+C4n
         THQkk2DRJ+WpUEDCgUzzwj5JNLoyFMLW4145KxoQbJW75T5jnlV1kpYXlCcposD0f1
         0HG5CdK7NerVKo0eo6Vg+wBJhxPz65aCVl383FpEXXPk3q8xnPhnFUgblpDFji74ZI
         GNDCgN91TPbmYWbjuLRUdqgD7MNsgDKaOlu36YONK1gaYWSSmerV0oEbLRwaRFfFkl
         6o0qNC1sOJq7VrK6xl7YHt8QpGkC2bltAKKusU/l+CRq0HuuZvKiwVFvGiWp5Uzw8r
         iGL8eWcTylyXA==
Message-ID: <2111b4a7-d195-0333-1d43-02fcd91f89e2@collabora.com>
Date:   Mon, 27 Jun 2022 09:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/7] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        David Heidelberg <david.heidelberg@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
 <20220624093525.243077-5-angelogioacchino.delregno@collabora.com>
 <cea65d6a-7d9b-7b14-9984-bcd7f115da47@linaro.org>
 <728b2c54-0dc0-533f-bab8-fca228f6c1b1@collabora.com>
 <ee945844-5d78-7c2b-215e-25fe5617b481@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ee945844-5d78-7c2b-215e-25fe5617b481@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/06/22 12:31, Krzysztof Kozlowski ha scritto:
> On 26/06/2022 11:47, David Heidelberg wrote:
>> On 25/06/2022 22:29, Krzysztof Kozlowski wrote:
>>> On 24/06/2022 11:35, AngeloGioacchino Del Regno wrote:
>>>> Add the bindings for the clock drivers of the MediaTek Helio X10
>>>> MT6795 SoC.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++
>>>>    .../clock/mediatek,mt6795-sys-clock.yaml      | 74 +++++++++++++++++++
>>>>    2 files changed, 140 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>>>>    create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>>>> new file mode 100644
>>>> index 000000000000..795fb18721c3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>>>> @@ -0,0 +1,66 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/clock/mediatek,mt6795-clock.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>> +
>>>> +title: MediaTek Functional Clock Controller for MT6795
>>>> +
>>>> +maintainers:
>>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>>> +
>>>> +description: |
>>>> +  The clock architecture in MediaTek like below
>>>> +  PLLs -->
>>>> +          dividers -->
>>>> +                      muxes
>>>> +                           -->
>>>> +                              clock gate
>>>> +
>>>> +  The devices provide clock gate control in different IP blocks.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - mediatek,mt6795-mfgcfg
>>>> +      - mediatek,mt6795-vdecsys
>>>> +      - mediatek,mt6795-vencsys
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  '#clock-cells':
>>>> +    const: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - '#clock-cells'
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    soc {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +
>>>> +        mfgcfg: clock-controller@13000000 {
>>>> +            compatible = "mediatek,mt6795-mfgcfg";
>>>> +            reg = <0 0x13000000 0 0x1000>;
>>>> +            #clock-cells = <1>;
>>>> +        };
>>>> +
>>>> +        vdecsys: clock-controller@16000000 {
>>>> +            compatible = "mediatek,mt6795-vdecsys";
>>>> +            reg = <0 0x16000000 0 0x1000>;
>>>> +            #clock-cells = <1>;
>>>> +        };
>>>> +
>>>> +        vencsys: clock-controller@18000000 {
>>>> +            compatible = "mediatek,mt6795-vencsys";
>>>> +            reg = <0 0x18000000 0 0x1000>;
>>>> +            #clock-cells = <1>;
>>>> +        };
>>>> +    };
>>>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
>>>> new file mode 100644
>>>> index 000000000000..44b96af9ceaf
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
>>>> @@ -0,0 +1,74 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/clock/mediatek,mt6795-sys-clock.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>> +
>>>> +title: MediaTek System Clock Controller for MT6795
>>>> +
>>>> +maintainers:
>>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>>> +
>>>> +description:
>>>> +  The Mediatek system clock controller provides various clocks and system configuration
>>> Wrap according to Linux coding convention, so at 80.
>>
>> What I understood that 100 length was agreed [1] as a limit. I haven't
>> noticed any recent change regarding to line length.
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
> 
> The coding style (also in change above) clearly states:
> "The preferred limit on the length of a single line is 80 columns."
> Just read the first line of new diff/hunk...
> 
> checkpatch was indeed long time converted not to complain on 80 but on
> 100, but that does not change coding style. The point of that was only
> to accept 100 wrapping when it is beneficial,  iow, it increases the
> code readability.
> 
> It's not the case here and coding style clearly asks for 80. Wrap at 80.
> 

Hello David, Krzysztof,

there's no problem at all, I can resend... after all, it's a fast fix and
all it takes is 10 minutes of my time!

Cheers,
Angelo

