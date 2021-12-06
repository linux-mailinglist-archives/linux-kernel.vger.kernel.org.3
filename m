Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBE46AB1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350299AbhLFWBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356433AbhLFWAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:00:30 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E170C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:57:01 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y16so14700115ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dlr0f6TbxDcCxHl6HIutvJuGXbJUX3iddVtHBaDQXFI=;
        b=WzMYMwiAdzw4xiZ8A4YkEUDqR4PJYLNryR8XGs5DaW+yxtvOdmDUnI8VBLsxVl2/uj
         42zlD3foae4B+GKRQ9506UxsjiHQn8la528ywLlsLxKsePgnftT1L6LTSVOFzzn3t48D
         RoORY119XwCFVLD/h5kL+PdIe5aVVLK9vIVWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dlr0f6TbxDcCxHl6HIutvJuGXbJUX3iddVtHBaDQXFI=;
        b=7SOBj8YYaR4tApCH9bk/2J0jzhfOUUUcMVDOaUAvVkmGV9B96O35fJ5N550io0Gepa
         iXdnLLLIowm0op7sMi4JbHugyWJL+tnlG+wrQH0Db0n+aStaNLZNig+TQ9ohYdcTMPzw
         cjZxBY1E97ZeBhd6k5qBhy/ZYk6+LUXTdfRtIgZBhwGYVy/xEbLn1OzCYvcWaQYle2cs
         2cD9VNXGGB39ZbhCtveD0BkyK/PwwB1JiVSnwPxsrmXhxxXS3LCuDsR4M77zC94URYtx
         VBGA32KvC+PLTtd/koy5dWNONmsaywf28k2Pz/EDuHawWdebw3JVM0cVMEFMzCQkll7N
         GWuQ==
X-Gm-Message-State: AOAM532wWZsodpJVbICY1RgIowRS67kqKf2DIhQAK163FKJtOrUryL8s
        khGhVTGhpqv7Y2mh390wDYCjsQ==
X-Google-Smtp-Source: ABdhPJwd0Ky2oxsOEFDNNL6Pp7oI9WY12HwJ+m0WWwNDGMlYTJTz2vQOmoZK9TZNPiFoBQmeUfV+Pw==
X-Received: by 2002:a05:6602:45d:: with SMTP id e29mr37375337iov.202.1638827820991;
        Mon, 06 Dec 2021 13:57:00 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c2sm7240558ilr.70.2021.12.06.13.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:57:00 -0800 (PST)
Subject: Re: [PATCH 5.4 00/70] 5.4.164-rc1 review
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20211206145551.909846023@linuxfoundation.org>
 <b4fd2b8c-cc44-ff11-2588-1d7a32155d84@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1be2e381-301c-bd44-3569-6270042a878b@linuxfoundation.org>
Date:   Mon, 6 Dec 2021 14:57:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b4fd2b8c-cc44-ff11-2588-1d7a32155d84@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 11:57 AM, Florian Fainelli wrote:
> On 12/6/21 6:56 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.4.164 release.
>> There are 70 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 08 Dec 2021 14:55:37 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.164-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels:
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
