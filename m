Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73948518482
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiECMrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiECMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:47:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD571CB05;
        Tue,  3 May 2022 05:43:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 92C501F4354B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651581805;
        bh=n9/BmWbN3g+/wyuxwqu1fAbXZTK/mlyH9NhVx5Z5DvM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BTKgQTkN2YsUXw1djbp3qfuwQbLGIZpI+tVUm0u4oeOlUbPviD9bCK4g9yo3fCd6e
         prWG0Famn7AwU6UHSLvRl7n/j6PzO57l2AFvD1wjxXDNgv2GJ61yOpDtLRScyc5hU6
         aA2O9o+24k09YaYa6wWbowIngNtIi1IXYhDPwEVc7sCagym9Ylh9zktGadH3zC08HY
         2sQDR+/SQQrNuvsRFsNckV8jqDIY3J2atQNUPXkERoyOzZ3AoHB756vNOPSWcDCndQ
         oNt8r6cG2nSP8Wv4gbGvedE/cpLOzTQMR/Fc7ksjUAho4DDebVJ71LitCPil+05ElK
         rS44evNa7Vyhw==
Message-ID: <94dbb7ee-764a-5568-a044-80dbfe77c29a@collabora.com>
Date:   Tue, 3 May 2022 14:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add MediaTek Helio X10 MT6795
 power domains
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220503105436.54901-1-angelogioacchino.delregno@collabora.com>
 <20220503105436.54901-2-angelogioacchino.delregno@collabora.com>
 <ac774c74-4577-3dfc-7bf4-3c180d45b420@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ac774c74-4577-3dfc-7bf4-3c180d45b420@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 14:38, Krzysztof Kozlowski ha scritto:
> On 03/05/2022 12:54, AngeloGioacchino Del Regno wrote:
>> Add power domains dt-bindings for MediaTek Helio X10 (MT6795).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../power/mediatek,power-controller.yaml         |  2 ++
>>   include/dt-bindings/power/mt6795-power.h         | 16 ++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>   create mode 100644 include/dt-bindings/power/mt6795-power.h
>>
>> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> index 135c6f722091..b448101fac43 100644
>> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> @@ -23,6 +23,7 @@ properties:
>>   
>>     compatible:
>>       enum:
>> +      - mediatek,mt6795-power-controller
>>         - mediatek,mt8167-power-controller
>>         - mediatek,mt8173-power-controller
>>         - mediatek,mt8183-power-controller
>> @@ -62,6 +63,7 @@ patternProperties:
>>         reg:
>>           description: |
>>             Power domain index. Valid values are defined in:
>> +              "include/dt-bindings/power/mt6795-power.h" - for MT8167 type power domain.
>>                 "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
>>                 "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
>>                 "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
>> diff --git a/include/dt-bindings/power/mt6795-power.h b/include/dt-bindings/power/mt6795-power.h
>> new file mode 100644
>> index 000000000000..0e27bc7fa748
>> --- /dev/null
>> +++ b/include/dt-bindings/power/mt6795-power.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> If it is not a derivative work, should be GPL-2.0 OR BSD
> 

On that, I agree with you, fully.

Though, all of the mt(xxxx)-power.h headers provide this license tag and I
wanted to follow that to give the same.

Should I change it to (GPL-2.0-only OR BSD-2-Clause)?

Regards,
Angelo

> 
> Best regards,
> Krzysztof

