Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7249348F37B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiAOA00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiAOA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:26:23 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11632C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:26:23 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id k14so10352544ion.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nnn6TgbEatXba1qMqMpIFTzJjUEOM6DXsCEXS6nFHmE=;
        b=FxVnvey7Eet1ab80FcuPZfwDVxn5H2v0ZIRgLD9ZXul3iVXfZwPY5wgQdnIwv2jAqG
         igxt+ClWx1l1WITfulHYOxxaX6FBBsxKb0gyoSAnmvqZAMdWpycW78KfQ5u1oUE73ptF
         lCwJnuFSkSZpzpIQ0rdUebdau4tf4DW1fTouw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nnn6TgbEatXba1qMqMpIFTzJjUEOM6DXsCEXS6nFHmE=;
        b=zoir4s6G1sVN6+A8e0XlTPb1G1TgtH9vd38fbIJyndiaH7M9EEYkqIEE4vA3OSIyPq
         gHxgk5G5jwcLqwAyi8995pSYBLSZrJIA3Xl7D7Zw+NjIs5MWUje2FMr+qwpnc7zyCrTy
         vPXWGHEtYAxGEMZLUoGz5El2Kq1Lphd2fgQVEAuEhUza9vvoVMKBGNif39eNQA0Prz7f
         Rk/arsisJr6kDjXqAQ8dEgFSyEM1qsf4wjAAb4OJ+6ASrxtbIlmX5GIn15O0X0aeMN9I
         gZVaMh1RD/tc44smIW4MZ95pfpEwrwRbzsBXQJuLRtKzvcbfX4V3GrOyGhpe8mVFZD6y
         W7Jw==
X-Gm-Message-State: AOAM530baUjwrUNdv7PUXE+fBcKYoNee+gjQY5nfbAOzAAo1qS6MrwXi
        vS6qipOdGe7HRmSTR9w8BuPjaQ==
X-Google-Smtp-Source: ABdhPJy2rTnL8+f85ezuzw8CkOTq2U6mFOjYthQYNn28RrDW0EVAxKzGQXezmSDceB0QPn0vK3Oewg==
X-Received: by 2002:a02:9508:: with SMTP id y8mr2922570jah.295.1642206382413;
        Fri, 14 Jan 2022 16:26:22 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a7sm4670869ioo.5.2022.01.14.16.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 16:26:22 -0800 (PST)
Subject: Re: [PATCH 5.4 00/18] 5.4.172-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220114081541.465841464@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f33d717e-9fdc-76bd-f3fe-144e29e1e62a@linuxfoundation.org>
Date:   Fri, 14 Jan 2022 17:26:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220114081541.465841464@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/22 1:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.172 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 16 Jan 2022 08:15:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.172-rc1.gz
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

