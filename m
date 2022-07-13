Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73D572BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiGMDRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiGMDRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:17:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D144D7A7B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:16:58 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id u6so9594976iop.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NOar6MnEqXDwtrvK2AQRJKKT3Ik/UOEZ7FiGAzg0z3I=;
        b=gWnkKtkYhbBlUSQWnVOU6Z4mkgThELPIxFQ6XfFxLao6p09xGmBlhs1vROXxR2pdhi
         yv57GMfJ36NdK9pu5AarTj+bQMdtTnwdr/ZVudUt6kfDV+e6FqEDm9mXXw8gfsDfJ4Xk
         qe4kJd2dmqc8y13graokDpOMsP8nQWiAnspMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NOar6MnEqXDwtrvK2AQRJKKT3Ik/UOEZ7FiGAzg0z3I=;
        b=mLDUBHYUlB718Hhun2DPcWNsncgoM+acm5bBEmR9Kr6VumUqqGkp8RItLwzC6qGJD6
         lHmAAXsAja/BqVpzGX76L8Gi8whmBV4bqurICQqT/BzAdlkvdD+JZjmxQssVNcOl1EU7
         J14H6gavsuWKoBHWOt9y3J9tjlkHLKUAF9geWX9h/Yg3muEEd4td4KanAiXYZcWdODFb
         h8YWsIhafqikT6FpBMFYptP54LAtYD93aQIDaxmnjkcW00z4iKW8OnFy5asN6lHcUP65
         LSSMSauEfOF+ozKsmAoumliqAr/m8WAL03Fd9vHuQ1ytK42JvyCOHz0ofa+H2JoNS3g/
         CmLQ==
X-Gm-Message-State: AJIora+9cG2a/MKUnHqImwxEWnWhi5JD9ZgDiuEyE36FFktNH0dxlKdS
        Wr0bdTKbrplxV38b+3dvEYFm8Vfb0aly+g==
X-Google-Smtp-Source: AGRyM1vmqZ30pQeW5eGceJziZlGF7mRuL7z7QxE4dc7LNV1ESwzK0EK9/Nldb9DQjAKsZE8ZvJYDVQ==
X-Received: by 2002:a05:6638:3722:b0:33f:4948:a91c with SMTP id k34-20020a056638372200b0033f4948a91cmr767877jav.283.1657682217851;
        Tue, 12 Jul 2022 20:16:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j63-20020a026342000000b0033f8312ee5bsm184798jac.41.2022.07.12.20.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 20:16:57 -0700 (PDT)
Subject: Re: [PATCH 5.18 00/61] 5.18.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220712183236.931648980@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <89cdeb96-6227-4f6e-5ca0-f78adf3c7e07@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 21:16:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220712183236.931648980@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 12:38 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.12 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Jul 2022 18:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.12-rc1.gz
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



