Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E94735F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbhLMUbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242916AbhLMUb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:31:27 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB63C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:31:26 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id v30-20020a4a315e000000b002c52d555875so4464690oog.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=deKBr0LFoKPX4TjZtCSnouZiCvMty0dcKoc4aq9X93o=;
        b=TIPndPq8h/a3wocqzKobbwtmpxchO9McvvpT9SpPY5cGW0CeXW2RRBfAnU6MfUk2jW
         KrLcDyTs07DBUcv4qn2+LclATc/hbyCOMaTbWBwQ7fG+GQ9CtvUy4BH0LFGnjqbpMQ5L
         bMEKY4Vvo7PYZbGK1Y0JwW/SqT+rSdOn/lsNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=deKBr0LFoKPX4TjZtCSnouZiCvMty0dcKoc4aq9X93o=;
        b=4ohdG1f4+33uhWAsLemBD14ZXRHQF6/Yptt8C4qGT/W64ftX1IGTPSyw8QrnSeqhdF
         0dHIIT87GEAY6Hqx88YN/ngq1H3tB3plN9ySrZAG1FxJW4mnwPHM6RrJDYFqAWqIfQ1k
         NA/tf2bGd7P6yr51w3rOltvuUzEGlzDAf3cNKoufege60+tNvFoOj1e6kfsoEWsPBooI
         I5yYV5zCY3QRS+5kogekhk4gk18BwYnaPqiosJ4A+aN34jNjQQlIaNQHZc9fhzIle7UG
         CHMtBVLFqiBFZAmHI4nOo2aiHKPxIXVSjDh+xf9/O7+AQwFQXyH+ukuKZeeRJrJhmLgp
         B2vg==
X-Gm-Message-State: AOAM530R1EeZMBUE6vYZduGT/Az1XrPtrHW05QAhm0gkuZA1Pn6VmIge
        P0tbjHaeidyWFoufNbLZPQWvnw==
X-Google-Smtp-Source: ABdhPJxcGmSRVnMQlMEXwzojRy52+Lb0yGIRbQNo1oW6pNe9HmnDaTzSBbGX/V2wxQGtRmYY+VUXeA==
X-Received: by 2002:a4a:9292:: with SMTP id i18mr521275ooh.90.1639427486265;
        Mon, 13 Dec 2021 12:31:26 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m22sm2534142ooj.8.2021.12.13.12.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 12:31:26 -0800 (PST)
Subject: Re: [PATCH 4.9 00/42] 4.9.293-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211213092926.578829548@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f10d5090-4966-dc8d-bf71-30dd9b312d94@linuxfoundation.org>
Date:   Mon, 13 Dec 2021 13:31:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211213092926.578829548@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 2:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.293 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Dec 2021 09:29:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.293-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
