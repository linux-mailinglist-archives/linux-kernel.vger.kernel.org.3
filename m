Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D123D582460
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiG0KcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiG0KcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:32:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12343E49
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:32:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso770498wmm.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KF5uYYuW8cxuLLmsc44dNIhEgku8IG2mFelPwjuqW9k=;
        b=kSgPrO66VNp9uxBdfc2Eourw4cX9CrZfWDmJvsq1B4hColf78QJMF9RXXcIbtmk3bZ
         ZgXGQfbfynWmyuS2CVe98YILXdOt6sE4B8OALkLH91bNapoBJObJLFuJOIAOJzIkqc0m
         OfiFUjyb81WRC+0uVVuuGSEb9pNvEbLbGYqBC27xD+Q3vUyLeVThAZYvuhlFLL0fIQwY
         uxA57eeRYkJkPRGNzF6vz/GTAFKV/nqEdNy2AFVstBq9k8qct20SUhsZpjxYOlonNtMR
         SAyzba1oPkiB+5g/qHX2Ji1SxEFdlBkRRAv63IWS926w6ghqyafneoP3fAKV1UbECQ+f
         LpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KF5uYYuW8cxuLLmsc44dNIhEgku8IG2mFelPwjuqW9k=;
        b=y4ghgn5ucS16gZEvfuOf4wEhPxwXX9DxVK6jrnZJJKrol0ItCvDumNKUmCMz7jATqa
         IAtUqp/nkaKzl03mxXasKFdiLbAYiGMGa0Fwm2qI80zxMMKgdH1VloPw7T4gW/6m0Xxx
         prfSdYwuung8iHSb83R0uPQGTpZ+iR6v0jTeJAeI6KuQhol0cc93+JMbEBsaSdOAWRTs
         4GAgpYNRVe9Wk6tmUOus5rtjcsYiiC0hYavEfzdKIeMDGJxOAt6pdhEuiNbArCPCYZBy
         UifsiLfBeJgNWC4+rs5cLuahLT/QFgCxKhNWqDFmwyOy5GVxz/Rkby7LbfBwN//TZhLT
         b0zw==
X-Gm-Message-State: AJIora9pLPjNT8+D9fILvpi3Cim4MzocN/neWj/qYDjcwyCAzbl07+Gr
        w6iKGNIxcDjh9D3aHO9O9/BAiA==
X-Google-Smtp-Source: AGRyM1sBceEVCYrz7G9ieJ2YXza7FBRyLu2iZ9/nRQjtxtByTph6/cZBponIXeyHZNRSUpMil3ZQIg==
X-Received: by 2002:a05:600c:3ba3:b0:3a3:5dd:f10f with SMTP id n35-20020a05600c3ba300b003a305ddf10fmr2554827wms.185.1658917923420;
        Wed, 27 Jul 2022 03:32:03 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b0021d70a871cbsm16828378wrt.32.2022.07.27.03.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:32:03 -0700 (PDT)
Message-ID: <1d4573fc-407a-13c2-b049-e7a060d7929b@sifive.com>
Date:   Wed, 27 Jul 2022 11:32:01 +0100
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

I suppose dw-apb-timers is the actual document name, but that's already
been used for the timer mode in a number of SoCs so probably isn't going
to be useful. dw-apb-timers-pwm might be a better prefix if snps,pwm is
not going to be acceptable. (Yes, the block can be built as either a
PWM or a generic interrupt generating timer at IP generation time)

As for the version numbers, we could have the -v.vv suffix for these
blocks, but the v2.xx log has 22 entries already and only one feature
for programming (which is also a configurable one so can't be just
enabled by default - it's the 0/100 mode flag in the control registers).

I'm not sure what the v1.xx timers had, but I don't have access to this
information and we're getting these documents as second-generation so I
am not sure if we can get a v1.xx at-all (I suspect this is also going
to have a number of revisions and about 1 useful register api change
which would be the "new mode" double counter method which we currently
rely on having being implicitly enabled by the IP builder (again this
feature is still something that can be configured on IP genaration))

Given the configurability of the core, the version numbers might be
usable at some point, but it does seem to be a lot of churn for what
currently can be described by one boolean for the 0/100 feature that
might-be available. Is there a way of saying the compatible string
can be dw-apb-timers-pwm-2.[0-9][0-9][a-z] ?


