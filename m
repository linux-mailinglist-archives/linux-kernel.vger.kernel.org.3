Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4174E4735FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbhLMUbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbhLMUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:31:48 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F74C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:31:48 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso4463670ooa.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=60FFvlQx8M1cv+xd9QHUP20nqXnsZUgkVALdIiDeSU4=;
        b=WliiZyVQof9aomFhe773ju4Yf0eKYEksu71xyXyzN87pu94KpBqp2nvzNXy5/37Q2x
         OOeU0FIYZgzjYma8NhZe0cXfWM31rQq/SrbzQQ+JJVpv2aBePqdYrzxlYb270QAEtuQC
         2FsfsksR9r1wmLmgV6xE0fXAFciaHR8pepYT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=60FFvlQx8M1cv+xd9QHUP20nqXnsZUgkVALdIiDeSU4=;
        b=ehI/xbs53pG4VSSphlmIvbmh//WrX8Tc7CED8dTIgJ2NIRk6zs8aPC2EKFJ/Bgc7kd
         j88eDkxGHdI9W3BOSo0PgG7GQ9hidP7wzecW14y7emUsyfoharQxlEMQG9ANPGHQ5KTH
         UT42WQD42CgnxNCEbU/H7q1FR9gayyvXuwRsa1gBTeq3MpMB/av/KVLLc4y8EdbmGjIk
         DRwR79bfcau2R+C6K9S4iBYfmWx77EbMdXKh+Z4+h4TdE865vMV+mPmvC0rZsPEn04sy
         OyUhMtjvy5ilkv7ptqGmopT6e7VmpgCf9z09gi6O072TgQ6g+QUy2KjjsbuX8B5mNuBU
         iCFQ==
X-Gm-Message-State: AOAM530uApK+Eqb+I1jmyQHOHtofE7a/Lgd4XR6sLb4UE8OzXURzk2Ib
        GEmJsfqyUEdUgjL7/0QGuWDqMg==
X-Google-Smtp-Source: ABdhPJxYbJ16guwKhlXoSROxPRg5DZcSs3v5a+pKXTBhDSJI72u9hRaFViR2P5wfSdd4IYq3RIKQkA==
X-Received: by 2002:a4a:d8c7:: with SMTP id c7mr526010oov.58.1639427507459;
        Mon, 13 Dec 2021 12:31:47 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m6sm2325252ooe.24.2021.12.13.12.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 12:31:47 -0800 (PST)
Subject: Re: [PATCH 4.4 00/37] 4.4.295-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211213092925.380184671@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <127a1f25-cf79-4af7-a5fc-7658d1acbd40@linuxfoundation.org>
Date:   Mon, 13 Dec 2021 13:31:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211213092925.380184671@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 2:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.295 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Dec 2021 09:29:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.295-rc1.gz
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
