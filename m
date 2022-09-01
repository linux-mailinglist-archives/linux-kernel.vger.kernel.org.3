Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1D25A918C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiIAIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiIAIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:05:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7FB852;
        Thu,  1 Sep 2022 01:04:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59EFB6601DF7;
        Thu,  1 Sep 2022 09:04:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662019491;
        bh=2zJfFSBZ2omTgok8iG1bcVSOE2x9FAqOQ/YPVZcVIH0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HU2ppayYG8zOTDbLiqQ2PUZbo4jkTO6B6P1DpNa6HGopM021oZ2sO5jbA/CC9a6bM
         dEeFx5R42p0JbphAuvPNOBoOwTUo+RZxFyW38fLWzPMZ/0BMSlqIh9CwIF8XoVUZl7
         aYVOQLxbKej7vzDqqJ2h5cG7JnFaWdz5ny5YZSiOm2bFVDqX7VFtzpLfV//ht+EByf
         I7oCcJGJa7Zh/AFYCHzlPP3naJCW5SpBCFJTp3hh2OJNaPg+oQEfymh0VWcck/rq8u
         5dHlSZzNBkVOUFnzQZqa9pR2mTxoU1Ku0PfVBSMkbSndbpXWhvnQNazaht8t2e10DA
         JLjeRBsGdFghA==
Message-ID: <1fae0c47-fff9-89e9-c849-536d167d741d@collabora.com>
Date:   Thu, 1 Sep 2022 10:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
 <20220831124850.7748-3-johnson.wang@mediatek.com>
 <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
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

Il 31/08/22 15:19, Krzysztof Kozlowski ha scritto:
> On 31/08/2022 15:48, Johnson Wang wrote:
>> Add the new binding documentation for MediaTek frequency hopping
>> and spread spectrum clocking control.
>>
>> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>> ---
>>   .../bindings/arm/mediatek/mediatek,fhctl.yaml | 49 +++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
>> new file mode 100644
>> index 000000000000..c5d76410538b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek frequency hopping and spread spectrum clocking control
>> +
>> +maintainers:
>> +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
>> +
>> +description: |
>> +  Frequency hopping control (FHCTL) is a piece of hardware that control
>> +  some PLLs to adopt "hopping" mechanism to adjust their frequency.
>> +  Spread spectrum clocking (SSC) is another function provided by this hardware.
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,fhctl
> 
> You need SoC/device specific compatibles. Preferably only SoC specific,
> without generic fallback, unless you can guarantee (while representing
> MediaTek), that generic fallback will cover all of their SoCs?
> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  mediatek,hopping-ssc-percents:
>> +    description: |
>> +      Determine the enablement of frequency hopping feature and the percentage
>> +      of spread spectrum clocking for PLLs.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    items:
>> +      items:
>> +        - description: PLL id that is expected to enable frequency hopping.
> 
> So the clocks are indices from some specific, yet unnamed
> clock-controller? This feels hacky. You should rather take here clock
> phandles (1) or integrate it into specific clock controller (2). The
> reason is that either your device does something on top of existing
> clocks (option 1, thus it takes clock as inputs) or it modifies existing
> clocks (option 2, thus it is integral part of clock-controller).
> 

FHCTL is a MCU that handles (some, or all, depending on what's supported on the
SoC and what's needed by the board) PLL frequency setting, doing it in steps and
avoiding overshooting and other issues.

We had a pretty big conversation about this a while ago and the indices instead
of phandles is actually my fault, that happened because I initially proposed your
option 2 but then for a number of reasons we went with this kind of solution.

I know it's going to be a long read, but the entire conversation is on the list [1]

Cheers,
Angelo

[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220612135414.3003-3-johnson.wang@mediatek.com/

> 
> Best regards,
> Krzysztof


