Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD32846296B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 02:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhK3BHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhK3BH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:07:29 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5306C061714
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 17:04:10 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z18so23951992iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 17:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v08//6x23RK24d1djPjWJ/lHAx7ybQ6yNemTD+/1QbI=;
        b=KZXr6znYobJE5JXq+dT+7jJ5K08DqFjWSSz2dudSjeO/boDceD3mSIlzr+w8wevZ1B
         wUrfAfNFV7Zt6zJIBdrmDlytryiPCPNslPISH+iBUSAShuF2X6oLJ4eskt4Hsn/O34D+
         SKh3B0FmSmMWlPJe8/tNnAIYSb14dwNZ3RjWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v08//6x23RK24d1djPjWJ/lHAx7ybQ6yNemTD+/1QbI=;
        b=3hYFLmMBvrGJP0CxJF3gP4e/KeeJ6fvaShPwEre4GdKuCTdEh6BI8C7eplh8kvfjo5
         DqtanFb9Kto+VAIXSrsPjxREysQv+Q5FxSM1iyN4b4xga8vts5Mt7lGw8RJ2wXSe5OZq
         OA4sXHbRUu4jkiFSPRToVqayC54sIZWAc7AH87/D63YP/glwsuffESWlMJk92hHzmpJ/
         B6RTm3DDe2LMguKax7HIz7TSDl+nsQP4H368ZRgjwyMn7p1OqpSqLQ2Sx6HwwUulA/CM
         EW9aPKz7d34wiGjxouEKYMm9mbKj2kZaOxx6TYswh5+r98nwSv+589OJ3/y/ztt8Zdjc
         fWMA==
X-Gm-Message-State: AOAM533WGSMG/bqiyX0fTCXgT6LnX9aUOGXj5QoImDPV0X5DqgqlynIO
        wFHKbZIHsjczUmJ25d2RbHlEOg==
X-Google-Smtp-Source: ABdhPJyuGwkbb2z5oSzX9keZLzhTm8VTIhVkpzk+CbrNNj4TyWNcK6iwL3PAU3E2/tU9qNh3iuKhJw==
X-Received: by 2002:a02:a708:: with SMTP id k8mr72088452jam.26.1638234249851;
        Mon, 29 Nov 2021 17:04:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f4sm9224328ilr.79.2021.11.29.17.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 17:04:09 -0800 (PST)
Subject: Re: [PATCH 4.19 00/69] 4.19.219-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211129181703.670197996@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7e7e4446-9e8b-a694-1d45-70634052a3c7@linuxfoundation.org>
Date:   Mon, 29 Nov 2021 18:04:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211129181703.670197996@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 11:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.219 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Dec 2021 18:16:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.219-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

