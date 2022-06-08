Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159B354253E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiFHE5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiFHE5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:57:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81BE1D4DDE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:28:51 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id f7so15543987ilr.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 18:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7kNwF0h+H8rkdxPKotOcvf/BB5NQzdZNvzFvJ5OBfc=;
        b=dFcVM9CyrMvVmX3qB/yizW0+HKHW22HrgG2s9e2QuiZj+nZ+M3kN2iuiDY1o0eKvfv
         D7sznt4AHpqSctQmtZKXWwLRCO2qqCXavzs8/jhzG5N+M6X9v3+A+Uo4YcFa3DwgcDEF
         8JSxOyGHuXwSsfs6McPSxEgQUpBh6xlLii8zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7kNwF0h+H8rkdxPKotOcvf/BB5NQzdZNvzFvJ5OBfc=;
        b=RQL+tugP3fMZkuczGT+FGJDzgQ1s9xKkAbfcSVMpZN17lT680A4CntlU+SwaBhFKRn
         56au1nlKg1mHnWHYHrkGOYXpEfA6bC8mEMnzh+p2nFmu3TMvmX1T+/1ZMyXuY2RmEEGm
         V+1pxMn6C3DHLX078p2kAWxX8kv/qs3kKesFvxjijtzwmGWww+Gx1gSeHrU5fjoQdTNq
         2CYD1T/3UHUkQ5k/YMJPkysJi4kXi8xAIV6lbspAwM12NDgAgGK5iQ1YrkRSDCSogRyh
         vlndz9CgMFxBIRkdO6zefPNah0kGAYl58wqoN9L3ciRX2WxmTKTG5RUQYdjbnsZhaXyj
         T1QA==
X-Gm-Message-State: AOAM530PU3zcT7FVQcdiq5AZSDy0bt1Vc8wvXMLfCM2LSWzrfseJrSb0
        34+ts3VqRpxckEY54pVYoVWk7Q==
X-Google-Smtp-Source: ABdhPJxDXzbSNTkq/+8rwfP5Qny1UZbRKrZzYcwHUxUNjyfVljYLgleXcryL5OYOOqUp8s1usLA+4Q==
X-Received: by 2002:a05:6e02:1647:b0:2d3:c43c:1cd1 with SMTP id v7-20020a056e02164700b002d3c43c1cd1mr18626752ilu.148.1654651731043;
        Tue, 07 Jun 2022 18:28:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k25-20020a02ccd9000000b00331598832besm7208775jaq.25.2022.06.07.18.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 18:28:50 -0700 (PDT)
Subject: Re: [PATCH 5.15 000/667] 5.15.46-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220607164934.766888869@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cdfdeae5-c94e-bd2f-5df9-667ec48f284e@linuxfoundation.org>
Date:   Tue, 7 Jun 2022 19:28:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220607164934.766888869@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 10:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.46 release.
> There are 667 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jun 2022 16:48:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.46-rc1.gz
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
