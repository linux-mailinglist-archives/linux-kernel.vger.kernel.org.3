Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5749F073
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbiA1BTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiA1BTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:19:13 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34446C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:19:13 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z199so5912681iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FpJ041YGFzawtPEE8PWXQZqe8kPrnkBMAyOtztAhIb4=;
        b=hyS7GRnMIgdorpHp3YbAOf0THSIhl5BaSjibjEgDF7PiTyKCbQmOc7ftVhBnwJvmSs
         cb4Z0uDd1TF3gO0llJg1gCRaWfawBXvAkODXp2QZnnrZcxuosE3Wp8tc2vleB1mwbJFv
         ygLOk3fWltBe8PViIDC3OH/K/0OPA2LKKrtRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FpJ041YGFzawtPEE8PWXQZqe8kPrnkBMAyOtztAhIb4=;
        b=dXS/dDmIgiH+OVn0IATTLi+zflGP4S8QpUYDnqEvT1mSY/Jk1mzZahnI8MaDX593im
         vlZDFlc2/VP1rHLmc6C5KiJtPMbfN4JR67REULyL7iyBbt+n3+pMpbu6dl027idbUvfd
         8614lJ63ymZlbCOkLksXwnRMDV7eu9Z0pwuuYekw94ZOT3ISOOG4MFefswlgILxlVUhW
         97iYIYw2iEqiKwRmNciSpzfwD+NJg35k0AW8lrnfSOpIGz4gXkEjhVL9/hQv7lISsxKm
         RCC5sSu7qN+HvTmGVZAqeqPX+OyteCWthnOclrtD+KQGv7Gk9ftoxAEVHeZn4eh4yHUM
         d25A==
X-Gm-Message-State: AOAM531ZCzN58U0jT4ZxxpcYxqz/6JonGJduT6jlRFMogAjzOU1i238S
        u/PuPxBEg/LTgMP3C3qFR4MjUoB+jwjVMw==
X-Google-Smtp-Source: ABdhPJwaRW0i76NqS1xHVhyTFRerrQ7EZmHCmRPxj9ywsdrOPQmkZCDGBjmOrE1jbA7+W8N4aPK/aA==
X-Received: by 2002:a02:c894:: with SMTP id m20mr3449860jao.136.1643332752686;
        Thu, 27 Jan 2022 17:19:12 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c9sm12886358ile.38.2022.01.27.17.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 17:19:12 -0800 (PST)
Subject: Re: [PATCH 4.4 0/1] 4.4.301-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220127180256.347004543@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <57a3ede3-f1d7-d600-1a5a-e2b9c8766349@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 18:19:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220127180256.347004543@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 11:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.301 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Jan 2022 18:02:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.301-rc1.gz
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
