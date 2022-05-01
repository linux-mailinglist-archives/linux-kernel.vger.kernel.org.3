Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042455162E3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbiEAInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiEAInS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:43:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFF48325
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:39:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j6so22777798ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9WVzij1T8iCMekan0Ad5/KsKpQIIUWQ6B5EMe3d2lrs=;
        b=mROR3otRplC07o1VILVg/gxS1mFRixD2TxOi5OqbbxVM8XZNnOv0hIHidqUUQIbpSI
         xbIyoUrjYdvXKlAVk8j8F7eowgb7y3rZNC3lVTcgsBfxxWMEEqZTr6GUzJAu0CQI+LDF
         FzoPuSFw5yU6Kw8NYH4Oy9oEgvf1nV8vbjsonJYwytOtaGjhY/lWmINanDMK8664ea3I
         UOO7ZdRQYyB0Wi/NdV2SgrFSvWbiMcRV2yoVk4zaqk2BJozbzhniZZLURoAJFmsKPzwQ
         VPvpptkjPqULmqY7ZamztTW4t6t7+LkfI/giQJIuqbQN2Ar/gifMbZmUW3rHskp2k1wY
         XgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9WVzij1T8iCMekan0Ad5/KsKpQIIUWQ6B5EMe3d2lrs=;
        b=aQ9z1/s0doX4MqqjE1JllzqMFUkbz+UR/A9DdCc5Dk5PSH4v3/CwvjwxXQlAolF+cS
         Jl8++2lyUGO7ffUy85qG4QqgX/kCE7lhxJmn36/IDEpnesP17iKOFkd/+4Aj7gwD3zLM
         BoHuDREYeSuLYYfRIDY64rylrxP53P0Bah6Dwb60sQcHqjhzq9ar4X6e7JIteC3MVPKv
         TVKU1XCE1KRtu5xz8MJlVmfCpkGr0bjz+li84CvWuLc48kpOOtRRZH1qTtDjWjt15gtc
         /EjvmbCc6kh85/X0ed3gS7Z6Q6jpOEXpwsU3HUcPiREW+Jcn3R29egVG4ZpAzpHRW+RX
         PxcQ==
X-Gm-Message-State: AOAM530W+QSJbWsBUThhNSg34dVzPfVYEFUsRCzzxaDk6SO53x2vjwn1
        Vl4Clj48GfGSKlyMlwXIyH5ecA==
X-Google-Smtp-Source: ABdhPJxSZX/QiQu3+AxPRtWO5Bwf8OHfZj8Hk0L0xj2XTUlRIcS57LBeqeX+kbSIvh5SbCQrJkPHBw==
X-Received: by 2002:a17:906:5d0c:b0:6f3:dce6:a69a with SMTP id g12-20020a1709065d0c00b006f3dce6a69amr6963489ejt.23.1651394392331;
        Sun, 01 May 2022 01:39:52 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hy25-20020a1709068a7900b006f3ef214db5sm2380978ejc.27.2022.05.01.01.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:39:51 -0700 (PDT)
Message-ID: <ec18c8f7-d25f-895f-c8c7-1a33e59cc973@linaro.org>
Date:   Sun, 1 May 2022 10:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dt-bindings: arm: mediatek: mmsys: refine power and
 gce properties
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Cellopoint <cellopoint.kai@gmail.com>
References: <20220429083051.11260-1-jason-jh.lin@mediatek.com>
 <c9239316-40af-724b-cace-7da5bf7e8e21@linaro.org>
 <cf3062c9ebc69642bdc16ce32ed3260486969b04.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cf3062c9ebc69642bdc16ce32ed3260486969b04.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 10:26, Jason-JH Lin wrote:
> Hi Krzysztof,
> 
> Thanks for the reviews.
> 
> On Fri, 2022-04-29 at 22:58 +0200, Krzysztof Kozlowski wrote:
>> On 29/04/2022 10:30, Jason-JH.Lin wrote:
>>> Power:
>>>   Refine description and add item number for power-domains
>>> property.
>>>
>>> GCE:
>>>   Refine description and add item number for mboxes property and
>>>   mediatek,gce-client-reg property.
>>>
>>> Fixes: 1da90b8a7bae ("dt-bindings: arm: mediatek: mmsys: add power
>>> and gce properties")
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> 
> [snip]
>  
>>>    mboxes:
>>> +    minItems: 1
>>> +    maxItems: 24
>>
>> Wait, no, I wrote it should be 16 for one device and 24 for other,
>> not
>> 24 for all...
>>
> 
> Ok, I thought maxItems: 24 contained 16, but it's not clear enough.
> 
> 
> I'm not sure how to describe different maxItems for different
> platforms. Does it come like this?
> 
> 1. Remove the maxItems in mboxes property.

mboxes:
  maxItems: 24

> 2. Add the allOf condition before the line "additionalProperties:
> false". E.g.
> 
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: mediatek,mt8173-mmsys
>     then:
>       properties:
>         mboxes:
>           maxItems: 16
>     else:
>       properties:
>         mboxes:
>           maxItems: 24

and you can skip the "else". In general looks fine.

Best regards,
Krzysztof
