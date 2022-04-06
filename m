Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43E4F5DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiDFMni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiDFMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:41:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2D31760D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:42:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m30so2122039wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UbK4RBSd0yuJs4TmZuJR2YyTKgeyXT9QjtmlpxRzZh8=;
        b=JAr2POc58WMdiI6hHHtXn4NZAcuZEtBVynJuBo+HcVSzObZkeKA62juntxIX2PefnD
         /oS4CxISFNDf4kF9m+Ny3B/ha9ND19AYwAGGZ0Ex7yId9QHZ0aWH+tqSCj4lQpQ/n4w9
         0vHfPQBz6oGFLJUtXe8aQfleIIX0puOpykpgUuwEX13ifgWYxPBIc/q+6xPUWaqOsxIx
         IyJCtJx4Gz2C4S10JxNOsSm/Q9GaStcxM7sJuW6VJshsNTKRlMkrF1Hr+6yN6RVjYMOL
         sKACCH7mbUbDESk5uViqX/q/5QvCUgPTa8Ge4MvrgtNh4HDkzt4D7w3B9oaGo+kOM5tD
         siSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UbK4RBSd0yuJs4TmZuJR2YyTKgeyXT9QjtmlpxRzZh8=;
        b=fasPtxHV+accHQ/024ToQNG7DxN9OsrIemcvPeTWt18NjiUOkkGNDmELm3rfDRx1GB
         HcZAm8e/NWycyRZusuvQ/k42gHVa/Zz0jVLTPr6E/CW9KPrjSJhlWrb2ElmDqNkVsmI3
         KUMEgzyQ7JI3B6LWLfDyvI3q8QStHCyyIGkzZoPHDsSUWsJcLTQWpJw94Brw/P5XZMGC
         FcypMC+juY1wyN32cIVRFhnOlshsosokJ7bzRSu1aBro6HFtHzbu9e+XEnKOCo0WqXrw
         kcU6E8Dhuup4bPvMbh1ut7hWa7yTsQsAau/WYsAou1rbetAdJYbDNfYIILbP0ccgX7Os
         AKpw==
X-Gm-Message-State: AOAM532Ok0IimJceIF0tNawGeusdsxWbCtX5elbelbH4iepycv4up6Ft
        p/EnyupaNaQBskjGAUp1AWYNcw==
X-Google-Smtp-Source: ABdhPJwt5POiwqFcwAJHu+CJKfOSdMY7MGAHgfwGFWwu6TDk8N+rhFOlTkF49gRMx+8a6bDs6y+Cgw==
X-Received: by 2002:a05:6000:1841:b0:204:ebf:1181 with SMTP id c1-20020a056000184100b002040ebf1181mr5758309wri.681.1649234577926;
        Wed, 06 Apr 2022 01:42:57 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm4983659wmp.13.2022.04.06.01.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:42:57 -0700 (PDT)
Message-ID: <8162900c-054d-6260-94ab-82ea090de499@linaro.org>
Date:   Wed, 6 Apr 2022 10:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] clocksource/drivers/renesas-ostm: Add support for RZ/V2L
 SoC
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6419fd7b-8213-3a51-268b-a9602c770991@linaro.org>
 <CA+V-a8sZdrpYMy-FSbaZzbKw_F_jEhTpOExPXr8_jDXD4_pooA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CA+V-a8sZdrpYMy-FSbaZzbKw_F_jEhTpOExPXr8_jDXD4_pooA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lad,

On 06/04/2022 10:16, Lad, Prabhakar wrote:
> Hi Daniel,
> 
> On Wed, Apr 6, 2022 at 9:03 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 06/04/2022 09:24, Lad Prabhakar wrote:
>>> The OSTM block is identical on Renesas RZ/G2L and RZ/V2L SoC's, so instead
>>> of adding dependency for each SoC's add dependency on ARCH_RZG2L. The
>>> ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
>>> ARCH_R9A07G054.
>>>
>>> With the above change OSTM will be enabled on RZ/V2L SoC.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>    drivers/clocksource/renesas-ostm.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
>>> index 21d1392637b8..8da972dc1713 100644
>>> --- a/drivers/clocksource/renesas-ostm.c
>>> +++ b/drivers/clocksource/renesas-ostm.c
>>> @@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
>>>
>>>    TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
>>>
>>> -#ifdef CONFIG_ARCH_R9A07G044
>>> +#ifdef CONFIG_ARCH_RZG2L
>>
>> I'm not finding this option anywhere
>>
> ARCH_RZG2L config option is part of v5.18-rc1 [0]
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/renesas/Kconfig?h=v5.18-rc1#n43

Ok, thanks

   -- Daniel

> Cheers,
> Prabhakar
>>
>>>    static int __init ostm_probe(struct platform_device *pdev)
>>>    {
>>>        struct device *dev = &pdev->dev;
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
