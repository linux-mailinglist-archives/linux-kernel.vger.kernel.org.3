Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1895AF73C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIFVrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiIFVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:47:35 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE47FE66
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:47:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q81so10036862iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kepMsfpha1CZHdXxmLNW/XvCN6LgxN8IvoqzTOYQfN8=;
        b=Ya+o3IdnsmQ2Hq8rbOuo1z5bm8RNVAvyueVP1FZf7yXbLiFXnIFA5UksvdJ99UD+vZ
         CfxM/FPO4KrQsnoRgcIGUFRYj8YDG/f+qA03LyCsdfQB/n3D3uuStWlLqzvbDRdq5KtP
         TKXo+eDkSf5uLDdZhmwTWeOh+cUJGCQ/s3f3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kepMsfpha1CZHdXxmLNW/XvCN6LgxN8IvoqzTOYQfN8=;
        b=mo2WIHe+Ifv4x9ItmJwVisqHUyUxeP1tzoA6PGrUsiarRs5AHsC/Uyq1wdyloyXAK1
         g7ttmZ44p6Q1FhraAhAwj7SIMqWhErC2s5URkxybel/VSotkNzV+jNWBgAMBirf5kWNu
         cn+xMySTsXYri7KmQ2V0fRVoPBfkjesdAMco/YJKxUnqFRDTr+n4JlrPtbfn/tgYmNhP
         ZQCGjv/99qoeupw0NHsHL9qruMp8ohPcL0DEljvffvZqZmfDAqzS91BPeIV74uz1BSNm
         ZapMomgpkvIpjeYeKHUWP7v49Kt3vVLnw5SLmesFsfy12jhJbU/zs1gNdlH6nIr06MAg
         NXBA==
X-Gm-Message-State: ACgBeo3wJJ2AZAy5dGgZzVAPuk6qViXSy1csGzptCGvjvkPM8Yl2yj2q
        /lfiKOvLHtMXpCiO70Exk7af7A==
X-Google-Smtp-Source: AA6agR6VkfMdtYivgcf8Hm7fhnA4MMA5kjwDhvpTJEKePcXBYubUaqM6B12P7d7aQy5IWbSDSDeMrg==
X-Received: by 2002:a05:6638:1505:b0:356:70c9:939a with SMTP id b5-20020a056638150500b0035670c9939amr417974jat.38.1662500851679;
        Tue, 06 Sep 2022 14:47:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 190-20020a6b01c7000000b0068845312ce0sm6593409iob.0.2022.09.06.14.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 14:47:31 -0700 (PDT)
Message-ID: <8f3fd5c2-991e-5705-89b0-ce39494300c0@linuxfoundation.org>
Date:   Tue, 6 Sep 2022 15:47:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.19 000/155] 5.19.8-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220906132829.417117002@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220906132829.417117002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 07:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.8 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Sep 2022 13:27:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
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

