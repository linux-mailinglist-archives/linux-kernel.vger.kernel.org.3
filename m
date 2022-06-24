Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39CF558C76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiFXAvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiFXAvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:51:11 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F73F33E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:51:10 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id f15so40754ilj.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x5Avj5gf7IuZFuLm4nE8WagAZKu44Qt1uYxBdsmd6Cc=;
        b=iiR0T1ZtgIW+7lswPRy6SwgMzAqfm9Ox7sCKb4ig1pmTUQFXvuXYrhabmMKbs3jGVO
         ftuj4SgTbHVn/doVw5s/+Ri5XLaCK8+LLyNjOXvzPUXSBUuJHNciZHf/p3i+QOJ6xFND
         aOGtc/VlfV3qTQptwhnxiGTyn0sttwLLp3TZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5Avj5gf7IuZFuLm4nE8WagAZKu44Qt1uYxBdsmd6Cc=;
        b=LX9cW//MhzK8Zrk9t8SW9j3ItJQPN27E8+ba1SksDqBPsOgbQ+KAQiDD1vX4KoeBS0
         3pPvEJzGxSQjIT0m63xUJl+xbO4QqpFnvbv+6SRCbaUCtt9PD2P/kt1k53clKVNLJwAG
         wDYxAmjlPln0+ORtB31Zz2OxHX03OvjihbCLcxfVfuJkpqwRDGblBhz33Ocyqa+quRgc
         95sNA4AxMTlBCJaVO4FTBNB0ujgA57OC2bv7yDpxYHuORdfzpwKORnNsLFkQ1L1wZULx
         qXIiqGGAD8vQxNV/NL3VlLbNNWN4zvW/vKZp2wVHNXfZbPHmHYsro5NzGrgBJ7T3c7fl
         Hpug==
X-Gm-Message-State: AJIora/6ZGTzlwu7dhePxbnadsMwEfapMXLRbpzlurNuL8xKVjig9bJt
        Om6vVw8LxbTxzoo4odIM/Nb6kO5Z5qEmSg==
X-Google-Smtp-Source: AGRyM1v2WPZt9A8jUfbTph8eGhhixLgmE4juqztX9I4AWJkTYx/smRra+JHWEjXUhzoERSwcAxWeEA==
X-Received: by 2002:a05:6e02:154b:b0:2d3:d112:5a0a with SMTP id j11-20020a056e02154b00b002d3d1125a0amr6942745ilu.131.1656031869878;
        Thu, 23 Jun 2022 17:51:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h6-20020a92c086000000b002d176be6912sm498539ile.33.2022.06.23.17.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 17:51:09 -0700 (PDT)
Subject: Re: [PATCH 5.18 00/11] 5.18.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220623164322.315085512@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3a73dda8-d9b6-9eb5-34c3-832127d55352@linuxfoundation.org>
Date:   Thu, 23 Jun 2022 18:51:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220623164322.315085512@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 10:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.7 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 Jun 2022 16:43:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
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

