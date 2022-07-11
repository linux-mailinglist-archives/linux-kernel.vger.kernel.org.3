Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B072557006F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiGKL0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiGKL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:26:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0B92198
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:02:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d12so8034948lfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MeyCZN/nvsiRNNCAAR15uWNXyKxL+fyysaeRMmXtoJA=;
        b=D4OVU2SdZDl1a2Jmvol1Su2acwSKKhbqYZKZn6/Qc8eT2iND/KO9t9DapzIOJtxYXe
         Me3ljHAhTzWcyA62SHeecPkZ9BDGif3nIQh/4L6wxXSsOfYRKcaerfZkctH+lPcPcaXR
         9nwslGSNuJR55nrpcs0QsF89vgcW8SmISLwf7h2vLLq4lkAVjwTUIVYO0/uBy/LsND6c
         fUnyCOa9fgewXhbnW8EdRaMnWofxJvAWbnpmaDz4VV5KTLCEbsVuj6MgdDHsj0ja4Cm4
         7iMTtMjKPL9Xg15Ww0kzLHvpVQi9YC6P0O0itH4F7zJK4x/PaxvCYROPFLopO6UyHl1u
         Htcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MeyCZN/nvsiRNNCAAR15uWNXyKxL+fyysaeRMmXtoJA=;
        b=7vzWIVe+f+qKRJzP0LEkgSr8FiMjxbeDtoO5BjA1KlX/5QLx31Dg5UeJyyePiH980g
         q6UsD9Jl2fjLcYNf83/o7QPkRZrA7ildumc8krksjY6A6BVmqx/e0q40gi7SwweCdiko
         MwncksUyw3D6D3YiwwIROxvCRWMXM1/uXq5gZXcjUV965TX835pDRRdTAjKsAlk5em6b
         g9KnlIjj4MoywM93THdgX79Ad2ZfSJUVWZmmdMT/enRlQhgaMk4jZtlUnTYE82TZNWtk
         O3LR5boIWzenbXA6w5eyYyCb5vW3CRmy6EgdMtlbDN3fZW8uz2G1rP5Jic8dadJ73aT7
         d4Kw==
X-Gm-Message-State: AJIora+Habb6qwk7bfnwJkLjyew8w5vs+R5MnaFt1OOUMP2v3BmZWodB
        xP+OgZipjKG/irJHco+OmnogQQ==
X-Google-Smtp-Source: AGRyM1vhnNj6aFdiTr/noru4YDiDuSvAcJcPUSJPfEwIMQ9AAASbaicPsvFT+S0lPieRGdaNAEiPLw==
X-Received: by 2002:a05:6512:3b20:b0:47f:8ca1:bd7 with SMTP id f32-20020a0565123b2000b0047f8ca10bd7mr10686215lfv.105.1657537353492;
        Mon, 11 Jul 2022 04:02:33 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id u10-20020ac258ca000000b00478a311d399sm1489609lfo.0.2022.07.11.04.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:02:32 -0700 (PDT)
Message-ID: <c8f8f5f4-173e-797d-e060-e5eaac7ca822@linaro.org>
Date:   Mon, 11 Jul 2022 13:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: mmc: Add compatible for MediaTek MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220707054710.1396-1-johnson.wang@mediatek.com>
 <41e17a56-5cb0-8e90-c7ae-a7a56de986d0@linaro.org>
 <3216ec92952c7d722feaeb76986e0a6a54340646.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3216ec92952c7d722feaeb76986e0a6a54340646.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 09:30, Johnson Wang wrote:
> On Thu, 2022-07-07 at 08:46 +0200, Krzysztof Kozlowski wrote:
>> On 07/07/2022 07:47, Johnson Wang wrote:
>>> This commit adds dt-binding documentation of mmc for MediaTek
>>> MT8188 SoC
>>> platform.
>>>
>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> index 2a2e9fa8c188..3fbf33ad4f7c 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> @@ -32,6 +32,9 @@ properties:
>>>        - items:
>>>            - const: mediatek,mt8186-mmc
>>>            - const: mediatek,mt8183-mmc
>>> +      - items:
>>> +          - const: mediatek,mt8188-mmc
>>
>> You duplicate quite a lot. Use enum.
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
> 
> Thanks for you suggestion.
> 
> I will use 'enum' to place this compatible strings.
> 
> Just like this:
> - items:
>     - enum:
>         - mediatek,mt8186-mmc
>         - mediatek,mt8188-mmc
>         - mediatek,mt8192-mmc
>         - mediatek,mt8195-mmc
>     - const: mediatek,mt8183-mmc
> 
> Moreover, it seems that missing an "items:" between oneOf and enum in
> the compatible property.
> Is my understanding wrong?

I did not propose to remove items, so where are they missing? Not sure
what you are asking about...

Best regards,
Krzysztof
