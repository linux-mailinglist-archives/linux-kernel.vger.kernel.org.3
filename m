Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9E527DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiEPGkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiEPGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:40:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4DDEB9
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:40:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d15so24059768lfk.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IezA8lFbZ3UBxt9oqnYwi09cIkKPiUW4FFJ1P5l8/O0=;
        b=I0O/pU6cY2spaVMFaJQg1irJ6isUwl5e5ClKCDBGbpiUdQzS1pP3ncibY1xLbZZETg
         vBW9p6Lpd+BtpNrqDG4mJ21n/B4zxxmO/6LHl1VmKb1PbeGm2SVTWk0dhxmNXIFEj8Il
         SeR18wyfnPf0rXsq3QP3qHtY/aFEUoVlh4TCorcawpqxJlgXDwV5VDjOZuJzzfhqt6nV
         BE4VwRhX4due6MEXRw9QYGdIsJ6Dh2eKZCZxR0DKwEB04NNOhHj3ALqp+QnSjUmFEE12
         y7FD12UQKOA4t9UHw5P0k+2a+g64QrNf69Qa74FVbltOzwKxd077dhAAKIunNPpAE58z
         ut2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IezA8lFbZ3UBxt9oqnYwi09cIkKPiUW4FFJ1P5l8/O0=;
        b=NjHa6j4Nrah9xhDhDqtJJTx0Jpe6plL7vccsTlQ0oHN1pOk/LJ82wyaPjVRbtRl+gx
         rpCeIr0V6Mwqn5e07djoF0OH7mnYZ7jarYQ1YwcaxmhfF2f2ra1wqFaoYIF7SOrAyVlF
         66hrBqXsGuoI4hAQAZomf2tzDDlGTN+wIQje/T407pfbkB0u6LmhJU6oMFGqTI+Ff0MT
         4mY0eqltQ8zAl/eDkC+6SYvHk7nNNdzC1bq1xVQ4erwM5hoinC843xXWSx3Gv9mr+j+Z
         JgJA9hPzapj0uKK2kWkteaaz+6C/wiWIaGaRTJJETcF7fBMr4M3++ipBIL/eIorvD0iD
         CZCQ==
X-Gm-Message-State: AOAM533vg3W4+new+EE1misdrknfbP+CfkCSOeTHoGZkBTbyBqp0ffH2
        IHUuXJKpqh00CX5mIdEf3Bzeyg==
X-Google-Smtp-Source: ABdhPJwI3h/Hpn4jlgzq0+4Ulqw991mhhdevbVWHgRGyPrbW/AO6bgZHqym+63dMwfGIhekMCGcUmQ==
X-Received: by 2002:a19:4348:0:b0:474:d376:45f3 with SMTP id m8-20020a194348000000b00474d37645f3mr11802453lfj.405.1652683242793;
        Sun, 15 May 2022 23:40:42 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f13-20020a2eb5ad000000b0024f3d1daedfsm1398118ljn.103.2022.05.15.23.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 23:40:42 -0700 (PDT)
Message-ID: <96686d6d-83a9-05a2-9fdc-f9fc4b4e7eed@linaro.org>
Date:   Mon, 16 May 2022 08:40:41 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WNSv+kgTZwjHVq+YNQAG0uB42QUPaU-BPTV_W+j=5aYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 19:00, Doug Anderson wrote:
> Hi,
> 
> On Fri, May 13, 2022 at 2:01 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/05/2022 09:57, Krzysztof Kozlowski wrote:
>>> On 12/05/2022 18:04, Douglas Anderson wrote:
>>>> This copy-pastes compatibles from sc7180-based boards from the device
>>>> trees to the yaml file so that `make dtbs_check` will be happy.
>>>>
>>>> NOTES:
>>>> - I make no attempt to try to share an "item" for all sc7180 based
>>>>   Chromebooks. Because of the revision matching scheme used by the
>>>>   Chromebook bootloader, at times we need a different number of
>>>>   revisions listed.
>>>> - Some of the odd entries in here (like google,homestar-rev23 or the
>>>>   fact that "Google Lazor Limozeen without Touchscreen" changed from
>>>>   sku5 to sku6) are not typos but simply reflect reality.
>>>> - Many revisions of boards here never actually went to consumers, but
>>>>   they are still in use within various companies that were involved in
>>>>   Chromebook development. Since Chromebooks are developed with an
>>>>   "upstream first" methodology, having these revisions supported with
>>>>   upstream Linux is important. Making it easy for Chromebooks to be
>>>>   developed with an "upstream first" methodology is valuable to the
>>>>   upstream community because it improves the quality of upstream and
>>>>   gets Chromebooks supported with vanilla upstream faster.
>>>>
>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>> ---
>>>>
>>>>  .../devicetree/bindings/arm/qcom.yaml         | 180 ++++++++++++++++++
>>>>  1 file changed, 180 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> index 5c06d1bfc046..399be67eb5d2 100644
>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> @@ -214,11 +214,191 @@ properties:
>>>>                - qcom,ipq8074-hk10-c2
>>>>            - const: qcom,ipq8074
>>>>
>>>> +      # Qualcomm Technologies, Inc. SC7180 IDP
>>>>        - items:
>>>>            - enum:
>>>>                - qcom,sc7180-idp
>>>>            - const: qcom,sc7180
>>>>
>>>> +      # Google CoachZ (rev1 - 2)
>>>> +      - items:
>>>> +          - const: google,coachz-rev1
>>>> +          - const: google,coachz-rev2
>>>
>>> The inverted pattern of old revision being compatible with the new one,
>>> is done on purpose? You claim here every rev1 is always compatible with
>>> rev2 ...
>>>
>>> I don't think we discussed such patterns in previous talk. I quickly
>>> went through it and there were only skuX moving around, not rev1 being
>>> newer then rev2.
> 
> Isn't this what we just had a whole discussion about?
> 
> Oh, I see. You're objecting to the fact that the order here lists
> "rev1" first and "rev2" second.
> 
> I think the issue here is that for the purposes of booting Chromebooks
> the order here doesn't matter. Certainly we can pick a fixed order and
> we can validate that the order in the yaml matches the order in the
> device tree, but for all intents and purposes it doesn't matter to
> anything. The same device tree is compatible with _both_ rev1 and rev2
> coachz devices. Neither of those two devices is inherently better
> supported by this device tree than the other.

OK, thanks for explanation. Since these were not documented maybe fixing
existing DTS to more expected order (rev2 being the newest, rev1
following) would make sense. But certainly please use such new order
compatibles for new DTSes.

> 
> We can reorder them if it's important for some reason, but it doesn't
> change the facts of the matter. You can't tell whether you've booted a
> "-rev1" Chromebook or a "-rev2" Chromebook based on the most specific
> compatible string.

Of course you cannot, because DT is not for such case (when you can use
different DT for booting on different hardware...)

> 
> As per the other discussion, we could "solve" this by making two
> device trees that were exactly the same but one of them had the
> compatible "-rev1" the other "-rev2". This would result in a big
> explosion in the number of device trees in our FIT Image for very
> little gain. It also fails to solve the "newest rev" problem.
> 
> 
> OK, so I've written up a description of the whole system. Maybe it
> will be clearer with that and we can continue the discussion in my v2
> if needed.
> 
> https://lore.kernel.org/r/20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid
> 
> -Doug


Best regards,
Krzysztof
