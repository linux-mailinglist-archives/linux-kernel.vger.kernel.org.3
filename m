Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F548F377
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiAOAZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiAOAZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:25:24 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DABC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:25:24 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id a2so3848648ilr.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K47FaHwTV4J1SuMx8/Y6BqOow5A1THVY4efkflHLIDg=;
        b=fKCc9WqXlqcaKQ+Od2hJzWck0ZWTmw+FuBh3zvDzmlg6BFHRNGF2xQAvqmgM4RGWiE
         0otfFuFGw4eHHW2IVHlCh6DkImBQIAqPuBq/mTYZWiIpkoWTs5mAjfcQJ92riVSqMWpu
         xcxOxjBevfQxUEh0rvf8cP8NbqoP04r72l3OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K47FaHwTV4J1SuMx8/Y6BqOow5A1THVY4efkflHLIDg=;
        b=7OG6VkZ9xcdLKEKXhASEL5iDOoeV+Pn7f//8LyABqlj+kfO1zn5f7eNFoqUWvUmtQD
         GMjxRzwJwm0KDHsfMdq53Zh3quOprI4vmCrgvwNscl4/JIqIje1pw8qyUfNE+mi67+Ms
         K+XHNbQ8zlEbDaG7sw/1UnUjgHspRnQYATG7yQqNYDTLo8ZrF6dGnvZxOn/f8ljtsroU
         9cJos7WHIuPS7d3ktfooHh8uMJ/6y+pMc6/r0nhFHW3JDm2PE3uUrec53l2VGBkQybhf
         hj4N/Igz1V/FNqFPHxTewQxZLxZx/hvvXSOQKHpMzuqPCdP6JggVnZEmXvKX08nbKmFr
         Jalg==
X-Gm-Message-State: AOAM533t1d+cmOF8W6tvlSVAiQJjgcaVIvNCUVvtREVknEW3g10lzXWL
        qjHyabJXmxlLDBf40HtNmU9J/Q==
X-Google-Smtp-Source: ABdhPJyGnrMMz1S3WSexqoUXh+PQXA1+Njaa6ZvzEHJ+7Txq8zYQMq1dQjb46iXdRAbHJ9deJN/Amw==
X-Received: by 2002:a05:6e02:1b8d:: with SMTP id h13mr6271492ili.26.1642206323830;
        Fri, 14 Jan 2022 16:25:23 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b3sm829832ioc.16.2022.01.14.16.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 16:25:23 -0800 (PST)
Subject: Re: [PATCH 5.16 00/37] 5.16.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220114081544.849748488@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <da1d204d-bc51-760d-985e-7a3daac62f2a@linuxfoundation.org>
Date:   Fri, 14 Jan 2022 17:25:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220114081544.849748488@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/22 1:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.1 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 16 Jan 2022 08:15:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
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
