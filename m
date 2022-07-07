Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D32A5696B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiGGADX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiGGADT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:03:19 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3062D1E5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:03:18 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h16so2162038ila.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 17:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pHY+rlhy7XAETynfllgOwshXSKWi6PJ+NgDnuwk5Hks=;
        b=f0O9/kYRDLEaXkzbZJWMzRWE52tXCi5ejtHLOvhaew4aSoV04j5sws/m5cKHadPtMR
         XrkxHx2qd4B2NtKhLmZ20YxRWVZB3EG1nxayXmDFu2uOLnW+EvTs+7B4DuIy06ySZeNL
         82XbaYtxgPAoGs5dVeblqfQ8Nsa+ANKlv5bxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHY+rlhy7XAETynfllgOwshXSKWi6PJ+NgDnuwk5Hks=;
        b=eBwwi8t8nZvn+sOenGwLVuvZ9WVmzit7ZPt5laJdzUTQJ3xmvieg2e4N8dmqfuqDmN
         FOJt9rhTuyUTcYgED5l9tqGRh2D+UsztiU7Iws4VJKGGawXKCoTiLZ4fpYQQ2WMrZhZW
         1RRIt9wPpUn3pClB6+TdyrqcZ1YnYe3x18qkIKv8i0wtVm5CWs+ThAvo6tzONKh83/St
         hbvzoaJbbONnoGbltrVR4Jy1Ine66Vz+Dz3ki4c+m8233w8z/boIBSzEJS7VCoB3CiXm
         5LjMDY9bsVVWmefS4wcHVgbPgY6boM86mSVFDdYAP7gyxGN6ozCI7dYeBX9u0g0gUh2z
         y5QQ==
X-Gm-Message-State: AJIora9VI9S/cZj9h23o8R2vu3MRjOW5okPWE2BWHH8Wrq5Gqm97kFOk
        UpNQ/zizE6cZei5H3U7BLAWFMA==
X-Google-Smtp-Source: AGRyM1vcWGc8M412Jbos/h/8sSDbi52g/eKNCOJklynrU//Gg9TCr6WGlZxcc6eZywsRP25B4c32ZQ==
X-Received: by 2002:a05:6e02:12c2:b0:2da:c41e:5aa2 with SMTP id i2-20020a056e0212c200b002dac41e5aa2mr25283844ilm.57.1657152197945;
        Wed, 06 Jul 2022 17:03:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bt6-20020a056638430600b0033c9beb0e19sm13026998jab.22.2022.07.06.17.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 17:03:17 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/33] 4.19.251-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220705115606.709817198@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0198934e-6160-2d5d-18e5-a3b7209b2e22@linuxfoundation.org>
Date:   Wed, 6 Jul 2022 18:03:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220705115606.709817198@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 5:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.251 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Jul 2022 11:55:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.251-rc1.gz
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
