Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432864FEA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiDLXh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiDLXc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:32:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB64A13D0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:21:18 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z6so9464iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gl+YqMB1WW3Ib7L+XCeBKpWla23lkdhnXW3bHwJTMT8=;
        b=GMeyzwBOf1UAQTAdYkU+w+Eotzg30VU1F93bzVm6GfCm7eayvv3TNG7IIq45+Nif1H
         KGpz5BrMhxviT5dQr+6JO/ZUfpiD/rhS80XRWgW5163Rbw2lZXgyRjQMrBkjXXSojjWC
         GyDCa5J/3ofiaDTSpfp8EeW5krJ28cxf2h38s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gl+YqMB1WW3Ib7L+XCeBKpWla23lkdhnXW3bHwJTMT8=;
        b=7Ph2Al6ie+W+pde36BGR2kBEgzswVsy4X8Jku4ElSZyIUuL8v6mRcx+O41wTndyxlx
         EkxNlTwJi5QhlnJCICeZAiaghgEiUjOM14XBdtLaN0Jakt2aA7W/dC6r4pbTlyYNX9cT
         oARmxcr/StmfLhNMTMMZz4G+XAF4bWdfAD1EM6FkkoTsBTsfNB3nhiRUCjASAX4U+dUz
         5KH5U9s9fimY71WYWuWyzuLymdXY6bnCsFb79/Qa6aHHvvjT3zocwQ0RbyOXkmBQB4Y9
         wnjU7sNSVeJd/7/IIrZ1jSX0nOoEtww/A20Kh3+QCbnWkzrN19u+eTeimOgVl64SfVm0
         gUsw==
X-Gm-Message-State: AOAM533UmvHVXZJ5FXWxewSlwjF24UhPNtkWrN0H7PYthvPVRp9417FG
        k2Ce5xughAZ2Hdp260Ke701G2g==
X-Google-Smtp-Source: ABdhPJzDTgRjGvzK8TyuYVbOVCUWj1YHnTHkPHES9mbxla3byGwlb/0PhwCjf8NjNKAvW0Vpevu3Gw==
X-Received: by 2002:a05:6638:3049:b0:317:9a63:ec26 with SMTP id u9-20020a056638304900b003179a63ec26mr19674690jak.273.1649802078223;
        Tue, 12 Apr 2022 15:21:18 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm2908668ilm.0.2022.04.12.15.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 15:21:17 -0700 (PDT)
Subject: Re: [PATCH 5.15 000/277] 5.15.34-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220412173836.126811734@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9c5405fc-432c-e45e-98a4-3ce252a5210e@linuxfoundation.org>
Date:   Tue, 12 Apr 2022 16:21:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220412173836.126811734@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 11:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.34 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Apr 2022 17:37:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.34-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
