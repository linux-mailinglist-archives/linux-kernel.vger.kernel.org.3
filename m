Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E132591516
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiHLRw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHLRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:52:57 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9110060E1;
        Fri, 12 Aug 2022 10:52:56 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a12so448807qkk.7;
        Fri, 12 Aug 2022 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hTbq319S2HqQfUvndHpgKaA8H0ceRNDXupwwPdukCdQ=;
        b=Ctco/O6u6/JrwISnAd8hrYNtPb/a/VDmUpBts4Voy050o7YASgw0wquCcH4ReUj96B
         JtrmT659rZseW76eZX1HTQcxVHQlDywx/44yC658maQMatxamLNzglBmQS1KbanrUQ8H
         L4QjRAt6Gv0CDm92uzO7uSREJ7hYF/o0cIjsYjB2pcXsRVpKPe8qsoRkfJjnJYqNsVRb
         wxDdvgNoB5XDRuqq8yYBQIgq8Rc7mDdRLpmY14Xb+MP63UbQaXZ2eGJl9AS/uj28ggdb
         aqhvgGmnuzeWpg7DRfau7R4Nv6H5u8UCJ1yKGxPKrPm7yVjcTkR6T5yjFpBx4w0Bbd6B
         hopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hTbq319S2HqQfUvndHpgKaA8H0ceRNDXupwwPdukCdQ=;
        b=Bf4R8AatqKdzNHsoJDV5J2To8zcNTNcjrKq5qk41A1wQpPiYwefZo74VEuio1Wx7XO
         T99vePwH0oT+SY/TfONG6f2/iFFdWNKIa0zDliM7LUPkD7OTlay7iq+uH74GDuSbh7Zh
         KhLivRg3MubrxkGWpR1DLGvPIX6mhCJ78Gk7e20oi0MtQF8L1pRGOQn1ioHYcKfw5BdQ
         +JSEQYqyCvsDv0VgPgB9ibVR3Vyn0Lu2Vd28Aw9zTSNaVmkldHO1IbCOUWi4lZzHoxc/
         NuMdfFu2FTLCyjUSQXvEg7sFKcGRHGpvwePdN6VwyvXMmJ5CUPAOrLb0Kz4z6Q8v9J80
         X3rA==
X-Gm-Message-State: ACgBeo2G0D6uQv80wF8Wk3hnzUA1FuHiHqwuU4EVxpgtWUGoHZbzk+w5
        ym0VGychBJo8t0C7oUSV7Ic=
X-Google-Smtp-Source: AA6agR4z+Xj0gOJv1Vdjzm9SnL5FTuExSao834rEtNsBpX4uar0ThkQZ6iTE7N0Cng8AzdEOIdfzEw==
X-Received: by 2002:a05:620a:4914:b0:6b9:5ae8:3f9d with SMTP id ed20-20020a05620a491400b006b95ae83f9dmr3783735qkb.335.1660326775684;
        Fri, 12 Aug 2022 10:52:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t6-20020a05620a450600b006b9c355ed75sm2197406qkp.70.2022.08.12.10.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 10:52:55 -0700 (PDT)
Message-ID: <ec06e9c6-f475-fe19-9046-d57a6168e72b@gmail.com>
Date:   Fri, 12 Aug 2022 10:52:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] memory: Add Broadcom STB memory controller driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220801220931.181531-1-f.fainelli@gmail.com>
 <20220801220931.181531-4-f.fainelli@gmail.com>
 <26ad247d-a4b3-4051-b8d9-505c09b76f6b@linaro.org>
 <375eac04-dbfd-080a-3003-cae3eda1f42b@gmail.com>
 <fa283e3c-5b96-b0a4-95c5-a7230d16d8ca@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <fa283e3c-5b96-b0a4-95c5-a7230d16d8ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 10:36, Krzysztof Kozlowski wrote:
> On 12/08/2022 20:29, Florian Fainelli wrote:
>> On 8/9/22 02:58, Krzysztof Kozlowski wrote:
>>> On 02/08/2022 01:09, Florian Fainelli wrote:
>>>> Add support for configuring the Self Refresh Power Down (SRPD)
>>>> inactivity timeout on Broadcom STB chips. This is used to conserve power
>>>> when the DRAM activity is reduced.
>>>>
>>>
>>>
>>>> +static int __maybe_unused brcmstb_memc_resume(struct device *dev)
>>>> +{
>>>> +	struct brcmstb_memc *memc = dev_get_drvdata(dev);
>>>> +
>>>> +	if (memc->timeout_cycles == 0)
>>>> +		return 0;
>>>> +
>>>> +	return brcmstb_memc_srpd_config(memc, memc->timeout_cycles);
>>>> +}
>>>> +
>>>> +static SIMPLE_DEV_PM_OPS(brcmstb_memc_pm_ops, brcmstb_memc_suspend,
>>>> +			 brcmstb_memc_resume);
>>>> +
>>>> +static struct platform_driver brcmstb_memc_driver = {
>>>> +	.probe = brcmstb_memc_probe,
>>>> +	.remove = brcmstb_memc_remove,
>>>> +	.driver = {
>>>> +		.name		= "brcmstb_memc",
>>>> +		.owner		= THIS_MODULE,
>>>
>>> No need, run coccinelle.
>>>
>>>> +		.of_match_table	= brcmstb_memc_of_match,
>>>> +		.pm		= &brcmstb_memc_pm_ops,
>>>
>>> Shouldn't this be pm_ptr()? and then no need for __maybe_unused in
>>> brcmstb_memc_resume/suspend.
>>
>> How can one can remove __maybe_unused without causing a warning for the
>> CONFIG_PM=n case, not that I needed to build to convince myself, but
>> still did anyway:
>>
>> drivers/memory/brcmstb_memc.c:275:12: warning: 'brcmstb_memc_resume'
>> defined but not used [-Wunused-function]
>>    static int brcmstb_memc_resume(struct device *dev)
>>               ^~~~~~~~~~~~~~~~~~~
>> drivers/memory/brcmstb_memc.c:252:12: warning: 'brcmstb_memc_suspend'
>> defined but not used [-Wunused-function]
>>    static int brcmstb_memc_suspend(struct device *dev)
>>               ^~~~~~~~~~~~~~~~~~~~
>>
>> unless you also implied enclosing those functions under an #if
>> IS_ENABLED(CONFIG_PM) or something which is IMHO less preferable.
> 
> Are you sure you added also pm_ptr()? I don't see such warnings with W=1
> and final object does not have the functions (for a different driver but
> same principle).

Yes I am sure I added pm_ptr() see the v4 I just submitted. I don't see 
how the compiler cannot warn about the functions being unused the day 
they stop being referenced by the pm_ops structure which is eliminated?
-- 
Florian
