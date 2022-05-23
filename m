Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053B2531EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiEWW6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiEWW5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:57:50 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31602A5A9C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:57:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f4so16827362iov.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ggcp0zjZmQ/QfsLBFD6ZMjEZEly6gIkm7Ekiu1tONqI=;
        b=Uu6yY4bFdBK82hHbEw9z/hJZDOnBlXq8fWH/8AlhZmeczo4OTRQ5IsghYGNUuwOPxF
         4wOwvluJAqAqYX/AmfiCv1V4w0YpOjefIqmRiuDp+YZ/PlZy6xSfb3YmxECHEqP9+p3r
         zRc4Ecwgf1cuGNTQnNAF+Ob6tdxbXG0MgYXu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ggcp0zjZmQ/QfsLBFD6ZMjEZEly6gIkm7Ekiu1tONqI=;
        b=ABa6jtru5Xq409rJG+uVreuKZVgiRzy2bDMKoU/kabLR/IkPgD/NKoxYyafX2+/Tl8
         EayAxisxcu0EGmXJDoD7NiylWimVAnRqwKreFSNRLCa0le5TnUhL22jLaDCe5T1PTa9s
         GxgTKZ9QayOCK92toFpnWgREfu1PzRpIL4aYIdaCECMtZ41aOgmVgfL8Ie52gT5uLiMK
         /g2slAg71sr2KY3iRDcMDOdsM/xTPl7nyxpI/SxbGY/jV/I71SEKbKyYNLkutv1LU0+A
         HzH+yDL3boITpZq4dTqLDVkVgjDe5LukKqG8+LOtFfU9Nzg+zTaI4s0UmPGtPGy8LQqn
         ghrg==
X-Gm-Message-State: AOAM5305GkFu9nbwDn5fPpmsDFZcCUtQUwbp7cyMfLukB/VjZl1rkKjE
        sKdQ2gkwXZWPUo3BaOtXZ/KgVQ==
X-Google-Smtp-Source: ABdhPJwFGd3YJH0D+TiMCqPgfwU3mlpztEJC/+6kBalWkAM6dN1a/ndxmR+zIwkLo/lz3h+eVx9dqQ==
X-Received: by 2002:a05:6638:1509:b0:32e:5c10:29ab with SMTP id b9-20020a056638150900b0032e5c1029abmr12577664jat.223.1653346669585;
        Mon, 23 May 2022 15:57:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k14-20020a02a70e000000b0032e168fa56fsm3029004jam.83.2022.05.23.15.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 15:57:49 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/44] 4.19.245-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220523165752.797318097@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <84422085-5f30-21ee-aeca-c3a9ca235143@linuxfoundation.org>
Date:   Mon, 23 May 2022 16:57:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220523165752.797318097@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 11:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.245 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 May 2022 16:56:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.245-rc1.gz
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
