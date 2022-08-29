Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1035A5733
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiH2WkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiH2WkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:40:06 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA194A837
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:40:05 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d68so7827366iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fw+ukfTmSDZ4o4Npq5CqO1EVfxOQHxJ/NRVgEA2WF2o=;
        b=N1+B+9nfF7dnXX6XxaEQI2D6eSozQ1HfiQxykqXx4Ep/uxrayNrjT4hSBxVmO68dNe
         iaVfVWeYS0CMI1wFd5HUVONwdodzUyUwy3DdL6OlpuGdityGGUvpMrQPHHlW+x+snXOT
         vLcg9hjtw0IQUBa9URRNdI/eZKEs9jb+YBrSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fw+ukfTmSDZ4o4Npq5CqO1EVfxOQHxJ/NRVgEA2WF2o=;
        b=I+gvl0DYCN5dkx2yIKc4z5xz8PY0EpuyRIdl7NlFZD8qvRbBbhq447VCnIHP5bmJXE
         gxcnm55JaLIZeqgbzIWPaNtopfiQFCGDxrQIj3o7xL36h01IjAmdJyjeAZO2rJ4kM1aH
         pzBk3jkTqkslDsToVlj+ZKS+4b3tLaRwuLUxGye5jJFdJrBaVv/+bVckyTLb9o7xpdh3
         h3AWPUK1LuFh1hIq604MfKQ8gtWXCwiV9HtN0BECiSz+Z5+99ATWITNAcfP8/r7Lxv2l
         Ywb6OP2hEAINMGsOFC75D9xMTKhnL1RuB5PldTy1Zhi4M64HywmCbCHNd70uh4JPHA0O
         uMkQ==
X-Gm-Message-State: ACgBeo1T4sazX7LazZu+MkTQvl+1wfN9o36bZJA1Fe/bk+QIJdNHNszB
        6ZwSdsGJMmYf2MYiO/lUswF2MA==
X-Google-Smtp-Source: AA6agR7HOuqqT15KXU+HhoZ8GbnT+QCR/MNEB5cDE1FNcZcfWB5CJOSQBZNP/ie/iWyGlQflkt93Lg==
X-Received: by 2002:a6b:7b41:0:b0:689:2648:9ce9 with SMTP id m1-20020a6b7b41000000b0068926489ce9mr9647222iop.185.1661812804772;
        Mon, 29 Aug 2022 15:40:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w1-20020a056638378100b00349d2d52f6asm4905185jal.37.2022.08.29.15.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 15:40:04 -0700 (PDT)
Message-ID: <3b5b12b3-e999-e097-40e8-ad2fb4a92bb5@linuxfoundation.org>
Date:   Mon, 29 Aug 2022 16:40:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220817034630.1172065-1-li.meng@amd.com>
 <20220817034630.1172065-3-li.meng@amd.com>
 <0f9706b7-6dd5-663d-70cf-7221b5a1bfc5@linuxfoundation.org>
 <dafdc2de-3846-2612-1b52-d15c02f89b81@linuxfoundation.org>
 <YwwDzcNMQnMcPOU5@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <YwwDzcNMQnMcPOU5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/22 18:09, Huang Rui wrote:
> On Sat, Aug 27, 2022 at 06:36:30AM +0800, Shuah Khan wrote:
>> On 8/26/22 3:47 PM, Shuah Khan wrote:
>>> On 8/16/22 9:46 PM, Meng Li wrote:
>>>> Add amd-pstate-ut test module, this module is used by kselftest
>>>> to unit test amd-pstate functionality. This module will be
>>>> expected by some of selftests to be present and loaded.
>>>>
>>>> Signed-off-by: Meng Li <li.meng@amd.com>
>>>> Acked-by: Huang Rui <ray.huang@amd.com>
>>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> ---
>>>>    drivers/cpufreq/Kconfig.x86     |   7 +
>>>>    drivers/cpufreq/Makefile        |   1 +
>>>>    drivers/cpufreq/amd-pstate-ut.c | 293 ++++++++++++++++++++++++++++++++
>>>>    3 files changed, 301 insertions(+)
>>>>    create mode 100644 drivers/cpufreq/amd-pstate-ut.c
>>>>
>>>> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
>>>> index 55516043b656..fdd819069d72 100644
>>>> --- a/drivers/cpufreq/Kconfig.x86
>>>> +++ b/drivers/cpufreq/Kconfig.x86
>>>> @@ -51,6 +51,13 @@ config X86_AMD_PSTATE
>>>>          If in doubt, say N.
>>>> +config X86_AMD_PSTATE_UT
>>>> +    tristate "selftest for AMD Processor P-State driver"
>>>> +    depends on X86 && ACPI_PROCESSOR
>>
>> This has to specify dependency on X86_AMD_PSTATE
>>
>>>> +    default n
>>>> +    help
>>>> +      This kernel module is used for testing. It's safe to say M here.
>>>> +
>>>
>>> Shouldn't this X86_AMD_PSTATE_UT depend on X86_AMD_PSTATE?
>>> I am running a few tests and when I have X86_AMD_PSTATE_UT
>>> enabled as built-in and X86_AMD_PSTATE is disabled, test
>>> fails saying incorrect cpufreq driver?
>>>
>>> Skipped: Test can only run on amd-pstate driver.
>>>
>>> So it sounds like X86_AMD_PSTATE_UT depends on X86_AMD_PSTATE.
>>>
>>
>> Once I enabled X86_AMD_PSTATE and X86_AMD_PSTATE_UT=m, the test
>> ran correctly.
>>
>> Please fix the dependencies and send me a new version. Send all
>> the patches so it is easier to apply them all at once.
>>
> 
> Hi Shuah,
> 
> Thanks to accept the patch series. Actually, we want amd-pstate-ut can be
> modprobed even without amd-pstate module, because it can tell the users
> they loaded a wrong module like "acpi-cpufreq" and needs to replace it with
> amd-pstate. :-)
> 

I see. The message could be expanded to let the user know which
config option needs to be enabled to run the test.

You can send this change as a separate patch. I will apply this series
as is.

thanks,
-- Shuah

