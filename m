Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A364E7BED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiCYX1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCYX1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:27:23 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0189540A2A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:25:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z6so10687119iot.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ush+s9e72Ld/mAMuujmuTcHI5KT9ZcUa2jg3wuiLwbs=;
        b=YGDVk45Mn4QhdExXlf1xqehkXOhja9d69ZLfZO/vLrYTmoZjb2BiT2knoq455syiKm
         F0uUMHnKsDLN6DCaSvC6PwJ22YNue6b2WYPt9KK95b/6ixUN6Oey8B+2zVxu9KM2mQ07
         kv8nP1I73xXBuxyh9ZZpUXTd2GqZ4Sx23k+W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ush+s9e72Ld/mAMuujmuTcHI5KT9ZcUa2jg3wuiLwbs=;
        b=aXoHAmT8giV5gd+rM3C09GkvEIwJ5lG6oEfQ41hXdqZLODMsQia5FMigovvq437puP
         YCly/a3dPoNfblDzWFyFCPE/sJQL9ba7ZLV05zz8d/MEjWYjDKk27kQ8IbXikcEdrniX
         2aJwvAZbEcPDh+ny3kvpC+xt4Yyt+0vm3FWniM9LYTOUQXxfWL9wg9+ahL+a4C8cSA/F
         erZySkXk2dhQdbiwDgv/Xg3aIFfC9i9NqFB9mAR1s7KWK8/nypKZEAapf8gCNBhEL0YR
         +M9atspBU+7G8m154O1wh44HqW6/2wZ6H1/BNSVsDEuoL+sAwhdXmci7btmHi3VQnaIb
         z9+A==
X-Gm-Message-State: AOAM532bj7WYJkpzOxLOUUJXj3fbWM2CRR8gDbB2Q9b9t8GgFWemItGg
        eAfsR16u0wNT+i5m1I6VxuaRwA==
X-Google-Smtp-Source: ABdhPJz/pgywuLQjbgejzLB/PsGAOQo386eTbtBACW+HYdUqJkDla9f68UBSZSWFJUTZfXbNPdJ6Mw==
X-Received: by 2002:a02:2715:0:b0:323:55f3:8ae6 with SMTP id g21-20020a022715000000b0032355f38ae6mr1084226jaa.192.1648250745999;
        Fri, 25 Mar 2022 16:25:45 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m14-20020a924b0e000000b002c851d50838sm3610334ilg.30.2022.03.25.16.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 16:25:45 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/20] 4.19.237-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220325150417.010265747@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9a40c39b-552c-b362-a1dd-2d5f57c43a68@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 17:25:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220325150417.010265747@linuxfoundation.org>
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

On 3/25/22 9:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.237 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Mar 2022 15:04:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.237-rc1.gz
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
