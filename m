Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F655A321C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbiHZWgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHZWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:36:34 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F8A61D3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:36:32 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t140so3679631oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=Ofhm5bu3mqX4oZOke1Uk6LLRRxsC4M1BT8VbT7XnGuU=;
        b=Cn2RHA0xopllp4bDKXkq8Vniq2sdgYPx7j1g+kcS14Nn7aGFvcMyVn4kPcpQcKPVm6
         j8xRrMyTaZL+nBHL7BH2j0a7LTB4EQ/CNDdtJgcFIb3Wf5yBv66/7uR+rdapHSCbX6/y
         3MRrhupuyyywMQtgKkTKdjPNuhGEz+okxgKAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=Ofhm5bu3mqX4oZOke1Uk6LLRRxsC4M1BT8VbT7XnGuU=;
        b=XhOL3cHW0IY4h5LVd/h4XtLpq4gzMC2hwyXNXxiuV6YugguxCGY6oLtYc0K0cCJWtn
         2PqDOE4icaq/tJjgU1vY9z/JIMZ8t0SKYGdJfcarCxr14gFcxy07r4fV4TKWTVrCietm
         Ot0t2QCbDg0oR0xgiTlGduAKXFpornk9fDxzw+Hyc4o0YjQWoPoYwJ2pr1ji/SUstZdV
         wdbh7WL2naIddi9qMe0UB6p1qHlDTxKSJqj5qrV8eg6yqlpn6ZEmSFFhhNF6o9yYsOYC
         JjkxlIMITMtgawcVQJ/gt/AgwVc4rRZTlzEj055fwcGpw7o1rRwDaE59vKuSfzL378CG
         0mvg==
X-Gm-Message-State: ACgBeo35WSkkt2eBzXE0kvnVCph9kA/cT6BjsAXaJ0CB8JeBIgNdGux2
        d8n2sLTPtgF4tny42poLiNZRSg==
X-Google-Smtp-Source: AA6agR5eAKTdiz4NHx9btzEqNq+lUU2Dib4LQjotSGU5os8ZrxHdYmc1dH2vR7hAWdyvnk4NVDN8hQ==
X-Received: by 2002:aca:b05:0:b0:343:53bf:3221 with SMTP id 5-20020aca0b05000000b0034353bf3221mr2536066oil.75.1661553391647;
        Fri, 26 Aug 2022 15:36:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e5-20020aca1305000000b00344e3751fc4sm1560445oii.36.2022.08.26.15.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 15:36:31 -0700 (PDT)
Subject: Re: [RESEND PATCH 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
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
References: <20220817034630.1172065-1-li.meng@amd.com>
 <20220817034630.1172065-3-li.meng@amd.com>
 <0f9706b7-6dd5-663d-70cf-7221b5a1bfc5@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dafdc2de-3846-2612-1b52-d15c02f89b81@linuxfoundation.org>
Date:   Fri, 26 Aug 2022 16:36:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0f9706b7-6dd5-663d-70cf-7221b5a1bfc5@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 3:47 PM, Shuah Khan wrote:
> On 8/16/22 9:46 PM, Meng Li wrote:
>> Add amd-pstate-ut test module, this module is used by kselftest
>> to unit test amd-pstate functionality. This module will be
>> expected by some of selftests to be present and loaded.
>>
>> Signed-off-by: Meng Li <li.meng@amd.com>
>> Acked-by: Huang Rui <ray.huang@amd.com>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   drivers/cpufreq/Kconfig.x86     |   7 +
>>   drivers/cpufreq/Makefile        |   1 +
>>   drivers/cpufreq/amd-pstate-ut.c | 293 ++++++++++++++++++++++++++++++++
>>   3 files changed, 301 insertions(+)
>>   create mode 100644 drivers/cpufreq/amd-pstate-ut.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
>> index 55516043b656..fdd819069d72 100644
>> --- a/drivers/cpufreq/Kconfig.x86
>> +++ b/drivers/cpufreq/Kconfig.x86
>> @@ -51,6 +51,13 @@ config X86_AMD_PSTATE
>>         If in doubt, say N.
>> +config X86_AMD_PSTATE_UT
>> +    tristate "selftest for AMD Processor P-State driver"
>> +    depends on X86 && ACPI_PROCESSOR

This has to specify dependency on X86_AMD_PSTATE

>> +    default n
>> +    help
>> +      This kernel module is used for testing. It's safe to say M here.
>> +
> 
> Shouldn't this X86_AMD_PSTATE_UT depend on X86_AMD_PSTATE?
> I am running a few tests and when I have X86_AMD_PSTATE_UT
> enabled as built-in and X86_AMD_PSTATE is disabled, test
> fails saying incorrect cpufreq driver?
> 
> Skipped: Test can only run on amd-pstate driver.
> 
> So it sounds like X86_AMD_PSTATE_UT depends on X86_AMD_PSTATE.
> 

Once I enabled X86_AMD_PSTATE and X86_AMD_PSTATE_UT=m, the test
ran correctly.

Please fix the dependencies and send me a new version. Send all
the patches so it is easier to apply them all at once.

thanks,
-- Shuah
