Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D594529881
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiEQELd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiEQEL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:11:26 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D711F611
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:11:25 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-edf9ddb312so22790244fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ghXKibsGeeDlqXrn4LuB7ZrsZcuzsC/5Mc52ZiE6IY=;
        b=X2ZpXRIxOUFJWP8cFqlix8VfI/5ewDOVJpvbdqsqI/cH3l+2tyxcglWgwwtKu469Lb
         knFr+MY1IbFOx8VHakZWgw/sbftI11qicKdjAhLYfAG+xY6coTJKtjC/SluEG9me4yyH
         OSQiQ1ZtJ6SSEJ3Wr5gURcgkw0Q6z+V+3BTKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ghXKibsGeeDlqXrn4LuB7ZrsZcuzsC/5Mc52ZiE6IY=;
        b=JXgTvvvqqqNlBZawnT6rkAV593a/LFDhpFsPgxDw+I0gfLeNnk6pka3Q3MM9ryZJ45
         XM3pPxxT18sU6WtyYvq3Ck2vL/TAkpO7FWex2BCCkSeNL2FwVSmQ+v9feu7dvC+uqN8c
         e/Yy8ueH1JUch0uXiTMEZP9AcYbzfaNy9sIm9A1Q3oTpaUbUWXfNniSGAp+SYKreymK0
         v/ge+SLjTcYj/x0Km0ZXZRfYXxMUCeSp/sGAxfqR0SDCAZbG7pIptZGeEKJrOC/1blBb
         Uv1zqjm6lbZK0p/mdDaNBmEUMjzbfPQm/ycVD+0kxIudidEQGL94GRTPhPLRCKrpXqhR
         AsBg==
X-Gm-Message-State: AOAM530Ibvqu/dKuHNzc4rqxvuLmJ1XJ+nc+dNPDpxg1LTyIbOyu2hhh
        rALPeQajI1k3PWY+cLTjCgs7Ww==
X-Google-Smtp-Source: ABdhPJxKPWYu7Ftpr9i9sph/zyZO0dGM4p2FbrUCRqXFE1pFySMGPV9PIcO+F62Wh6sAl85F4zzAmw==
X-Received: by 2002:a05:6870:ea93:b0:ee:1763:6ed2 with SMTP id s19-20020a056870ea9300b000ee17636ed2mr12099716oap.28.1652760684477;
        Mon, 16 May 2022 21:11:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 35-20020a9d0da6000000b0060603221263sm4606832ots.51.2022.05.16.21.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 21:11:24 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/32] 4.19.244-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220516193614.773450018@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <87bb7e4a-1074-cbbb-2d50-6ef048f5b97e@linuxfoundation.org>
Date:   Mon, 16 May 2022 22:11:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220516193614.773450018@linuxfoundation.org>
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

On 5/16/22 1:36 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.244 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 May 2022 19:36:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.244-rc1.gz
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
