Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E847E46F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348803AbhLWOQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348799AbhLWOQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:16:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76818C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:16:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e5so11755469wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bTgBA2Z0BvYIGO7q6tu/7IahnMgog9d3KpLyr5zde7g=;
        b=WaG188HX9v2btGZJf94XFI07oVa78PRlAGOJ6s/EQq/i1Symmy/sVKlb0xBk5sbma/
         urDmypqFQzJTJuunsqhulobFeTbIUBjm33sm9MuOOargmWRuRI8yBM6YXuOa/w1T2+0o
         LpEmDPAf01W368iDcmvZgK+KYlXvFa+TKwAm5JN+TT4Pc+whp275Jkrq93OAKhb/AUdf
         RBCwNZccdnW8hLLrDA15QNtX/ffsdjoQJtvoLrnw1iOWdI/DJlXGzMYZuuux+Tv7XtUd
         yL9zcVPJUHFJVf32xYvpRvNeZDvjNRfY9aDrMnQfdt3si9wlNWLfsKyCvHsokKOJ9EIM
         wC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bTgBA2Z0BvYIGO7q6tu/7IahnMgog9d3KpLyr5zde7g=;
        b=D66BD2x+iv7aKLTld5aGg5eU1qBL4g/3Uhk+9H03SaCp8OFF2D5hHWdzWbGyl0I+M9
         VPacH6nbTrF9bUAt+v9nvJwhAltGA0/ViWXgegqS9p5CaA2reQupi77u3J9/7wDLfa5V
         46MNr+MEbScwSvNsUNMzdyfC+yHF1E5XyI++iPd45C/K7op9mdzZJU7IMbwfh8LbuSBm
         inOEIXwbhCLi5/JPbYAAoO15Cg1updcQZH20VgwiH9m+6CmmncUwce9nK+a3fMBsS4AQ
         jSD+bW3leRjMrI2YY5n8+pt5BJzltKXjgi2DDStLbxKmaWjCmWJ9tBErkioiRbk+FWzs
         fCwg==
X-Gm-Message-State: AOAM532H3n2w3yJJvJMIZyAm6LiQakckNHY7d2g0yNgtZ0xe37MuM2C0
        DnPt3+AFSJAMxP/i5P9mC5RnwQ==
X-Google-Smtp-Source: ABdhPJwv4AbCPAfJBRN89Va7WGp95ZtC6FYlRGaSupmX6f98rCh7PbjjFLpKTaVph9LvpvGT4UsVCw==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr1845125wro.713.1640268964825;
        Thu, 23 Dec 2021 06:16:04 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:34ca:f67b:b782:1949? ([2a01:e34:ed2f:f020:34ca:f67b:b782:1949])
        by smtp.googlemail.com with ESMTPSA id r8sm5135494wru.107.2021.12.23.06.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 06:16:04 -0800 (PST)
Subject: Re: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
To:     "Sanil, Shruthi" <shruthi.sanil@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
References: <20210906183621.21075-1-shruthi.sanil@intel.com>
 <20210906183621.21075-3-shruthi.sanil@intel.com> <87lf3jaubj.ffs@tglx>
 <BN9PR11MB5545F024ADB86394FED085BCF1949@BN9PR11MB5545.namprd11.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f8af5711-4cc4-7513-5ad3-0f17ce04b346@linaro.org>
Date:   Thu, 23 Dec 2021 15:16:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5545F024ADB86394FED085BCF1949@BN9PR11MB5545.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2021 11:42, Sanil, Shruthi wrote:
>> -----Original Message-----
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Monday, September 27, 2021 3:11 AM
>> To: Sanil, Shruthi <shruthi.sanil@intel.com>; daniel.lezcano@linaro.org;
>> robh+dt@kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org
>> Cc: andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
>> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
>> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
>> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
>> Sanil, Shruthi <shruthi.sanil@intel.com>
>> Subject: Re: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
>>
>> On Tue, Sep 07 2021 at 00:06, shruthi sanil wrote:
>>> +
>>> +/* Provides a unique ID for each timer */ static
>>> +DEFINE_IDA(keembay_timer_ida);
>>
>>> +
>>> +	timer_id = ida_alloc(&keembay_timer_ida, GFP_KERNEL);
>>> +	if (timer_id < 0) {
>>> +		ret = timer_id;
>>> +		goto err_keembay_ce_to_free;
>>> +	}
>>
>> May I ask what the purpose of the IDA, which is backed by a full blown
>> xarray, is here?
>>
>> AFAICT all you want is a unique number for the timer name for up to 8
>> timers.
>>
>>> +	timer_name = kasprintf(GFP_KERNEL, "keembay_timer%d",
>> timer_id);
>>
>> So what's wrong about:
>>
>> static unsigned int keembay_timer_id;
>>
>> 	timer_name = kasprintf(GFP_KERNEL, "keembay_timer%d",
>> keembay_timer_id++);
>>
>> Hmm?
> 
> Yes, we had initially implemented it in the similar way, 
> but in the course of review it got changed to use IDA.
> 
>>
>>> +
>>> +	clockevents_config_and_register(&keembay_ce_to->clkevt,
>>> +					timer_of_rate(keembay_ce_to),
>>> +					1,
>>> +					U32_MAX);
>>
>> Aside of that what's the point of registering more than one of those timers as
>> clock event? The core will only use one and the rest is just going to use
>> memory for no value.
> 
> Instead of
> keembay_ce_to->clkevt.cpumask = cpumask_of(0); 
> can I update it as 
> keembay_ce_to->clkevt.cpumask = cpu_possible_mask; 
> so that each timer would be associated with different cores?

Let me try to clarify:

The Intel Keem bay Soc is a 4 x Cortex-A53

The arch ARM timer is per CPU on this platform.

Case 1:
-------
 - the architected timer is not desired and this timer is wanted to be
used instead (but rating tells the opposite) => rewrite per cpu code

Case 2:
-------
 - the architected timer are desired and this timer is used as a
broadcast timer when a core is going done with cpuidle. One timer is needed.

 - In order to prevent useless wakeup, the timer uses the flag DYNIRQ.
However, cpumask_of(0) is set and makes inoperative this flag. In order
to make full use of it, clkevt.cpumask must be cpu_possible_mask

Hope that helps

  -- Daniel








-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
