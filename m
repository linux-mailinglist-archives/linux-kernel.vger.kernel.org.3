Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791CC4B0245
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiBJB3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:29:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiBJB2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:28:48 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0652672
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:28:50 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id p11so3222110ils.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vEXae9Jn1YGDAQ8qzBe4eMP1XH/dd4B8lowp92SBv64=;
        b=dQUUuQSGt2xhvzqU4tBVyTrJQ674Zap7OID/BvZsKtGx3TXJ9+5e3UJyt9XUBDO/hL
         cyPIvcYm0tRKMgLHbTfvUNuLquAvtFhWZHSmaDWdac+uXsLHR083G/NyByO3rm/GDhp+
         ii/K7nUrgxcg1NgBkexQJFrHj6O6wEiK6hRaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vEXae9Jn1YGDAQ8qzBe4eMP1XH/dd4B8lowp92SBv64=;
        b=4tcsRQkzG8i3uoBaVxrE9PGXeeNW3z/ABTpO9UEuDPkDweJepWW6ekRycdHT+fWMw9
         Oqli7vVjBSVr/7niAd7miSarNr8UazLBa/xpyKOacHHzlLVcADNsBj849lNM6g0XUz/u
         zesDzoB7SRLGoct7hAx7WK2vZ8IBoCSjMxg9f/7zQjuoCQU6SaEcp8vd91S0OsBbSCZ4
         o3edbHpsHz/hjxNAQnYfsRUgaWTOpG+hJ8iKCl4Tw7FqAd1LK+0Ylody4i1f5dTpDsep
         yrij4Q8E5ME5p7JTO/Tyxr5Vo8Q3MVfBc2wFqvI1XPPJ4LnnNlqQztO7KImEnKWbKn4K
         bAZA==
X-Gm-Message-State: AOAM533m4OI56qrIxsl/1Br4dGypBK+iMyM/kQRMCA4pkAzN78PGQ3MQ
        RaGS87TyzuRHYlUezj7H/EHw6T9JmT3Rrw==
X-Google-Smtp-Source: ABdhPJwyULpMqZaN14jtHBDgSmjZGU4tx6Sloz/BBfiTMfMoD/2lU+BmuF4tV+NdUpSM6kQXSBH81g==
X-Received: by 2002:a05:6e02:144b:: with SMTP id p11mr2707646ilo.100.1644454795049;
        Wed, 09 Feb 2022 16:59:55 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w4sm6990890ilo.53.2022.02.09.16.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 16:59:54 -0800 (PST)
Subject: Re: [PATCH 4.9 0/2] 4.9.301-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220209191247.830371456@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <08949c74-98be-f824-359e-419b9759b75b@linuxfoundation.org>
Date:   Wed, 9 Feb 2022 17:59:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220209191247.830371456@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 12:13 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.301 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Feb 2022 19:12:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.301-rc1.gz
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
