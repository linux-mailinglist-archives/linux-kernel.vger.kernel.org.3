Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A616B4C7C37
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiB1Vjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiB1Vje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:39:34 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9114AC96
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:38:54 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q4so11146626ilt.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+b5R0JMGpRhShwpTZEqLcTokuOkIgFTltRhanvABKGM=;
        b=OsO3lc6Y3Jc9Tuywb1iDfsZ/2LWfE7FlDZ9Now6RTsQkIX7UWMMFLnBRXnQumTKhV7
         Huo+j0zlAfVEW9jR0d6JAouJQY4nt2/I+RBfzbarZNjNIoop7x5oUDQRqL1b+s/nRubb
         v1xJZSrdLiWyoObpMaQJF3FbvljRbAJWlPNk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+b5R0JMGpRhShwpTZEqLcTokuOkIgFTltRhanvABKGM=;
        b=JxdVAgi1iaHjAEZ/FFqrmKUmg+QeCMKLO/iP13VELbUAS7vcahjP+E8reqV4nwhZuD
         Hf2sN0D+FkDFtZ6NQ7ELW6vz2oW6vsAXip22pq8cg8CaC/fGp4nxWVn9wt21KH0eWooO
         5CaQaEdBW1LRHPy9tvHUGZ0F/ksQx17TYUCbOOSY+F4jKl1ZNrrwmEztE2zqUYDbxR0q
         jb/bGwWyGEsFCCOr6Uc+qlKqiUZHmZP88dblebBZi9uZKfv/Bwpch/29PikuKyCLIoqK
         tNnTvCGxfcknDXZ9MYJU2ZmxmAJDZ9jiDCRfJ6WDkwdkcUTmnvvPAwnDregiyinJIrqZ
         374Q==
X-Gm-Message-State: AOAM530rKAom+cA4aCgtPrKRAkTZ1kt4ZXouVyDWUNHoS1DcemVMvaXZ
        h3078TpH9DFFFHqWq6OMPsckFA==
X-Google-Smtp-Source: ABdhPJzzes2NUYvxzMUQHnJOuvPURYtR8PyUMh3Vazjg0lBKUZh+2DW7Poj8KwYsjQQ0w+wT4XFDUA==
X-Received: by 2002:a05:6e02:1849:b0:2c2:ae56:7be1 with SMTP id b9-20020a056e02184900b002c2ae567be1mr15558825ilv.6.1646084334223;
        Mon, 28 Feb 2022 13:38:54 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b24-20020a5d8d98000000b006409ad493fbsm6294518ioj.21.2022.02.28.13.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 13:38:53 -0800 (PST)
Subject: Re: [PATCH 5.15 000/139] 5.15.26-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220228172347.614588246@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3ec5a029-34aa-f7ed-611b-e80bbdd2bf78@linuxfoundation.org>
Date:   Mon, 28 Feb 2022 14:38:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220228172347.614588246@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 10:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.26 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Mar 2022 17:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.26-rc1.gz
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
