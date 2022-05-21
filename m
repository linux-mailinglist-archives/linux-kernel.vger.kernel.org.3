Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8E52FD2E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbiEUOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiEUOQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:16:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583FF58E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:15:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu29so18721561lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ie8zVBkqSt3mxRxNew4V89gQfU1Dg5+Y7b1pz0Qwsgk=;
        b=mJnsHPN/JuGfeOjYcqypPumJTBfx69JAky7b516fmsp+L2JhVIWo6S8hYfX40pP5sO
         O4QGVQCO/2hvAOQU6QCbovNdtS454MYji7VLu1YJ54aYrpKLZz188Q1ecRX0BLBZDIaM
         5Vhxa+HxWiOfTNy9JXX7W26LZJ4ZTCLwmW/FXYzWioVCW8oD8Wt3/kouyw5Hwm/Q0S57
         70XmsKkaicL2hHlWi3hpguw2eYd+C3DmDPF/FW+KJFPL/3QKJhWLUjQ5TgpvmOG4wUYC
         b7z2LfPTa/mszPl4G3d53Khs9HukTaxnTVjl/pLP/B28VfB/hWsp0MBlSU2ng0PTrmI/
         waGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ie8zVBkqSt3mxRxNew4V89gQfU1Dg5+Y7b1pz0Qwsgk=;
        b=qeaYjWb0+jhnMhjRWVYkySarslVCXZ1P9TksKfi9ol7CZRG+w0S1Mi4YNxP2jiEHwn
         gjWv5pKFuOPRVjsqAc7nnTQBCJ7to4BUOMWgvMNm9V5nnIzg8r8Ok2vkRXYRlJsHHJaY
         ihnT6RMi5v9Ruu1hc93MY8qaVxgX6zSXRkT3CBy1ea0XqxSmWTXuhUaIFb7pCmkM3H/v
         UHQlqtSaUmm3bBBIJtkgNS66AE3oBAzZCNbSNgXSd4iwNAv29ZkuW1u9EOZdY7qum/LL
         ylbtlt5S+8PU28HmJf4dLnTdtxFvXDrYxMfZGW703NV4TFno6rITfSOEO0boz14lYBzw
         lfbA==
X-Gm-Message-State: AOAM531nKPAbZPHqyRERNfeanhcTCkkzFrSAWLTr2p/ZFm213XKuoaxH
        bZ4qN2w+wLaL5RtOSME46ukwpg==
X-Google-Smtp-Source: ABdhPJyNf03Ac2HOEK7HzwSC0r/Ht5ZW+xnDZkt2mHHpfBcY8kE6V4rhIbQTL+H9dqOAhuXXfYiROw==
X-Received: by 2002:a05:6512:3b09:b0:478:66dd:3081 with SMTP id f9-20020a0565123b0900b0047866dd3081mr656946lfv.107.1653142554809;
        Sat, 21 May 2022 07:15:54 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u24-20020a2e8558000000b0024f3d1daea2sm721653ljj.42.2022.05.21.07.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:15:54 -0700 (PDT)
Message-ID: <6b35e16d-e08d-ebb1-9d3c-7e670e700bdf@linaro.org>
Date:   Sat, 21 May 2022 16:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 1/6] thermal: exynos: Enable core tmu hardware clk flag
 on exynos platform
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20220515064126.1424-1-linux.amoon@gmail.com>
 <20220515064126.1424-2-linux.amoon@gmail.com>
 <6a6ed76a-50fa-2b05-896e-8936d3c3f597@linaro.org>
 <CANAwSgTMwKhn6QDcoOXcSVgUqLGq1W6X4QvcSRHT-JSVfOe0rA@mail.gmail.com>
 <39336391-8882-b2cb-058f-18f59dcc90d3@linaro.org>
 <CANAwSgT0Vmq4D9nRNc9h=xXxjmN_wXjbhwjj4btX+4SkXePkrw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANAwSgT0Vmq4D9nRNc9h=xXxjmN_wXjbhwjj4btX+4SkXePkrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2022 11:50, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Wed, 18 May 2022 at 12:55, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/05/2022 20:42, Anand Moon wrote:
