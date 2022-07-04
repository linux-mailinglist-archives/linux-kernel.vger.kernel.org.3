Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7765657D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiGDNuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiGDNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:50:46 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3C7667
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:50:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s14so11190373ljs.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lT/WBzy1xTEwZAbHZXK8gHu8QzttQ69byOmkHs6AXd8=;
        b=AqfDJpmMA1heNclPI30P28wHc5C1ei9kQ1TumAb8DzCU8oZrkIwlXGf8mY9NBm2rpp
         wfvqUU3jWUWOfPwb28yw9iPI9jZyeMfbm/YRmYgrJ/mPGpp3EtJYUn9okLxwWR171VIN
         RvJaRVFxFjaz4KpUwgtFCzMmj7cPAQobdSu2BHncy7ChcrwxMBBwkXgNiJWt+TIPIhia
         lsrv5SV3xLHKmywyznqo15V1bkezHVZlbeK+zFk781EVJKMCxnYMJThOXjMMsx6uypJ+
         hqvfvMrd9n0WLfCH9PPp1AmTkhVGzkMq5IauvKlOIthMPfHUnNrPxMYbghSCG4BYE6CD
         yvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lT/WBzy1xTEwZAbHZXK8gHu8QzttQ69byOmkHs6AXd8=;
        b=v85UktJBMaTK48b4PwqAZNk9ZNBSYTdg3VdVgnHNq7PHZT6cVAAOwXnyVBMO52ucAI
         XUMAbdQ3r92SEmWl99OVGQS75H4ESol/0QDQiXhwncF9jetvkc8F6IMPNHOlGtAk9JW+
         9iFum6Xh1aQoIc0GXiEP1Y7V8BGsj/AaruUq01nVLfUaUOBBnZHbxIr4zt3FXKgZVxza
         ZJU5Wwpbq9zxA5cj10TZuTlRPC5+rA9mejkLyprSSYK0hGsgGjcNWnsCqb5/xXZjW1mU
         qPuTy2FASOi6nMOfGs7a0YGQfiICeKT1dJTd08AhmyEebrrdsf93g3qkMsuBUCWUOy7E
         MsMg==
X-Gm-Message-State: AJIora+5GO6qiuDQLJ2MCnf73r+bCR4GfqspV340DNCEDY6v4oocDiOb
        2XgQzsx5zbOJiJ/n35mJ1ZQ4wg==
X-Google-Smtp-Source: AGRyM1t2Bgk/Rcpn44SeT+dVzENdaqgmd3LwGLwpfpceBWJVJRCY8Fc0RgrqisnfShY3FN/VsR01GQ==
X-Received: by 2002:a2e:80d3:0:b0:25a:736c:1c80 with SMTP id r19-20020a2e80d3000000b0025a736c1c80mr17375381ljg.436.1656942643213;
        Mon, 04 Jul 2022 06:50:43 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id t10-20020a2e8e6a000000b0025d2bd46603sm74583ljk.131.2022.07.04.06.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:50:42 -0700 (PDT)
Message-ID: <5fa79e89-144c-7261-335a-8f509b182bba@linaro.org>
Date:   Mon, 4 Jul 2022 15:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/5] dt-bindings: interconnect: Update property for
 icc-rpm path tag
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20220704093029.1126609-1-leo.yan@linaro.org>
 <20220704093029.1126609-2-leo.yan@linaro.org>
 <18f1ee4a-5787-40d7-2eb5-50a43298845d@linaro.org>
 <20220704130712.GD659023@leoy-ThinkPad-X240s>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704130712.GD659023@leoy-ThinkPad-X240s>
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

On 04/07/2022 15:07, Leo Yan wrote:
> On Mon, Jul 04, 2022 at 02:47:13PM +0200, Krzysztof Kozlowski wrote:
>> On 04/07/2022 11:30, Leo Yan wrote:
>>> To support path tag in icc-rpm driver, the "#interconnect-cells"
>>> property is updated as enumerate values: 1 or 2.  Setting to 1 means
>>> it is compatible with old DT binding that interconnect path only
>>> contains node id; if set to 2 for "#interconnect-cells" property, then
>>> the second specifier is used as a tag (e.g. vote for which buckets).
>>>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> ---
>>>  .../devicetree/bindings/interconnect/qcom,rpm.yaml         | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
>>> index 8a676fef8c1d..cdfe419e7339 100644
>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
>>> @@ -45,7 +45,12 @@ properties:
>>>        - qcom,sdm660-snoc
>>>  
>>>    '#interconnect-cells':
>>> -    const: 1
>>> +    description: |
>>> +      Number of interconnect specifier. Value: <1> is one cell in a
>>> +      interconnect specifier for the interconnect node id, <2> requires
>>> +      the interconnect node id and an extra path tag.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Ah, too fast.  No ack. This ref is also pointless and not explained in
>> commit msg.
> 
> I referred other DT binding file for adding $ref to specify property
> type [1], so it's confused why it's pointless, anyway, I can drop $ref
> in next spin.
> 
> Thanks a lot for the review!

The "arm,prefetch-offset" is not a cells property.

Best regards,
Krzysztof
