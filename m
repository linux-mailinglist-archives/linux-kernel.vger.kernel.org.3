Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E058F7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiHKGnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiHKGnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:43:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B8DEE1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:43:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x25so18351291ljm.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=y5FLc62ya38DCrndtGr7VVaO4umLSwe5yc3jrPdFBrc=;
        b=L1T1o8ZLdd5kbxyZjbXT0VQ5v2U/q5JVdFy57DZbCP0SNbQjsqKePpl+rzYwQFzV5M
         29v0Q06y1/W7DMjRiu9GCAd9Djt94Mhrbeky9w4L5xk3u1Co3GhxrrXef0rcSpsmUckr
         rXRRTKiX5qPxWLB7gIfUwN3+QeyEk9BrOucigGqNMtUfLEkDqEAp5aMKbMXSY4VB2eF+
         3xiDTTLRKjILEuGa6KU+qs0gK2H9Tx9ymABJmRl86YRLig4XV/LXIsTY6wtaKfcIIwpn
         D2o8Utp4GVH6MpEYvwUfk+79wt5tNkYv5ruSIjzGrVSF6VF9e5usgLnarhq0gsHMIISS
         W1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=y5FLc62ya38DCrndtGr7VVaO4umLSwe5yc3jrPdFBrc=;
        b=wo8l1r7cpZDqW/U84k5iyFQW28YCMqIny+Y+blPsJ/VHY6muHYSgrSaE6krJuTwwYC
         XmG5Sw5M4ktBOA8rFjA8kG3okkPCfWJUjjOd2UKH1gqXMrIWDQ3tYRNcdJq1WplV2eGk
         4tn95+a4P6OH4jVYwLESld5T4BhB/1FBxAIpK4TLKZOm534ipYtu3r8QkSCjdoBhlv2u
         +p1DaR+Whsu4Z09EoLnJEoSGmANzj4KJF4OO58a9BqW6AfV0zb0W2liNxJpFzhYh1SAC
         fdjnfVh0cxrsAp7syyCDzUGdHvULC/yKyAOvhDBjm5G0Z0n3O3qcK7X8cjpZKbr1hijN
         0QFg==
X-Gm-Message-State: ACgBeo0hwY5tx5s3nGkxE7QNCT019652ocFAosdQZM8VyszCB7z6tG0A
        rafND9+VYlwX5KLfOcRrXS+D8Q==
X-Google-Smtp-Source: AA6agR4h+jzDsmikLvCssyfAVWexiXl8Fvftjc223qA8kNJVZYUbk3OTI+SNepuFVGd3G3IP6e5rpg==
X-Received: by 2002:a2e:b4ac:0:b0:25f:fc9f:bc2 with SMTP id q12-20020a2eb4ac000000b0025ffc9f0bc2mr2480323ljm.185.1660200185171;
        Wed, 10 Aug 2022 23:43:05 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id c16-20020a05651c015000b0025e6e1c836dsm683249ljd.126.2022.08.10.23.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 23:43:03 -0700 (PDT)
Message-ID: <97934c11-4308-a579-9088-9356e0ccab1c@linaro.org>
Date:   Thu, 11 Aug 2022 09:43:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/7] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
 <20220810035013.3582848-2-bjorn.andersson@linaro.org>
 <c5cc8752-d7e2-b870-6887-c025137ed8a1@linaro.org>
 <20220810192029.GF200295-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810192029.GF200295-robh@kernel.org>
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

On 10/08/2022 22:20, Rob Herring wrote:
> On Wed, Aug 10, 2022 at 05:47:52PM +0300, Krzysztof Kozlowski wrote:
>> On 10/08/2022 06:50, Bjorn Andersson wrote:
>>> Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
>>> Qualcomm SDM845 and SC8280XP platforms.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>>  .../devicetree/bindings/display/msm/dp-controller.yaml         | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> index 94bc6e1b6451..90f9302d1731 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> @@ -16,11 +16,14 @@ description: |
>>>  properties:
>>>    compatible:
>>>      enum:
>>> +      - qcom,sdm845-dp
>>>        - qcom,sc7180-dp
>>
>> Alphabetical order, please.
>>
>> The DTS warnings from the bot look unrelated to this patch.
> 
> Yes, but there are a ton of them and I thought Bjorn might care. Looks 
> like the schema is pretty out of sync with reality and they don't really 
> look like dts side fixes.

It's in progress by Dmitry:
https://lore.kernel.org/all/20220710084133.30976-1-dmitry.baryshkov@linaro.org/

Best regards,
Krzysztof
