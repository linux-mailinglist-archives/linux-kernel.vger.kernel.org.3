Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2278E49BF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiAYXfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiAYXfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:35:17 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545CC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:35:17 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i14so18192702ila.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v5uItbLy2dNckIENJgQr6Gy//H+2b3w8aM/UfSPItD0=;
        b=DOSOSxxSU/iFt1DMzyD9v3XyoqYB3hyn18iZMxKRGmH6L2kVcaq1APN1OLfRQh2bHb
         yVpKEEvdgEw1S3NA8+K5fbJBHfIPE4NQH/lYU+jSIZEFIntW1zDU2LHXcPgnEKtEGA2l
         tMaNbkl64/BHGiDhHIdJLqx0lhSowLCp93WTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v5uItbLy2dNckIENJgQr6Gy//H+2b3w8aM/UfSPItD0=;
        b=aNSg3TKwffZkCgAdCyN29IJ7j9KtO8rZI7I0EONSI4wiVtkXXLkSgfnc1U1pYnE1AO
         276pQ3KljKJb5Ez8KAYrsE2pgJWljglGxrBqGM39D9jF7we2Qc6jInJ+YciXzb6XRy3W
         6EkBetveJVXk3efSoDDg6SKruzAj0T8AWlIOJukvC7DPo9A5+tkwlsmwSBE+5KPue+qf
         sXJjvdqc1uEmfUd3kFOfJi+bLgR1RLz9DEh4rLJ7dPNQm/mNWeITqczIJ6X6M8sabby0
         V87Et7zssmFHkDpqriKGe+74+IS8Y3XGCH0G0b0BnIeg0hnjpsMsgk1Sdqk0FJITg0qH
         4K0A==
X-Gm-Message-State: AOAM533+xvT4sCwIOAlnO8RhEetwjQzvFic5pysaCESKutZVDMbtoSxm
        hmeubhsgRF7BxG+Yj7ofhLCVyA==
X-Google-Smtp-Source: ABdhPJxWEGnDS1UoX54hiGsITPNXkvNmUT1riGw+sFUOt+f5WIbvq9clOksWzuv82FpVe5vIwa1atQ==
X-Received: by 2002:a05:6e02:1073:: with SMTP id q19mr12839539ilj.49.1643153716896;
        Tue, 25 Jan 2022 15:35:16 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id a6sm716492ilk.6.2022.01.25.15.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 15:35:16 -0800 (PST)
Subject: Re: [PATCH 5.4 000/316] 5.4.174-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220125155315.237374794@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <382fe443-eb06-8eb6-d104-a59bb090b088@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 16:35:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220125155315.237374794@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 9:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.174 release.
> There are 316 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jan 2022 15:52:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.174-rc2.gz
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
