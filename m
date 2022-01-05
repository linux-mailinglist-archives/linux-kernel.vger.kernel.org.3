Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12E94855AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbiAEPSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbiAEPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:17:48 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C35EC0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 07:17:48 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id v10so31247023ilj.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 07:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QaOzKmh/45r78gZKU4j1aKbGW0eNXE2J7cm64/2dxCk=;
        b=K5RNtelQspgwCLSZiD4EbOVrNMX5nQK1yUidJKPMcSRrM6B9HjQv76qhptfUsurjyQ
         9rnU+FDMGGp4uKnXQ47hS/kAfQCMRrjGwaeNe+3InQBK53orKK8EuN6COcJ8QK3HHDBL
         0CNUcMOEnBqLVMImvZ8PRRWK0oYYdNtOCla2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QaOzKmh/45r78gZKU4j1aKbGW0eNXE2J7cm64/2dxCk=;
        b=d0mD22cgCc0XoTPclUujl4FC7WKtBqBL59bZE/MpwHMCkJ93wHjZDmuE1K5aEKcYpZ
         B9HioSZDt9uXJHAM2muevrXZ5uM0GCPlXKwNoHQBSQobVR5KwjszNCwu/EagoqMXc32g
         0wyBf0mJWyOqpN/w8/tewbuDp4Ai1v5UY32dYudb9nnbMIbjZr1bLdF+ndUD7NwNlimN
         G4UDKpMSppN5PgKq2iRWCa8H3z8OKKiQi11HQ5DhbUwwyxzPWrxZ7LwUtyBcs1wGQeVg
         2HmoMNvbDLyJa35BdoLbtQgPVGf9xXyh2Q0MawYhoSi1TqiQg4JKhtQAH8+496+Up7Jm
         Mxbw==
X-Gm-Message-State: AOAM533MGHJyHa/4QJ9T9mmqEwyC87CUn52uztKv7o7BK/bZ+W4y79k2
        /uGlUuLT6MvvcH/6RCZeCI2RJg==
X-Google-Smtp-Source: ABdhPJxvefzoIF7Q/OwzbSZ1Hp0o/UnKPfkzM1v9TBRTzXmEXtYvV5LElJNYL5VFD84/w5Tsod2sJQ==
X-Received: by 2002:a05:6e02:148a:: with SMTP id n10mr21526451ilk.142.1641395867321;
        Wed, 05 Jan 2022 07:17:47 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g1sm27236084ila.26.2022.01.05.07.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 07:17:47 -0800 (PST)
Subject: Re: [PATCH 5.15 00/72] 5.15.13-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220104073845.629257314@linuxfoundation.org>
 <54461ffb9ebe34e673e6730f3e9cc94218ad2f49.camel@rajagiritech.edu.in>
 <YdWxh/OR0dQDeS9E@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b7a7543d-2e18-93fb-7a7d-791a8030d347@linuxfoundation.org>
Date:   Wed, 5 Jan 2022 08:17:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YdWxh/OR0dQDeS9E@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 7:56 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 05, 2022 at 06:32:43PM +0530, Jeffrin Jose T wrote:
>> On Tue, 2022-01-04 at 08:41 +0100, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.13 release.
>>> There are 72 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 06 Jan 2022 07:38:29 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>          
>>> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.13-rc2.gz
>>> or in the git tree and branch at:
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
>>> stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>   hello,
>>
>> There was a compilation error....
>>
>> -----------x--------------x------------------x--
>> MODPOST vmlinux.symvers
>>    MODINFO modules.builtin.modinfo
>>    GEN     modules.builtin
>> BTF: .tmp_vmlinux.btf: pahole (pahole) is not available
>> Failed to generate BTF for vmlinux
>> Try to disable CONFIG_DEBUG_INFO_BTF
>> make: *** [Makefile:1183: vmlinux] Error 1
> 
> Is this a regression?  If so, what commit caused this?
> 
>> i did CONFIG_DEBUG_INFO_BTF=n  in .config and then compilation was
>> success.
> 
> Or you can install pahole, right?  That's a requirement for that build
> option I think.
> 

Looks like some distros enabled this option - either disable the
option or install pahole. Not a regression.

Keep in mind that CONFIG_DEBUG_INFO_BTF is a dependency to build
bpf tests. bpf build pulls kernel defines from BTF to generate a
header file. Not desirable to generate header that conflicts with
standard libgcc defines which is not relevant to this conversation.

thanks,
-- Shuah
