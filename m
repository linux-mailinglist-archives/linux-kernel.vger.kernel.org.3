Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3771049A86F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318763AbiAYDHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347011AbiAYB7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:59:01 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D80C055A80
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:51:18 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id a12so21924325iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PLNl1n+ArWj4qgvxdeXOuJ0Go6oqKB8kznJ4QDRWUEM=;
        b=QMmybs4P4z/N501e17N58Rqmft/exeSOywcpVLntSEwc6z8ZkVkrxP1N1tdrJ4cHRe
         8Q6ITbn0VT+8vdnaT4dPjcSOO/LssB0Yu/e3s0yb/WxRvqJqhTnoP8CLHkK/zUvpwMOQ
         a6utyFhOpOb7CfZlcWuFX5m2ml0rmsvTLSTLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLNl1n+ArWj4qgvxdeXOuJ0Go6oqKB8kznJ4QDRWUEM=;
        b=62dv7tPk1/XuOehdsVEjWk6LoE/WZPIjm/9QsSknP1FeTohQ6PHEoZEslcVdTlmXAe
         GP3KAko4ZMdNxyBwMYmY1J3+59KXvCc8wfjRmLGXJmIVkjF6UqQlGTawqQpvtyfyG0wt
         LKQWR8xy1sW6cppecfdyh4yTurB2maT0iNGmDFjhJASNcyAJE4lg9fwJ7Rxjj1QSxmYw
         /C5pots2VIBUNC41RjXPrVLYRFQVaOH5TzSsq3JILAYyPXC9kh08XUB2vsgcTZnC6BxC
         OEV29GQiQEXbF2uHG2GENXvUNz7AK631fG2Z9EG07MiYz33q5gl2G1ZjN8sBEdkVhk4p
         xdvQ==
X-Gm-Message-State: AOAM531PIotfvfmsTXAu1KigpezS3R2Cl/ilFTURzptdIppnCILCJm9J
        8VTZDacI5R+8BbK+tbCNLKNwPQ==
X-Google-Smtp-Source: ABdhPJyG9fWz6ez4vBJUr5NEHb+kDo75RY6fOU8hfE7G7MsCUG9lsjGpnwqG9w7vNUMQof6ki72mXQ==
X-Received: by 2002:a02:a1d4:: with SMTP id o20mr4716189jah.45.1643075478323;
        Mon, 24 Jan 2022 17:51:18 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id u2sm8346698ilv.1.2022.01.24.17.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 17:51:18 -0800 (PST)
Subject: Re: [PATCH 4.4 000/114] 4.4.300-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220124183927.095545464@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <de58657c-71fb-96eb-3dbd-2d99f2507518@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 18:51:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124183927.095545464@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 11:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.300 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.300-rc1.gz
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