>>> Hi Krzysztof,
>>>
>>> On Sun, 15 May 2022 at 15:22, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 15/05/2022 08:41, Anand Moon wrote:
>>>>> Use clk_prepare_enable api to enable tmu internal hardware clock
>>>>> flag on, use clk_disable_unprepare to disable the clock.
>>>>>
>>>>> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>
>>>> Here as well you ignored my first comment:
>>>> https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#mbfc57b40a7ed043dd4d4890bedb6bad8240058cd
>>>>
>>>> "This is not valid reason to do a change. What is clk_summary does not
>>>> really matter. Your change has negative impact on power consumption as
>>>> the clock stays enabled all the time. This is not what we want... so
>>>> please explain it more - why you need the clock to be enabled all the
>>>> time? What is broken (clk_summary is not broken in this case)?"
>>>>
> 
> This was just to update my knowledge on what is missing in the driver.
> 
>> I don't understand how all this is relevant to the Exynos TMU driver.
>> You paste some COMMON_CLK framework links, but this is just a framework.
>> It has nothing to do with Exynos TMU.
>>
>> Since we are making circles, let's make it clearer. Answer these simple
>> questions:
>> 1. Is Exynos TMU driver operating correctly or not correctly?
> 
> Yes Exynos TMU clk is getting initialized, but not incorrect order.
> within the exynos tmu driver we call
>    exynos_tmu_probe
>         ---> clk_prepare
>    exynos_tmu_initialize
>        ---> clk_enable
> which is seem to work but it does not enable the clk in total.

Correct and this is done on purpose, to not have the clock enabled all
the time.
> 
> But if we call *clk_prepare_enable* in  exynos_tmu_probe we enable the
> clk correctly.

It was enabled correctly. clk_prepare followed by clk_enabled is correct
way.

> 
> *Note:* This current patch is missing the clean-up in
> exynos_tmu_initialize function.
> 
>>
>> 2. If incorrectly, how is the incorrectness visible?
> 
> See before the change in Exynos 5422
> $ sudo cat /sys/kernel/debug/clk/clk_summary | grep tmu
>                          tmu_gpu       0        2        0    66600000
>          0     0  50000         N
>                          tmu          0        6        0    66600000
>       0     0  50000         N
> 
> $ sudo cat /sys/kernel/debug/clk/clk_summary | grep tmu
>                          tmu_gpu       2        2        0    66600000
>          0     0  50000         Y
>                          tmu          6        6        0    66600000
>       0     0  50000         Y
> 
> After the changes, the internal tmu clk internal hardware flag is set to 'Y'
> * hence I mention this in the commit message.*
> 
> Before the patch
> # cat /sys/kernel/debug/clk/tmu/clk_enable_count
> 0
> # cat /sys/kernel/debug/clk/tmu_gpu/clk_enable_count
> 0
> 
> After the patch
> # cat /sys/kernel/debug/clk/tmu/clk_enable_count
> 6
>  # cat /sys/kernel/debug/clk/tmu_gpu/clk_enable_count
> 2

This proves your patch is incorrect, because you enabled clock for times
when it is not needed. Original code looks ok.

> 
>> How can we trigger and see the issue?
> 
> We can trigger or see the issue but enable clk trace feature,
> for example trace clk_enable, clk_prepare clk_enable_complete
> 
> I don't know how to trace clk during clk initialization
> but I will try to find out more about this.
> 
>>
>> 3. If it operates correctly, maybe it is operating in nonoptimal way?
>>
> Few new things we could set in this TMU driver which control the internal timing
> 
> SAMPLING_INTERVAL  - sample interval
> COUNTER_VALUE0      - Timing control of T_EN_TEMP_SEN on/off timing
> COUNTER_VALUE1      - Timing control of CLK_SENSE on/off timing

I don't understand this. Again, where is the non-optimal way?

> 
>> 4. If it is not optimal, then what states are not optimal and when?
> 
> We could drop the unnecessary clk_enable and clk_disable as we don't check
> the return value of the function and it just toggles the clock which
> does not look optimal.

No, you don't understand the clocks. Enabling and disabling the clock is
optimal.

> 
> Since CLK_SENSE internally has a timer to on/off and control the PMU operations.

This could be better, what is this CLK_SENSE and which clocks are affected?

> Look at following functions we could drop this
> exynos_get_temp , exynos_tmu_control and exynos_tmu_set_emulation.

I don't understand this sentence. Why do you want to drop entire
functions? How is exynos_get_temp related to clocks?


Best regards,
Krzysztof
