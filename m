Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB4A55B133
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiFZKbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiFZKbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:31:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021D1261B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:31:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ay16so13330814ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uid1nPU8KOeE8niwF3D46qRU8qJY11HwGt4P2APkK6s=;
        b=XAAC8AAlqRMmEzIHciueTzD3m22dmzWily6b8BHr6rpAvs0uXwzFyjFU045Lj7kkAe
         E79BdJ7MTKVbCL4wI6W9DsNgbpv6aW6GnwH7FZ4j3Es873/RwWQZOYfEASsZ8PPpzVP5
         dP5C+APcEInT67HZF1QBAf2do2AqTi8t07BAr4Gnx6UU+kyFOgz3SrYCkQ0LvoCC2dY5
         wAIMpoeO6Tp2eb8BRQqGfvmaMIF2KLt6qtodk3zqF8PF3YIfXCn9TvG9r4GjheCfMRFh
         8ec2U8O7uXcId5goQakMrd/qdV1II34NJfmrTyvrbe0MNI60NvlpB6Mwy0F/+l4Rqp0l
         6+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uid1nPU8KOeE8niwF3D46qRU8qJY11HwGt4P2APkK6s=;
        b=TQLd3smG7gQBmp4KdLrMNXa8h9T/F5fwO1xU9uIqAg6T+HUnF3qElGVum8ImiUxvsB
         SJoIfoYbg4FX7SXvejC7gH5V7OleQq7vP2itVqadKPeTOrW0x+EBRPHHXF7IBaOUjHsG
         RTZj33BSTpeN9ORjCRDgoPP4dL3F8DYGwIM0fjHSnbKbBOURJ2muCag/lXmb0sBL8Ptb
         wYlHwY+5pI/V1r8xWGLgKo07DMPJMdQDegM5Yntxwbu3Ef8w2MFT/stSl3f8Y0vcAC0u
         6EG2ZGuZbwjt3zvzRDEDCe8iambSGZYwkiPHx5i6dMPChwBjkdJb//UmZ978OY4FUeTt
         HMtQ==
X-Gm-Message-State: AJIora8pAeVETrYTMXE7+/wRH5TRPys/dBK6tde40oT1ZPcFwS/8sweT
        9iROI/6JZ/u8nYv6zkYR4/q1Xx1zSVOgeQ==
X-Google-Smtp-Source: AGRyM1v5PkYm9NSDHkT60vS80gGlYU4SSApNwB4dG6nO+r0o1Sb57gZPEpYSfK3zIyIeGsRQtSZH7A==
X-Received: by 2002:a17:907:980a:b0:722:f4a7:e00 with SMTP id ji10-20020a170907980a00b00722f4a70e00mr7752467ejc.114.1656239497724;
        Sun, 26 Jun 2022 03:31:37 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7dc4a000000b0043567edac3csm5724723edu.61.2022.06.26.03.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 03:31:37 -0700 (PDT)
Message-ID: <ee945844-5d78-7c2b-215e-25fe5617b481@linaro.org>
Date:   Sun, 26 Jun 2022 12:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/7] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Content-Language: en-US
To:     David Heidelberg <david.heidelberg@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <728b2c54-0dc0-533f-bab8-fca228f6c1b1@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2022 11:47, David Heidelberg wrote:
> On 25/06/2022 22:29, Krzysztof Kozlowski wrote:
>> On 24/06/2022 11:35, AngeloGioacchino Del Regno wrote:
>>> Add the bindings for the clock drivers of the MediaTek Helio X10
>>> MT6795 SoC.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++
>>>   .../clock/mediatek,mt6795-sys-clock.yaml      | 74 +++++++++++++++++++
>>>   2 files changed, 140 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>>>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>>> new file mode 100644
>>> index 000000000000..795fb18721c3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>>> @@ -0,0 +1,66 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/clock/mediatek,mt6795-clock.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +title: MediaTek Functional Clock Controller for MT6795
>>> +
>>> +maintainers:
>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>> +
>>> +description: |
>>> +  The clock architecture in MediaTek like below
>>> +  PLLs -->
>>> +          dividers -->
>>> +                      muxes
>>> +                           -->
>>> +                              clock gate
>>> +
>>> +  The devices provide clock gate control in different IP blocks.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,mt6795-mfgcfg
>>> +      - mediatek,mt6795-vdecsys
>>> +      - mediatek,mt6795-vencsys
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#clock-cells':
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - '#clock-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    soc {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        mfgcfg: clock-controller@13000000 {
>>> +            compatible = "mediatek,mt6795-mfgcfg";
>>> +            reg = <0 0x13000000 0 0x1000>;
>>> +            #clock-cells = <1>;
>>> +        };
>>> +
>>> +        vdecsys: clock-controller@16000000 {
>>> +            compatible = "mediatek,mt6795-vdecsys";
>>> +            reg = <0 0x16000000 0 0x1000>;
>>> +            #clock-cells = <1>;
>>> +        };
>>> +
>>> +        vencsys: clock-controller@18000000 {
>>> +            compatible = "mediatek,mt6795-vencsys";
>>> +            reg = <0 0x18000000 0 0x1000>;
>>> +            #clock-cells = <1>;
>>> +        };
>>> +    };
>>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
>>> new file mode 100644
>>> index 000000000000..44b96af9ceaf
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
>>> @@ -0,0 +1,74 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/clock/mediatek,mt6795-sys-clock.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +title: MediaTek System Clock Controller for MT6795
>>> +
>>> +maintainers:
>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>> +
>>> +description:
>>> +  The Mediatek system clock controller provides various clocks and system configuration
>> Wrap according to Linux coding convention, so at 80.
> 
> What I understood that 100 length was agreed [1] as a limit. I haven't 
> noticed any recent change regarding to line length.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144

The coding style (also in change above) clearly states:
"The preferred limit on the length of a single line is 80 columns."
Just read the first line of new diff/hunk...

checkpatch was indeed long time converted not to complain on 80 but on
100, but that does not change coding style. The point of that was only
to accept 100 wrapping when it is beneficial,  iow, it increases the
code readability.

It's not the case here and coding style clearly asks for 80. Wrap at 80.


Best regards,
Krzysztof
