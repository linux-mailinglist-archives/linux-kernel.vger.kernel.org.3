Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9352883E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbiEPPPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245039AbiEPPPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:15:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF67C3BBC1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:14:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ch13so29257702ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mT7/Ms8+mt3fxt9Iti7ZV4qUURzTdQF9NTtcKJjj9p0=;
        b=eTtQA3FGnuABes6xiwZEqM1pVCSn6mP/1J0Zs8PnYUbrf6wa6sWtZV1CMHBCZtTm4P
         jSKHjKMdc6cj+Qp2wMPTw39Fd+cznhXrru+fGRovVTqjLKhNt3i0Jcx6HekN37E9U0kd
         0RbT6UHXqoyaa8cBAGwVJO2eQlpWNLNX/MNYBczXUMe4Ino92smkbHWRDU/Ybwyu50qS
         VGI7DHqkTLHxbPpM2HBhoZILupb4I0WHNRyqCyykv/QPmqpahJFQvs9FQSJymcIdtT8R
         H3dANwMPkow+FrXWsWmZpYThFo6OWev9hWfWFHOVF9h38h5cwOo0D3Hx/0Mvul4iXPo6
         0hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mT7/Ms8+mt3fxt9Iti7ZV4qUURzTdQF9NTtcKJjj9p0=;
        b=apAEHmCaa0jiug7kWZsN+Q593mYX6s/xzSWPVUh0APrzGaPWf0rNB5JYZ7ZKDE2tdt
         Avug0CmcLASue7EVL4DnN/tqnOEeJDO3XnRdM52XcYWvE4sYJtUytf4Cua01hL4jqNpI
         80iscBcF3R4K/FzAwFdNktLAlaDILlUzbpEn/YlERaVXg3Calc/s0TCyDkGtO2rodEMA
         V3RnytIABGF03fmWpXw6nmRl7eHmfdJFQ9hoXleJduVAwWXIzNdiXlA19K/BgnjsrobA
         kdS9fnaFGBNhb9dM1kQO9rvY0xqXM1MVScq2Gx8353KXHCDzhLRKfZANyuhsOfKKa5k/
         Gtmw==
X-Gm-Message-State: AOAM530/VTHL0hY8Km4hoWjF2ddQ9KJMti2dH6YvV8IubHSTAe3KMR1+
        PVK2UlqlMoh1FjDor+6wBPqVIA==
X-Google-Smtp-Source: ABdhPJzZJYJRYHriof0O9i6fwoHE6QsUFvkL/p4fdhMBl53WDdCzW2eGFoljqkVBReNlwPP91IzS9g==
X-Received: by 2002:a17:906:aed8:b0:6f3:7e6b:14d with SMTP id me24-20020a170906aed800b006f37e6b014dmr16118561ejb.451.1652714097404;
        Mon, 16 May 2022 08:14:57 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906518900b006f3ef214e0csm8153ejk.114.2022.05.16.08.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:14:56 -0700 (PDT)
Message-ID: <e7730596-8fb9-7fbd-3074-de561086a121@linaro.org>
Date:   Mon, 16 May 2022 17:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Add sc7180 Chromebook board
 bindings
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220512090429.1.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
 <828bc65f-e585-0fe7-c038-c750861c9446@linaro.org>
 <48d96a4e-ce1b-03a1-1831-36555efd7080@linaro.org>
 <CAD=FV=WNSv+kgTZwjHVq+YNQAG0uB42QUPaU-BPTV_W+j=5aYg@mail.gmail.com>
 <96686d6d-83a9-05a2-9fdc-f9fc4b4e7eed@linaro.org>
 <CAD=FV=W8F5xbv2tKhCvjLLHitts+eQFbFE3fb3wogwY91Q7gAA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=W8F5xbv2tKhCvjLLHitts+eQFbFE3fb3wogwY91Q7gAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 17:11, Doug Anderson wrote:
