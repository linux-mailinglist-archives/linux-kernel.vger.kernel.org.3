Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08496484C63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiAECRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiAECRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:17:20 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1E0C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 18:17:20 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id c4so23416998iln.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 18:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eKDVCHJqIqFvkjnCbGyKQ8C1rwDSmPjlWz9f1rI4f2M=;
        b=L1Pxr7ycYMrpQpNBmhB0GI2eZ5DWUXLe/My1eh1Vku84mRHpnke42qDPR8U2D5Ga3O
         BYNi2mq8/T7MDGXN5dAaOwHbz1VtMzsmGDmM0pCSW2K9mTW63i1sd8c5Hyti7+HqORxl
         MOxz2GRhpn5u1EJbmEKYezIQzzU2Ri4n119kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eKDVCHJqIqFvkjnCbGyKQ8C1rwDSmPjlWz9f1rI4f2M=;
        b=nvt/Vm/9MlGqpywzeDYRROfB1Dwqt3YA6ecVOYHGvQp3DgDfzJie8yqnVSodQ6OKmz
         9y8F3EvpFLNd0HNs7oyDV/JePpJlAXfd/RW9B/puwIGOeC1UlSsPGFvXRhwvon1h1+H3
         HsYrEf1IzMrriJQJQMWP1Gipl6q8QIuHnSI+yqpk627V/yP+RMOvufRgcq4Vxfm+depw
         qT749eL8QWw8ASdhgpem+c4ZuokAJOBSuZKmBLCDrIqZNneq24i5BqfiKWpDlXESZlr4
         7ko8mFEudTTn1Ko3j/8ASi2X91wQrSaNblUNAzAQgMKgUJzFzmMnp9QO1EjRR4O+kKxA
         hayg==
X-Gm-Message-State: AOAM532ll0BeLaZ0mx2BqN48T7phYsS4L7pIM6mU7oo/pgMpt7N96zHi
        7iScbpWMpxfGHaqbtKKb7uFC25FNCPJkGg==
X-Google-Smtp-Source: ABdhPJy+NC6V4xTkSM2Ce8/yHBbyHEsYtIF4ds0WwnKP1Suq0954giPqBhRBcXYM18u5o2ts1gL9vg==
X-Received: by 2002:a92:3f07:: with SMTP id m7mr25084265ila.115.1641349039689;
        Tue, 04 Jan 2022 18:17:19 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o12sm19470422ilu.86.2022.01.04.18.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 18:17:19 -0800 (PST)
Subject: Re: [PATCH 5.4 00/36] 5.4.170-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220104073839.317902293@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9d638cb1-7e3b-b957-550f-e73e32abc9ce@linuxfoundation.org>
Date:   Tue, 4 Jan 2022 19:17:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220104073839.317902293@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 12:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.170 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jan 2022 07:38:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.170-rc2.gz
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

