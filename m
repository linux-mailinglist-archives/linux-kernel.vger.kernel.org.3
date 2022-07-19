Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0957940D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiGSHWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiGSHWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:22:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7C3207A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:22:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z13so661605wro.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zhZx7OelFktddqeuw5G8PgvrBIH+jYWzqpM0BySOSho=;
        b=jHwP4d8nPt5m3OcG9yygEJvr3q4paVLcrXvrPkHX+dNeG1La0W38p54fQvK9useFj6
         K10OGAWmVX+PF8YBZZyY5C6rjsoY+WBDDFMXtTtwCB0EiW7I1z/07kcUG3WY4LcdhOoC
         4xp7QbrtqlZOYOu9smorDW68ehKkUi8cSl6FlzVQn+It2SPxDhOdzUpwHqOxxlRzbLr5
         khqoa3oSaJOXDFvkSUVmvBC2NEADAduVoleA0tb+ZI3dq17VLzoVVS0mpsNV4GnbGRI2
         UDTgiFZ5rs9wN4PSwImYHipQ0T3zbcSSS43vLRrD8v/eFUCSYVf2VfT4kVPca8EjHSCX
         0JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zhZx7OelFktddqeuw5G8PgvrBIH+jYWzqpM0BySOSho=;
        b=CnujqenIc6CSRKe2OEpLgORImRPVUoptJAxfPZK7lS7z2YRWaH5hkYjGW/iIE7nvhc
         H/SBXjzXSXX+EAJFv8KfhJlYKMP0LytnsIeUA5Ot3WOSm6ijJVoNeLMG1nRNrocDTArx
         k+snibRx4nFLTtHbG/bmKAmYSOZsR5BfUNw5e07PnRPPDG5NBXfuin1m8lldRJ9A3K1i
         nhFwl5pBZaKsCcio03VuaLFkpbm09rrqBV2Pi/AvuSb99OevJ8Qg1+8KjczISap3Y3TO
         x9waB+0b39rPzkUGXSD2cdx3+A9kBk9JYfB5WpgyBXmBYTpJ/xrKLhOylO/W3wMVeVyC
         mHog==
X-Gm-Message-State: AJIora/HjSkun4SXdjmj9SrgqwObd3xvBjSfBPHNotcw/yei/Xoi4oMC
        XCEKRH6Ugx5/X/HKB+amq61zJw==
X-Google-Smtp-Source: AGRyM1txegwX6PPB6J4yWQk8XjE3s0d4QXmt0iUioRmC+ZAaCuKV2FCUQYXYXT5kwow3JR5z+bvdNg==
X-Received: by 2002:adf:e28a:0:b0:210:b31:722 with SMTP id v10-20020adfe28a000000b002100b310722mr25735689wri.65.1658215325276;
        Tue, 19 Jul 2022 00:22:05 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e? ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.googlemail.com with ESMTPSA id az36-20020a05600c602400b003a31ba538c2sm6018930wmb.40.2022.07.19.00.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:22:04 -0700 (PDT)
Message-ID: <c0d3e523-d75a-d837-313f-bf46f3fab3b4@linaro.org>
Date:   Tue, 19 Jul 2022 09:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
 <20220715210911.714479-3-daniel.lezcano@linaro.org>
 <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
 <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org>
 <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
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

On 19/07/2022 03:14, Zhang Rui wrote:
> On Mon, 2022-07-18 at 15:21 +0200, Daniel Lezcano wrote:
>>
>> Hi Zhang,
>>
>> thanks for the review
>>
>> On 18/07/2022 07:28, Zhang Rui wrote:
>>> On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
>>
>> [ ... ]
>>
>>>> Instead of taking the risk of breaking the existing platforms,
>>>> use an
>>>> array of temperature ordered trip identifiers and make it
>>>> available
>>>> for the code needing to browse the trip points in an ordered way.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>
>> [ ... ]
>>
>>>> +static void sort_trips_indexes(struct thermal_zone_device *tz)
>>>> +{
>>>> +       int i, j;
>>>> +
>>>> +       for (i = 0; i < tz->trips; i++)
>>>> +               tz->trips_indexes[i] = i;
>>>> +
>>>> +       for (i = 0; i < tz->trips; i++) {
>>>> +               for (j = i + 1; j < tz->trips; j++) {
>>>> +                       int t1, t2;
>>>> +
>>>> +                       tz->ops->get_trip_temp(tz, tz-
>>>>> trips_indexes[i], &t1);
>>>
>>> This line can be moved to the upper loop.
>>
>> Right, thanks!
>>
>>>> +                       tz->ops->get_trip_temp(tz, tz-
>>>>> trips_indexes[j], &t2);
>>>> +
>>>
>>> what about the disabled trip points?
>>>
>>> we should ignore those trip points and check the return value to
>>> make
>>> sure we're comparing the valid trip_temp values.
>>
>> We don't have to care about, whatever the position, the corresponding
>> trip id will be disabled by the trip init function before calling
>> this
>> one and ignored in the handle_thermal_trip() function
> 
> hah, I missed this one and replied to your latest reply directly.
> 
> The thing I'm concerning is that if we don't check the return value,
> for a disabled trip point, the trip_temp (t1/t2) returned is some
> random value, it all depends on the previous value set by last
> successful .get_trip_temp(), and this may screw up the sorting.

The indexes array is the same size as the trip array, that makes the 
code much less prone to errors.

To have the same number of trip points, the index of the disabled trip 
must be inserted also in the array. We don't care about its position in 
the indexes array because it is discarded in the handle_trip_point() 
function anyway. For this reason, the random temperature of the disabled 
trip point and the resulting position in the sorting is harmless.

It is made on purpose to ignore the return value, so we have a simpler code.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
