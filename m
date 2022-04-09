Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8D4FA74A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiDILaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbiDILaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:30:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACAE2CF2F9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:28:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n6so21851951ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 04:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PooaHONqZ3morb3wBaewUnRY9UPBpG0RRv03MJGzAek=;
        b=MssUOwxelL9/v9ooozb9mBvooglCpqSDKkLiInz+GRpaeeJQ/gFZfzlcDBUrJEzN+2
         25EUEsQMrbJa6xigfY7dXZ9onLPDoZUCH2QZ2t+ym6BBYLARlpj0axukYLjkMGm2gN2w
         aMx6gYvbRMhhxnsejouyaTefWI8JWVxZJTMLQfwqm2ipTbRiMuDPHcpeX0kZwZ1Lw7yO
         E9GddyM1l8nEM2XKKjMKDhUszg7bJHtFXtRrujxbcPaCS+PstzGKK0vPgJjpifGB7kBo
         vXQFE88H/RayhO432luOCYs0wBUcLJbzLCKqgctzATTVvcojRC4X95mQE4E6YbhVnSi0
         J/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PooaHONqZ3morb3wBaewUnRY9UPBpG0RRv03MJGzAek=;
        b=gVISj6T5mITjGrAvv7LI3Kn1LYEXtbC3rD7RRPu9ljxJCX3xLTmr8swJ5TaCP9AVAZ
         V6B/I51suCd7sNXrL/I6QKcKWkr09qf4AK6zYEU88CsYN+JW2c89vmRbIfgocGBRtb9D
         6CuBHzCy5qfCiDnM0lKWcdw/eAevWcsbmnIymu4crj20cJ7mXFP7ocRB04XbFU1MnQ88
         oFFm5l6yq2d+2yzFRCyY/itPzEbhSVNapq8gXMh17KWT/JBeey4HtXfxnFbKqrWDEP8n
         JHX3ZVItY2X+li0tppRIl0cfZyniuTohT9CM5h4xFTkji9B+Mmms/g0B9WodQxdgFYz2
         BQdw==
X-Gm-Message-State: AOAM532Ki4Rdb80ncZHtlOqbT2jBu/XsEHzWXaXmqdo83vJUFk3hHkYV
        +QyxPIoG7dHwqhbRtB2ERcxjnQ==
X-Google-Smtp-Source: ABdhPJwzDeJ1FFxw1gerOuBsfxqzcuc/CtzzQSYaIGqY/Vsx02rgbyStflfendIRMubNpji+NSCjVA==
X-Received: by 2002:a17:906:fa16:b0:6e8:4762:be82 with SMTP id lo22-20020a170906fa1600b006e84762be82mr7617821ejb.243.1649503694328;
        Sat, 09 Apr 2022 04:28:14 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906718500b006e7edcda732sm6946077ejk.125.2022.04.09.04.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 04:28:13 -0700 (PDT)
Message-ID: <202bc116-0df3-da07-62d5-5eb9bdd53baa@linaro.org>
Date:   Sat, 9 Apr 2022 13:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 2/2] mmc: Add mmc driver for Sunplus SP7021
Content-Language: en-US
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
References: <e99f3027590b5ab3938c2e2d8713bf6284a810b2.1649229258.git.tonyhuang.sunplus@gmail.com>
 <202204070029.JvyEor8F-lkp@intel.com>
 <CAHpW4oQc0=SinXTVW=ph8BgKQ4bN1mXOtWDv46MCNgXED+9TGQ@mail.gmail.com>
 <607c96516048441db549f716656ea62f@sphcmbx02.sunplus.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <607c96516048441db549f716656ea62f@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 13:11, Tony Huang 黃懷厚 wrote:
> Dear Arnd:
> 
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>    drivers/mmc/host/sunplus-mmc.c: In function 'spmmc_set_bus_timing':
>>>> drivers/mmc/host/sunplus-mmc.c:311:15: warning: variable
>>>> 'timing_name' set but not used [-Wunused-but-set-variable]
>>      311 |         char *timing_name;
>>          |               ^~~~~~~~~~~
>>    drivers/mmc/host/sunplus-mmc.c: At top level:
>>>> drivers/mmc/host/sunplus-mmc.c:798:13: warning: no previous prototype
>>>> for 'spmmc_irq' [-Wmissing-prototypes]
>>      798 | irqreturn_t spmmc_irq(int irq, void *dev_id)
>>          |             ^~~~~~~~~
>>>> drivers/mmc/host/sunplus-mmc.c:894:5: warning: no previous prototype
>>>> for 'spmmc_get_cd' [-Wmissing-prototypes]
>>      894 | int spmmc_get_cd(struct mmc_host *mmc)
>>          |     ^~~~~~~~~~~~
>>    drivers/mmc/host/sunplus-mmc.c: In function 'spmmc_drv_probe':
>>>> drivers/mmc/host/sunplus-mmc.c:1021:22: warning: variable 'mode' set
>>>> but not used [-Wunused-but-set-variable]
>>     1021 |         unsigned int mode;
>>          |                      ^~~~
>>    drivers/mmc/host/sunplus-mmc.c: At top level:
>>>> drivers/mmc/host/sunplus-mmc.c:1170:9: error: implicit declaration of
>>>> function 'SYSTEM_SLEEP_PM_OPS'; did you mean
>>>> 'SET_SYSTEM_SLEEP_PM_OPS'? [-Werror=implicit-function-declaration]
>>     1170 |         SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend,
>> spmmc_pm_resume)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>          |         SET_SYSTEM_SLEEP_PM_OPS
> 
> I follow your sugguest in v5. 						
> "It's better to use SYSTEM_SLEEP_PM_OPS/RUNTIME_PM_OPS instead of the SET_ version"						
> But kernel test robot shows error.						

Which you need to fix. Kernel test robot gave you tools needed to
reproduce all these errors, so go ahead and fix them. :)

Best regards,
Krzysztof
