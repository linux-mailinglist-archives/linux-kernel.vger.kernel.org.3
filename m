Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14054E3449
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiCUX1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiCUX1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:27:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B134FC1B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:22:39 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d3so11405313ilr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wbz7eA7sXs8BTR1S42YkU+lHGWz3lrzmqkVZS+zGbDM=;
        b=aWnB2KaOYilidkn9QkDlABfNSGjZ2sMgqw7YVMetheRJHuyYr+IPITGbbqcv/Up+jn
         PfBJJHMlZgcGDX9UBUR/MHnP4EKj9c7jaKSN4Rpmbo/LrS3keVwxnmg+b9ojWIZ0eWv/
         9uY17Y2ruQwD1W5pi6hKLhVR1MnM/WJlbk1v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wbz7eA7sXs8BTR1S42YkU+lHGWz3lrzmqkVZS+zGbDM=;
        b=Z4SRfyjLbmm8mw/SWGl+NZvjNHXSoRoakIFkjC58CwzakOhAgj8y8W3bgNjhLgSgHm
         r+Tv4NWdHWr/3ldBhoicHwhPTxN9XcPE3ZSrW9ABoRRQf1dT3s8SxIlhVybHGv/uYGCf
         IGLrZHYhYeE8hVn3UoC5UVrXcniOBVFh0SfuQDExMvuGXUyN+TT5yW510v9D8MTrRMov
         SHCtMv0brYS7BNH7TvEP/6eXj+f2/G/G4Y3eZd2ANUmXEhizZGp44zEFb5fxfsnQSwvU
         NvwlvsnN84egVHwZ9LWGDn2EvxPG/Acdv+Pr0OWjzWJN6my9PIHDRgAKNQsCByyaX0V8
         OnKA==
X-Gm-Message-State: AOAM5323NcXjq5sb/B3BK6HBbsN9oexyGhybkJoOVnIbdhnEzpcCFMQ5
        msALm3eAm1qS37TQhkZYICoHAQ==
X-Google-Smtp-Source: ABdhPJwFy8AFT4nK9ILyFy5W2t4+qcXVKTbXyzDQwQZZq6sg3Z/VDeMhJLns0hq8sTsOBFoinaFp/Q==
X-Received: by 2002:a05:6e02:12c9:b0:2c7:ce8a:edaf with SMTP id i9-20020a056e0212c900b002c7ce8aedafmr11202788ilm.218.1647904959386;
        Mon, 21 Mar 2022 16:22:39 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y12-20020a056e021bec00b002c786b37889sm10442084ilv.47.2022.03.21.16.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 16:22:39 -0700 (PDT)
Subject: Re: [PATCH 5.15 00/32] 5.15.31-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220321133220.559554263@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2b6a6901-90f9-6ccf-a8ec-892a609f03d8@linuxfoundation.org>
Date:   Mon, 21 Mar 2022 17:22:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220321133220.559554263@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 7:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.31 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Mar 2022 13:32:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.31-rc1.gz
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
