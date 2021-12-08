Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB246C9D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhLHBVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhLHBVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:21:35 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E794C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:18:04 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i9so815310ilu.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s0qKDyUSX7oUear5OLLim6Kwhuz4N6fkk3KXYVydv0o=;
        b=K2ZQ4Lf8C7ESN6qbCeB7VgDPgXhCAI/5lFc1sQ2iKqPpPjbB/zYwZ7Zot9t6NKf9fZ
         o3HMIaHR5Mp7QM98Yg757t/T7DhDiQJUnmwgEspV2xEm9eyQfLqOaPo8A7Op27rXlTHF
         vfbCtt1so4uRqzUJVLZzxoZbezxRebRWudvf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s0qKDyUSX7oUear5OLLim6Kwhuz4N6fkk3KXYVydv0o=;
        b=WZuHBqCZRejrRETzFNmoVdHRs6nAyFpXU0MdrQxbEPXDbcHSZrdGsLcQEXS29EVcyg
         HzSKLCeJoBFiyUCVneL0oFluEdGEr9LVWtBR24SGzhtICrIAwsVp5n4Q2Hhgpfsj+0zA
         unz8yDkh4n3NKs9KV/ezq8/gHmWfK5D5OmCjJ4ID4KaBZb/s06lqJZ8GpTQOiJVP/m9c
         9P1Q5qZdZXjHehEMqG/sopD+1Op21nRpESgvZaR9ZjiE4UbuMcpJz8KUPjD8bbYuZ9FY
         GDUzfcHEhEV5P19oNiJ2MH9Q1WyA4Qk/65ehdIKQ5G6TOIZ8jBMsD/LNIE6+Et9c0XW4
         J7QA==
X-Gm-Message-State: AOAM5332TVT0PzzyjFM3r4SpHz00FK4jbo0613OWxLHVgZQYx88PuVs2
        +gJ7+btF4lIBNj4DosYonvA6Fg==
X-Google-Smtp-Source: ABdhPJyNIpatq/4bp0eHqStT4vvZ/gNBAMHJ52SsP1c2fN01bDH4ac5z2/YzCZPQzx9sh3SMxFnchw==
X-Received: by 2002:a05:6e02:18ca:: with SMTP id s10mr3242412ilu.166.1638926283355;
        Tue, 07 Dec 2021 17:18:03 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g7sm844683iln.67.2021.12.07.17.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 17:18:02 -0800 (PST)
Subject: Re: [PATCH 5.10 000/125] 5.10.84-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211207081114.760201765@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d0d9734f-e62d-3c56-72ee-ec952a29b331@linuxfoundation.org>
Date:   Tue, 7 Dec 2021 18:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211207081114.760201765@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 1:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.84 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Dec 2021 08:09:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.84-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
