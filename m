Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE404E7C08
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiCYXZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiCYXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:25:25 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758E340C4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:23:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b9so6183868ila.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E0Za359ReI0RRBjVwPJRtdWCaWLOO+OOZnvlhNziPCw=;
        b=UXrSMVMUDKIuMKmJmFgCJWo3lzBLy6HvmXPsiemRIsOuGpF9NdgCUCw+nWWT/3u9r3
         RuGVv+GavkLXPGVEKxyh1VU8lV3vGo+mEl9lHv9ybetjo1MD1IlCifV8xgnzSiS/vMxL
         8WKP/7nJkLqTPH2ukJq+QcII7pgVR+AwNpFlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E0Za359ReI0RRBjVwPJRtdWCaWLOO+OOZnvlhNziPCw=;
        b=Tu9hm8LE8Xt/gPIx05rdGpA4LsA5iZW/rdh761xluW6dzIODGhWv7ZptdLLXlj9HSN
         Gn7D0qE49QAdpXdjfAjOHx+9dou+iKZVg9SUDd0Kh1O1OZyTV+usgjbeYOINLP046Fqk
         lk9+e5C4parinANmNrNt1Y/xHvawwzvClKooHaXYN88HURwYXAjQCgaJPNAEUVM1trFv
         NKB+vlo8LscDNL2KZ2XYT11g9oI9axsXLXn9nsA3b8q14VFsKiNYNTjhROicKVNOOr7p
         zx9TjBly1e8uxv2ifsEh/OH/SLa/r1J3Wy+QT9K+s6wkoZ9KAnL4zAXI6RQGfy2ZUrFx
         iTcg==
X-Gm-Message-State: AOAM533KjvZhksWDigXSbi/4jj2GZCTspXaGbRfXvZ2as7OJ4vhgpJJR
        a2VEhvdKi90P5P0Pvnc5IYUA6w==
X-Google-Smtp-Source: ABdhPJzCBBQFjHqCq6oVZenMyKokfGse4//snHJiLCxuBt9AEYnyUkFpMoIKdVIkJyCeQViwbiA0tw==
X-Received: by 2002:a05:6e02:190a:b0:2c8:e23:27ad with SMTP id w10-20020a056e02190a00b002c80e2327admr616882ilu.142.1648250629754;
        Fri, 25 Mar 2022 16:23:49 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id t7-20020a5e9907000000b00649d6bd1ec5sm3652484ioj.31.2022.03.25.16.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 16:23:49 -0700 (PDT)
Subject: Re: [PATCH 5.15 00/37] 5.15.32-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220325150419.931802116@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <30d7a9d8-41ce-e331-787c-23c358ee7a89@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 17:23:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220325150419.931802116@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 9:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.32 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Mar 2022 15:04:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.32-rc1.gz
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
