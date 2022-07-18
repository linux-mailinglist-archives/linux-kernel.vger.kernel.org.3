Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C8B577C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiGRHS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiGRHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:18:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0392611804
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:18:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v16so15665911wrd.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gW4rCz2Fitz5o6DAUQMXkszJ5QgTwpkr1x/wG9fwwys=;
        b=WAfdEbULVsF5Oo7vSbNU8BB24raJXDQHcwUNULmxYsyUjA+q0FFnge4ehvHxoU9urU
         HzjuUBe8R/xL3MgwxR2IevPYimacvL8XuQompMyWgX0ATptMMfS6+c8ze/WIf8Jx+pL4
         iTtNK8vAPgNglwypSrHB+YpmYcIxS8gDOOH7WULeskhAMDiQTmtldoTdOQquoYqOwJK4
         DHVkFlWIFZRZN2Q8jZnC/7BDyjxewn4//sp/grS5mRj1QEYwpGCYCaweiCo+AoeGMNYS
         iJSVGdOznd3znMCqvOaPAZtgidh7T24R3ZMQ3D8naib1g+Ht/kQ8Ul9L9KPCKTkG+Jkf
         tZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gW4rCz2Fitz5o6DAUQMXkszJ5QgTwpkr1x/wG9fwwys=;
        b=2Q3crOimHc7Jq7gVnskYM0EyX+nZ6KcaCc8Jt36bU/D2PJEs2yBtDd1EHQKfxFdSFR
         u9sYfvjoLYJmbefDfV9W+M/z7KB8l4P1B60TNbuKvNXZQMwXfpWIcG9iuPmk3d2q7N4P
         4unDcuMis3yxUsdBDJvoxQE6nmtWxUL3F5+7ceqEoRlqMLO5h5L82U4FzMkIYTwKwLMy
         O+4QjPvcVU5R2c504jAygGps8H8Fq8KlaDcu1CwRQfanzW/eKX9KdXi7eKucs87CAvx6
         dplwJCRubfx4siW3R6Rwqqk00ogGw6Ih/9gxILK5m816CYvs2GnxogNj/qVRYBrrhN7F
         JWwg==
X-Gm-Message-State: AJIora9SAtucDxG8Z1CDTF2190Oc7lXb3WbtFF590pvc9xv1TwBiNvJj
        E9+QsqE+spryQ+6i0k3+ARj9UA==
X-Google-Smtp-Source: AGRyM1t+UYLA0q90Sx0OLpN5vQr5rFVtNKJ4KmLAjLMTXPex06QR2HLZKDt4VaOjk1Ct9sezG3ASHA==
X-Received: by 2002:a5d:4750:0:b0:21e:375:2825 with SMTP id o16-20020a5d4750000000b0021e03752825mr6200608wrs.42.1658128704615;
        Mon, 18 Jul 2022 00:18:24 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4ccc000000b0021d6e758752sm10075729wrt.24.2022.07.18.00.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 00:18:24 -0700 (PDT)
Message-ID: <869e52f5-e1bd-4d40-1ba8-a467a852c3ec@sifive.com>
Date:   Mon, 18 Jul 2022 08:18:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <20220712221715.GT1823936-robh@kernel.org>
 <feaacf44-f9a8-b892-d8ba-8a396b49d56b@sifive.com>
 <20220713135230.gjbd3v6iih2uicpu@pengutronix.de>
 <7999fec2-847a-86ce-ed78-d2a9008bf654@sifive.com>
 <20220713150755.bimcq2yiuvxn6n6v@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220713150755.bimcq2yiuvxn6n6v@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 16:07, Uwe Kleine-König wrote:
> On Wed, Jul 13, 2022 at 03:30:07PM +0100, Ben Dooks wrote:
>> On 13/07/2022 14:52, Uwe Kleine-König wrote:
>>> On Wed, Jul 13, 2022 at 12:56:55PM +0100, Ben Dooks wrote:
>>>> On 12/07/2022 23:17, Rob Herring wrote:
>>>>> On Tue, Jul 12, 2022 at 11:01:09AM +0100, Ben Dooks wrote:
>>>>>> The dwc pwm controller can be used in non-PCI systems, so allow
>>>>>> either platform or OF based probing.
>>>>>>
>>>>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>>
>> [snip]
>>
>>>>>> +properties:
>>>>>> +  "#pwm-cells":
>>>>>> +    description: |
>>>>>> +      See pwm.yaml in this directory for a description of the cells format.
>>>>>
>>>>> pwm.yaml doesn't define how many cells. You need to. And you don't need
>>>>> generic descriptions.
>>>>
>>>>    "#pwm-cells":
>>>>       const: 1
>>>>
>>>> should be sufficient then?
>>>
>>> I would expect a value of (at least) 2 or (better) 3.
>>
>> OOPS, forgot the phandle.
>>
>> I will have to check if we have any support yet for dealing
>> with any of the pwm flags yet.
> 
> I didn't double check, but given that the driver only supports inversed
> polarity it might not even work without passing the flag for inversed
> polarity. Having said that, I expect you have to only add "#pwm-cells =
> <3>;" to your dts and then everything should work just fine.

I've gone back over the documentation we have for the block, and it
should have a count for high and a count for low in the PWM mode the
driver puts it into. I have no idea /why/ the driver is reporting it
as inversed, unless the PCI version has this automatically set....

I will go back and talk with the engineer who did the testing of the
PWM to get the test-bench re-set and check this, however my expectation
is we could easily do both and for the of/plat case we should just
report normal polarity (and we could deal with the inversed by simply
swapping the low and high values).

I also noted the v2 block supports 0 and 100% by setting a bit in the
control and the timers to a given value, so that can also be added to
the series (although this requires an IP generation option to be
set) which we can also add.

Thnak you for pointing this out, hopefully we can have this sorted
today and if so we will need to change this to a range of 2..3 for
the PWM cells.


> Best regards
> Uwe
> 

