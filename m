Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D11B4B90BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiBPSvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:51:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbiBPSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:51:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A253EE08F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:51:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so2307198wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=URoPzCQ1GYVbUmkPb8PCj2L1MLcilgcwaw9oBkDMMoU=;
        b=Dn+GJgXUyqty8VcZI2t6ENysFolV/CRpw172Sx9rg0hfY5/sHVhtfDxQgkuJ+TFjyz
         bOFYjHp/4wLlCS6za4pp2Z4tb59oYHELFELUK2WJkmF0fa/Uc91X40689p9qXgBzXYHP
         UU4vj1YC8PowHY04N3xwlMtfsfO5cAw/uhz2agSSTCf1XP8DyoLP9WvkqKCLEyJH2JAs
         JTW3V7ABVYH8eSQPhM4AI5qv1LgGBXQ9xlhNNsKWUp0kdLcnbc+JhmDvd9zvMoy7VAjM
         GK+dHp+90RlnQhflrtKZU6vty/X8AVm33c3DU36p+zNTs9iIWB22nNJva4GF3pHh9fJt
         E7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=URoPzCQ1GYVbUmkPb8PCj2L1MLcilgcwaw9oBkDMMoU=;
        b=P6v7C+CBlG8P8oOD8rvvjY3Cj9B1frgEao6nPKwvW4B9gxSljYw5xXy8XLaVQvMVtM
         H5xsaJW9YSiv3y/ZxxZ4OGh/JQGqnQdruGeG/3V2aDA+YOUIORyU0AqtmNMPJtld7S+W
         F4EQXYWjRQ7abZnJ4GcMjsIP4ZrMr78CnZ8klb7/l9vUQ1E3oA6gSvl8aKX0DeZ/J0RP
         Ep8+pRyRJZ0nO/JH4LIJQzNroPsktreYQ/aPgORt3JFfW2wOCA/6mKA3s87XrSm2vB1c
         oc1aW3Mq7CfRUqxn8DQqmAV2mPOw3XN4QZIWZlOMkVtAFxYkDfUii6xZwGue+FBD/A5x
         HLkA==
X-Gm-Message-State: AOAM533qEZs+iws15VsMJzIuviZBiMA97OwmnkKT0UEjpyXlFmafEP5T
        E8iOj+gWkRzUp5RiIpiMKpLbmg==
X-Google-Smtp-Source: ABdhPJynwUa3oKAEvz/39Y5qCM4sd3r8Dko92JBEYQbxZnJSwVf29e4YUKpXa3Frq/m2XA8hLDg9MA==
X-Received: by 2002:a05:600c:22d3:b0:37b:f1a7:ceb5 with SMTP id 19-20020a05600c22d300b0037bf1a7ceb5mr2850287wmg.164.1645037488094;
        Wed, 16 Feb 2022 10:51:28 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id q13sm37066246wrd.78.2022.02.16.10.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 10:51:26 -0800 (PST)
Message-ID: <40320c0d-1bea-568e-f668-119e1c7df204@linaro.org>
Date:   Wed, 16 Feb 2022 19:51:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] drivers: thermal: clear all mitigation when thermal
 zone is disabled
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <1643307093-22501-1-git-send-email-quic_manafm@quicinc.com>
 <4024218b-7938-e181-f456-bff4b3fb157a@arm.com>
 <c02d28ce-bef4-0b71-e90a-991ef4fae9d3@quicinc.com>
 <f936ee68-3e2c-273c-38fe-9b37277f54ba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f936ee68-3e2c-273c-38fe-9b37277f54ba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 10:57, Lukasz Luba wrote:
> 
> 
> On 2/14/22 8:00 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>
>> On 1/31/2022 12:55 PM, Lukasz Luba wrote:
>>> Hi Manaf,
>>>
>>> On 1/27/22 6:11 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>>> Whenever a thermal zone is in trip violated state, there is a chance
>>>> that the same thermal zone mode can be disabled either via
>>>> thermal core API or via thermal zone sysfs. Once it is disabled,
>>>> the framework bails out any re-evaluation of thermal zone. It leads
>>>> to a case where if it is already in mitigation state, it will stay
>>>> the same state forever.
>>>>
>>>> To avoid above mentioned issue, add support to bind/unbind
>>>> governor from thermal zone during thermal zone mode change request
>>>> and clear all existing throttling in governor unbind_from_tz()
>>>> callback.
>>>
>>> I have one use case:
>>> This would be a bit dangerous, e.g. to switch governors while there is a
>>> high temperature. Although, sounds reasonable to left a 'default' state
>>> for a next governor.
>>>
>> I believe only way to change the governror via userspace at runtime.
>>
>> Just re-evaluate thermal zone  (thermal_zone_device_update) 
>> immediately after
>>
>> thermal_zone_device_set_policy()  in same policy_store() context, 
>> isn't it good enough ?
> 
> It depends. The code would switch the governors very fast, in the
> meantime notifying about possible full speed of CPU (cooling state = 0).
> If the task scheduler goes via schedutil (cpufreq governor) at that
> moment and decides to set this max frequency, it will be set.
> This is situation with your patch, since you added in IPA unbind
> 'allow_maximum_power()'.
> Then the new governor is bind, evaluates the max cooling state, the
> notification about reduced max freq is sent to schedutil (a workqueue
> will call .sugov_limits() callback) and lower freq would be set.
> 
> Now there are things which are not greatly covered by these 4
> involved sub-systems (thermal fwk, schedutil, scheduler, HW).
> It takes time. It also depends when the actual HW freq is possible to be
> set. It might take a few milli-seconds or even a dozes of milli-seconds
> (depends on HW).
> 
> Without your change, we avoid such situation while switching the
> thermal governors.
> 
> For your requirement, which is 'mode' enable/disable it OK to
> un-throttle.
> 
> It's probably something to Rafael and Daniel to judge if we want to
> pay that cost and introduce this racy time slot.
> 
> Maybe there is a way to implement your needed feature differently.
> Unfortunately, I'm super busy with other stuff this month so I cannot
> spent much time investigating this.

IMO, we should be able to disable a thermal zone, no mitigation will 
happen but somehow we can keep the hot / critical trip points enabled, 
so if the temperature crosses these that would trigger an action for safety.

However, for me it is still unclear what means "disabling a thermal 
zone" exactly ?

Maybe we should clarify that before going further


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
