Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900354D3B03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiCIU1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiCIU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:27:05 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A7563DD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:26:06 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id p2so2345939ile.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNRBFNAWwgbrtCvaKgMruA1CPCeSAHI2kdKDPY9VLbw=;
        b=dbQlULAxQIK9kG7QWSDHbYuPQZzdp6pdJtfZItEfmn8+IZSkM0M8MxMwO5MhsQCdc9
         tr0Wnglr+d0FleW9hDrBEgh9TkyccuuxgM08SJGUiMpDBBjS6hnk+ThiMtIc1BajG4kK
         ma97moN4oDKKwWDlrlOp8CCFq5i+oXNgFwu/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNRBFNAWwgbrtCvaKgMruA1CPCeSAHI2kdKDPY9VLbw=;
        b=K298RhsNWdeSqxXRE4AFwH6i/n/54ZrYKUHwFxO1prAi0SpJBCQGO3zADxL+G8k2N3
         SnO1w1jmMqjJJJ4XitMtmKUDGPnDkRhieMaLbujQ7KU/MYckoMPD+hEosf4wGB+TyaZT
         c5qtkCeZbbHmJP3H2ZRq255rGoSPvw8fGMELjDtF40nFAP0k0TuesxkVttZzN+nnQaak
         gt51WrkU+p8reqxRFbfDjKoXSi6jcGf0znYRmfAzlnf0hAL1PuFWBSsFYlRe67Ondz5I
         XglhuMTUw5g7ZokyzDjsEeOZkR9kWmWv36XU/F6o+13WFrsJ/Lj5nb3pjp1/zmmb6Xw2
         eCEQ==
X-Gm-Message-State: AOAM530H21/GqS49hqnaT64UKEippE4sKd8K7ydbw7gxdq4pIU0/tm0+
        CsghK015ipU+BTCydyZIRMxMyA==
X-Google-Smtp-Source: ABdhPJzDuy1Gmt+a6MUNnO+o2tUGJU2saY3HPHLvH8QFMXQA7UaAReP+2whGCr9zKzS2TSJHjmiKfQ==
X-Received: by 2002:a92:d40b:0:b0:2c6:6b2c:8a4a with SMTP id q11-20020a92d40b000000b002c66b2c8a4amr948796ilm.131.1646857566099;
        Wed, 09 Mar 2022 12:26:06 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 5-20020a92c645000000b002c632ac65c5sm1575290ill.43.2022.03.09.12.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:26:05 -0800 (PST)
Subject: Re: [PATCH 4.9 00/24] 4.9.306-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220309155856.295480966@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4b4743d3-8465-50ac-4d35-e86510557244@linuxfoundation.org>
Date:   Wed, 9 Mar 2022 13:26:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220309155856.295480966@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 8:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.306 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Mar 2022 15:58:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.306-rc1.gz
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
