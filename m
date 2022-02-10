Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3DF4B0202
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiBJBXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:23:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBJBXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:23:21 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF68767E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:23:20 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id o25so3390958qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZO4TemCZ8xmhdNFoaIraPzmY18I03u16eQkDpDWGxg=;
        b=btEjxvWZwzfmYXT1MzA+MxUz2YNp6aGlGnqyhsPlm++PMTaJ1BalMTHvRmgVtY40qW
         hERYDcBs/H/UomXIxXAoHkdM5hIBTbnkMCghbUGwvi9FwIW3geHyi7GCtuV6huFyVet4
         Xe0Y/BUTW//RTJEe20Or6Qkn1FPPPGMrRq948=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZO4TemCZ8xmhdNFoaIraPzmY18I03u16eQkDpDWGxg=;
        b=XzYXSGhjxr/c860eojxVSLZwezXpXnJjb8tXSH2xN4vuZ9dadsUHjJqcm9s0qEdIji
         eXURH1LT52K2CbNFUmenPnCef87/lORLhOJ3fEsVWaR9B9WX+Jlbb43FRDHXNBcS2IV+
         KC6U31rmUDXmDQ6YBg9zVAgyWvur/VHdf1fPCmsbyRJOdvqIVJlLiyFG+JIZU0gf/RgJ
         1rj0srTMWSc064hRr/BdV11ZFbc7FQkoSnaWmcUkHsO595qDXWu/4+ac7zh+UAXiJ+OK
         vijL9hfJtGMvuzEpo/OzVcPYF3K5zLveLrnhJ1HiMqYMvjnh8aGd1eMz/oVaEeX9IYqR
         j5Ng==
X-Gm-Message-State: AOAM530XoKEL3HvMaiUDQNrJNGPvHdpGispLD2IpLzeBslg4d7lv+nCz
        KgPN23X+vY7Q9sIYCcHOaRu0zSFszALLnA==
X-Google-Smtp-Source: ABdhPJzlJDxhdVWGAi6UhKwOweI2QgEC/M5titKQ/PUe+fQ9cnMmUTBueH1sFoVkjm0wWwZu+icLag==
X-Received: by 2002:a05:6638:345c:: with SMTP id q28mr2599777jav.143.1644454651912;
        Wed, 09 Feb 2022 16:57:31 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l16sm6835203ilc.54.2022.02.09.16.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 16:57:31 -0800 (PST)
Subject: Re: [PATCH 5.15 0/5] 5.15.23-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220209191249.980911721@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d0bcbf2-bbe9-c04f-e879-5a3655a24f88@linuxfoundation.org>
Date:   Wed, 9 Feb 2022 17:57:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220209191249.980911721@linuxfoundation.org>
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

On 2/9/22 12:14 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.23 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Feb 2022 19:12:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.23-rc1.gz
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
