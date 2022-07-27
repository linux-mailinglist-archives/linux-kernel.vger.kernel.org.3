Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839B35824B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiG0KpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiG0KpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:45:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F9474C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:45:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h8so23587083wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5oVqAH+iWelszybMh6Ae4+JTub68D8khqQAfrWm+UrY=;
        b=Vf9pdSjZMg3SLJ19yGuuiHBu8f0Z4m7f640uGxbOjb43MhHIpy3Z7mK4GKres7Ordp
         SpllByUGC+tfiiifjsPpQpw2mF7ycjBIZikMFCnyNcASVp3GXdmLo9rBbu18erzVq18v
         Uq7SPPy9krm2n8atNNVDbhZ87Gx6RlMJDlKIAWHmipUqu84MC+GBBWrH3AhnWIpVMkye
         H2JlPBYgPFlyqHlSdraDF7pQlQzaNRup4ernzsPFtQ9iDUDYxLIH8BEFFq+9on8/jrxO
         Rvvdsl2r9+9u3UbXW197Xm3br5AwXHApHvDIubYmQuxdVNhn73VuAV7aQUziKTSWxRx/
         Hs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5oVqAH+iWelszybMh6Ae4+JTub68D8khqQAfrWm+UrY=;
        b=hOGI1MHNVG5smlO+LhF6fBNPyFOZGKEf2a8OJz0UzkKa4uWxgKPso+VqgbT1CDyyjO
         ES0a4WAXEanQJbd5vqz7m4JnD7Cdi/74pbAEPLqwEuHM25WqL4ORIyqLJw35wc6yjXU1
         TwASX0Xpy8sax5vTBVXwWz6yGZHv7mEv90PI/PsqyYxu+NS9okfEJMQkpUVwclgPTyv7
         3lS6INqCG6lxQQIqEaj+X6O7ZBVaM2Ktp0tsyIgFCqFCZeXdHV2ePooK005ocMHQVim7
         vr7bwqVFuc9lXaDTuQv9m1/JIhP/lnWyB8KRnqqvleLQsboY8DhPIeCxvT6uLxolEQn5
         93YA==
X-Gm-Message-State: AJIora/3uU0idZHBP8RxVneJdFxZEM/IGeDeBSLV+9tWCSbsrHqMYNwJ
        W/M7UR4+rqYVogTfcNuudDHzrw==
X-Google-Smtp-Source: AGRyM1uGCOaeaXOdwirAYekuOB4Lxs31AWSF1L9awJK4JKpctBf/cT7K9dLT9+RwDmyqaDaxZr91vA==
X-Received: by 2002:a05:6000:1848:b0:21e:8fa5:e5f4 with SMTP id c8-20020a056000184800b0021e8fa5e5f4mr7738882wri.691.1658918703770;
        Wed, 27 Jul 2022 03:45:03 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc003000000b003a2e7c13a3asm1877429wmb.42.2022.07.27.03.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:45:03 -0700 (PDT)
Message-ID: <d335c1a6-ad45-994c-053f-32cdfa4cab8d@sifive.com>
Date:   Wed, 27 Jul 2022 11:45:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org
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
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <6317212b-1fca-65b4-9bce-0b9f7408fdae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/07/2022 12:05, Krzysztof Kozlowski wrote:
> On 26/07/2022 12:12, Ben Dooks wrote:
>> On 26/07/2022 11:05, Krzysztof Kozlowski wrote:
>>> On 25/07/2022 23:21, Ben Dooks wrote:
>>>> Add documentation for the bindings for Synopsys' DesignWare PWM block
>>>> as we will be adding DT/platform support to the Linux driver soon.
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>>>> --
>>>
>>> This is not proper delimiter and causes the changelog to end up in commit.
>>>
>>> Correct also wrong formatting of subject PATCH.
>>
>> I realised that once sent and forgot the cover letter.
>> Maybe I'll try some more post covid recovery.
>>
>>>> v2:
>>>> - fix #pwm-cells to be 3
>>>> - fix indentation and ordering issues
>>>> ---
>>>>    .../devicetree/bindings/pwm/snps,pwm.yaml     | 40 +++++++++++++++++++
>>>>    1 file changed, 40 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>> new file mode 100644
>>>> index 000000000000..594085e5e26f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>> @@ -0,0 +1,40 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright (C) 2022 SiFive, Inc.
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/pwm/snps,pwm.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Synopsys PWM controller
>>>> +
>>>> +maintainers:
>>>> +  - Ben Dooks <ben.dooks@sifive.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: pwm.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: snps,pwm
>>>
>>> This is very generic compatible. I doubt that you cover here all
>>> Synopsys PWM designs, past and future. You need a specific compatible.
>>
>>   From what I can get from the documentation (2.13a) there hasn't been
>> a huge external interface change and what has been added is all part
>> of synthesis time options.
> 
> But you have some specific version, right? Usually these blocks are
> versioned, so you must include it. I would even argue that such generic
> compatible should not be used as fallback at all, because it is simply
> to generic (PWM is not some model name but common acronym),

Thank you for the feedback, forgot to say that on the original reply.

-- 
Ben

