Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1323C484C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiAECTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiAECTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:19:09 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17BC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 18:19:09 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y16so29831915ilq.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 18:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QQyNK4z2xjBZLN+iy+sPLS1MjEHS68Xh2UKK8u18fS0=;
        b=SKv6qgik1elB/bn9E4/f/Sk7P9wloDS9FDqLagDtR84l2lzAK7os0iWE6pTvT4ozuf
         U96DxqPAxF0qprm3CfCmgybGr5LaTVuHk4nfAyEebBGALOj4nbUZusZQAyC+/VhRrOvQ
         gOOTJ0VkbBqsBANiEnhR9kKkW3ADkFHJh+Z3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QQyNK4z2xjBZLN+iy+sPLS1MjEHS68Xh2UKK8u18fS0=;
        b=QAkAFFfTUmEia0hKskxGS2GwCG20CGRKCtVyHRQ2mZ9to9QO5lCqsrB7tNkg6texy7
         EKaQ3JRqd0edoa9MGKC07V6rHAWeFdrN0JPVuj6vzPOm6ApbELmyaNOVDq1BdOd1ujVS
         4jZV/+Tx4HeUWdnl9bywUPYYeWgZrTIHYy/ePupK4LtlHawrrbI/4eKrafddCsybKLhO
         ng4myIYsF63b23CaFGMIe2tr0eu7Ur0TC6gbmGSEh3ldiAZOc9ImM0y1A3xw9qqXYTp/
         ZSo7RHsXJFb25LF6YvFEdwhaeJQ9UKcgDi0nVNUAnu04GhyC89awS19bTvlbKCfxsZb4
         Pw/w==
X-Gm-Message-State: AOAM531XBmnbW/TjZKxRxOjHSLsGwWx9VCJ3sQXGPtaCrn3x5hrRqjpd
        xzzoKBBG3UDWS8C7+UCO5Nkuuw==
X-Google-Smtp-Source: ABdhPJxIK0L0AX1QHytGlY7mNNE0cgIA7rVu+9RZjFVF00bdreoQbhUsEJ10kdrfMoMfFLyfOhAONA==
X-Received: by 2002:a05:6e02:12ef:: with SMTP id l15mr11123685iln.34.1641349148810;
        Tue, 04 Jan 2022 18:19:08 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r12sm20742448ill.58.2022.01.04.18.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 18:19:08 -0800 (PST)
Subject: Re: [PATCH 4.14 00/19] 4.14.261-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220103142052.068378906@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <57018043-a091-4383-de89-e508cc7cbcfa@linuxfoundation.org>
Date:   Tue, 4 Jan 2022 19:19:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220103142052.068378906@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 7:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.261 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Jan 2022 14:20:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.261-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
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

