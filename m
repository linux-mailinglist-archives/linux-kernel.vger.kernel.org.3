Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798BB4DBA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiCPV6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiCPV6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:58:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98805F32;
        Wed, 16 Mar 2022 14:57:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b15so4394903edn.4;
        Wed, 16 Mar 2022 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=1OAQbtmaZdNIyjRxgjPGasOAl8hVZ0IRLH/v9tSHVWA=;
        b=NUOCcaJUn/I/fN7B3Cuk8U/+RsgLiMmTSQh4E8lmG3S4cfIv1nC47OLhzNMfhSzuWf
         A9snOz42mn84Pug9lpUih1X0Ljza3SyshxJYNn0wyufNMnLKKmS5/JAIK7EX26kcsaaz
         8Ykcxb1DokTjeJASANAxb2OJfjPDuzf+dPybtmnIJfKd4Yyt/NkqPNuZTweM3OEe/9dE
         B8ZVg51qwOyY3pi6TxjzoqMc/q2PfuuA5u1TrjZJFVjaRQ+mFWu0yKVHwdzYrU4fX/Ud
         E/10f+eHxipmBxvHTncyZbZWgxXHHcTvfOsZuyO9565wCKK+O6CpGRLw6YmyRolgtOc5
         pdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=1OAQbtmaZdNIyjRxgjPGasOAl8hVZ0IRLH/v9tSHVWA=;
        b=lXm6Z+PwSoXXecwWt50c6fDUH5KgHG27sC+Ojfi6BkeTkzyzDrVr6rRrZSFOP4xXk0
         NzGw8t4+wSGCORYMDdqMsBIyxPYOAMKEmF3jn1WW/2UcHAqmd45Nx5xu4eyu/8KPkVxQ
         ceBXHueLnJxP/IBCDV18cF+Jq+jeQWhnHDsloiXJtuSHZAENPA+QO6Id7aGtEGOEZAmg
         cctoQDoYe0clX//RKYkfnMH6CvilkrfniyN/gpy76dgptQ1yzU1/QSsgUbfe+7Eskmmn
         Rvy5fLspMyfoyEen5/ds8CRxy3iCN5gDkwcZR/qDK2V9oM2hQcI0Hwf/IjT2Qn8H0cTO
         x6qg==
X-Gm-Message-State: AOAM530CdP50/9PraScavBB7RNf8bXA2M/9iOT/G4LeZuFqeogR72yd9
        zek0U9SeQyJmnPKKc4HCpk4=
X-Google-Smtp-Source: ABdhPJyoD5xW6O6c12V8Kofr8zxRUHnvPt0lzmQxJ3tGvooctXFnz0ef7+TSCn0vsqH48779LnBuPw==
X-Received: by 2002:aa7:d645:0:b0:418:ebf1:a1bb with SMTP id v5-20020aa7d645000000b00418ebf1a1bbmr1375060edr.361.1647467823133;
        Wed, 16 Mar 2022 14:57:03 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b866:cc00:e490:2de6:a89f:9b66? (dynamic-2a01-0c23-b866-cc00-e490-2de6-a89f-9b66.c23.pool.telefonica.de. [2a01:c23:b866:cc00:e490:2de6:a89f:9b66])
        by smtp.googlemail.com with ESMTPSA id s7-20020a170906778700b006df7e0e140bsm1240570ejm.140.2022.03.16.14.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 14:57:02 -0700 (PDT)
Message-ID: <3ef33014-be77-3a97-d49e-84b62d09ba00@gmail.com>
Date:   Wed, 16 Mar 2022 22:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
References: <20220310125636.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
 <50d4b87c-003f-818a-c8ba-a3bac9c0f171@intel.com>
 <CA+ASDXO8-wmEDPxUrO6j9wBvCMzTZMpTyH7adSga8dYLNq5ehg@mail.gmail.com>
 <CAPDyKFoQfr3W45vWY4SnTeBG7=z3J749=WBGNtEgujvXAqAn0Q@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] mmc: core: Set HS clock speed before sending HS CMD13
