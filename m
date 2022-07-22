Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01A257E58A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbiGVR0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiGVR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:26:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90771BE1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:26:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z25so8743772lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qoN3gDHWVDLFAUm42xgoSLsUq4+PL4CyeQJ0bjtEpCU=;
        b=ve4ktK15OM0pfiMIrqujRlezfMGvsEQ5YAqFux57vtJ3J20/mY8UAzgLg0HYm9+N0u
         47DSWQ4U+8NAqESzQcHSEuXsrh6z6hFoIIPVXAOnzYapERTRn/arZX134XW7HojrduPm
         j3aXxulLfoKC9EnQf91v4gAF1rFUJQAjANXYapg0REhSI+MckWQA7/YSXRscN2wXptKX
         I7VUzN7iixc9WPegThHkQErY2lzuneQJ3ooy9JDLp5aHN9CgJKLQ3hjPNRRjtMxdfWqD
         K/MvnpJlCBOquEp1u040AFUgxkZYV2LyqvPkfJvlLsA/1A7kHv2pilYQSS9CZfLHy5uW
         paeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qoN3gDHWVDLFAUm42xgoSLsUq4+PL4CyeQJ0bjtEpCU=;
        b=yAbXwXz+V7o0WnMTps5+SOVjTTUDQFdt9DaxknXEh44pBn2iAeipaYUcLidJHmb+Qs
         8AKrNhm/2B4khgc6NO9uXKfQcnKKb6PcuikoTavTzyvM7pxZOQFTsjHrDq5m+f6ccFYt
         DQ1D8/jWfje7JuhYRpM33SvkHuYk+/NixqocKwoonI6agTGGoS5S0M2CGDVmYXojjpHG
         WmfHu6nUQfkFM/+57jYywk/AuPBHtXpnODy6Mb7qYYMehApRVqB26dk55NZg0GDe3hKe
         dROZojKi7FasyE+g8mwojqrYYj4or0OlYHtAe3UMMl9kp4EKuFBS9Co2J3GIruc3CDhA
         mMew==
X-Gm-Message-State: AJIora+xdHj85TCpm83WEeQx9n4K2FH/6Ipxj90a98xWw0niGaW4HyJP
        +KAFISVV1ff8F+2zp/3RF4nuhg==
X-Google-Smtp-Source: AGRyM1tWDz3YFjB2oREEYfHT63bgnHfvazVkGCurcjXwv9zhQAkymmmPouZ7MaolfC9GM8Hvk+Iykw==
X-Received: by 2002:ac2:5989:0:b0:48a:74a6:8658 with SMTP id w9-20020ac25989000000b0048a74a68658mr384428lfn.660.1658510797594;
        Fri, 22 Jul 2022 10:26:37 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id k12-20020a2eb74c000000b0025d40241c1dsm1252846ljo.6.2022.07.22.10.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:26:37 -0700 (PDT)
Message-ID: <9b6b5e2a-a78d-9aac-5eca-e8231ba6db55@linaro.org>
Date:   Fri, 22 Jul 2022 19:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: qcom: Document additional sku6
 for sc7180 pazquel
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
 <20220721033918.v3.2.I7ecbb7eeb58c5e6a33e32a3abf4d6874e6cb725c@changeid>
 <CAD=FV=WSBgupLFMCZgianck6uTkAyqrG0WK2ChSbNbJdhOPdLA@mail.gmail.com>
 <4b2fe9d0-f590-0fac-79fa-bb05da1d61df@linaro.org>
 <CAD=FV=XmaNdc9k98vAwbcN-sm0w_WeqhRsK_AUm3h4LZ5-egmQ@mail.gmail.com>
 <c2b03863-2249-13e6-98e0-731c1b40d0a9@linaro.org>
 <CAD=FV=XKC_fbBzna8TgiPRmPH_=AQ3ckv2EEjoNvayKQ83Uciw@mail.gmail.com>
 <8a4999b9-862e-f698-28b9-42d26f680367@linaro.org>
 <CAD=FV=XBCC6HwUzKJ51LBkfWpXcbY9QepVZfNzQJp3qADzkkQg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=XBCC6HwUzKJ51LBkfWpXcbY9QepVZfNzQJp3qADzkkQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 19:23, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jul 22, 2022 at 10:14 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/07/2022 20:29, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Jul 21, 2022 at 9:52 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 21/07/2022 18:43, Doug Anderson wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Jul 21, 2022 at 9:33 AM Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 21/07/2022 15:37, Doug Anderson wrote:
>>>>>>>
>>>>>>> Not worth sending a new version for, but normally I expect the
>>>>>>> bindings to be patch #1 and the dts change to be patch #2. In any
>>>>>>> case:
>>>>>>>
>>>>>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>>>>
>>>>>> I would say worth v4, because otherwise patches is not bisectable.
>>>>>
>>>>> You're saying because `dtbs_check` will fail between the two?
>>>>
>>>> Yes
>>>
>>> OK. Then I assume you agree that reversing the order of the patches
>>> won't help, only combining the two patches into one.
>>>
>>>
>>>>> How does
>>>>> flipping the order help? If `dtbs_check` needs to be bisectable then
>>>>> these two need to be one patch, but I was always under the impression
>>>>> that we wanted bindings patches separate from dts patches.
>>>>
>>>> I don't think anyone said that bindings patches must be separate from
>>>> DTS. The only restriction is DTS cannot go with drivers.
>>>
>>> I have always heard that best practice is to have bindings in a patch
>>> by themselves.
>>
>> Yes, bindings must be separate patch, no one here objects this. You said
>> they cannot go together via one maintainer tree or I misunderstood?
>>
>>> If I've misunderstood and/or folks have changed their
>>> minds, that's fine, but historically I've been told to keep them
>>> separate.
>>
>> Nothing changed. Bindings must be separate. They will be applied by
>> maintainer and, if correctly ordered, this is bisectable.
> 
> OK, I think this is the disconnect here.
> 
> No matter what order Jimmy's patches land in, it won't be bisectable
> from the standpoint of "make dtbs_check". This is what I've been
> trying to say.
> 
> * If the bindings land first then the device tree won't have sku6 and
> will fail "make dtbs_check"
> 
> * If the dts lands first then the bindings won't have sku6 and will
> fail "make dtbs_check".
> 
> Am I missing something?

Ah, you're right... The patch changes the bindings of a board instead of
bringing a new variant. Yeah, this cannot be bisectable if kept
separate, thus order does no matter.

> 
> So when you said "I don't think anyone said that bindings patches must
> be separate from DTS" and that you cared about "make dtbs_check" being
> bisectable that you were saying you wanted these squashed into one
> patch. I guess that's not the case.
>

Best regards,
Krzysztof
