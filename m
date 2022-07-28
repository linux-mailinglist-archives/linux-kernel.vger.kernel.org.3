Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBDF5839E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiG1H5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiG1H5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:57:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C96172B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:57:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z13so1104210ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1lpMQN88B3GJiLuDJ0ZCgn8SfyC+royPpvqIh61alHY=;
        b=l8d7o8TaFL/tPbUu5FBdD9dqFTXQBVWuDbqwqhRv4bCktfaPXpyNYAKQY7o7pBDMGo
         wvSTjVwJHdZXLeOhR5NANtsqKSqtvO5T198Y6DjUNS43qCC37O7eIR6ycpZBptvm9oL5
         snpGBj0A7u7EKEcsSC48oyvWVIAeHNzBlREpAnwMQn9l/SgWxrDt9guUYUgmuCTp1kpI
         IYclr+hiJZNP5zIQXrnGCFE+35dLiBurj/ZkfpGthjgNX2Z8IhmjXhcBSZL8szt7opSN
         pDhUAMeIzy957JcW1G3D1FWmEDOUbbsm6NTLn/DJ7BlpD+fMDu7Vl81WQFDJ3jbQUkoR
         rQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1lpMQN88B3GJiLuDJ0ZCgn8SfyC+royPpvqIh61alHY=;
        b=w2wS8j1riB/GoyzVzz8mVmwTkoOTH3LMb36VDqg9HgcGrOzEk2zy8VghQNLFMeB6bz
         hbGfH/fOhjXevjuraiHVs1ZO/raP5zy2bejKT6bAi2Mb0hwuEVD4dYljkhTC5iQUU2Rd
         /eGBTkqClHfXSpDvzWb2EPbecsykXuCvU4+pqQgyX6LV8LtKuKBeCKDPDPCXosJCi7gF
         ljYKSxDsd4rM8nApxh8psNp5FaW2s30yetCv+Vq5tQ8um6RRS13sCF+RQqHvZHMZ2CZg
         9Z5LrDrziD5LsLz6uC+Vcs0yXz3htVTcbylYjxOCdX+tUdzWye8YH9qFaGUQFlrfG8LB
         hlaw==
X-Gm-Message-State: AJIora9hxJKExCWMMO8PkS+h/yx7VlWnjowoVWpHdIu8gbG4fMrBbehi
        Ujd3Sq/NjNQPlBF5pMVSVYIBCgwiS02lpQ==
X-Google-Smtp-Source: AGRyM1v5IZ+qzM10/US2RwgKoMfHhbQ3sOL4Qy7Tm8mn8WgQ4RiYm89XEkOk67nUfSlE6qcx9r7n4g==
X-Received: by 2002:a05:651c:218:b0:25e:1b43:9824 with SMTP id y24-20020a05651c021800b0025e1b439824mr3703005ljn.350.1658995024442;
        Thu, 28 Jul 2022 00:57:04 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id b4-20020a05651c032400b0025d3c2e6b8dsm4286716ljp.105.2022.07.28.00.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 00:57:03 -0700 (PDT)
Message-ID: <73392de4-e037-ccc4-b312-77f052c38fa6@linaro.org>
Date:   Thu, 28 Jul 2022 09:57:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
 <922628f6-cbb1-b563-6464-e57959bafbcd@linaro.org>
 <8bb5103d-803e-90d2-fd93-132bb2aac2d6@sifive.com>
 <6317212b-1fca-65b4-9bce-0b9f7408fdae@linaro.org>
 <1d4573fc-407a-13c2-b049-e7a060d7929b@sifive.com>
 <0f5f75c3-269d-a804-7a46-9fa7aec03245@linaro.org>
 <2cd851de-ce7b-5383-a015-101a1ac4a054@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2cd851de-ce7b-5383-a015-101a1ac4a054@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 15:21, Ben Dooks wrote:
