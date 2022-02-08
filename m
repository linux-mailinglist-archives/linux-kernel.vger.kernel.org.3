Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A87D4AD25C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348472AbiBHHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiBHHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:39:08 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDEFC0401F1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:39:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k1so12520031wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A5bUbwGkKQlXLpWsy9TPFsLb6gmc2QPm26L3v501V4c=;
        b=KqVk3xA4HYLHM8Tz5KHMWy7mSFcX7bdDpIZiAXIYWP0FsjWSnmB8SDTT0Yn93XvOyK
         CHI32ncaqz1nL1zNVWlVFjpVaBaSVCLofSToIPOHkFyPHUNSFiQ/+RYhBWEKa0uj2rsh
         D3hB6grlYH4m+fztaURW3XEWIkb8Vx1uW/AA5AHIJTQAIWluVdjn7CWNpSXk9R9sMIXg
         CGKBtyzIpgY7P5zJpEeIvccG0TcUABMM+8Mb2GVqdYQlCi2RApLGOJrCxahbAliZuY7y
         XIMGNs/f3J3YKSWXDGRWK6tfqnJekatIZFs2sug7mmkS2JEq2xUqIRXjz9mddluXDAqg
         bwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A5bUbwGkKQlXLpWsy9TPFsLb6gmc2QPm26L3v501V4c=;
        b=s2v3efaOER0VWTKpwKh4ekcDaXmfHIsA83BhqpcmVvqYF0T3FaOddWCbM++DM7y8f7
         luRL1EvnQA6op3ne9a6vj3g6by4sXB/Y239OltCf+rHQb1k+Vzyd2uvj4wnFScaXWqHp
         2dcvOT44iw058T3p4+wCkU83KkWvQcpLprWdqLcHsFhbcNK2b/+8kFsfwJjmKxpWGhJA
         diH4blkppsYfHvPc2eBbCcTCVuGywBNm74kiTS9kaKVQBQVVvUVR1fVJ7gPZucQ3tb2Y
         7lq8FxEpOWCQEwGspwFQYKEYIzzwBO+3v6mPi7/L1glxZyy9o14NNGMTfo9Ww3CZgVEK
         7zXQ==
X-Gm-Message-State: AOAM531Fc4w2wtGBX2pTgmxqXSRS/dGn6bHg95obunKOUld+cLvRJiWr
        Zt7mxZr3KXuzxVX6nojOX8pBlg==
X-Google-Smtp-Source: ABdhPJxLFibNiHiiDz4aXl7IafWaZMaTn6HCCI1pZykTEc4VmvrBZ1SnsvVXB7spUjrCjz1EMI9WNw==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr2364714wrq.534.1644305945291;
        Mon, 07 Feb 2022 23:39:05 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:f084:7eaf:38c2:fbc5? ([2a01:e34:ed2f:f020:f084:7eaf:38c2:fbc5])
        by smtp.googlemail.com with ESMTPSA id 2sm12965099wrz.59.2022.02.07.23.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 23:39:04 -0800 (PST)
Message-ID: <f63be987-a1a5-cf7e-8302-4ae6e87b6699@linaro.org>
Date:   Tue, 8 Feb 2022 08:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] Ignore Energy Model with abstract scale in IPA and
 DTPM
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <0d2217e0-44f7-8587-3e1f-a73d301ab166@linaro.org>
 <616307f7-b419-8e36-6879-6cf6f4e02d5a@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <616307f7-b419-8e36-6879-6cf6f4e02d5a@arm.com>
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

On 07/02/2022 12:44, Lukasz Luba wrote:
> 
> 
> On 2/7/22 10:41 AM, Daniel Lezcano wrote:
>> On 07/02/2022 08:30, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The Energy Model supports abstract scale power values. This might cause
>>> issues for some mechanisms like thermal governor IPA or DTPM, which
>>> expect that all devices provide sane power values. This patch set 
>>> prevents
>>> from registering such devices for IPA and DTPM.
>>
>>
>> Does it mean for example big and little have both 0-100 ?
>>
>>
> 
> Unfortunately, these can be any numbers. I hope at least the CPUs
> Big and Little power have sense: Little power is not higher
> than Big power. The purpose of EM is to enable EAS, so this power
> relation between Big and Little should have sense. Someone
> who is not willing to or cannot expose real power values, still
> wants the EAS to operate (my assumption and hope). The SCMI FW can
> provide abstract power values. It's in the SCMI spec. Thus,
> creating these abstract scale power values for big.LITTLE the right
> way should result in properly working EAS.
> 
> I can also have hope for GPU vs. Big power, but it is a weaker hope.
> The second is more tricky to distinguish even if you have a domain
> knowledge, but not the real measurements with you. The GPU power
> values is also a 'sensitive' knowledge to share. Open source guys can do
> that (after measurements), but some vendor's engineers probably can't.

So basically, we don't know, right ?

At this point the different subsystems (cpufreq cooling device and dtpm) 
disabled by these patches can deal with abstract scale values, like they 
do today with the very approximate power numbers we have defined in the DT.

Let's wait and see how the different SoC vendors implement the SCMI spec.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
