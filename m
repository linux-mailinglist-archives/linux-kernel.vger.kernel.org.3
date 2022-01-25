Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9B49A859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiAYDDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415600AbiAYBsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:48:09 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC3AC06179A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:48:09 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z4so391084ilz.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TcTjktdwQBBVKF9vPy6VlJWnBnsd4qaUxxJFKbh9HNI=;
        b=NCVUneneGDmkiDvfCj82fwHeBQ0NoayROmABAiQwmGxAU4kJCX0L8garbYQzzANF8D
         fNA7WLz3sIkMnBxu8xVJcj5PSOFPV1Goj5Noj+CWQxbYD7fJ2fWmMnRSx1btCN+u+kOZ
         HYL4a50k+9C1zNXEgg/vfRWZIMaI3IBTBDhFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TcTjktdwQBBVKF9vPy6VlJWnBnsd4qaUxxJFKbh9HNI=;
        b=drVSYolt+8tzOLaH5WN0hKK7TcCnisgCVbBW0/69G68Q2DgR0+Fh57pxhlANz3ajh+
         kpPt+tgbxs758Yyqy/OEGCFR/COySWUx2cQNUygrVekF/dokTQIa65B4qrNBSj4BN2QG
         HKLJhvXY1rfFnfRoYbgPHnIFuFUdlBzV5O4GCrUlZ3eKog7Zm1ObLHXuv1mKlBlus9mK
         tUpvAwbbyEHelTbkjrYpvZxSrgJ6COy2s2c7kToLYjuYUTtLFRf69FBov2v5v+jQ9pvI
         qn7Wo7iCFkcWWFwHhE2WjD0NPyWIvn2vNca81S0K1IoaE6tyz+ytzoGENoTW5P1u9xwj
         +EuQ==
X-Gm-Message-State: AOAM53385a8v5jzUybbV+GVuOO8pzztG1owyT01E9vLhLW0FNkJVHRUd
        0ey3WLQ9L8BvhviM4UM5krxisA==
X-Google-Smtp-Source: ABdhPJzWq9bmRGqaqSAji+NFuJz0q6lFuPq+ULQ4SAt3uCy2B+6AUo6o4mKPYBzY208jdnggHRa1Kw==
X-Received: by 2002:a05:6e02:180e:: with SMTP id a14mr8264008ilv.307.1643075288943;
        Mon, 24 Jan 2022 17:48:08 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id e5sm8081707ilq.9.2022.01.24.17.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 17:48:08 -0800 (PST)
Subject: Re: [PATCH 5.15 000/846] 5.15.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220124184100.867127425@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cf082288-9b77-c7af-f64a-cf94a9c3fdfe@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 18:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124184100.867127425@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 11:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.17 release.
> There are 846 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
