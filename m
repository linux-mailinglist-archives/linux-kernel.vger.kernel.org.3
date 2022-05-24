Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AAA532F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiEXR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbiEXRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:25:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786697CDE2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:25:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i40so23974691eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7DverL1ikxumj0Y3SFmQnwkR+piWdmMTQZvxAemn6kg=;
        b=oVRBh/+TJakQz3DjIaUyjRcW6DeXRSxUUd6/ILbdyZglYUF013SG6jQp2kG/9n0pQT
         2AcVuGhNKshvanzyLnHVW2jeCOOFvPCa/bc1PV+5HuKcFI9A/BAKin5n68r9YZ2kkUl3
         IeBa2rXlvo6YFcbENTD0ZXC1IYRJWUkQQ1b5IedVwPsWmERbFUenvboHapdw7aOlOVJ5
         RFtHzba2iRjEanFvrDmrTSYHzTw+nSa7Ty0XodqSRy7th74zZQJyuK5eTChL2wXBTYfZ
         /O4hZC5YyqEQduIquJbbiWZbqw21SCQAGYeGvZR20AyYj4FCfGzQfKKpXmPhonUGAMig
         nk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7DverL1ikxumj0Y3SFmQnwkR+piWdmMTQZvxAemn6kg=;
        b=6J0nZYxsiqW4jGuWRYs6A4f4H2PZky5z+/P6bwbulM6eFnSmlRuq4KXJC2pIsURzL5
         XjM/rvYomTnutuUhqil3Ixir3KoJA/VjMIdeWn//fHtMvWtlJuFkxKgzU6A5RFZQwURE
         DsLmvuhGDpk1aEKCIBr/Q5Q2QpAtKPyn4cqxF6TauhXJGyH4uneWQe+Pn66OvpA6uj9X
         3DeTzT2L7kaddvF9lgtlT5IgtOFKdMFD1KMPEtSqyf2CUuGkt9vbnNv0z1v73jmjuboH
         tBVGkseLmk54s6s7+4DAvseb2lFv84GV9Jankrvh8w+ujb03fxuJ8C8KPRqPtkiQLuXJ
         QOLA==
X-Gm-Message-State: AOAM532H9dafsLDuSdnYuEL3nnSKBCo8AdQ4TvG6JKnJFnJkVtXd4zvR
        7TCp3A1pSCkbeZQM+RFg0XUY+w==
X-Google-Smtp-Source: ABdhPJxNyNZDNZ7N9j3lhWQZf5V7llJx5ZQm1zVAUBt5vYk9QRZ7YzifEnKNJLjQSXuVw51IAxUyZg==
X-Received: by 2002:a05:6402:1612:b0:42a:be18:8c8 with SMTP id f18-20020a056402161200b0042abe1808c8mr30089414edv.223.1653413155944;
        Tue, 24 May 2022 10:25:55 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ta16-20020a1709078c1000b006fec27575f1sm3561060ejc.123.2022.05.24.10.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 10:25:54 -0700 (PDT)
Message-ID: <4b3d980e-1d5a-019c-ca1c-1f4a06f51a0f@linaro.org>
Date:   Tue, 24 May 2022 19:25:53 +0200
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
