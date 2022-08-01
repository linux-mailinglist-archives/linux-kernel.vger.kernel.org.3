Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E128C5873CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiHAWN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiHAWN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:13:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A469BB9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:13:55 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h16so6202600ilc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 15:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNHPWPj8siy37I5SSEheyq3GqHY0NjSZ54pkkOzX4fw=;
        b=UnaFDYK16pzAvnxwDtcfqF6cK4qoG3II7qfDniFzIL/B1cURQoHiFKPxJmO4Pndfzs
         edA3tbsdkkgqayqEmo75TpA5QwipU9Blt0/xO/heMAl0ywWbVLiLQJYr+f+vlnC+mzlh
         2ijPXoqO2VWVZWJdsnlYT6RBlBaydZnnHZzIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNHPWPj8siy37I5SSEheyq3GqHY0NjSZ54pkkOzX4fw=;
        b=W4Dwv3qJRir4+sRSUmLxK24J3eB/0tyKbzDx6mikJLYc8fM7BbSwwc6rseFFLSeEeQ
         mbjYIhwQ0A5rsqPYPL5FWL5td4w6Dsain75e8rSFqEejkneFPw03EVGq8ZZFtW5uA9yb
         DJwye7ZaeN0AS1NdxvI9WTEESsVnnaoj8WGZkBTdv3Gv8v/n31chgDs9sBx6iwEI3KBB
         GePzi+HpXwpZbwBFE+XTnaFi4NT2Y0T0do7uSuL6tCeUNGctUCTjIylLTuPkQ+jIwL+t
         hfI4P25w5lWNISzRYaygtrnksuhk30K6laN21eHPd9tFwSWtyJrEiuBDs2kCxb+aBUSx
         ncaw==
X-Gm-Message-State: AJIora/YY/xxcXnx7Y7E1Vk4dYATG8cVQTsYqCP4iDnl9bNAQQUZgSwP
        eAxLOzypJmHNwONsgrgJJSmplw==
X-Google-Smtp-Source: AGRyM1veYe9c0FEZfH6DXuEyH0paqyMkxXulY0uGGXPYE+Wvzdj9dFRFxPC2iMgmJpWNx6ePQvAhug==
X-Received: by 2002:a05:6e02:1ba7:b0:2dd:27d9:8386 with SMTP id n7-20020a056e021ba700b002dd27d98386mr6835720ili.295.1659392034968;
        Mon, 01 Aug 2022 15:13:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e23-20020a02a517000000b0033fbab06b75sm5723914jam.46.2022.08.01.15.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 15:13:54 -0700 (PDT)
Subject: Re: [PATCH 5.18 00/88] 5.18.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220801114138.041018499@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <84ff260a-53f6-76c8-221b-ca01fc43b407@linuxfoundation.org>
Date:   Mon, 1 Aug 2022 16:13:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220801114138.041018499@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 5:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.16 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Aug 2022 11:41:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.16-rc1.gz
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
