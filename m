Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8742532FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbiEXRel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiEXRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:34:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D269CDB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:34:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gi33so28295253ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7DverL1ikxumj0Y3SFmQnwkR+piWdmMTQZvxAemn6kg=;
        b=V89TtH6YxlERZjNMpwaZ7/EbItHp+lpN/gdBIAq7W6qyJ1BSDvTsnbh6X+tbiB2iO3
         H0aGmE97Es4AHjKcV632zSXln4gtsbR8C6PG80krEaad5saYT+2ThuWzUL3G7nnKXR8A
         5DADenUHUhtOq5BjFPMQ4e+Rl4IapVObF4Enb7os+83JQ1IMKqupbJbQkxnTYxl9IUzA
         g0jIkckPdIpMsIi46J3ahcnKuma2FguT4pgchM2ZXYrU0IT5IKEq6BehVE0nmubLHZR5
         q+3LyXMv/ch7zK/C2rm7Wbwvl0+TZAiva78782l/HPi2tKL8d3AwMaJ/4NmlKRC6pDgx
         P20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7DverL1ikxumj0Y3SFmQnwkR+piWdmMTQZvxAemn6kg=;
        b=K1r4rNkrooXLK12d6waYhFjyTbumSDZdNz3Hx0yIyx8f9nd9VHooJxjKwGMlMqxoSi
         Akj4fqq6ky6jrG8dwJME43nS42cFPb0akqGSQvH25TLa9g6BANe9CFpFZDySGCHjKG4o
         q4DadeZbBJeYcgGDMBr++/u9gRbaQ2k42HDMCwGbscf6M7R0IUccmoLZrGryuS2W92Wk
         BiDns6KlVXmW4YBsj759/FywiXvDGwWpJoV+2U49sAq2DkBhuK5AEIEMBZJspZLCSZes
         kXy3U1364wNRF/zJkzFsVHBexCVOBw1endYQ8iO2sW2ylnxaW2oqad94Cj35z6iNo7aa
         9UkA==
X-Gm-Message-State: AOAM530NUVL7078ELhwNJSzf/XmljSiXiBXD0wjo/XbRFZYNAhBFUX8O
        pPiUWD7SFV00p/6Y3As+Yt5okg==
X-Google-Smtp-Source: ABdhPJwaQaTi86z4BOl9sm+ut14vP2KRQeJAkL8eABsQ+gRMQjfXVeyKRqO2XpaD7Akox5WIy9RO6w==
X-Received: by 2002:a17:906:2cc8:b0:6fd:d8d8:b8f3 with SMTP id r8-20020a1709062cc800b006fdd8d8b8f3mr25538894ejr.384.1653413675583;
        Tue, 24 May 2022 10:34:35 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qu14-20020a170907110e00b006fec0d03da7sm3649676ejb.76.2022.05.24.10.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 10:34:35 -0700 (PDT)
Message-ID: <c6b11622-fd28-4da2-54d5-4ea0ff41f2d9@linaro.org>
Date:   Tue, 24 May 2022 19:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: mailbox: mtk-gce: Convert txt to json-schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220519101806.18097-1-angelogioacchino.delregno@collabora.com>
 <45e78390-5f91-7ac7-45d8-5796bc608234@linaro.org>
 <8d1411a7-0714-1667-ffd4-3de99732b1a3@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8d1411a7-0714-1667-ffd4-3de99732b1a3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 14:18, AngeloGioacchino Del Regno wrote:
> Il 20/05/22 10:15, Krzysztof Kozlowski ha scritto:
>> On 19/05/2022 12:18, AngeloGioacchino Del Regno wrote:
>>> Convert the mtk-gce documentation from freeform text format to a
>>> json-schema.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   .../bindings/mailbox/mediatek,gce-mbox.yaml   | 114 ++++++++++++++++++
>>>   .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 -------------
>>>   2 files changed, 114 insertions(+), 82 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
>>> new file mode 100644
>>> index 000000000000..750391b4038c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
>>> @@ -0,0 +1,114 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mailbox/mediatek,gce-mbox.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek Global Command Engine (GCE) mailbox
>>> +
>>> +maintainers:
>>> +  - Houlong Wei <houlong.wei@mediatek.com>
>>> +
>>> +description: |
>>> +  The Global Command Engine (GCE) is used to help read/write registers
>>> +  with critical time limitation, such as updating display configuration
>>> +  during the vblank.
>>> +  The GCE can be used to implement the Command Queue (CMDQ) driver.
>>
>> Mention the headers in description.
>>
> 
>    Values for properties used by the GCE, such as sub-system IDs, thread
> 
>    priority and event IDs are defined in 'dt-bindings/gce/<chip>-gce.h'.
> 
> Would that be enough, or should I list all of the headers?

Yes.

> 
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,mt6779-gce
>>> +      - mediatek,mt8173-gce
>>> +      - mediatek,mt8183-gce
>>> +      - mediatek,mt8186-gce
>>> +      - mediatek,mt8192-gce
>>> +      - mediatek,mt8195-gce
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: gce
>>> +
>>> +  '#mbox-cells':
>>> +    description: |
>>> +      The first cell describes the mailbox channel, which is the GCE Thread ID;
>>> +      The second cell describes the priority of the GCE thread.
>>> +    const: 2
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>> +  - '#mbox-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - mediatek,mt8195-gce
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          maxItems: 2
>>
>> Are you sure this works on mt8195-gce?
>>
> 
> Thanks for that, I've just rechecked the driver and.. no, that won't
> work for MT8195: it's just one clock there (like the others) and the
> clock names aren't even enforced, as the driver is always taking the
> clock at index 0.

I was not thinking about driver, although it's nice that my review
helped in that. What I was mentioning, is your bindings behave correctly
for mediatek,mt8195-gce DTS? You have maxItems:1 and maxItems:2, so
usually it was failing, AFAIR.

The same with clock-names - I think the schema should fail here.


> 
> I got confused because the driver uses a slightly different kind of
> logic when probing on SoCs with multiple mailboxes, specifically:
>   - For single mailbox, having a clock with name "gce" is enforced
>     as it's grabbing it with devm_clk_get(dev, clk_name), where the
>     clock name is declared in a string called "clk_name";
>   - For multiple mailboxes, it's looking for an of_alias, declared
>     in an array of strings called "clk_names" and getting the clock
>     with of_clk_get(node, 0).
> 
> 
> So there comes my confusion, recapping:
> 
> static const char * const clk_name = "gce";
>                   <- this is a clock name
> static const char * const clk_names[] = { "gce0", "gce1" }; <- OF alias names
> 
> 
> At this point, I think that the best idea would be to fix this issue
> first... luckily there's no MT8195 devicetree upstream yet, so I would
> technically not be breaking any ABI by changing it to be the same as
> the others.

All this sounds a bit unrelated to the bindings. Anyway, gce for one
case and gce0+gce1 for other, are okay, although schema looks a bit more
complicated. See for example:
https://lore.kernel.org/linux-devicetree/20220523181836.2019180-8-dmitry.baryshkov@linaro.org/

Best regards,
Krzysztof
