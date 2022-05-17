Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBDD529E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbiEQJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbiEQJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:49:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BDD75
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:49:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so1043806wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DpqDpoQ86mGSjzackjYkVGZOrE1fChU7d/OHtDBy5EU=;
        b=JBJ4uw2WKDeIWvcfPr6VMC3QifoJJHZdiRve30tbTssMBsrWPXJjyCPE4OLjvTLhIl
         NfpC0Yr5uC7W4OoIJi6uPcYxeykP6LQDFomc0Mc97wUPX3Lx1L+yJ96wYwF9BxKoz11P
         3qYfDeLNaTA1z4tLD1DIVmiENnxUZZuBhsZQ+OXuEUmXDSU2jX/nsQkK/D+JiHsKYX6u
         r+3BlZTdD1i6WuQuHPAQI0DigRani3hSo/X4/VSuS2dQKxXtDsvJIBQ8l6kUuzZUTIl3
         lOUwkQYk6J67knsyfXbi+n+CPdm1j0BQUfyQY+99K025CyBM+oOqcAe2T2yIjyMj3jPI
         gu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DpqDpoQ86mGSjzackjYkVGZOrE1fChU7d/OHtDBy5EU=;
        b=3Jl/ROYELWt9MSpwzdGBkbxCDFFb9vfHAbo+61pBM75e091OcXkSiOSv89++62g5sC
         fQtQWFe9kJQhRb5FpjVq9x9njIDXldZUWwT/Y+Pu5V8I+kKIxjQIY1x0EL6eN1UJiBH+
         f7faZjZlETzhdCyY0uiCSUlI64ivtkRDqiL4wzOZZBj8s7/A4zD7VdZG7Z5Pe/AyGuyw
         ZSThu6c0FF46B6ZrvQYyrvCp4yX217kkY07CwIkbvLUzcjGoaUIWi9633KzllfHpgyRS
         bpbY+dFkrmR/f3I3X6Na1y56kMRkWFxCReo38H9fuKwX+1pL/mDXaHbTjHHnL4Fu0acW
         DfgQ==
X-Gm-Message-State: AOAM530G6gCHLYqopGXyBDBzodrFlpBCrWLLORs1AGjf8PijSzdROxva
        qsL4owWNVXVBh1cl6+B/p4A=
X-Google-Smtp-Source: ABdhPJxc6NR92FTeptvCA4+hO3jyue1+FXlzsbJf5GQrUyJsTPK+G1Wfwa9RezLJurVEM4iHWeVcLA==
X-Received: by 2002:a05:600c:224a:b0:394:8ec:3d37 with SMTP id a10-20020a05600c224a00b0039408ec3d37mr20467646wmm.19.1652780973999;
        Tue, 17 May 2022 02:49:33 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003942a244f49sm1370233wmj.34.2022.05.17.02.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:49:33 -0700 (PDT)
Message-ID: <bb1aea80-a926-8545-646e-bb526bc5cb84@gmail.com>
Date:   Tue, 17 May 2022 11:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 3/5] soc: mediatek: pwrap: Move and check return value
 of platform_get_irq()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
 <20220516124659.69484-4-angelogioacchino.delregno@collabora.com>
 <ad736290-2e01-f867-d2ec-867a4385005a@gmail.com>
 <03ac9b18-cb5d-5ff6-d220-f2f4062cea7e@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <03ac9b18-cb5d-5ff6-d220-f2f4062cea7e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2022 11:34, AngeloGioacchino Del Regno wrote:
> Il 17/05/22 11:18, Matthias Brugger ha scritto:
>>
>>
>> On 16/05/2022 14:46, AngeloGioacchino Del Regno wrote:
>>> Move the call to platform_get_irq() earlier in the probe function
>>> and check for its return value: if no interrupt is specified, it
>>> wouldn't make sense to try to call devm_request_irq() so, in that
>>> case, we can simply return early.
>>>
>>> Moving the platform_get_irq() call also makes it possible to use
>>> one less goto, as clocks aren't required at that stage.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c 
>>> b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> index 852514366f1f..332cbcabc299 100644
>>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> @@ -2204,6 +2204,10 @@ static int pwrap_probe(struct platform_device *pdev)
>>>       if (!wrp)
>>>           return -ENOMEM;
>>> +    irq = platform_get_irq(pdev, 0);
>>> +    if (irq < 0)
>>> +        return irq;
>>> +
>>>       platform_set_drvdata(pdev, wrp);
>>>       wrp->master = of_device_get_match_data(&pdev->dev);
>>> @@ -2316,7 +2320,6 @@ static int pwrap_probe(struct platform_device *pdev)
>>>       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
>>>           pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>>> -    irq = platform_get_irq(pdev, 0);
>>
>> For better readability of the code I'd prefer to keep platform_get_irq next to 
>> devm_request_irq. I understand that you did this change so that you don't have 
>> to code
>> if (irq < 0) {
>>      ret = irq;
>>      goto err_out2;
>> }
>>
>> Or do I miss something?
>>
> 
> That's for the sake of reducing gotos in the code... but there's a bigger
> picture that I haven't explained in this commit and that will come later
> because I currently don't have the necessary time to perform a "decent"
> testing.
> 
> As I was explaining - the bigger pictures implies adding a new function for
> clock teardown, that we will add as a devm action:
> 
> devm_add_action_or_reset(&pdev->dev, pwrap_clk_disable_unprepare, wrp)
> 
> ...so that we will be able to remove *all* gotos from the probe function.
> 
> Sounds good?
> 

Sounds good, but that means we could get rid of the goto as well. Anyway I 
prefer to have platform_get_irq next to devm_request_irq. If we can get rid of 
the goto in the future, great.

Regards,
Matthias
