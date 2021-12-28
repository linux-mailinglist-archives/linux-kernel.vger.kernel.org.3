Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE24480D64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbhL1Vag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbhL1Vaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:35 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746A1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:35 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e128so24012128iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZvOfSOH8VFifkcrmWap8PZDc6B1c4tbfrTrYb0VU5Ok=;
        b=DHFOvCCL9iJwPLjPnbuIAY2nU85/k0njuLcPNcdEQlFF+NYdW0F8eNZ8uTosAsu+uC
         ilmjEAs8vB113UKCmMtlVrYjzvjYPrE/u/SZHUbo86wW28Dk7o+X6Ds32mSLcRCgCJM2
         PcyitPOLPQgKgvu1SzY2TvEXjf36DzDjDa4F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvOfSOH8VFifkcrmWap8PZDc6B1c4tbfrTrYb0VU5Ok=;
        b=SZSssbXwd7n28TLA/w5d3Ng/r+3rjoO94ebTpqbniolIoKjsBzEl6OCnaR96Q4O805
         imyMFjNkKSaGIVqM86fFOn4tAM+7OZcyOdk9dmxVWsL9Tsmd20C7abtWzLuNN37rqrrf
         iTSdFE08gGYuVYCHXwrj0oPAjke4IzMYLW6H3LBoLnOT1eVdw3aw2ecJnZP/A4zCWUkz
         KuoxomrcA547f9NhzjBs2FjqYhXj66v373V4momhuJqY5Ovedl1/S+PRD0CedETfaJEh
         SKLjrfZrhmcTjsEdEkk46YcmPtiliTZafU/0sOubjtRM7FElPNAtObnilAU5RsTZY5Hd
         Y07A==
X-Gm-Message-State: AOAM530igZ/EkZYUlHYws/Q9YQAsA3BXO3jVn2jOwSylCN+EOAMxCulb
        0FdEdiBGcokEjXE4yJ/Cf5ndPzJMBNvqtw==
X-Google-Smtp-Source: ABdhPJx+8/QcoXRzcFB8YMbAJr2xfhU/QiDG7+fjBSVkFCGiDCrb3D3L7dImRhvR1yxrlp/QPN30OQ==
X-Received: by 2002:a05:6638:d49:: with SMTP id d9mr10414038jak.79.1640727034804;
        Tue, 28 Dec 2021 13:30:34 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n5sm11564536ilm.87.2021.12.28.13.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 13:30:34 -0800 (PST)
Subject: Re: [PATCH 4.4 00/17] 4.4.297-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211227151315.962187770@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9613459a-c98c-7f30-4e2a-ac55e24aac43@linuxfoundation.org>
Date:   Tue, 28 Dec 2021 14:30:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211227151315.962187770@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 8:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.297 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Dec 2021 15:13:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.297-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
