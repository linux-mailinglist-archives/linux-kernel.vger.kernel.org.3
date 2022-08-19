Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2DF599601
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbiHSHbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346273AbiHSHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:31:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC065E3C12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:31:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bs25so4193874wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=RV+ARt4gQhvfrcS7u827ZCv30OBKAwgCr4iLi8/48cU=;
        b=uPBQyrxzcJRob7in8TPErUSfRm3jOEFuSNQgZupp8+Ej6fHuZgxgNhI7L58GtA/r4q
         1kUAaFh6sZFr/Lv+8LELzSu7XAh+MbsHbi13EThBfYvbnJqLgnGj6tE0rCGEptfWco8C
         MisfjK6/VbW6wfA783dRwWjORTSsFkok6kGias/7AYzKYgYir3Rz2uDzdAt4x5PLJ47+
         u1QDM4t2Iu6tqff52mzhzokQh+79xRvvjosSTd8QGXJrncta5xHxMxgxiRoxCXETnHwp
         pNhzPnLLPf8MsgNmxQViIFmXB6tN3Y3gHN//f/lN7erANYZrr7IYck/UIt7SNzRfhfy1
         ryZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RV+ARt4gQhvfrcS7u827ZCv30OBKAwgCr4iLi8/48cU=;
        b=cRwAu566Wk+YlhxRQnNEIMAEqxLR5RS6PVpoiFZBDqJ63Ym0ID/TD2IEycGd8ynyAT
         7vZ1x989N3z5gvWIeziLtg1i/hHTBcmZkisl7mXweyXxSMaJJH8M4C0htZVopaxDjKJ1
         lCAsGxTLCWpebHlCTdaXKqEPTwWkvgP5w1pZ2AS/Gal+ZtAZ+l8xy92ftQXjwVqfNhce
         EG3G4wEw/7nAKsYD9sSSnXmN7rfaTLnftAzUCvfCIH53wP6WrNBgdEpiSFbK4JfqI94N
         y+zU5qp0OBmToJ2CLFatgUxvtLJxrEhGkEoxQlJcxwyPmwCByGC7uL8tO7FTQ6Ec1aAK
         PkKw==
X-Gm-Message-State: ACgBeo2SUC6/xwO/2gYbLFJCmmSf3bkqz51OICGZvp0i4RXXE3DXfZZD
        rJKjJUOVHGnL07dIpVUuXcpr1A==
X-Google-Smtp-Source: AA6agR4CGIlqAV6RizwDoxYJFGlwJm1SK13W9rHLu2V5WQfDmh0FysHCD1l7Q3/xJfa5DFO9Az+90A==
X-Received: by 2002:a05:6000:2cc:b0:21e:e8c1:2704 with SMTP id o12-20020a05600002cc00b0021ee8c12704mr3693424wry.378.1660894298251;
        Fri, 19 Aug 2022 00:31:38 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id v8-20020a05600c214800b003a5c244fc13sm8237202wml.2.2022.08.19.00.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 00:31:37 -0700 (PDT)
Message-ID: <1e365b6a-abc0-7745-572e-4bb76ff9a4c8@linaro.org>
Date:   Fri, 19 Aug 2022 08:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] dt-bindings: nvmem: mediatek: efuse: Add support for
 MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220715120114.4243-1-johnson.wang@mediatek.com>
 <20220715120114.4243-3-johnson.wang@mediatek.com>
 <8ab34dd4-ca5a-2824-ccbf-867996ac6536@linaro.org>
 <726ec17f1b8d42f7ec9858a54ee952cb53f03188.camel@mediatek.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <726ec17f1b8d42f7ec9858a54ee952cb53f03188.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 19/08/2022 04:28, Johnson Wang wrote:
> On Wed, 2022-08-17 at 13:21 +0100, Srinivas Kandagatla wrote:
>>
>> On 15/07/2022 13:01, Johnson Wang wrote:
>>> Add compatible for MT8188 SoC.
>>>
>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>>> ---
>>> This patch is based on "linux-next"[1].
>>> [1]
>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git__;!!CTRNKA9wMg0ARbw!yz8fBHH39-ntsRnAlXZfmS1k9PoKMtITUk-DhcvGQJOJSu9HP70OmFoCYMfvxnjWw4Ql$
>>>   
>>> ---
>>
>> Applied thanks,
>>
>> --srini
>>>    Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>> b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>> index b5a1109f2ee1..75e0a516e59a 100644
>>> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>> @@ -30,6 +30,7 @@ properties:
>>>                  - mediatek,mt8173-efuse
>>>                  - mediatek,mt8183-efuse
>>>                  - mediatek,mt8186-efuse
>>> +              - mediatek,mt8188-efuse
>>>                  - mediatek,mt8192-efuse
>>>                  - mediatek,mt8195-efuse
>>>                  - mediatek,mt8516-efuse
> 
> Hi Srinivas,
> 
> Just a gentle ping on this.
> It seems that this patch hasn't been applied into [1].

Its applied and pushed now!

--srini
> 
> If you have any concern about this patch, please let me know.
> 
> Thanks.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git


> 
> BRs,
> Johnson Wang
> 
