Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C319A4A5237
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiAaWRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiAaWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:17:40 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E875C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:17:40 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p63so18001252iod.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ixSsSZNNXa1x0EU5SgRGr7tTrFXXVuJli1qeIsbs3L0=;
        b=MWljJdprLwmkQTcNqqSfprof3T4jcAc1+EkLTD4QAA1lyGJNGmQV9uMsB5U8n+JPMG
         RUGubujhlzkdn5cHsFCtsMIACiT9V6qy3F2CYqTxGHctzGG4mFe4fF5x+/BoY29WObtV
         a5APtOLnQPyRbBqwo+aYvj4aX2EhbZVTuO5bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ixSsSZNNXa1x0EU5SgRGr7tTrFXXVuJli1qeIsbs3L0=;
        b=I2xxy26BC66905Y0WilaBf/C7TiH9lkc6fgLGdAWWgXUT9o96biuCFicthuHlk/sAe
         jAk3oWiuAYa0c1TlNvVjBzSlTF3QrmaLo8gKRKBWesjR1ySpsJiUzEzNmsqqJAwY+DzV
         aKyarcIyg+TCqwh7YSkERJJYD0GPWw1ceDDBN94LuzZ53iCfJl2mJzwmiqBECP6Y2c4a
         jbvV2iR58Se8G2HqXH4JQzVi4YizzyFkPiuG0TUYKFNPWmkIMuWicqKlH3Ty2KUNO/ms
         /hO1Fk0Tq6cBYAZul8Vulj1+SOHEVXWa19RyK5WpC0TiZZT0mjzHPxONBPSoQ2ZCCetz
         c6qg==
X-Gm-Message-State: AOAM531NNQ9XcABX7t74vv2iP1/AlKdruZORtwL0rKfACiBy5gjee5ov
        F0A5u7FAKt6oKjU3W0UyFm29lw==
X-Google-Smtp-Source: ABdhPJxlqifQ06snSOWXPp15iE48EJ5pC2ndgnxyFOYGPnXk3a6d9xtXczxLe7pPWVcVku1Uou1ueg==
X-Received: by 2002:a6b:8bd3:: with SMTP id n202mr12197088iod.114.1643667459900;
        Mon, 31 Jan 2022 14:17:39 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g5sm20136413ila.59.2022.01.31.14.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 14:17:39 -0800 (PST)
Subject: Re: [PATCH 5.4 00/64] 5.4.176-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220131105215.644174521@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b2eb630f-d362-13c6-38b1-b5270c615873@linuxfoundation.org>
Date:   Mon, 31 Jan 2022 15:17:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220131105215.644174521@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 3:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.176 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Feb 2022 10:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.176-rc1.gz
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
