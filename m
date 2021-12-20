Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BEF47B623
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhLTXTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhLTXTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:19:16 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BFC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:19:16 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q72so15360940iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ixwBixl3DA+Ak4NT1uAzar+Y8cmjPcOD+Oeij9tM0xU=;
        b=TZMba17RhAqvQRP0CtntsGxAOLnOEl53W6rQbjAw4j8wXsGtxK1dBKVZZIgn71W6zo
         cYYW4o3zyiFZkXRmuQ0V4aSCtIg6D7JE3x7FNph4PHNxgRiy206D9oThfCT0WbO9CUcI
         rkwBOsRWd+CRT/tLvtmTwN+kpSpcH72Ahl2eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ixwBixl3DA+Ak4NT1uAzar+Y8cmjPcOD+Oeij9tM0xU=;
        b=qruoMFq3mJN4hjluAlyGzS/r05CJ3t1rUwOstzz8SKQge2fsaXVAbeFYr5nB27TjRv
         xrpHBCHcN+fx1T4GnNUD32KQHR5HiH5o80hoXJcrykRquERFnk2fPq4lVIUVPvHuTvyc
         9S0UhRQUP+lPAVh5ARFQBMstm0xWQ9vc2JUjrHK5Rd+7ltF+PpC1cjw3dUvEdRIjeMy7
         kCFkQnY7QyiDk+HMg0/BbwNGiA6yJBHsg6kZ+pZIztzQD9ctRezUq0+juLz3Psiey9nJ
         8SUA7iLnoEQlPgmqJTLNTxx8IlEf8TKdH3o56Y8Gkcus6pe9Z+PozIcQfOgFf6XtwcWk
         iK6Q==
X-Gm-Message-State: AOAM531SY/31EquABlSe2tI99fLNu/eAMCY9j9hjTW0ODBP7i0HeriN2
        4uSkRwc54AZsAzKx0YN0WFGkVA==
X-Google-Smtp-Source: ABdhPJytEZvjew9s5V0Dvuv/njOuPuvWwEfMvMb1Wv1TZixNdoaRPIgkzl/rrxOdHgwIsbWBovvLDg==
X-Received: by 2002:a05:6602:25d4:: with SMTP id d20mr254401iop.72.1640042355501;
        Mon, 20 Dec 2021 15:19:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a1sm3085157ilj.35.2021.12.20.15.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 15:19:15 -0800 (PST)
Subject: Re: [PATCH 4.9 00/31] 4.9.294-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211220143019.974513085@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3eb58b6e-4291-413b-02b8-b94ab2417ea2@linuxfoundation.org>
Date:   Mon, 20 Dec 2021 16:19:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211220143019.974513085@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 7:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.294 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Dec 2021 14:30:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.294-rc1.gz
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
