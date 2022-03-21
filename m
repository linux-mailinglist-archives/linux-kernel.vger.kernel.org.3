Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37174E3436
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiCUX0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiCUX0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:26:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B73B374910
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:21:25 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k25so18444714iok.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rfhdkicib0U/85KHEI2dlAxTiISoo2Wo3fR7SPHcWtw=;
        b=PxvV9pU628OdzWF5D3My9VeG9CcuSrs5mHcrTuv+N6K/weEXCD29bawMR5B1gGnsrj
         Y0yDUcL2CF2JsVIcFiCYCcQtiLa92fcCTXjBCeuQshDoI66ogpwSx4AYtklx7PsZhqry
         SLI4HzTwBu6UQjEwG+fL9oaaBCmnW+ObhRTC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rfhdkicib0U/85KHEI2dlAxTiISoo2Wo3fR7SPHcWtw=;
        b=4KaEWTUN8MoUHo2r0s2ypZie4jEbYBBFhAKKIQTIz6EQwhHjOz0Ym8DAtXDAmyU///
         Wg6lE9/BftbqnQTDjs1qWHt9h3iWSrLTOsTNWa0JwGDjtirCd8Z1I06YArHHVlW9GEIS
         FapitM1eUPcBC+OviGQrI4v7kc1+S98rOGqiAXZ3z4Evg0tcj51Lqc6fKkH37Q3EQvyZ
         kX5AWjg7Q33aS7PULNwWuhEQtD6raygK//IL2OJMguDOBNpo4CrfmjremOuw04DboArb
         PPHiwPNj9nKdnUvqz+R4lsIHlg6XeOVYtHA1QTGv84liMkTtf3D/5iNK+wzKR/o6UK95
         juAA==
X-Gm-Message-State: AOAM532uQiVymXhgu3f/tu8Hq/FUqjg9bneuUpBc4Y/+L66H997aj5n0
        JxEyMAbj5b2CRMuQuFrK/Gk1RPjy4yda6Q==
X-Google-Smtp-Source: ABdhPJwsJ7rLpryy+dyOPLoPKx2AaqcLjGpVmMRJ/Eeu6GNxHWNGIfT8AqzF1RDGQI85KGtX4QdcCQ==
X-Received: by 2002:a02:a081:0:b0:317:b141:29ca with SMTP id g1-20020a02a081000000b00317b14129camr10965627jah.275.1647904884418;
        Mon, 21 Mar 2022 16:21:24 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id v1-20020a92d241000000b002c82ba9d58esm2267499ilg.9.2022.03.21.16.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 16:21:24 -0700 (PDT)
Subject: Re: [PATCH 5.16 00/37] 5.16.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220321133221.290173884@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <06751c62-015e-e269-3644-8ef7eaacc941@linuxfoundation.org>
Date:   Mon, 21 Mar 2022 17:21:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220321133221.290173884@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 7:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.17 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Mar 2022 13:32:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
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
