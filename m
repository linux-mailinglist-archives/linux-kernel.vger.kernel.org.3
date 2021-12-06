Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E411F46AB10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356102AbhLFV5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355916AbhLFV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:57:06 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FE9C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:53:37 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b187so14638887iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UHYf4k90BvuJeGfUf6UFMRL41Daz+q2MMxSGim88ACA=;
        b=O+TlL+bTA95cbMxebCwICFFq136Ki3E7TIqx97XsVYnbgZZkfbXTLU5QSHVwBpWDwI
         D8qfsclWD8sPkmGDQ2M2FWxwH4ONaM6CnBn/6G34h+otOznjamN4G26JAUHHuDPL0SSG
         yZGIYlKJ/PTCDIC/68ljPgYcmfd+ozUrnl7GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UHYf4k90BvuJeGfUf6UFMRL41Daz+q2MMxSGim88ACA=;
        b=ZV/1WGv2zicM10izd31peuOjFZ2Np7zMYgQ3lLMnVTnT5j+IECocvLC6H8ojA+WjYW
         NEz5oW3m3BEIprzs3qBxqC7JOj24FDq658+O1JShFYFHVbQYq1LXaBEc+M1XUhe9CYD0
         IK4MK9Bzv7JCHjhRWoz/LKcBTYqXLgXU71IvYY3KbDNJFv03ae0TvYStBKCkCFrrlWoH
         zKQ+MpTEt8mZUJbowuKk/ecAPfzTt3ydX06WCd+WaTjf2wTY4T4obYbjqTKVyBaSAG7k
         ffUkwP23dho589fa6APD5rarnx7Nv7O4m9PZD+iGoLf8o59TXFh7AKz0Rkvv8Fc/OTaO
         iLjw==
X-Gm-Message-State: AOAM5304jLQBzI+pi8FugaccSk3QtV5/3bqY4c5mT+3/k+Wgvv/poukv
        3WyjCRjUCBpyhGc9Nwd/7Lykuw==
X-Google-Smtp-Source: ABdhPJw/CjG324oR2E/gob9zdvoMpUGtomNMuiPePqTvubSAYCODa5+bbts45oByzT/mwrgjWdZBPA==
X-Received: by 2002:a02:a11d:: with SMTP id f29mr44394494jag.78.1638827616743;
        Mon, 06 Dec 2021 13:53:36 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x15sm7040693iob.8.2021.12.06.13.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:53:36 -0800 (PST)
Subject: Re: [PATCH 5.15 000/207] 5.15.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211206145610.172203682@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a0b27438-f3aa-e2a7-73ca-96f5b91db7e7@linuxfoundation.org>
Date:   Mon, 6 Dec 2021 14:53:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211206145610.172203682@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 7:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.7 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Dec 2021 14:55:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
