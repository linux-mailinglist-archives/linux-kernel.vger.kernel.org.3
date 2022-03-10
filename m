Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A294D44E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbiCJKoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241381AbiCJKn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:43:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EAFA8EDB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:42:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so7229131wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QVMbWuHkkDuZtNM8luekJjrN/fjg/FyiWebrna5roZw=;
        b=tIzoauSJ+w5agVaEFio3bpeTlHSNKY7X4l83Kr8LtMdX7pcS3I+jVWWKNLFprL+e3p
         yMRJADedzZG7//YHPb+2zWxhWZ+UaEz7ubkaPixFQZhL4RXi6Oq+9/bQGTSEMWDeKaPq
         sXaYEm3chI4nvNcNVIEOYeOIIMhumUmkyyCX/h4YUmCiQvpecMQTmILjGYlPj8DmVcn4
         XoeSe0geQ5i32wtQn+Ywn4REMUWuwyqFp6XuK/Bn0bkzuZUQlenWReKxabxrAKIRMzS1
         If+tpvYP0RWQVIbRllPeA+KJ8iVWm/KuKZ3IPewdqJxOmzLG0eK+HO+Bndo5SAjFLSJ6
         wWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QVMbWuHkkDuZtNM8luekJjrN/fjg/FyiWebrna5roZw=;
        b=3AlhUB8xE9se/OzvJU9Al/Tsdzy7YPYchREuUZgdSDHYFr4wsBccCo1i/CgGvZMm4I
         vYRyq0kzLi/kEUX3OWMMqp5wTzJiUXaA7VoJzXts/iMmSAqEjfchlln0DY5dAPunQH1K
         Wfa4sWZZHCSx/FmFYpA67YwvE7xVSI6VYpLGrVwKtG1ta3/rMbe7jD8A/ntoKsalOoC/
         YWehV+S6yCs359OKmeivUC9ZTJky5N7Kp/VI21XND/f65tZR2b+BVHrcLCSGgSeBIizD
         2PhBHzp4prxlQgNQzjtexZplbebsCtZvm8MLcKOx687vDQ2HIXa1L4bcTQ8h4VDU0z/r
         CClA==
X-Gm-Message-State: AOAM532bj90TDAd2Izxr08g6In5IWHoW7l4jwhmtPDW7GadmM+FNtXTe
        YzXAgOTBmpVQhjlYL0tEU3Kaj1ceuQ75jg==
X-Google-Smtp-Source: ABdhPJyY6drV+z0QAzNTPASiA7ycLBG5wzjkdEV9U3cnvDm+EIQxess0YzG0KPe/LtY8rbMKgGefdQ==
X-Received: by 2002:adf:fa41:0:b0:1f0:2118:4832 with SMTP id y1-20020adffa41000000b001f021184832mr3016372wrr.571.1646908963682;
        Thu, 10 Mar 2022 02:42:43 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id g2-20020a5d46c2000000b001f079ba0158sm3751927wrs.60.2022.03.10.02.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 02:42:43 -0800 (PST)
Message-ID: <5e13c1ba-0bf5-e360-c350-e7a1a1402350@linaro.org>
Date:   Thu, 10 Mar 2022 10:42:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        alsa-devel <alsa-devel@alsa-project.org>
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <c5ea7235-8642-6a89-f4ce-bd0861b6e4aa@linaro.org>
 <CA+V-a8tkhERx+8zDae5aWkNQ9Oxd1AamRL=i4TDC2X8RGgAo0w@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CA+V-a8tkhERx+8zDae5aWkNQ9Oxd1AamRL=i4TDC2X8RGgAo0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2022 10:23, Lad, Prabhakar wrote:
> On Thu, Mar 10, 2022 at 10:16 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>>
>> On 24/12/2021 16:13, Lad Prabhakar wrote:
>>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
>>> allocation of IRQ resources in DT core code, this causes an issue
>>
>> Are you saying that we should not be using platform_get_resource(pdev,
>> IORESOURCE_IRQ, ...) on drivers that support DT?
>>
>>> when using hierarchical interrupt domains using "interrupts" property
>>> in the node as this bypasses the hierarchical setup and messes up the
>>> irq chaining.
>>
>> Should this not be fixed in the DT core itself?
>>
> Yes the plan is to fix in the DT core itself (refer [0]).
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
>>>
>>> In preparation for removal of static setup of IRQ resource from DT core
>>> code use platform_get_irq().
>>
>> I would prefer this patch to be part of the series that removes IRQ
>> resource handling from DT core.
>>
> Since there are too many users (which are in different subsystems)
> getting this all in single series would be a pain. As a result it is
> split up into individual subsystems.
Am happy for this to be included in that series,
TBH, this patch make more sense along with that series than by itself.

This would also give better insight of what exactly is changing in 
platform_get_resource() w.r.t handling IRQ resources.


--srini

> 
> Cheers,
> Prabhakar
> 
>>
>> --srini
>>
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>> Hi,
>>>
>>> Dropping usage of platform_get_resource() was agreed based on
>>> the discussion [0].
>>>
>>> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
>>> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>>>
>>> Cheers,
>>> Prabhakar
>>> ---
>>>    drivers/slimbus/qcom-ngd-ctrl.c | 10 ++++------
>>>    1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
>>> index 7040293c2ee8..0f29a08b4c09 100644
>>> --- a/drivers/slimbus/qcom-ngd-ctrl.c
>>> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
>>> @@ -1526,13 +1526,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>>>        if (IS_ERR(ctrl->base))
>>>                return PTR_ERR(ctrl->base);
>>>
>>> -     res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>> -     if (!res) {
>>> -             dev_err(&pdev->dev, "no slimbus IRQ resource\n");
>>> -             return -ENODEV;
>>> -     }
>>> +     ret = platform_get_irq(pdev, 0);
>>> +     if (ret < 0)
>>> +             return ret;
>>>
>>> -     ret = devm_request_irq(dev, res->start, qcom_slim_ngd_interrupt,
>>> +     ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
>>>                               IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
>>>        if (ret) {
>>>                dev_err(&pdev->dev, "request IRQ failed\n");
