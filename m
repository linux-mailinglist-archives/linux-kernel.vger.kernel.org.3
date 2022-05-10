Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74276522707
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiEJWnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiEJWnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:43:35 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DC15BAD1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:43:34 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e93bbb54f9so727085fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aHRE6wYQBX41Inx+C4oG+c12srlwL57DpDUyySMlOY0=;
        b=L5m5syOhBWBQIWijlz3qFhUeEaWBltthZ386HZN7bbwJ5rLDX+ZeQccXZ0Vtv6ulK8
         yusCra6kvlqldnDOQwFd8vlqgKHqR0nh/2NLnWyPwh+B6NT8lCg9kSGu8KtdhqnZZyHf
         avdhWpQ3uK7vul52lsYLVD9yq6CfCw9r4ZSg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aHRE6wYQBX41Inx+C4oG+c12srlwL57DpDUyySMlOY0=;
        b=tw4xeRhSUusnExRt2qRyr9bvK0sYI2BivLSS0FXQevARlk7ZB9IltwyJXDvzLSvaI6
         vGZONgGF3hxRd1Suog79ef5Nbuk0LDE/7g34X4W0I9Ji/MlACCNQtLzxFuAoNSBvl4ho
         nTryoZpsgbwxmaxhrGT3Y21Vs0W6JYw+ZRYQJIyyrCFg0pHZ72Z+0pPUINJ5LzFfBNct
         MReLc/J0elormVaIoHbEWVF5wWy032XylYagpAOYLO4bnDIKwMKjHkYaxABHUz/nzix6
         1d+uvjsHDXHOybRnGbNA0yOhG4bfih13g5F9hlbC8L26IADG6DiNj/0bXlnkUaI53Htv
         M2DA==
X-Gm-Message-State: AOAM533uSVH30zUY2tlXHnkfCBaxXRQmy/T7D/xFkNoQ94vsLisBToPw
        P9+AFZZ8Kr+9mKXv6IZxuRKCzg==
X-Google-Smtp-Source: ABdhPJzGIkxzJLb6JIawgDNflNSBcFW4oBVf9Dfb3923xxlZp0s4LUcKrnUAGARNFbxyZJqGglZJ2A==
X-Received: by 2002:a05:6870:4626:b0:ed:331a:c3d4 with SMTP id z38-20020a056870462600b000ed331ac3d4mr1325766oao.225.1652222613777;
        Tue, 10 May 2022 15:43:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u8-20020aca6008000000b0032643374d17sm119825oib.41.2022.05.10.15.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 15:43:33 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/52] 5.4.193-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510130729.852544477@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d5010f60-ceec-66ac-2a72-55e387920e48@linuxfoundation.org>
Date:   Tue, 10 May 2022 16:43:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510130729.852544477@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 7:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.193 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 May 2022 13:07:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.193-rc1.gz
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
