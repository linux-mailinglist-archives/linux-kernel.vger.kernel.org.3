Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747A14A51E3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350600AbiAaVw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345541AbiAaVw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:52:26 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADDC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:52:25 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e8so12630124ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MvksuHShdo5C7SWbdBSuidzz86NTZYVYdIk6979/9jk=;
        b=Oh3zFvezgmFYuG1aTRHGQD84XhucshaqYKH8Sh6yVd5EKupzdeHLaJ4r7CrBhyag0K
         xmghCnjWzGzhT3CIvVzuvtH91HzLGr0I6mtB5WBHlUlCyQ62XD7fbHSK/mN1MN9zLhLH
         SSShUrpuu//+LF9xSxGuiou8DtZdRzStBu1co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MvksuHShdo5C7SWbdBSuidzz86NTZYVYdIk6979/9jk=;
        b=kC44H+ZQGMBnI5cPSc4U7E+iznm+XSlb89naO7gtACRuku0ynIO521Dhn2DFJlUHJV
         jCGkMVvmPw9I7r3xwaHo1dhACeazhGePV7I8g44iwVhst9PhWdehecDdTJfHF5CKJVe5
         OrL+r10TXfrI4/ndE13Ujkfyds6nnO1x0O9KSk3IWKV0I4YhWBNV7nfOEsJ5HSCY32Ta
         o9WyMXeMoT/9gHm6yLIKfmZ4Z4qsiYQLan5Wb5UxhC5N64l5UrRZCASOJ9M4kmBPTGvt
         NasR1B8XkSuIp6fXxxrlFyO3fMzWqmCnlsk8zyzYWgvRwE6Y0uHM9RaFUpwJm0Dd2vvT
         azWw==
X-Gm-Message-State: AOAM530hc/+W6uYyo99RM25/dN14WDZ/9bxaxLv4l21EsmTPBdli1auk
        P33nlV6faojXgTsTZ5hx3iXPEw==
X-Google-Smtp-Source: ABdhPJxpcirdkzc7uOT8HkKnAc5aGpsJWddaUC75LEiX6aQp9Dh0qxfu8p/wb/9aY4NgD9lI9wqsFA==
X-Received: by 2002:a05:6e02:20c9:: with SMTP id 9mr9920122ilq.267.1643665945260;
        Mon, 31 Jan 2022 13:52:25 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id z5sm19774768ioq.47.2022.01.31.13.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 13:52:24 -0800 (PST)
Subject: Re: [PATCH] docs/kselftest: clarify running mainline tests on stables
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126201341.55771-1-skhan@linuxfoundation.org>
 <7ba5e99a-9169-75c4-2324-f9a3ce9a506e@intel.com>
 <bb1ba6f5-4cd8-742c-62b7-a62a6f4cef91@linuxfoundation.org>
 <6f9083e2-d633-d483-702e-f974317133b7@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3e830fee-2402-0ba5-4e31-75d87e864b73@linuxfoundation.org>
Date:   Mon, 31 Jan 2022 14:52:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6f9083e2-d633-d483-702e-f974317133b7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 1/31/22 2:20 PM, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 1/31/2022 12:34 PM, Shuah Khan wrote:
>> On 1/31/22 12:37 PM, Reinette Chatre wrote:
>>> On 1/26/2022 12:13 PM, Shuah Khan wrote:
>>>> Update the document to clarifiy support for running mainline
>>>> kselftest on stable releases and the reasons for not removing
>>>> test code that can test older kernels.
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> ---
>>>>    Documentation/dev-tools/kselftest.rst | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
>>>> index dcefee707ccd..a833ecf12fbc 100644
>>>> --- a/Documentation/dev-tools/kselftest.rst
>>>> +++ b/Documentation/dev-tools/kselftest.rst
>>>> @@ -7,6 +7,14 @@ directory. These are intended to be small tests to exercise individual code
>>>>    paths in the kernel. Tests are intended to be run after building, installing
>>>>    and booting a kernel.
>>>>    +Kselftest from mainline can be run on older stable kernels. Running tests
>>>> +from mainline offers the best coverage. Several test rings run mainline
>>>> +kselftest suite on stable releases. The reason is that when a new test
>>>> +gets added to test existing code to regression test a bug, we should be
>>>> +able to run that test on an older kernel. Hence, it is important to keep
>>>> +code that can still test an older kernel and make sure it skips the test
>>>> +gracefully on newer releases.
>>>> +
>>>>    You can find additional information on Kselftest framework, how to
>>>>    write new tests using the framework on Kselftest wiki:
>>>>    
>>>
>>> (My apologies if this is already documented, I was not able to find this guidance
>>> in Documentation/dev-tools/kselftest.rst nor when looking at the
>>> "Kselftest use-cases..." slides linked from https://kselftest.wiki.kernel.org/)
>>>
>>> Could you please clarify what the requirement/expectation is regarding fixes
>>> to tests? Since the recommendation in the above change is that Kselftest from
>>> mainline should be run on older stable kernels, is it required to backport
>>> fixes to the tests themselves to stable kernels?
>>>
>>
>> Couple of things to consider.
>>
>> - A new test gets added to regression test a bug in stable and mainline
>> - A new test gets added to test a kernel module/feature/API that has been
>>    supported by stable and mainline releases
>>
>> In both of these cases, running mainline kselftest on stables gives you the
>> best coverage.
>>
>> Kselftest fixes get pulled into stables like any other kernel fixes. If a few
>> fixes are missing, it is a good idea to back-port if they fall into above two
>> categories. If the test is for a new feature then, it doesn't make sense to
>> back-port.
>>
>> Hope this is helpful.
> 
> This is helpful, thank you very much. In summary I understand this to mean that
> when testing a stable kernel it is recommended to run tests from mainline, but
> running the tests from the same stable kernel version as the kernel being tested
> is also a supported use case and thus fixes to tests should be back-ported.
>

Correct. Right. In the slide set you referenced, I included a slide that shows
the combination and one of them is indeed rev matching kselftest and kernel.

Some tests such as bpf require rev match with the kernel i.e running kselftest from
the same release.

thanks,
-- Shuah