> On 27/07/2022 13:02, Krzysztof Kozlowski wrote:
>> On 27/07/2022 12:32, Ben Dooks wrote:
>>> On 26/07/2022 12:05, Krzysztof Kozlowski wrote:
>>>> On 26/07/2022 12:12, Ben Dooks wrote:
>>>>> On 26/07/2022 11:05, Krzysztof Kozlowski wrote:
>>>>>> On 25/07/2022 23:21, Ben Dooks wrote:
>>>>>>> Add documentation for the bindings for Synopsys' DesignWare PWM block
>>>>>>> as we will be adding DT/platform support to the Linux driver soon.
>>>>>>>
>>>>>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>>>>>>> --
>>>>>>
>>>>>> This is not proper delimiter and causes the changelog to end up in commit.
>>>>>>
>>>>>> Correct also wrong formatting of subject PATCH.
>>>>>
>>>>> I realised that once sent and forgot the cover letter.
>>>>> Maybe I'll try some more post covid recovery.
>>>>>
>>>>>>> v2:
>>>>>>> - fix #pwm-cells to be 3
>>>>>>> - fix indentation and ordering issues
>>>>>>> ---
>>>>>>>     .../devicetree/bindings/pwm/snps,pwm.yaml     | 40 +++++++++++++++++++
>>>>>>>     1 file changed, 40 insertions(+)
>>>>>>>     create mode 100644 Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..594085e5e26f
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>>>>> @@ -0,0 +1,40 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>> +# Copyright (C) 2022 SiFive, Inc.
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/pwm/snps,pwm.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: Synopsys PWM controller
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Ben Dooks <ben.dooks@sifive.com>
>>>>>>> +
>>>>>>> +allOf:
>>>>>>> +  - $ref: pwm.yaml#
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    const: snps,pwm
>>>>>>
>>>>>> This is very generic compatible. I doubt that you cover here all
>>>>>> Synopsys PWM designs, past and future. You need a specific compatible.
>>>>>
>>>>>    From what I can get from the documentation (2.13a) there hasn't been
>>>>> a huge external interface change and what has been added is all part
>>>>> of synthesis time options.
>>>>
>>>> But you have some specific version, right? Usually these blocks are
>>>> versioned, so you must include it. I would even argue that such generic
>>>> compatible should not be used as fallback at all, because it is simply
>>>> to generic (PWM is not some model name but common acronym),
>>>
>>> I suppose dw-apb-timers is the actual document name, but that's already
>>> been used for the timer mode in a number of SoCs so probably isn't going
>>> to be useful. dw-apb-timers-pwm might be a better prefix if snps,pwm is
>>> not going to be acceptable. (Yes, the block can be built as either a
>>> PWM or a generic interrupt generating timer at IP generation time)
> 
> The first thing I'd like to get sorted is should we rename this to
> snps,dw-apb-timers-pwm so we can rename the file and the compatible
> that goes with it.

I don't have the datasheets/spec/manual for this, so I have no clue what
is it. I know though that calling it generic "pwm" is a bit too generic.

For example "snps,dw-apb-timer" is not called "snps,timer" but
DesignWare APB Timer.

>>> As for the version numbers, we could have the -v.vv suffix for these
>>> blocks, but the v2.xx log has 22 entries already and only one feature
>>> for programming (which is also a configurable one so can't be just
>>> enabled by default - it's the 0/100 mode flag in the control registers).
>>>
>>> I'm not sure what the v1.xx timers had, but I don't have access to this
>>> information and we're getting these documents as second-generation so I
>>> am not sure if we can get a v1.xx at-all (I suspect this is also going
>>> to have a number of revisions and about 1 useful register api change
>>> which would be the "new mode" double counter method which we currently
>>> rely on having being implicitly enabled by the IP builder (again this
>>> feature is still something that can be configured on IP genaration))
>>
>> But why would you need v1.xx documentation?
> 
> I believe the driver should cover a large part of the v1.xx cores
> as well, we just don't have any documentation for these to verify
> this.

Yeah, but I still don't understand what is the problem to solve in
bindings for that.

>>> Given the configurability of the core, the version numbers might be
>>> usable at some point, but it does seem to be a lot of churn for what
>>> currently can be described by one boolean for the 0/100 feature that
>>> might-be available. Is there a way of saying the compatible string
>>> can be dw-apb-timers-pwm-2.[0-9][0-9][a-z] ?
>>
>> I don't understand why. Aren't you documenting here only v2.13a version?
> 
> The document as-such should cover everything I have a log for, we've not
> had time to test the extension for 0or100% which was introduced in 2.11a
> spec. The earliest history I have is 2.02d. I will go and see if I can
> find someone who can go look for anything earlier.

Several of them might be actually compatible, so you might not need 100
different compatibles. Patterns are not allowed.

I doubt that PWM block is much more complicated than for example DW MAC,
which somehow can exist with few versions defined...

> 
> As a note, it does look like all the v2.xx cores have the IP version
> register in them so we can auto-detect the version from that, at least
> for the DT/platform case.

Auto-detection is then preferred, so just call it -v2.02d which will
cover all known v2 for you and the rest is done via autodetection.

Best regards,
Krzysztof
