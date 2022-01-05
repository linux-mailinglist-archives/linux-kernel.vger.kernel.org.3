Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF851484C72
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiAECV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiAECV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:21:28 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C07C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 18:21:28 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o7so44767168ioo.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 18:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+JhvZAhcIbvUejpkurtGrjc2CQFerKc5YStUGJS4tsc=;
        b=dJCXYnFHlcn1mK7Qr4aPNzt3TlXFZ3T7TaTYV2AYJlMOIpXWWPAsGNDJ+a5pEUBuCC
         d4b2cLhefbo1zpRYQar8iuF/yicr/iYJ1xRHmr9odeyZ7bw32kw2LHYgZ7uhzqE5frFP
         ezKdFVnpDLzfCqvtG5HFLQ4P57XuOyA7bYtG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JhvZAhcIbvUejpkurtGrjc2CQFerKc5YStUGJS4tsc=;
        b=q6bB7vBOEgszqhEtF+w3bEa/L6ray0suhjLJfvdVlo6PLdRCd1NU/QE+f9asNK8HA0
         gEhvAJt60m2uOhGI7Kz5NcbyyAxAagBhPZhI3rd5S/di62lxb9MOCDWNT2idyi9h1izx
         jDpOBdh8iVD8l1Fc/38YEbJQbYqaxIwJb6YKDNEqibewk64IbO4bKmr8hHmzm9KxMAZK
         PO6F/o3xSOi/28RDhEChm7COVhu5ak/k9FgzJsl24ipve+N7E2nEOEqEKmbpofMzWfF9
         6oeQHAWWA/n2y5bjXHpnNoOzYC9iiT1sR19RrTALuxcQ66Etud64/bc27ZQKlmX3iOrf
         9yCg==
X-Gm-Message-State: AOAM5330tMvuqdtdyx2w+TgDjlkhLi0ghRpnRtINEoOcfa7U/XUeAmBF
        vSGQbGz6OD7qjwM5Y+lwnluysg==
X-Google-Smtp-Source: ABdhPJwUZ3iHBttTA+ssUGQmMNDklxwKrgg/WTTEs08cH3ZZ5wU1qaw8Qo4hcGDkQGd3J7zYJnKCfQ==
X-Received: by 2002:a05:6602:1686:: with SMTP id s6mr25326913iow.186.1641349287431;
        Tue, 04 Jan 2022 18:21:27 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u24sm25705454ior.20.2022.01.04.18.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 18:21:27 -0800 (PST)
Subject: Re: [PATCH 4.4 00/11] 4.4.298-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220103142050.763904028@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <33933d60-ad87-469c-1bbb-0af6ce093db7@linuxfoundation.org>
Date:   Tue, 4 Jan 2022 19:21:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220103142050.763904028@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 7:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.298 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Jan 2022 14:20:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.298-rc1.gz
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
