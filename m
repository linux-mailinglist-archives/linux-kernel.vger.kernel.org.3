Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9D534AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbiEZHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiEZHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:33:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307692D34;
        Thu, 26 May 2022 00:33:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 2F73A1F451F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653550390;
        bh=XBjRr4zV7iqDwsqd8+WLNul7+0XXrRR/5iyVy4RBtnQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VtmF5DhwKEE20g/IthAnqzs2a7+lBZ5pXA4i2d+al5SLa2MWVjx0sTNVDrRnJGBV1
         rCpUwGJCngiKgle9iQ9+T3jt6aUn1lulMYNBHMv3QdSOpWV0coo+ITDLmlg4/IMpCP
         fSSXC2uagn8+KwvnJV4j/0bI2DsNONy48Akxnwai/xpTc+Ixzd7Muhkgz7XnjZ+a1/
         FNKjmpTZPdkJu7sgjdeYXby57hC0HOWJVX4TaMSCSiCEbv+Pa387PBaxi/HMUWQB/3
         FwgL315QLVU1uAgjz+fecawbHrpNavf+p2OUaKtOZyABrIX8Qaid7dabpP56kflXAq
         PxbdPorVN8Osg==
Message-ID: <507d7711-3755-1a2e-473d-3c1c9e23563d@collabora.com>
Date:   Thu, 26 May 2022 13:03:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as
 deprecated vendor prefix
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, lars@metafoo.de, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-2-shreeya.patel@collabora.com>
 <20220516170058.GA2825626-robh@kernel.org>
 <83907dd2-2a53-2448-576b-ae26462d432a@collabora.com>
 <20220518163255.GE3302100-robh@kernel.org>
 <f37bccaf-233c-a244-3d81-849a988b1a92@collabora.com>
 <20220524154703.GD3730540-robh@kernel.org>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20220524154703.GD3730540-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/22 21:17, Rob Herring wrote:
> On Mon, May 23, 2022 at 08:27:56PM +0530, Shreeya Patel wrote:
>> On 18/05/22 22:02, Rob Herring wrote:
>>> On Tue, May 17, 2022 at 04:07:33PM +0530, Shreeya Patel wrote:
>>>> On 16/05/22 22:30, Rob Herring wrote:
>>>>> On Wed, May 11, 2022 at 03:10:22PM +0530, Shreeya Patel wrote:
>>>>>> 'liteon' is the correct vendor prefix for devices released by
>>>>>> LITE-ON Technology Corp. But one of the released device which uses
>>>>>> ltr216a light sensor exposes the vendor prefix name as 'ltr' through
>>>>>> ACPI.
>>>>> ACPI? NAK.
>>>>>
>>>>> There are no cases of 'ltr' for DT, so fix ACPI.
>>>> Hi Rob,
>>>>
>>>> Yes, we understand there are no cases of 'ltr', but we have released devices
>>>> which uses this string for probing the ltrf216a light sensor driver ( x86
>>>> with DT )
>>> That's not what your commit message says.
>>>
>>> Even if this is DT based, given an undocumented vendor string is used,
>>> it seems doubtful the rest of the binding would match upstream. What
>>> about the rest of the DTB? Got a pointer to it or want to publish it?
>>>
>>>> If we don't document this in vendor-prefixes.yaml, then the following
>>>> warning
>>>> is generated.
>>>>
>>>> WARNING: DT compatible string vendor "ltr" appears un-documented -- check
>>>> ./Documentation/devicetree/bindings/vendor-prefixes.yaml 364: FILE:
>>>> drivers/iio/light/ltrf216a.c:313: + { .compatible = "ltr,ltrf216a" },
>>>>
>>>>
>>>> Can you suggest us what would be the right way to fix this warning if not
>>>> documenting
>>>> in vendor-prefixes.yaml?
>>> Fix the DT. We don't accept bindings simply because they are already
>>> used in the field. If this was the only issue, it would be fine, but I
>>> suspect it's the tip of the iceberg.
>>
>> Hi Rob,
>>
>> To make things more clear, following is the modalias info of the device.
>>
>> (B+)(root@linux iio:device0)# cat
>> /sys/bus/i2c/devices/i2c-PRP0001\:01/modalias
>> of:NltrfTCltr,ltrf216a
>>
>> It's a dt namespace on an ACPI based device. We used an of_device_id table
>> to be able to probe the driver
>> using the vendor prefix and compatible string.
> Again, it's ACPI so I don't care. If someone cares about using DT
> bindings in ACPI they can step up and help maintain them. It's not a DT
> vs. ACPI thing, but just that I can only maintain so much and have to
> draw the line somewhere.
>
>> But when we compile the driver, we get the following warning and hence we
>> documented it in vendor-prefixes.yaml
>> and also added a complete device tree file [Patch 3/3] just to get rid of
>> the warning. In real life we are not using
>> the device tree file at all.
>>
>> WARNING: DT compatible string vendor "ltr" appears un-documented -- check
>> ./Documentation/devicetree/bindings/vendor-prefixes.yaml 364: FILE:
>> drivers/iio/light/ltrf216a.c:313: + { .compatible = "ltr,ltrf216a" },
> So, is someone telling you to fix this?


So will it be right to just keep the warning and remove this patch?
Is there a way you know to silent this warning?


Thanks,
Shreeya Patel

>
>
>> There are many existing devices used by people which has the vendor prefix
>> name as 'ltr'
>> and it won't be possible to change that hence we are trying to upstream it.
> There are millions if not billions of DT based devices using
> undocumented bindings. If those used "ltr,ltrf216a", I wouldn't accept
> it either.
>
> Rob
>
