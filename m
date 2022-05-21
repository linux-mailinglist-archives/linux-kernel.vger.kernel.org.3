Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547A952FD28
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiEUOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348575AbiEUOLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:11:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243BA5B8BE
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:11:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r3so5531029ljd.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RYQl+aSSz5PsYbdsuyy+v7rTecA/vZhumWdjuVfDKJU=;
        b=F3KMUI0Hix+/TfIYMbxg1Ypge2zPmys0v3YycP7qikAxm1HoOVXiozuLobosqJ+uvL
         flKkM208eQQrUACVO5UKBlg+R73EVUsLqepPpb5oMayWIvfEbw9isE7r+k222jAxiixf
         XPipudb1nlRrxxtMGMg0nurlX/mmgE0w7BKfPbvRPnOZ2XFJqrXJ2Ab8DdEhKS5EfuzT
         8qBnjdhHnRUNAaj0Dnbk/5NcdkJIImeHEMuPRdziQf1kikN0Y6w5tdN1jjYmlHl8UP87
         vv9Smewt3cX9xWNTheSPcjqhHdB9F1OzniM7BBMs0HsB1MxghuAu6ua7iYY9NUM1E7Eh
         yiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RYQl+aSSz5PsYbdsuyy+v7rTecA/vZhumWdjuVfDKJU=;
        b=IIP2fPBi+rVNjDcnGdTPZ2/omNywe44vrtHkZlEi8B6ro20bDTNlXuAk//f/3HeISo
         Xz3lyRj1rF/AbzBgsT5mnnYYVLQxxIQ7RlDR+xUEo2DsHP1eUlm6ci9sXrrbyYaS/8eX
         OUtol1FFR8LKYQ3OccOJ9UbPb3Nc5Gae4TP+parJnG88UEV8KYfG3+nhxg4qwpoH6mt8
         5bp+Txl8m7Rw0aAWG+mlsMTDj1pNlAIi9Z9sdIB9GLLFgh7qN3YF3QjzGqvLqLmRSf/i
         1G+BgKksyh1/5T1MbBcmrjfAwDcqxwjr2SAthe5VV8cPWu0Dl3Ozs6f3EMDgYC9LYvQ0
         tfrw==
X-Gm-Message-State: AOAM532/icTMJ7nnzphoCR7rhDIaFpp11bNbs/4OdYNu0c+Ky8qLG4Yd
        QimGJ5xXkCv8GPSdIjMFESLIrg==
X-Google-Smtp-Source: ABdhPJzPIY5bRKl/lSFeIJShNcSK8ZwQEDiGbi1evoB0c4BWO3BIv09buuA6GVolzs36yKpWhvoiJQ==
X-Received: by 2002:a2e:84c8:0:b0:24b:50bb:de7d with SMTP id q8-20020a2e84c8000000b0024b50bbde7dmr7876086ljh.40.1653142299331;
        Sat, 21 May 2022 07:11:39 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e7-20020a2e9847000000b0024f3d1daeacsm722958ljj.52.2022.05.21.07.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:11:38 -0700 (PDT)
Message-ID: <54c7cc5e-8bf5-b0b6-017b-32063c3a9652@linaro.org>
Date:   Sat, 21 May 2022 16:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 6/6] thermal: exynos: Add runtime power management for
 tmu
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
 <20220515064126.1424-7-linux.amoon@gmail.com>
 <79b727f8-0631-5a96-fbc6-6e5d637bab7d@linaro.org>
 <CANAwSgSY=4zOLjw22GN+a7cc5j=myWWkD7gEQ4_3sgEaTS74Rw@mail.gmail.com>
 <018b97c2-efab-699d-653d-c220a98f5ec3@linaro.org>
 <CANAwSgQe9uveBMgrt3VNUTmFodW3P0Pxhc28KfB8MyEogOtOjQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANAwSgQe9uveBMgrt3VNUTmFodW3P0Pxhc28KfB8MyEogOtOjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2022 11:52, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Wed, 18 May 2022 at 12:49, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/05/2022 20:45, Anand Moon wrote:
>>> Hi Krzysztof,
>>>
>>> On Sun, 15 May 2022 at 15:18, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 15/05/2022 08:41, Anand Moon wrote:
>>>>> Add runtime power management for exynos thermal driver.
>>>>
>>>> First of all - why? Second, I do not see it being added. Where are the
>>>> runtime callbacks?
>>>>
>>>
>>> To control runtime control PMU, did I miss something?
>>
>> Controlling runtime PM by itself is not a goal. What does it change if
>> it is enabled?
>>
> It means we could have efficient power management for this driver.
> as per my understanding, it controls runtime sleep and improves power efficiency

How? I asked - what is being changed after enabling PM - and you
answered without any specifics. Where exactly is the power saving?
Please be specific, very specific.

> 
>>> I looked into imx thermal driver # drivers/thermal/imx_thermal.c
>>> to enable run-time power management for exynos driver.
>>
>> So you have runtime PM enabled and then what happens? Where is the power
>> saving? Since you did not implement the callbacks, all this should be
>> explained in commit msg.
>>
> Ok, As per the original code, it just registers the SIMPLE_DEV_PM_OPS
> with .pm = &exynos_tmu_pm

And does nothing else, right? No benefits?

> So I have made sure that suspend resume feature works correctly
>  with these changes on SBC Odroid U3 and XU4.

How is suspend/resume related to runtime PM? Are you talking about
system suspend? What do you mean now?

> 
> I will try to look into setting RUNTIME_PM_OPS
> or use UNIVERSAL_DEV_PM_OPS instead of SIMPLE_DEV_PM_OPS
> any thought on this?

Why looking at them? You avoid giving any specific answer, so we are
repeating the same and the same. Just to be sure - maybe I don't see the
obvious stuff, so please explain also this obvious things.

Please come with specifics, because otherwise I see it as a waste of our
time.

Best regards,
Krzysztof
