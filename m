Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E4480D61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhL1VaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbhL1VaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:13 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03AC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:13 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id y16so15185546ilq.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sJpLTpP4QDI6cfN8o3Q88KiR7SnhcBIGx0jwnSt1In4=;
        b=hmLRZsM3ffY25FkK7SAmoUymwLcavpa3tgE8X+u6r4mUgSjdffrxxYxvs7ksPthgB7
         o/45yeKvjQbsiqU03JZW7r17TCwdjdAWFXJNjLmcn0FWt7JX8GQmHcxYjwPk43QF+Cu7
         ta8vgSrnO+aag1PCVNEw+rVB9vNSaCpJpjGpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sJpLTpP4QDI6cfN8o3Q88KiR7SnhcBIGx0jwnSt1In4=;
        b=tvg0jZN6bvUkD54x14Jmb4JFvhoPG2GeYuvAG5hv/u1i+lcluHHf/XajTfHL0zHODT
         9liO4uwOR4AF/SlFgvV7iu/dKRXRBjsFu+rjEIgmjuYWxZ5cwzvdCEgeI1DSKO3TAzxI
         8H7Njb6LpRMheTxNv9GY5t4l06RgEUFq60lS7REr5dDP/c3QFvlmkRWHmGKf/syx3H6S
         tVk0Mu6leTryxDfgXAZOg4zPiDjndfBHhacvgh8Pz/j7eTcNYPc3+1nuoZujeGUGrbsO
         NJTEB9gsKuAM9HrlZnHMd34zKjfPaN2hPyNsW3Z8+UvQsdDpL2S3/8b8Y4Wyu4SxzKJV
         Pe5Q==
X-Gm-Message-State: AOAM530GRq1lc17TNCiPSUI9/skKas4bp4VQzSQxdCmli2oe4zG6gro5
        05r1Qm570lqnEn9Ks7xr2FzKRtjKlHxwvg==
X-Google-Smtp-Source: ABdhPJz/tzUsDxpl0TvrnLEgzd8CH7dMUYnFUxxnA37lA6qqUmAUPJZL98jW0rAdTdnw/bIKg2m9tg==
X-Received: by 2002:a05:6e02:1d86:: with SMTP id h6mr10395171ila.265.1640727012777;
        Tue, 28 Dec 2021 13:30:12 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y15sm6606908ill.15.2021.12.28.13.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 13:30:12 -0800 (PST)
Subject: Re: [PATCH 4.9 00/19] 4.9.295-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211227151316.558965545@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5bd74040-d49b-c428-712f-f1371e96907b@linuxfoundation.org>
Date:   Tue, 28 Dec 2021 14:30:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211227151316.558965545@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 8:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.295 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Dec 2021 15:13:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.295-rc1.gz
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
