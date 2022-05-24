Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D38532A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiEXMSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiEXMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:18:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294288DDDB;
        Tue, 24 May 2022 05:18:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 759CF1F43F10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653394722;
        bh=qL2zwEVTGyHx3qjDE2gF4fhdtuxKIJOmdMC0x5/fTok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JQ/tsavMoWUhJC7+r53CgL89tt+wgN9dKsUbLNgReY5V8a7Aos7c1EZ0Ox8KLUmuK
         rjA/ZAdXfjCML/ZzbOeElopTUlqZPg08pOCyFDmDmCSeUEZ6/jlF29jltWhcAU7031
         wxobtSG5g4sh+pudjAra1pOPwbYlU87ccTtoJ9UhDVJgj6YR8z/REy/IVbhXBn4klo
         /Sz2022c8TNJD85AY5pdw6JEndg0FnTxWRvwXfScGpAxifmFt6CxSTR6YD6CzTVuEv
         4x41a+rizq6hS0r8kFj9cx9XrFLdW2dytM6cSpE9hS2QaC7S0CyZpya/Pm8V3DtMiS
         DI8bm98tL04Vg==
Message-ID: <8d1411a7-0714-1667-ffd4-3de99732b1a3@collabora.com>
Date:   Tue, 24 May 2022 14:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] dt-bindings: mailbox: mtk-gce: Convert txt to json-schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220519101806.18097-1-angelogioacchino.delregno@collabora.com>
 <45e78390-5f91-7ac7-45d8-5796bc608234@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <45e78390-5f91-7ac7-45d8-5796bc608234@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/05/22 10:15, Krzysztof Kozlowski ha scritto:
> On 19/05/2022 12:18, AngeloGioacchino Del Regno wrote:
>> Convert the mtk-gce documentation from freeform text format to a
>> json-schema.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/mailbox/mediatek,gce-mbox.yaml   | 114 ++++++++++++++++++
>>   .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 -------------
>>   2 files changed, 114 insertions(+), 82 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
>> new file mode 100644
>> index 000000000000..750391b4038c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
>> @@ -0,0 +1,114 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mailbox/mediatek,gce-mbox.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek Global Command Engine (GCE) mailbox
>> +
>> +maintainers:
>> +  - Houlong Wei <houlong.wei@mediatek.com>
>> +
>> +description: |
>> +  The Global Command Engine (GCE) is used to help read/write registers
>> +  with critical time limitation, such as updating display configuration
>> +  during the vblank.
>> +  The GCE can be used to implement the Command Queue (CMDQ) driver.
> 
> Mention the headers in description.
> 

   Values for properties used by the GCE, such as sub-system IDs, thread

   priority and event IDs are defined in 'dt-bindings/gce/<chip>-gce.h'.

Would that be enough, or should I list all of the headers?

>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt6779-gce
>> +      - mediatek,mt8173-gce
>> +      - mediatek,mt8183-gce
>> +      - mediatek,mt8186-gce
>> +      - mediatek,mt8192-gce
>> +      - mediatek,mt8195-gce
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: gce
>> +
>> +  '#mbox-cells':
>> +    description: |
>> +      The first cell describes the mailbox channel, which is the GCE Thread ID;
>> +      The second cell describes the priority of the GCE thread.
>> +    const: 2
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - '#mbox-cells'
>> +
>> +additionalProperties: false
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - mediatek,mt8195-gce
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 2
> 
> Are you sure this works on mt8195-gce?
> 

Thanks for that, I've just rechecked the driver and.. no, that won't
work for MT8195: it's just one clock there (like the others) and the
clock names aren't even enforced, as the driver is always taking the
clock at index 0.

I got confused because the driver uses a slightly different kind of
logic when probing on SoCs with multiple mailboxes, specifically:
  - For single mailbox, having a clock with name "gce" is enforced
    as it's grabbing it with devm_clk_get(dev, clk_name), where the
    clock name is declared in a string called "clk_name";
  - For multiple mailboxes, it's looking for an of_alias, declared
    in an array of strings called "clk_names" and getting the clock
    with of_clk_get(node, 0).


So there comes my confusion, recapping:

static const char * const clk_name = "gce";
                  <- this is a clock name
static const char * const clk_names[] = { "gce0", "gce1" }; <- OF alias names


At this point, I think that the best idea would be to fix this issue
first... luckily there's no MT8195 devicetree upstream yet, so I would
technically not be breaking any ABI by changing it to be the same as
the others.

Easier explanation: plan is to change the driver such that we won't
need anything different from the others in this schema.

New version coming soon, then....

Regards,
Angelo

