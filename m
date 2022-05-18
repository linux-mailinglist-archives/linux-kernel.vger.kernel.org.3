Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876E852B363
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiERHZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiERHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:25:31 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C995C5E4B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:25:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e4so913909ljb.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KItcCQHIx5QemKINDxfk5VGuH/Dh8qJcbtAAjaRKmuU=;
        b=PEtUrfFMPbl9KFh1jgTdYLLgJJxKKzGb+X4VhlbC5sVmM0SEofa7zXCysnhfc8pSRt
         wwKkNn4Znp6V3FvihssVUEQoho+76QZN1RVdbX3z0voixdSJk5lP3kcFO2ZuqjNr+2jW
         nm9eDynRipUX0Dwgt7lELjm9UQTrUDLOU7yFwKfIGvYmM8gF5wr5ghWLgUDzjx9ekV86
         Q9q+xmAaO63tEtlagNSqMN59tr39sej7wMSrsHX4JMwlsGYpFK769X/bS15vyMvZ8Q+B
         sxaWe3QU7tJTtmTMhe9G141F8azbZsS64BcXD9JSLPQDpKfLa6ClNrlMbVAKA7U9iIgC
         VQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KItcCQHIx5QemKINDxfk5VGuH/Dh8qJcbtAAjaRKmuU=;
        b=xBGebeY0dMm6amnTLVwS153jvOsm7FBKOKukNGdN4ioW+TcfXThDoEnWiPWxBRQWXx
         tBkUmHijjMp8V5Iq8vanrraXDjkB6YZLpGdbVaiPnfNVG4fiC3Q3L83Fz5IQ8iykjxOk
         zLKF6XoSY4vg4Lquj5p5T+3aZ+QXL6OiDCkzkvIgsZhbIH+5P3KiYb5hw8xvPsXvC1XP
         8AbkZbReHDqfaPOU19vkSRfD44kaVZNDLVrM/d49ks2H5iOkg+kD6ZJrcNKFluQ0nUzu
         QSD2YDteZOmRQ0gsy1rCq73d4xIi0dz/vPC6KEs2Rg9r4RxD0Dc1ApghZv0EHEu6Z24p
         Hgtw==
X-Gm-Message-State: AOAM533p34wSBFkmOHP/ArQTriMHt94+O3Kb2QHprEpk723NfUkG8idx
        j3UehZJbNzrLpETET03KEpDAqA==
X-Google-Smtp-Source: ABdhPJxcZB4aU8fDJJf64tBX2qfP1CQ6PEbKMGp7ljmFnuLPO2yyLNKa1IkXzT0rO0bTx4pZeP1oew==
X-Received: by 2002:a2e:8e82:0:b0:250:80ec:420 with SMTP id z2-20020a2e8e82000000b0025080ec0420mr16098633ljk.26.1652858728845;
        Wed, 18 May 2022 00:25:28 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c6-20020a197606000000b00477b11144e9sm27436lff.66.2022.05.18.00.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:25:28 -0700 (PDT)
Message-ID: <39336391-8882-b2cb-058f-18f59dcc90d3@linaro.org>
Date:   Wed, 18 May 2022 09:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 1/6] thermal: exynos: Enable core tmu hardware clk flag
 on exynos platform
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANAwSgTMwKhn6QDcoOXcSVgUqLGq1W6X4QvcSRHT-JSVfOe0rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 20:42, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Sun, 15 May 2022 at 15:22, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 15/05/2022 08:41, Anand Moon wrote:
>>> Use clk_prepare_enable api to enable tmu internal hardware clock
>>> flag on, use clk_disable_unprepare to disable the clock.
>>>
>>> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>
>> Here as well you ignored my first comment:
>> https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#mbfc57b40a7ed043dd4d4890bedb6bad8240058cd
>>
>> "This is not valid reason to do a change. What is clk_summary does not
>> really matter. Your change has negative impact on power consumption as
>> the clock stays enabled all the time. This is not what we want... so
>> please explain it more - why you need the clock to be enabled all the
>> time? What is broken (clk_summary is not broken in this case)?"
>>
> Ok, I fall short to understand the clock framework.
> 
>> This was not addressed, you just resent same code...
>>
> Thanks for the review comment.
> 
> Here is the Exynos4412 user manual I am referring to get a better
> understanding of TMU drivers
> 
> [0] https://chasinglulu.github.io/downloads/SEC_Exynos4412_Users%20Manual_Ver.1.00.00.pdf
> 
> Exynos Thermal is controlled by CLK_SENSE field is toggled on/off by the TMU
> for rising and falling temperatures which control the interrupt.
> 
> TMU monitors temperature variation in a chip by measuring on-chip temperature
> and generates an interrupt to CPU when the temperature exceeds or goes
> below pre-defined
> threshold. Instead of using an interrupt generation scheme, CPU can
> obtain on-chip
> temperature information by reading the related register field, that
> is, by using a polling scheme.
> 
> tmu clk control the CPU freq with various power management like DVFS and MFC
> so this clk needs to be *enabled on*,
> If we use clk_prepare_enable API  we enable the clk and the clk counters,
> 
> I check the call trace of the *clk_prepare_enable*
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/clk.h?h=v5.18-rc7#n945
> it first calls *clk_prepare* and then *clk_enable* functions to
> enable the clock and then the hardware flag gets enabled for the clock
> 
> I also check the call trace of the *clk_prepare* below
> [2} https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk.c?h=v5.18-rc7#n943
> it does not enable the clk explicitly but prepares the clock to be used.
> 
> "clk_prepare can be used instead of clk_enable to ungate a clk if the
> operation may sleep.  One example is a clk which is accessed over I2c.  In
> the complex case a clk ungate operation may require a fast and a slow part.
> It is this reason that clk_prepare and clk_enable are not mutually
> exclusive.  In fact clk_prepare must be called before clk_enable.
> Returns 0 on success, -EERROR otherwise."
> 
> What it means is we still need to call *clk_enable* to enable clk in the drivers
> and *clk_disable* to disable within the driver.
> 
> In exynos tmu driver uses many clk_enable and clk_disable
> to toggle the clock which we can avoid if we used the switch to used
> *clk_prepare_enable* function in the probe function.
> 
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/samsung/exynos_tmu.c?h=v5.18-rc7#n259
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/samsung/exynos_tmu.c?h=v5.18-rc7#n350
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/samsung/exynos_tmu.c?h=v5.18-rc7#n653
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/samsung/exynos_tmu.c?h=v5.18-rc7#n731
> 
> Locally I remove these function calls of clk_enable/ clk_disable
> function calls in the driver
> with these changes, stress-tested did not find any lockup.

I don't understand how all this is relevant to the Exynos TMU driver.
You paste some COMMON_CLK framework links, but this is just a framework.
It has nothing to do with Exynos TMU.

Since we are making circles, let's make it clearer. Answer these simple
questions:
1. Is Exynos TMU driver operating correctly or not correctly?

2. If incorrectly, how is the incorrectness visible? How can we trigger
and see the issue?

3. If it operates correctly, maybe it is operating in nonoptimal way?

4. If it is not optimal, then what states are not optimal and when?

In any case you commit fails to explain WHY you are doing it. I
explained you this over the years several times and after these several
times you still do not like to answer that simple question. This is
pointless. You receive feedback and keep it ignored...

Always, always please explain why this change is needed.

Best regards,
Krzysztof
