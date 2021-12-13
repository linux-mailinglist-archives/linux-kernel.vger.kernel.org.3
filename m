Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0F4735F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhLMUbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhLMUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:31:01 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620A1C061751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:31:01 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso18748176otj.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vx4DgpKwXYLRyQtyPwKpxXH7HX64rLNuZzcL69veMN8=;
        b=gz1+IY3hZOzkYQ5nE5/Ug+BAAfikWEd0ZE8Eoj28rIYvqYY7pTmfbMjCUtfRNGX/E1
         kqJD9yt8RTIX6Pv3uDelIVgPV9DF8Pe4BmdyT2kgiJSh0aJPkBAqDx8vZHAgrDe2NPMO
         zEP9AAqRCdwS403/FXiC7jIxEC0xQJXKvF5so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vx4DgpKwXYLRyQtyPwKpxXH7HX64rLNuZzcL69veMN8=;
        b=hxcfv0+B9urz6eiWUWKt43UPBu1S/gryYrdJXVZmZVfbsSvGVtRa5mTQ4q6ut/RMmt
         uwXz/lJtW/+Kp4zx4HdBIgE5VWrBxMJIkzmNZ7vSoctUzltp6PLBS+MU0aAcHlYl9E48
         R2ip2K+yyBH3Ob2acfJE5diEAivZCe4F1oiYKCYA266HnJX6zxpZ+NtGbAxiXv2bZMSA
         FAc9T63dDuk56y3Mo5yWka3LqwPXUPY3KoBxJsLJJIvwoWPj5Lo8ZwgOOqoSaSszA8id
         ldnlIKbE2tu7/1WmTih8u1CC6Nikweo307LmQhisweOPGWt7ylbBmz22rXXloVzW8Fe9
         +JfQ==
X-Gm-Message-State: AOAM532kWOxoNSLJh7PkiQho9t+l9/2tEOArHKZtMHibIGq8H+LSZAzk
        582zbHly1sEiMuURHCnfojodrg==
X-Google-Smtp-Source: ABdhPJzQH5Cr+HPyv0+zGjfQ3BewhWHUdoI9MOS0kbdKvtKXhJnGNGObcQ7ap0P/aJhQ8a9M/rC9PQ==
X-Received: by 2002:a9d:7a42:: with SMTP id z2mr703438otm.362.1639427460745;
        Mon, 13 Dec 2021 12:31:00 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j20sm2859895oig.52.2021.12.13.12.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 12:31:00 -0800 (PST)
Subject: Re: [PATCH 4.19 00/74] 4.19.221-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211213092930.763200615@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cdb87933-1411-85bc-c520-a7c609f70508@linuxfoundation.org>
Date:   Mon, 13 Dec 2021 13:30:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211213092930.763200615@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 2:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.221 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Dec 2021 09:29:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.221-rc1.gz
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
