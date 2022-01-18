Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ED849309A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349434AbiARWWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbiARWWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:22:00 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5CFC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:22:00 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r3so59293iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cm1T1i038ojGt2+/0BVWAAz3LDLXsJk0d/HaUDaaI2k=;
        b=F66FNkhT6RWOD4uC34F9tGfbW6KKDKMejkmwBR100EvrOibyU2yun23KvrlEKBjYYq
         TWJ0GH/9eJ5y7z1pX3dviMyvmp3K5YvOyMwp74IOKCkOZIpzTJ0gCOWH8SwNa47FAEhs
         l8XTBhlx5/opHGqq7druZVtsc4/3nwfByao/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cm1T1i038ojGt2+/0BVWAAz3LDLXsJk0d/HaUDaaI2k=;
        b=k9nSgHjobrOzQzXlwh2h/XJS95XPTIvHiEMsOUsgB50Du0TK6kpsySCN4U0UJ4tZyr
         uny1bCfphBtMSXRFCtJEWZyEkKyHZSxAZnd+WgepbarQGqZCq3eDjcfBN3m5dIedhwxX
         q+ZTX5607XRpF2ejavDEYVMt0Mi43VloLpclB82qzny29t5nxR+CUrUCMD5AKP6BllHg
         Lkcy2MUZAmjqpN2YPHtubyjKcwXcoUB/vUmg+zr7LlFv8Kh9YfvJqRsaK4RIhPlc1+XZ
         lDCF7yGW8/MO1y8CIvfqotCuv+mjyu34FK4v2kv5wDNnKe64ma53SWIOAlZvP4itfI4M
         vp6A==
X-Gm-Message-State: AOAM532zP4cZJm9yrU8XlfeRC7D0CfOpgrw3ALkqB+VDOr+zmY9dgF3h
        qZfoMBW/254grQyQElwZJBiXwA==
X-Google-Smtp-Source: ABdhPJwTFTbCgf2Gz4ABHgn6Z6m34uMyp2g+y+Tke7es+M3RQuU2H4qg3DOnTxLufD5GwHS/ed8C2w==
X-Received: by 2002:a05:6e02:20ee:: with SMTP id q14mr14942605ilv.44.1642544519355;
        Tue, 18 Jan 2022 14:21:59 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i8sm11973865ilm.63.2022.01.18.14.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 14:21:58 -0800 (PST)
Subject: Re: [PATCH 5.4 00/15] 5.4.173-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220118160450.062004175@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f2407f26-872f-af5f-2f77-f4bb6a20efa3@linuxfoundation.org>
Date:   Tue, 18 Jan 2022 15:21:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220118160450.062004175@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 9:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.173 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 Jan 2022 16:04:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.173-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
