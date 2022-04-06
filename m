Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D794F6E14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiDFWxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiDFWxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:53:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF902200975
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:51:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q11so4814615iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LhLrFcTJdN0MyQgGqik/pDNO2Tmd3bn5F2SfDE9sxYg=;
        b=B5VmOhGKEDfBwkHfDjI6SdGmK4QTmThmIB6r44KJkU3FbHwjDCROIF7vqYXWnupMrm
         JHGnaEdp8s/tIxoI3rHstf/+ly4in0+RPOoz8FXM493hBRqlqhhSpcPkOuqEiRfpvDQg
         Q3eXyohXkNQ3i3ZcjQgplA88u+eVpMynuc+5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LhLrFcTJdN0MyQgGqik/pDNO2Tmd3bn5F2SfDE9sxYg=;
        b=T5Rb7CZ/QHeW/tTbv6qYeJu2gKNYK4UhtmoJzs2WhiYC4y6vealIByDmz1hLzCYzqz
         gJyCuR2SATXq6DkRLsnI51g/MzFqCaoP5AhN+oEo7oiUkf1epyphzKzoL76mzFaTCYjD
         6BGPJPbxPTSFVHqZ8HXD5pztjitbeG45jBwQmzdiBdTJzZfMz55lEpUXlmo/Q5yk0XhK
         W0ifSkPur84vJ8w15EcpYo97YWl5EmFaH9RJLON+ZNh1p9MXxvAt22HZ8Joz+qNhr6Nh
         Ef4pZfE2VX2kSxIwSk4NjkYVEWP740LISY74PDrbWMdiHHjjoQYhMO1vl6xAYpdkeYPH
         fyag==
X-Gm-Message-State: AOAM531s9/4ivsMjDp9jV2JYW+ziN1nw1nh8l2FpdX4g1bsGHPAwQiKu
        kcLCVY515AAJUDh8n5aXh0ycxw==
X-Google-Smtp-Source: ABdhPJwBou2hJHn5g+qBkuPsN4yU0hqUunMANuO3+MiQlhNjNpnUhn1XJA6tmla0UZK4c0tmYk9e4g==
X-Received: by 2002:a5e:dd08:0:b0:645:d3ba:b9fb with SMTP id t8-20020a5edd08000000b00645d3bab9fbmr4976646iop.35.1649285481029;
        Wed, 06 Apr 2022 15:51:21 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a9-20020a926609000000b002ca50234d00sm4809521ilc.2.2022.04.06.15.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 15:51:20 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/43] 4.9.310-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220406182436.675069715@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a4adfaed-24d4-f47b-cbb3-eea8010e57df@linuxfoundation.org>
Date:   Wed, 6 Apr 2022 16:51:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220406182436.675069715@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 12:26 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.310 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Apr 2022 18:24:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.310-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
