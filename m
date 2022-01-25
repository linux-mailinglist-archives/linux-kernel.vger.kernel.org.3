Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3349A86E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318740AbiAYDHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346119AbiAYB6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:58:35 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE7C06179A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:50:57 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id i62so6225838ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/1d1kaM+wY9koZYobUo0XrdU4rdHnsKv0hB2d3Y2iLo=;
        b=ULrPj7FtDkx8HUFfClmDZrlERjdr03KjuRzkVS24IWs5Cslv0HY+ht853cAenMwKLd
         s2HXWoG3LzazlqsZSc3b6UmKiJLDpoNmYqKFDWfXxOhRwy9SwVh/b9mYGmULF5+/G5kr
         7BvPj312ch4JtZmc9kh09e3dl1EQo3qQ64u7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/1d1kaM+wY9koZYobUo0XrdU4rdHnsKv0hB2d3Y2iLo=;
        b=GfnjxlHuuAvqMBdNZq9pMvqvJdBIMoUMdW8r39xQm6GTrLPMLe4xyGJYcWgaEQvwXl
         J6dEbEvltx/eC+yVbJEwSOEKPlN5LbvmkKdj7ZzmhtbZwshHjhFkR7dzVZjiUv7BskB7
         KJ239FM9fHsAUjrbtrW904yUA/whfKH0X1xoG02v8JBRnmV4qUOPWV+lcsTpm198YrYZ
         t6/dT63YEuvsj4vqZKCyb6R4sPhqLfPUPWz6i9YHzqDhxZZebl2+x1RKWUi6wuWxWzoh
         lJbVxeU/4fw4OAunxcGoiPQ+F7krOycH9pwFbeBS/0A3jrJjLX4U2CzUG9tyb3JP3e9k
         C5Ag==
X-Gm-Message-State: AOAM533izTMTFDFXVvfr32ttNM8gVVLl4+xZ5uSEV3GesqU8v9d98bTm
        XNillHei+kyQtM9PlzCf8kQCMg==
X-Google-Smtp-Source: ABdhPJxHW5JydOSiC9Ml0dy6dX/xJijg6+C7Uy1XiIffHE+NGmEm7LEPvoGkysvQF4/ZsxSlfaZOSw==
X-Received: by 2002:a02:b10b:: with SMTP id r11mr7684802jah.14.1643075457219;
        Mon, 24 Jan 2022 17:50:57 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id k14sm8446572ilv.74.2022.01.24.17.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 17:50:56 -0800 (PST)
Subject: Re: [PATCH 4.9 000/157] 4.9.298-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220124183932.787526760@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <647b943e-48b7-fbe2-fae5-3729d68c8e2f@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 18:50:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124183932.787526760@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 11:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.298 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.298-rc1.gz
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
