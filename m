Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64DA55C1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiF0WET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbiF0WCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:02:01 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3290BBC2A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:58:57 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a16so6950822ilr.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9GT2nNkf49vF8e158U/wUxr794H1AaU7oOi4NpwptRo=;
        b=hI3vmhAhkEP9/+pbu0tlgrBl5K2kpR9NO/0KOOMQlkWERtpIiGxuMs6UYoVc0khr1B
         T2N/zjxyZ5U9LpQOGiqhXC46jisNQvSetx43pFRoxEn/5vcfNHzlu0/SbHmnKwALj9iq
         9jM1ZidZCct2NUfVieaRv5q5u1wMbm8FSEJXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9GT2nNkf49vF8e158U/wUxr794H1AaU7oOi4NpwptRo=;
        b=kDS0aDOIB1oJYa2P+PScjblpI5WHVaiu58VfwfNIYFVklfB4Ppynndx2IgY8dIF+YS
         zw7w4O69YfQ3YbeIsajWQjAXP1BJPzmPaQUhxwMzb1gzT96LgPkrKeNJ7XTK9gOGYKVf
         WlUBCFJIfc5S/Iwlfow4LcYVdOtycceKVxmFGJ5EL8h5fFvSsw67/W5SksjBNIjC1Elv
         g4zxs414YlR9OSfHxsa4ixX1gcPpzgjEcWWuyCWZ1xRmsdQRoryN38Pkau90UedgfEYL
         /q5xyJ9UR0kOQNdUO1wSsMBbO1Kn4YeIx8R8ZhtOaJzDEr1IMYlUL41rh73baN1nhdkJ
         dzBA==
X-Gm-Message-State: AJIora8PYGcQ9PPekH+jZUXIQkQtRqPNF4qN2WduZVQu0La97db/9h7H
        Rte8s6nX8aNw3Q/AIznS/tcm0A==
X-Google-Smtp-Source: AGRyM1uZ8G2wTmyTVBvBNcpvF0K/igCH/hzNr+NZzmvopzmHYb/uOzsaqR+LDhuX70NqRGsjSNzyvg==
X-Received: by 2002:a92:a041:0:b0:2d7:7935:effa with SMTP id b1-20020a92a041000000b002d77935effamr7843380ilm.222.1656367136275;
        Mon, 27 Jun 2022 14:58:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t3-20020a056e02060300b002d93c072c56sm4031214ils.40.2022.06.27.14.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 14:58:55 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/60] 5.4.202-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220627111927.641837068@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ff5f22d8-37b5-df9d-5873-4a9ce7c1b070@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 15:58:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220627111927.641837068@linuxfoundation.org>
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

On 6/27/22 5:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.202 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Jun 2022 11:19:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.202-rc1.gz
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
