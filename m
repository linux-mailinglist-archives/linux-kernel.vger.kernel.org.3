Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931CC47B621
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhLTXSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhLTXSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:18:49 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6201BC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:18:49 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id x6so15243130iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4B4SpmhHdx32X53AjRVhtZIKXk5wDvradjqSsrhDOgI=;
        b=Q8zVjjmunIoMGwz6yF3kRubQW3ZhM5k0KDvYc2oJJU3kdmMnuisN3povwfgAy8whhA
         7iYiqnE7SQj9nAk077x3PwUTMXkbUeuS4KVqR5aXegJnbKcW0eVIxwRGmLqrKpY4bbH8
         LMK/lRmPu/FQjRyxOLlVae4iU9x7hRYZQFGmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4B4SpmhHdx32X53AjRVhtZIKXk5wDvradjqSsrhDOgI=;
        b=LGQ0Zhs9ORSa0eWc6+vy4W+FFIzCt0CBSH1r03XZqolpnMVj6ZgZWt14CsLroHpWV0
         oQ/Ui0yJ1bPj1fxH5mG0zciFtY9PZDf9PcgFl3VMGJmVeepGmkRII1pV8HHAUVxf1mIX
         EaqVl1YWxHvHu2MU1Q5gb88HV2uODkl7Yy/v6o4E1dCgdufHOpz2QnKKdV+Gp2L3YEoz
         d6D/UbrokXIyxcqTI2y+i8kOMj7zbEjA58Dpoe54pZo6u81AuayaHhqLIWpXLbePtK8b
         SUyyfa124f42pHAd5luIOt5QifPRofUqxZeYrdtVCeD5/Lu2pi+MR9C4v5Go1IeBH+ze
         0fcw==
X-Gm-Message-State: AOAM533VtqQp5MccICmnpyfToRgt9r/JLOgy0vjzxPFOEthHz0zzHZAJ
        yPofAqWJScLqVwxpIg3aZlua/m4SGmeCfw==
X-Google-Smtp-Source: ABdhPJyFWAmyaqDsuuJsjaj/5uQ1MKXqNUg/C/yrD1PA7pWrKwWy3oCnFwQ1UBvKuAJaRwTNCcfsvQ==
X-Received: by 2002:a05:6638:11c5:: with SMTP id g5mr290612jas.47.1640042328765;
        Mon, 20 Dec 2021 15:18:48 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g8sm12120644ilf.75.2021.12.20.15.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 15:18:48 -0800 (PST)
Subject: Re: [PATCH 4.19 00/56] 4.19.222-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211220143023.451982183@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <55c3b5d2-f84b-a58a-deec-862fd39200e8@linuxfoundation.org>
Date:   Mon, 20 Dec 2021 16:18:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211220143023.451982183@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 7:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.222 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Dec 2021 14:30:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.222-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
