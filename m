Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0758F99D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiHKI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiHKI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:58:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC2915DD
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:58:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u6so13287116ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=N5Ft5sVhLXeWT9idHrJs9i/WomNuOkmhDhB2xyIuVDk=;
        b=wVyaWMWBQECdMUBpp7ZCsMs+ygcvsTNhL3QyN1Hd3bVN+jIscsZW1+Sk5718mb7T+9
         5AvoXULMa/v55wb0yPGXxOKYOpF2dD8DByh6BHnnFRwEo9FTZCwL/FfnNPwdlv2EtPhK
         Q24/SOHs2lrjO5qbXSWNhq0jwyFvovuBAP59gMTjZx0wv6dD48qGNpTcGnmvRUqYcJ9I
         Txg8SUshCo8Aq0AFZu6itRg0fhDD6HS2y8ctI6VTgtGZvXurw+bJWIc+HbktjkPk1LtD
         Tr1aTOpwiSRo0M/KuHjWW09YYo5AzUEy6njjIloYn9DnAOkE1+3YkWkSzi1LnMkyWfmr
         fZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=N5Ft5sVhLXeWT9idHrJs9i/WomNuOkmhDhB2xyIuVDk=;
        b=5TLZ3VlYkuDhUO0sOhSuaZJq4uw+Fsr7VXlQp0bBT5+F4JJ4Z9T3pLNI4aoCNTr5ra
         AFy3z2+hhKHSfVcsUpALgvjHd1FIj6Ix76aL/dQ3JwST1oYTmmRs1Ato3sqo9J+wX96q
         iawV13s1a2CU8buLjSc7LAAB3mxCx3N2fHtVQdgDp2OCypLScJ1wQ/ARucDPnXytNQ3M
         7UVh6D4sqrJ19T8jx//hWBDtFEo7A+izlFzhvLeRhj4a5iO1MFXNp5ps1++Fdz7kEPEl
         x679be8PbJ6tghj4rG6XW8NV994iBHjv97/J6QqjzACm5I4THWWgtCRKZRUSFchydEP2
         np1Q==
X-Gm-Message-State: ACgBeo3oaZ/mXepqVU9PGJ9XZq3TMowWbVO9yCk7M/WGHD8NDn9jA1ns
        JdLrszkBrYFlkbuEW3z3bBM1RA==
X-Google-Smtp-Source: AA6agR5IG/BKNBEX72bjzs3bSYNizTV99VINIDm/s2LxtwxR86KNQn9gvYNlkjqA9dNJgl+dksY4+A==
X-Received: by 2002:a2e:9e17:0:b0:25d:7654:4c6b with SMTP id e23-20020a2e9e17000000b0025d76544c6bmr10392843ljk.130.1660208292382;
        Thu, 11 Aug 2022 01:58:12 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id du14-20020a056512298e00b0048cf7e8145asm635053lfb.117.2022.08.11.01.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 01:58:11 -0700 (PDT)
Message-ID: <86ab77f5-8beb-7237-d6e2-734f52ca176b@linaro.org>
Date:   Thu, 11 Aug 2022 11:58:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] pmic: add mt6366 regulator document
Content-Language: en-US
To:     "zhiyong.tao" <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        zhiyong tao <zhiyong.tao@mediatk.com>
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
 <20220728062749.18701-2-zhiyong.tao@mediatek.com>
 <03a13ed4-e7cd-6f7d-f8f7-9b1e6193e202@linaro.org>
 <111e1073e1ce689e289e52c645a1be2e7dc7fe12.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <111e1073e1ce689e289e52c645a1be2e7dc7fe12.camel@mediatek.com>
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

On 11/08/2022 11:42, zhiyong.tao wrote:
>>
>>>
>>> Signed-off-by: zhiyong tao <zhiyong.tao@mediatk.com>
>>> ---
>>>  .../regulator/mediatek,mt6366-regulator.yaml  | 375
>>> ++++++++++++++++++
>>>  1 file changed, 375 insertions(+)
>>
>> Subject does not match subsystem.
> 
> Hi Krzysztof,
> 
> Do you mean that we should change the title like this:
> regulator: dt-bindings: mediatek: add mt6366 regulator document
> is it right?

Yes. And remove redundant pieces so for example:

regulator: dt-bindings: mediatek: add mt6366
or:
regulator: dt-bindings: add mediatek,mt6366


(...)

>>> +    patternProperties:
>>> +      "^buck-
>>> v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
>>> +        type: object
>>> +        $ref: "regulator.yaml#"
>>
>> No need for quotes.
> ==>
> We will remove the line "$ref: "regulator.yaml#"" in next verison, is
> it right?

No, it is not. Why do you want to remove it?


Best regards,
Krzysztof
