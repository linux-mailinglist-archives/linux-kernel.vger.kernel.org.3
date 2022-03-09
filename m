Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2203C4D3AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiCIUYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiCIUYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:24:11 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC8F6D1B6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:23:11 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d62so4077394iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zccQabmwEaT2zzCzjlHWPhLvWXcYdS/kixyDFxTbt9E=;
        b=dKc8P3dU7V+pTeaxgT7Sn22F6u8y9/+LzKu8QXIo3MsLta+u+VwWZQ3eaJBCDd1KwY
         ptWD/P9ffDl/xG6BG6wI7dt6AEkrHrjWPHWWQYRLqLfoQ6psLusH78G5S35um06zd5dA
         AtQkyAZef0ANQJFAGTfmW3AYkuz29e97gx5IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zccQabmwEaT2zzCzjlHWPhLvWXcYdS/kixyDFxTbt9E=;
        b=rZ3af4VR+w0eGE/WWIIVWKhzuESDYTI6tU6/xAKqnp3uA84P6uDrDlmy0HOEAtxZT6
         w5zW69JYFgMqbV4TUWsGgbTI/2QM0xdG7KVA3dLYPPdORxvM0doYtjZAr4hHIYPryRRr
         10QehV0gEGAYlvLQ85VhIm66ZXipCnaslQNVUIeVp8afQqrMKqd87XKd3POBAq4qhtK6
         FAiLCHXcvuTq/v3AQzG1JkLEtkDm/RrCwK2HoSlfyq2PEb+r+TnQPzz6yTvkBrmGVort
         wBOgFfDH07ZAqKzMVgp9xmOL+jEvEg/a915wYWx7d0WgVW7wIxOsUJ54qOlhj/g5ct2L
         KLaA==
X-Gm-Message-State: AOAM533c1OvvUc722g+dWtpexoUWZ2elQlm4UZXzzE/MtHZUcTKk8M8T
        PtUMxkvVmbF236fH9GjXkuHBJA==
X-Google-Smtp-Source: ABdhPJyjama6xZuzvXm44NwWPOAZhV0Wsht6GwKdBfBcE5IATB2ZFXrePUmqGEWagUdw13rV6yRaZA==
X-Received: by 2002:a05:6602:14cb:b0:646:3b7d:6aee with SMTP id b11-20020a05660214cb00b006463b7d6aeemr1067170iow.178.1646857390385;
        Wed, 09 Mar 2022 12:23:10 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e8-20020a056602158800b0064683f99191sm779562iow.39.2022.03.09.12.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:23:10 -0800 (PST)
Subject: Re: [PATCH 5.16 00/37] 5.16.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220309155859.086952723@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1dda6068-728f-a470-7147-e045b62f03fa@linuxfoundation.org>
Date:   Wed, 9 Mar 2022 13:23:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220309155859.086952723@linuxfoundation.org>
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

On 3/9/22 9:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.14 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Mar 2022 15:58:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.14-rc1.gz
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
