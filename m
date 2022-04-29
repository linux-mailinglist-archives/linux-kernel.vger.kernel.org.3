Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27145153CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380064AbiD2Sj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380060AbiD2Sjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:39:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7334B6D1D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:36:34 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id a10so9374269oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=quVehm8AdBPS7PuXSm/zjt0DrN70Kgrs8EZ1OqzABbw=;
        b=Zc0N4POcB4EwKaPhhk7Uwn7/OOkIhf+UKEns8s9lUSDf8KRKZvIQObQtGMB+dOa1B3
         SCYcFTviHzHE0DnZVi929a9BBQB9CafncxgA0U7uHR/OMH8F3snYN2peOg/64vf9/HN7
         wKrVfxZiqynS+osFEC4caQ9r2DwD7ygXQjeAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=quVehm8AdBPS7PuXSm/zjt0DrN70Kgrs8EZ1OqzABbw=;
        b=71RassB+nEmOc+QbG4leLabRU8ZrBz5l+5Jac/RnfWvFjraUbtF0gKBw9YwmmPZmBK
         gb14CP6CO6ZL1Gt2IETV7duLSR5a0yfMcVocK07x+11hpRNiuCvdEKbRu8f+FvPbI9Zd
         St54y0BjDITerE43rGHAviNsthZrIVGidGAv8IpAe+W13/hDDi324RrLTHL07VurQZ/f
         BlhQsl66PUJwYSCsG1v5EB2FhBiQ2hNf8d0eHOPK+XefEsECJgqMiv37CBWFExDaUMnZ
         Nc5k3SyiW2Hd3bWMlSW14xSl5Knbkolpd4AfipiS60HEtD/WVIZIBfMIxMzR+2OF/YP1
         F6qQ==
X-Gm-Message-State: AOAM533cUVDvorK9reMiICsOBMl9Zc2JxWJXEleWqJlCjjsl96N5cA9J
        wEVDPGXKAehBr5Li65MGvHS67g==
X-Google-Smtp-Source: ABdhPJyyAWalFRfpaWMOTNkeqwtLblCu1Ym3ztHwV6LUyrKf9sy5ztJ7MyGlPrjblR8fsfTQQfMWgw==
X-Received: by 2002:a05:6808:180a:b0:322:bcd3:ddaf with SMTP id bh10-20020a056808180a00b00322bcd3ddafmr361017oib.35.1651257394186;
        Fri, 29 Apr 2022 11:36:34 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id ds10-20020a0568705b0a00b000e686d1387bsm3223866oab.21.2022.04.29.11.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 11:36:33 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/12] 4.19.241-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220429104048.459089941@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <63664acd-3e58-ee14-3a94-bead4631cc20@linuxfoundation.org>
Date:   Fri, 29 Apr 2022 12:36:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220429104048.459089941@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 4:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.241 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 01 May 2022 10:40:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.241-rc1.gz
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
