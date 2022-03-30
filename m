Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C134EBCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbiC3IXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244267AbiC3IWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:22:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05793120B;
        Wed, 30 Mar 2022 01:21:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3C4931F443F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648628460;
        bh=sD9zda1gQkNv3MUA4bkv/V5WHuwzCfeFynE1ba/36bI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lwqXWCyvUJTMcWkmXB/XryVKNZ3doT0L4in++YJhNLlEumVov1VdrMn6WG2XwP0ks
         blZ4fiFE4Q0hNhTRpBd0ICap0dAq4rUqv6Nx574wrl2C/2wf9fmlKPNu13ak+i9io3
         XuGtTjPq0bybFhxrjyjT8O9tviLy2mV3ijMdf4YmcBenisQ5JUKxTJ1r+sC/KVqf8/
         YDrwtXvpxBbOVALzBJ2KhF0A4Xle3gmzF1YumNtOdnjiLJ0IkLwdWn8R9yyHo3t0Pj
         tVq4OP09GfDsPwVt2n20oWvaZw3i7S6EQpXqzxGxqug2kMu8MrH9mYT6LXort9N/r+
         q6o2+0V72XjlA==
Message-ID: <61c2609c-18d1-fea9-7b71-0b17fb2beaef@collabora.com>
Date:   Wed, 30 Mar 2022 10:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 2/3] dt-bindings: mmc: mtk-sd: increase reg maxItems
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Ryder Lee <ryder.lee@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
 <20220329114540.17140-3-tinghan.shen@mediatek.com>
 <d720a5e9-d078-6c60-f55b-0506c4b4e1fa@collabora.com>
 <CAL_JsqLrgW4GwSZ20x5Gsu-umjtw4x8k=uHeZk9T2+A3K6UT0Q@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAL_JsqLrgW4GwSZ20x5Gsu-umjtw4x8k=uHeZk9T2+A3K6UT0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/22 21:10, Rob Herring ha scritto:
> On Tue, Mar 29, 2022 at 7:43 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 29/03/22 13:45, Tinghan Shen ha scritto:
>>> Add optional host top register base for the reg binding description.
>>>
>>> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>    Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> index 7032f7adf3ca..6d41bcec900f 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> @@ -40,7 +40,8 @@ properties:
>>>              - const: mediatek,mt8183-mmc
>>>
>>>      reg:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 2
>>
>> it's just maxItems... adding minItems: 1 is not required.
> 
> If 1 entry is still valid, then minItems is required. If not, then
> it's an ABI break.
> 
> Rob


Right. Sorry for that and thanks for the explaination, Rob.

Cheers,
Angelo
