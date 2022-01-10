Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFBF48A359
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbiAJXA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345588AbiAJXA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:00:26 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC97C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:00:26 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h23so19779369iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPlgaH8RSmMz+j/Iej8qezGlqpIWaIdsG1ptpmEBxJA=;
        b=F6irRvqO9uUhmUrsz95rKJPytggE0VlcENzHu4ks2w4wf0X0W3YrdzzxaN/3BCmFv3
         4grg2th/Nw/q1CE05uXpeyrkYWhmw17jTDPR2saQBPbGal1UOhDftfp21Jh8tGQYWsX7
         xPbOnVZCHNtjW5tbML7rz7DHBVw4f/uROwUc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPlgaH8RSmMz+j/Iej8qezGlqpIWaIdsG1ptpmEBxJA=;
        b=SHer32bNuVUmvOh83gPDE62F07BwIVusX1DhuW12ljlr2ZKpbnXeY7SaGBYoYuBgNY
         Cjw/emSo9gDKunI84mCuqiy58pUuT/FPpVxbcxtYcvNsk9Q4zSHWWk6RihcM3ZBitMvr
         00oRr3ZH2dHmDydPCKXDkv2gEON1lZkMf0EuqufpuGbx8eFN+yy0IYSo2+J+njzPPWM8
         MAaC+rEbu39/3k5a2UI+FXVLdDJUakZczG7jeeeBuZlnR/xsOeEp8lMSXDkAWjUIoZgt
         fCO05hJlLPZwDEOXmQRWYqi49oXHDfUUwJM+/WuSMkUAn6AdFABVrOI/NArZaapboSmj
         +0QA==
X-Gm-Message-State: AOAM5339Wjo21uQLFqKK9646MYHrHqlpobil7bEx4WqrBTQWVmkmhVNU
        d8r9gRhgemWwy6tNp6C1dzVCGw==
X-Google-Smtp-Source: ABdhPJxbRm9Pzyfd1/F9WvTsP5t1h9WZQd0Nw2IihdNxgugj+Nn5j3fSmCsxgQevKix2LcNN8z9a+Q==
X-Received: by 2002:a02:cdd0:: with SMTP id m16mr1063521jap.158.1641855625589;
        Mon, 10 Jan 2022 15:00:25 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z9sm4968282ilu.82.2022.01.10.15.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 15:00:25 -0800 (PST)
Subject: Re: [PATCH 4.4 00/14] 4.4.299-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220110071811.779189823@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <eecff82c-5e2c-330c-e290-1146d62b72ed@linuxfoundation.org>
Date:   Mon, 10 Jan 2022 16:00:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220110071811.779189823@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 12:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.299 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Jan 2022 07:18:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.299-rc1.gz
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