> Hi,
> 
> On Sun, May 15, 2022 at 11:40 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/05/2022 19:00, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, May 13, 2022 at 2:01 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 13/05/2022 09:57, Krzysztof Kozlowski wrote:
>>>>> On 12/05/2022 18:04, Douglas Anderson wrote:
>>>>>> This copy-pastes compatibles from sc7180-based boards from the device
>>>>>> trees to the yaml file so that `make dtbs_check` will be happy.
>>>>>>
>>>>>> NOTES:
>>>>>> - I make no attempt to try to share an "item" for all sc7180 based
>>>>>>   Chromebooks. Because of the revision matching scheme used by the
>>>>>>   Chromebook bootloader, at times we need a different number of
>>>>>>   revisions listed.
>>>>>> - Some of the odd entries in here (like google,homestar-rev23 or the
>>>>>>   fact that "Google Lazor Limozeen without Touchscreen" changed from
>>>>>>   sku5 to sku6) are not typos but simply reflect reality.
>>>>>> - Many revisions of boards here never actually went to consumers, but
>>>>>>   they are still in use within various companies that were involved in
>>>>>>   Chromebook development. Since Chromebooks are developed with an
>>>>>>   "upstream first" methodology, having these revisions supported with
>>>>>>   upstream Linux is important. Making it easy for Chromebooks to be
>>>>>>   developed with an "upstream first" methodology is valuable to the
>>>>>>   upstream community because it improves the quality of upstream and
>>>>>>   gets Chromebooks supported with vanilla upstream faster.
>>>>>>
>>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>>> ---
>>>>>>
>>>>>>  .../devicetree/bindings/arm/qcom.yaml         | 180 ++++++++++++++++++
>>>>>>  1 file changed, 180 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>> index 5c06d1bfc046..399be67eb5d2 100644
>>>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>> @@ -214,11 +214,191 @@ properties:
>>>>>>                - qcom,ipq8074-hk10-c2
>>>>>>            - const: qcom,ipq8074
>>>>>>
>>>>>> +      # Qualcomm Technologies, Inc. SC7180 IDP
>>>>>>        - items:
>>>>>>            - enum:
>>>>>>                - qcom,sc7180-idp
>>>>>>            - const: qcom,sc7180
>>>>>>
>>>>>> +      # Google CoachZ (rev1 - 2)
>>>>>> +      - items:
>>>>>> +          - const: google,coachz-rev1
>>>>>> +          - const: google,coachz-rev2
>>>>>
>>>>> The inverted pattern of old revision being compatible with the new one,
>>>>> is done on purpose? You claim here every rev1 is always compatible with
>>>>> rev2 ...
>>>>>
>>>>> I don't think we discussed such patterns in previous talk. I quickly
>>>>> went through it and there were only skuX moving around, not rev1 being
>>>>> newer then rev2.
>>>
>>> Isn't this what we just had a whole discussion about?
>>>
>>> Oh, I see. You're objecting to the fact that the order here lists
>>> "rev1" first and "rev2" second.
>>>
>>> I think the issue here is that for the purposes of booting Chromebooks
>>> the order here doesn't matter. Certainly we can pick a fixed order and
>>> we can validate that the order in the yaml matches the order in the
>>> device tree, but for all intents and purposes it doesn't matter to
>>> anything. The same device tree is compatible with _both_ rev1 and rev2
>>> coachz devices. Neither of those two devices is inherently better
>>> supported by this device tree than the other.
>>
>> OK, thanks for explanation. Since these were not documented maybe fixing
>> existing DTS to more expected order (rev2 being the newest, rev1
>> following) would make sense. But certainly please use such new order
>> compatibles for new DTSes.
> 
> I'm still not sure I understand: if the list of revisions is
> effectively unordered, why does it matter which order they are listed
> in? Certainly we can change the order, but I'm not sure how I justify
> the extra churn in my patch description.

The list for the bindings (YAML), the toolset and for the Devicetree
spec is ordered. Even if it is not ordered for your bootloader
implementation. Your current order is a bit confusing:

compatible = "google,coachz-rev1", "google,coachz-rev2", "qcom,sc7180";

Changing the order in existing DTS, might not be worth. I propose then
to introduce the logical order in the future, so for new DTS:

compatible = "google,XXX-rev2", "google,XXX-rev1", "qcom,sc7180";

I understood that for your bootloader it does not matter.

Best regards,
Krzysztof
