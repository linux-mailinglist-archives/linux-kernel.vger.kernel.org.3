Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC052FD35
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiEUOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiEUOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:20:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1562CD2
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:20:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g16so12424801lja.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xrVvgGpFwC0qfTU8CkXMR2gz4gvqWYcjZfKq5E02l7I=;
        b=eIz2Zhyd7jFETbpfLY2ODuuP0mBnfCi4/JRwZmkwhGV8pAooU3w7uazeCICpmUBuCq
         Sk337CsQwzwG/8tPIY2OWFXjCh53+TBmWNdblYb7sMppqOStOhU99LVr7P6Gu8Bx855N
         wNBp/A9wiXOexdfSLN2KY84Jy0zm5SAOjSSrbMEvXgfKjdE+PhCrPLLcGD+ulbDUZQGK
         hg4jlt4BmrREyepjX7y5DcKT2kZKUkhQSHhiHVhA/hBPIDkpyKR14jFdiJBK8elV7nOL
         0uPeY+PJQpIc8s8F8fKDhVvfYEnoMrR1igEwThKq2kkbRsaaoZK3G3lVDSFmLWKKm1uP
         NM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xrVvgGpFwC0qfTU8CkXMR2gz4gvqWYcjZfKq5E02l7I=;
        b=AsmzvESRQUb7La564YvcuWBLibIBVF5a/ccZSPH+0Ge13Mys8PkGb+ODAxaJUvaUu7
         BrFxbAX5/IHn8VJSYWtdLzDRcXoxj+X6+E0acUGYbyHO6gVwTdskmr3E5L1GFY8OL97T
         4T+QO4WNfn2hoYupOIEjr2VnsFHV3mH0mzDQ2t0CQVD7yVEF437S0FLJJX8CN9YGS1NZ
         PnnrjK6UAfYINWBH8hn01NpjqZZ0sUlYZyJQTok9xTKZE+ZYR4MgjRlxoJVmCK+SB8xP
         p/2rKb4SKzC07f8GS8HOBSXUlWgxhnTVulkkQRQ29NJplEjo4XWTZZJUxRvrfBDMlj/B
         oZFw==
X-Gm-Message-State: AOAM533Wwbbo3rNhegQvubznfp8xKcACE+50GPMo5KBaiwKXSgur6If9
        gNqetfqNyRUWG4uPh4SjOyht1Nd6LNztYk9D
X-Google-Smtp-Source: ABdhPJwwnngd/0Mx/PI34JuKwmKYxubLU9MWgXgvRgl9EQbWdC5uXxSWXIe1139D4SRIrwVAX0KfsQ==
X-Received: by 2002:a2e:b1c7:0:b0:253:dfbf:56cf with SMTP id e7-20020a2eb1c7000000b00253dfbf56cfmr3680430lja.513.1653142824967;
        Sat, 21 May 2022 07:20:24 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n6-20020a2e8786000000b0024f3d1daee3sm115913lji.107.2022.05.21.07.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:20:24 -0700 (PDT)
Message-ID: <023e6b0c-26a8-1563-1861-9a5cfe715c1f@linaro.org>
Date:   Sat, 21 May 2022 16:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 2/6] thermal: exynos: Reorder the gpu clock
 initialization for exynos5420 SoC
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
 <20220515064126.1424-3-linux.amoon@gmail.com>
 <68969550-e18b-3c27-d449-1478b314e129@linaro.org>
 <CANAwSgRBpm9gybfUWZbu3-eXLTYkpTZ=s3fmhpNyQcuj7+xdOA@mail.gmail.com>
 <a197ed7f-6115-4407-6931-f37b719587be@linaro.org>
 <CANAwSgRLFr=3GGQ6AZWnzoL9knJrWCY3ONdozd_pbqhFwgpHvg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANAwSgRLFr=3GGQ6AZWnzoL9knJrWCY3ONdozd_pbqhFwgpHvg@mail.gmail.com>
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

On 21/05/2022 11:51, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Wed, 18 May 2022 at 12:58, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/05/2022 20:43, Anand Moon wrote:
>>> Hi Krzysztof,
>>>
>>> On Sun, 15 May 2022 at 15:11, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 15/05/2022 08:41, Anand Moon wrote:
>>>>> Reorder the tmu_gpu clock initialization for exynos5422 SoC.
>>>>
>>>> Why?
>>> It just code reorder
>>
>> I know what it is. I asked why. The answer in English to question "Why"
>> is starting with "Because".
>>
>> You repeated again the argument what are you doing to my question "Why
>> are you doing it".
>>
> tmu_triminfo_apbif is not a core driver to all the Exynos SOC board
> it is only used by the Exynos542x SOC family
> 
> If we look into the original code its place in between
> the devm_clk_get(data->clk) and clk_prepare(data->clk)
> after this change, the code is in the correct order of initialization
> of the clock.

What was wrong with original order? You still did not explain it.

> 
>> It was the same before, many, many times. It's a waste of reviewers
>> time, because you receive a review and you do not implement the feedback.
>>
>>>>
>>>>>
>>>>> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>> ---
>>>>> v1: split the changes and improve the commit messages
>>>>> ---
>>>>>  drivers/thermal/samsung/exynos_tmu.c | 43 ++++++++++++++--------------
>>>>>  1 file changed, 21 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>>>>> index 75b3afadb5be..1ef90dc52c08 100644
>>>>> --- a/drivers/thermal/samsung/exynos_tmu.c
>>>>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>>>>> @@ -1044,42 +1044,41 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>>>>>               dev_err(&pdev->dev, "Failed to get clock\n");
>>>>>               ret = PTR_ERR(data->clk);
>>>>>               goto err_sensor;
>>>>> -     }
>>>>> -
>>>>> -     data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
>>>>> -     if (IS_ERR(data->clk_sec)) {
>>>>> -             if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
>>>>> -                     dev_err(&pdev->dev, "Failed to get triminfo clock\n");
>>>>> -                     ret = PTR_ERR(data->clk_sec);
>>>>> -                     goto err_sensor;
>>>>> -             }
>>>>>       } else {
>>>>> -             ret = clk_prepare_enable(data->clk_sec);
>>>>> +             ret = clk_prepare_enable(data->clk);
>>>>
>>>> This looks a bit odd. The clock was before taken unconditionally, not
>>>> within "else" branch...
>>>
>>> The whole *clk_sec*  ie tmu_triminfo_apbif clock enable is being moved
>>> down to the switch case.
>>> tmu_triminfo_apbif  clock is not used by Exynos4412 and Exynos5433 and
>>> Exynos7 SoC.
>>
>> This is not the answer. Why are you preparing data->clk within else{}
>> branch?
>>
> After cleanly applying the patches I see the below changes.
> if you want me to remove the else part below and keep
> the original code I am ok.
> 
>         data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
>         if (IS_ERR(data->clk)) {
>                 dev_err(&pdev->dev, "Failed to get clock\n");
>                 ret = PTR_ERR(data->clk);
>                 goto err_sensor;
>         } else {
>                 ret = clk_prepare_enable(data->clk);

Which is wrong and does not make any sense. This is third question - why
the main clock is prepared within 'else' branch?

Best regards,
Krzysztof
