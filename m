Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEA3480D59
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhL1V0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhL1V0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:26:47 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F4C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:26:46 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id b1so15202828ilj.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8TvEHADrYpunnbEiMmuvsDShsFF6nO9+iyYquSrp8ho=;
        b=EiXE4D784kZi6Rby4mfeU23jOF1SO9g+VThI9febJfgb4mPZMs3kiUbre8/3mrwLG8
         YBuV/Aif1qgfYc8sUXhtKCYfwdV7Re/bVgOk0ZIG/g4Df+vh4zIk8YCtbldgUCgeg6KR
         bQQtN+H95EgPFbK/e7lodCppUdmRmULsDQhww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8TvEHADrYpunnbEiMmuvsDShsFF6nO9+iyYquSrp8ho=;
        b=mCS9N30NpQ6bF0Z4FX3Su5OLlEmTkMCmccLugz0BHIIraCypJN9qmRDISj/APR/1FZ
         vjc/dXKOFKl1x4x28P8wOb/zAayIVUNqHPxXemANszIOSNIc+5L//ArR56N4vfdnWbLh
         ePBPRtO+R0568VpXqBTOpS4OvbKVxQ3nCEO2h3NExR0UIFn8J9xB3TZV2oTEchXx5E9t
         DDev0ZNx92vo5SiQg9vPPLpChtc4vxwXY1Mil+pzBkNN7Ft+7peIoTjFucxcswSQYYZQ
         zUJTRl5dG6N6jf9uwFYLDe23GJU7CA+hYKZX83hm2LOEQVaLDj5l+ysA7Z53x4MW1Frd
         Vsww==
X-Gm-Message-State: AOAM532fCfJy3fDceO/0vYvazYokRd4zDmCWVVcYePA/Joow1UVRTEx+
        ncc1iODB7Kz4Mjn0IW98ZoHNpg==
X-Google-Smtp-Source: ABdhPJyrN92wesVNSdiLKRTG9JmJdL6a7KG51/9qIax+UzL8v9x8SdFCxpkAHF+Rtu86USdskx4XZQ==
X-Received: by 2002:a92:d091:: with SMTP id h17mr9674349ilh.102.1640726806203;
        Tue, 28 Dec 2021 13:26:46 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i12sm5391119ilu.84.2021.12.28.13.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 13:26:45 -0800 (PST)
Subject: Re: [PATCH 5.15 000/128] 5.15.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211227151331.502501367@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <548fc71d-1eec-b350-38d3-b4740c22dbeb@linuxfoundation.org>
Date:   Tue, 28 Dec 2021 14:26:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211227151331.502501367@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 8:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.12 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Dec 2021 15:13:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
