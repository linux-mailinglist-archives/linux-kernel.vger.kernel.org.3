Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38E4484C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiAECQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiAECQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:16:22 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701B2C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 18:16:22 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id q6so29774478ilt.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 18:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+0nAn2fljOXYCTKaU8psQRY15h8t4XyJCVyYbQvxv8=;
        b=fALgnvL9LH+efjxqnMKpe5rEH7SwzFfCSGvL0zzZWjFPSQQw1vH0wd6F9ZR5DeD6vY
         baRJiF5ZgqNKhgLYlRS2azvCMQBhC71ZhrXL2sOPprT0CpB0oY2Lc5NWFyPubK8kV6RV
         ZweeC2eNqw8l8j36QJtdvRghSI8L0S06Fa/hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+0nAn2fljOXYCTKaU8psQRY15h8t4XyJCVyYbQvxv8=;
        b=4X/CqaS9Yb/6REg8aom//RbZTy3tyLpriBI1XFP7LxJTlmJX63601ON0x+A2nBTjDy
         DRxabL3jbPo9KHCk1CYZ37sJ6q1JjdvDta99kuRPagkGyHcooYs81F3cHhl3rTr78Z45
         LknRdz4UFV8NSYxqljbiUEf0ruHEIoOnFvKhzvaU59g7JqHIBhT7ud6rWnfAZfzroBQk
         OeL4O9yNnrCkhkI+PXKkuvFbDo4QOHbIZbmfvy0Ym4ejh3P+VUEWTinsjNtiY8xTrAvf
         /D11n+Aun2NUqiHXnJcG4fGmlnx8RTpvdFaMwdWgD1YEj55/wb0zm+n6ompw3rzLW8cu
         dKsg==
X-Gm-Message-State: AOAM5318Qb06CDepu1FRHRTXMy9iP18MZpSWDuJ7eByQ+oOQ/eYhuHRu
        0YVJ+jm0yUkDsUtOJrub6cu8Lg==
X-Google-Smtp-Source: ABdhPJwUAZH74PPDfkpDwMQQG3TK3yggt0UxeSfDFKfqGmps3b78HueSXIMXNlhvBz69w2OKRUVxbg==
X-Received: by 2002:a05:6e02:92d:: with SMTP id o13mr23933931ilt.49.1641348981724;
        Tue, 04 Jan 2022 18:16:21 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g20sm29205998iov.35.2022.01.04.18.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 18:16:21 -0800 (PST)
Subject: Re: [PATCH 5.15 00/72] 5.15.13-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220104073845.629257314@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <21de8f0a-bba2-c376-756a-a2b21f66b8b9@linuxfoundation.org>
Date:   Tue, 4 Jan 2022 19:16:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220104073845.629257314@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 12:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.13 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jan 2022 07:38:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.13-rc2.gz
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
