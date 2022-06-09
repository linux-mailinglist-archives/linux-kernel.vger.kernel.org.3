Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E054559C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344276AbiFIU2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344443AbiFIU2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:28:30 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F161E453A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:28:29 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y79so4784500iof.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Nw44iAbwAa4TflzWFQ+4t9iEMEgwQigUnBEPSy2g/k=;
        b=eCVdfwl+sZP/ibvZ80kK63PQ3Sh/oBkBYkRdSjPDzKRU9ru7cAkhxnVX+Rb+uUllh7
         cav3j3Jphu7yDVxZgaoQ67MG0FhSR2q5YCNhgh6LtZitq7VXD/bVhh2uFeEgLg3s4Dl0
         BCUzC1msyNN8ojDEwDouGhNkg+8DZcPG+uc6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Nw44iAbwAa4TflzWFQ+4t9iEMEgwQigUnBEPSy2g/k=;
        b=asbiI/uiMkLZJYf5DImk4wRoXvyvA+axiqnIcC4s83yStl30KgNKd2k+tIB/yh3AWO
         nANzLpxStmetijoUDXKxuB1Z0IkDF0IjvFwtOe48h97YEUACRTfM5L9ryD7QEY8ninF2
         G7i6NgCOQ7a1F1Yg1WuXZHnLuWG5qwFsjjdlJMonoY83YL3g7G2L8Nqk7ADVDvVJrkMm
         /4B9KOBvWKPrfj97yFA2TD7wSSpado3cnop9SiRG13o5a4dnJ8e0QzcSHOSHWv2NGIgo
         KrscsKRFgbhPYIdZnhBAGd94Xp8btV0zQXlOhQdGyX+iYCDyYHIq9aHKiQrUeyHFeQHI
         h6iQ==
X-Gm-Message-State: AOAM53342Pv+oiYfNgEKqNs0kzJPNWYwyD21nAyIaxRvZ36tKh+0KgVa
        kSTJBLyr1TzXw0zygSGpbOkmbw==
X-Google-Smtp-Source: ABdhPJxbQIaLSSPsBgoBjp+quiVTIwhy4GAXCQk3zsrCyl7vpS6M4JiVHPY0sLztvZQcCpGTILp1gg==
X-Received: by 2002:a05:6638:2616:b0:331:fff5:764f with SMTP id m22-20020a056638261600b00331fff5764fmr2602376jat.267.1654806508802;
        Thu, 09 Jun 2022 13:28:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i12-20020a02ca0c000000b0032e7d0a79basm9880459jak.158.2022.06.09.13.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:28:28 -0700 (PDT)
Subject: Re: [PATCH V8 0/4] Add unit test module for AMD P-State driver
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220526034725.1708916-1-li.meng@amd.com>
 <fbd6bc2f-b6d7-497e-410c-4a82876075ff@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5792136d-079e-6e1e-0bf5-aed1b3db6566@linuxfoundation.org>
Date:   Thu, 9 Jun 2022 14:28:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fbd6bc2f-b6d7-497e-410c-4a82876075ff@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 9:44 AM, Shuah Khan wrote:
> On 5/25/22 9:47 PM, Meng Li wrote:
>> Hi all:
>>
>> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
>> the functions of amd-pstate driver.
>> It could import as a module to launch some test tasks.
>> 1) It can help all users to verify their processor support (SBIOS/
>> Firmware or Hardware).
>> 2) Kernel can have a basic function test to avoid the kernel regression
>> during the update.
>> 3) We can introduce more functional or performance tests to align the
>> together, it will benefit power and performance scale optimization.
>>
>> We upstream out AMD P-state driver into Linux kernel and use this unit
>> test module to verify the required conditions and basic functions of
>> amd-pstate before integration test.
>>
>> We use test module in the kselftest frameworks to implement it.
>> We create amd-pstate-ut module and tie it into kselftest.
>>
>> For example: The test case aput_acpi_cpc is used to check whether the
>> _CPC object is exist in SBIOS.
>> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
>> existed at the detected processor, so it is a necessary condition.
>>
>> At present, it only implements the basic framework and some simple test
>> cases.
>>
>> TODO : 1) we will add more test cases to improve the depth and coverage of
>> the test. E.X. use the script to trigger the tbench, gitsource, kernbench,
>> netperf, speedometer, and etc. testing and monitor the cpu frequency and
>> performance goals change, power consumption at runtime.
>>
>> Please check the documentation amd-pstate.rst for details of the test steps.
>>
>> See patch series in below git repo:
>> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
>> V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
>> V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/
>> V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
>> V5: https://lore.kernel.org/lkml/20220505022913.329259-1-li.meng@amd.com/
>> V6: https://lore.kernel.org/lkml/20220519134737.359290-1-li.meng@amd.com/
>> V7: https://lore.kernel.org/lkml/20220522115423.1147282-1-li.meng@amd.com/
>>
> 
>>
>> Changes from V7 -> V8:
>> - cpufreq: amd-pstate:
>> - - amend commit message.
>> - - amend module description.
>> - Documentation: amd-pstate:
>> - - amend commit message.
>> - - Remove the personal data.
>>
> 
> Looks good to me. Thank you.
> 
> Rafael, Viresh,
> 
> How do you want to handle this patch series? We are in merge window
> and this would be for Linux 5.20 based on the changes and content.
> 
> Would you like to take the entire patch series through your tree, you
> have my Ack(s) and Reviewed-by(s)
> 

Picking this back up since rc1 is out. How do we want to handle this patch
series?

thanks,
-- Shuah
