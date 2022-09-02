Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412EA5ABABA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiIBWQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIBWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:16:37 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF30A1D13
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:16:36 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d68so2741373iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mf4MOeB8IFzC9a/pzJ/crsUERCbati8LGfbITRzYVtA=;
        b=Exki7VHZvsSm9/awlVADGcZr2fj240NKkGb664RWXsY/jUpjXBcrv28YCutLWR0nxU
         WaTE9pOqiXwD0ybqXaCtGEf1w37/kV7L00vmAfJavn85jeHYILgPdwPvnftN2vq+XoMj
         n5tKPMooa/1x4VNy9tCYsQ80KwqlU9TiAvyS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mf4MOeB8IFzC9a/pzJ/crsUERCbati8LGfbITRzYVtA=;
        b=nHNZrtpR0lGcQ123aUppdC0sOVw/z3zvO4Wewamu0eu0QxZ3kfcF9utibXS35qXVqX
         ZAh6Wn2hUXir8bBOugfwt7baVqyYmesX4gVi1fRlsmsBgTMqeW3+DB0p0BGzs+zSF6P2
         VgXgQQJ4C/YQJKgS8tAxf/4AXSoCgYLSdgWSlSioZ1EzKE59pwYgVBFFDoY42v1K3V5z
         SyZkXIs6p9LLLQV08vtOiDqrVS5RHhRbfa0vGI8WOg+mpKvMeOtHs4tTiFLhJEbI6D5k
         4wKPHUSi33DZfR/vVuAgT6xP4/93KwuqFtmvJH37p3uw4QnWylhYedru/j3hZPlRn94z
         mkmw==
X-Gm-Message-State: ACgBeo2hub8pI3g/O3jyKHCWcDkZmKtZseMRTRFKGUGAUHCNo4Hi5k05
        FpXirPyRe1KffeRqHg8loHHQhg==
X-Google-Smtp-Source: AA6agR7oQr13xU7E4ned6YCqgxBGIzc9I2SideK9L+o2tWKomBO5FZxPSSkGC1pPKNZQXtJhOFuqUQ==
X-Received: by 2002:a05:6638:2105:b0:34a:694:4fa4 with SMTP id n5-20020a056638210500b0034a06944fa4mr22339670jaj.116.1662156996362;
        Fri, 02 Sep 2022 15:16:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t3-20020a92dc03000000b002eac43d2013sm1222994iln.43.2022.09.02.15.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 15:16:35 -0700 (PDT)
Message-ID: <2a29f109-c529-0eb6-96a8-40088c25702d@linuxfoundation.org>
Date:   Fri, 2 Sep 2022 16:16:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.10 00/37] 5.10.141-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220902121359.177846782@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220902121359.177846782@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/2/22 06:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.141 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 04 Sep 2022 12:13:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.141-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
