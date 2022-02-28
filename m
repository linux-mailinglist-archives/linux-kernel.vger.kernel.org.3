Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B406F4C7C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiB1Vna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiB1Vn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:43:29 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52C140D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:42:49 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c18so16335965ioc.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DurEJmUs/1Btth8W+8YJcVQjbNp4GPf9v8HiyJ+Ki+E=;
        b=hBxet8wWMJhD0UNSY4UNM4Qpf/cw31YHmtpSmRtcGXbpvbi/8FrFWenG/QjjCsaTdE
         N37/MgcF+tDOTiIpW80rExa9HX6GYlrqqLQ1UkGvrG2BRv2qpg+ABYwo7NxciucU5Bs+
         BfvREqSuJeaH/nZVOpDE5jnPgP60VjdeBOYvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DurEJmUs/1Btth8W+8YJcVQjbNp4GPf9v8HiyJ+Ki+E=;
        b=xN6ibPYz+0BkHOSxaZrWjUj1TXefZao0QhXejLKuDSYKfPtWsp723nOt7GneKgr04z
         Mk7oX66q8qwuVO/6W4DBpzSInLnEqqDUmEz/RNW0WyESfU0LYYvIed+jSW0O0QRHYK0V
         FqRtirc9JnXrEJU/mksbV+raOIqJw7nDcTagnB9CJ558M6BBklINz9KSBkzp0IDDdfaA
         a2OwuQvX5d7PyzegkecWggBrld3fgxRU3IggCD99T4L700PgJQ34b6ivXd+DgPAipkV3
         OXJWQMNAqUqWTl7Udnjvv8haCszTaAsIPqPf3V0UimmFjbF7cpmaBYmVTo9ZJa4JzMHx
         4ZNg==
X-Gm-Message-State: AOAM530G7de0H5sgKqT2UqZJFSKpyGR0qcednySNhx6R+5ZyBrGtETJF
        oTWgMBgKbvLYuGp5+QBArEogxw==
X-Google-Smtp-Source: ABdhPJw9FX8rGbCYOTbMfusLnTwz39xTzxQs2cR+/7PXL1K+LSBLsbqPKg914AwnASr6pgnO0VRVDQ==
X-Received: by 2002:a5d:84c5:0:b0:60b:bd34:bb6f with SMTP id z5-20020a5d84c5000000b0060bbd34bb6fmr17060778ior.32.1646084568516;
        Mon, 28 Feb 2022 13:42:48 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id v17-20020a927a11000000b002c29e9b5186sm7021747ilc.43.2022.02.28.13.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 13:42:48 -0800 (PST)
Subject: Re: [PATCH 4.19 00/34] 4.19.232-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220228172207.090703467@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a6422810-0f78-e5c5-985a-395dd9db7502@linuxfoundation.org>
Date:   Mon, 28 Feb 2022 14:42:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220228172207.090703467@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 10:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.232 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Mar 2022 17:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.232-rc1.gz
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