In-Reply-To: <CAPDyKFoQfr3W45vWY4SnTeBG7=z3J749=WBGNtEgujvXAqAn0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2022 13:27, Ulf Hansson wrote:
> + Heiner
> 
> On Tue, 15 Mar 2022 at 00:11, Brian Norris <briannorris@chromium.org> wrote:
>>
>> On Mon, Mar 14, 2022 at 6:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 10.3.2022 22.56, Brian Norris wrote:
>>>> Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
>>>> hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
>>>> some eMMC don't respond to SEND_STATUS commands very reliably if they're
>>>> still running at a low initial frequency. As mentioned in that commit,
>>>> JESD84-B51 P49 suggests a sequence in which the host:
>>>> 1. sets HS_TIMING
>>>> 2. bumps the clock ("<= 52 MHz")
>>>> 3. sends further commands
>>>>
>>>> It doesn't exactly require that we don't use a lower-than-52MHz
>>>> frequency, but in practice, these eMMC don't like it.
>>>>
>>>> Anyway, the aforementioned commit got that right for HS400ES, but the
>>>> refactoring in 53e60650f74e ("mmc: core: Allow CMD13 polling when
>>>> switching to HS mode for mmc") messed that back up again, by reordering
>>>> step 2 after step 3.
>>>
>>> That description might not be accurate.
>>
>> I've been struggling to track where things were working, where things
>> were broken, and what/why Shawn's original fix was, precisely. So you
>> may be correct in many ways :) Thanks for looking.
>>
>>> It looks like 4f25580fb84d did not have the intended effect because
>>> CMD13 was already being sent by mmc_select_hs(), still before increasing
>>> the frequency.  53e60650f74e just kept that behaviour.
>>
>> You may be partially right, or fully right. But anyway, I think I have
>> some additional explanation, now that you've pointed that out: that
>> behavior changed a bit in this commit:
>>
>> 08573eaf1a70 mmc: mmc: do not use CMD13 to get status after speed mode switch
>>
>> While that patch was merged in July 2016 and Shawn submitted his v1
>> fix in September, there's a very good chance that a lot of his work
>> was actually done via backports, and even if not, he may not have been
>> testing precisely the latest -next kernel when submitting. So his fix
>> may have worked out for _some_ near-upstream kernel he was testing in
>> 2016, you may be correct that it didn't really work in the state it
>> was committed to git history.
>>
>> This may also further explain why my attempts at bisection were rather
>> fruitless (notwithstanding the difficulties in getting RK3399 running
>> on that old of a kernel).
>>
>> Anyway, I'll see if I can improve the messaging if/when a v2 comes around.
>>
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>> ...
>>>> @@ -1487,6 +1492,12 @@ static int mmc_select_hs200(struct mmc_card *card)
>>>>               old_timing = host->ios.timing;
>>>>               mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>>>>
>>>> +             /*
>>>> +              * Bump to HS frequency. Some cards don't handle SEND_STATUS
>>>> +              * reliably at the initial frequency.
>>>> +              */
>>>> +             mmc_set_clock(host, card->ext_csd.hs_max_dtr);
>>>
>>> Is card->ext_csd.hs_max_dtr better than card->ext_csd.hs200_max_dtr here?
>>
>> I believe either worked in practice. I ended up choosing hs_max_dtr
>> because it's lower and presumably safer. But frankly, I don't know
>> what the Right thing to do is here, since the spec just talks about
>> "<=", and yet f_init (which is also "<=") does not work. I think it
>> might be like Ulf was guessing way back in the first place [1], and
>> the key is that there is *some* increase (i.e., not using f_init).
>>
>> So assuming either works, would you prefer hs200_max_dtr here, since
>> that does seem like the appropriate final rate?
> 
> I think that makes most sense, as we are switching to that rate anyway
> just a few cycles later in mmc_select_timing(), when it calls
> mmc_set_bus_speed().
> 
> That said, I have recently queued a patch that improves the
> speed-mode-selection-fallback, when switching to HS200 mode fails [2].
> We need to make sure this part still works as expected. I have looped
> in Heiner who has been in the loop around this change, hopefully he
> can help with further testing or so. Maybe $subject patch (or a new
> version of it) can even make HS200 to work on Heiner's platform!?
> 
>>
>> Brian
>>
>> [1] https://lore.kernel.org/all/CAPDyKFrNp=Y3BhVE_kxtggv7Qc6m=2kef2U8Dn2Bb3ANHPYV-Q@mail.gmail.com/
>> Re: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when
>> selecting hs400es
> 
> Kind regards
> Uffe
> 
> [2]
> https://patchwork.kernel.org/project/linux-mmc/patch/20220303164522.129583-1-ulf.hansson@linaro.org/

In my specific case this patch makes no difference. My test system is a
dirt-cheap Amlogic SoC based Android TV box. My best guess is that maybe due
to chip shortage the vendor omitted some regulator, making the eMMC card
refuse the switch to HS200.
Therefore my test result doesn't speak against the proposed patch.
