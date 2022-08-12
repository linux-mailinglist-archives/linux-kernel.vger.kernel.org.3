Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4EA5914CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbiHLRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiHLR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:29:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B3B2746;
        Fri, 12 Aug 2022 10:29:55 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cr9so1253923qtb.13;
        Fri, 12 Aug 2022 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Ai2HsUP704GMlIzejaJoLn59RRK3/SzYyUuWR94MIL4=;
        b=TXZGPzKcE7bYngWw7KpHl+NVc6xLAw/AliIXjBeWgw6YNJuVtLC8fi/RWfCQQ/cVLn
         lxzRXwoxNfBgYuA+wBj5IR2pM2vEOPpdhu9lpxVwBKZlxrU21P8tQm6iBxrBcU2Twpq0
         DJErNg3B/ivCY+tJwX7Z/Vy4tcPZ1wW8xiILJquLLEX6XdI0IM9PtiKYmZjPdkxYrCsb
         p1u+dshkTNSOI7XvLEtoCmKutqPcSdDc8xiBa2fhlJprMS3CiQWTEh4uH91puGIXdP3w
         s9rBDlaXblnntNdBNfGg+bkkmKLqPrISroZTCCjq8uwJIKkQQh2Ya22HEhwMBhS9PrBu
         VIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ai2HsUP704GMlIzejaJoLn59RRK3/SzYyUuWR94MIL4=;
        b=JuyB0tR73t+PZd4NwzzvFxqGjE6qwGCgCy32HxYqEeR6Z29m5GL4JD+PiFVnhLsr8C
         RdxzxznRJAtr32aiMmlq0U8aHobg1dLqz7sAm2tC1QEIGRxpdzmpilU/NldU3uIfopSr
         diRQ2XCJKC2XbMtsRFTi6+qkmhBR+3XMpaPFi1sWynbrNdEbn0gR8P15Hc8fO1aLfUXS
         hhpdWqxg4eQFVvVV/EwXyR4CZcSwYaMLCOwCqp06Z4344xNgYq3QRb00ZC4CsY4pJOW8
         1HMU5Xkygju2Yl2Idh9lj7QdxPPdg5A2HQPtS5wKUcLs8O/2b/Fc/TM7BVrW5lg0D89N
         WAyg==
X-Gm-Message-State: ACgBeo00ouR9zul24KxQUwWFhcJRJbS/oqDGo8SKDqoFJ/qS+bCScaWa
        8CXxz0z9gYpoPZjjaFaWtwo=
X-Google-Smtp-Source: AA6agR4gkODGcvEaK8l0bY+IKrZkwI3Wy+SSMYjbe2r/KhNlG9XCutTuN0Lo4jAYYI5yqqRcnKkTeQ==
X-Received: by 2002:a05:622a:2c2:b0:343:645f:1601 with SMTP id a2-20020a05622a02c200b00343645f1601mr4511482qtx.349.1660325394707;
        Fri, 12 Aug 2022 10:29:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w20-20020a05620a0e9400b006b63679a433sm1975883qkm.133.2022.08.12.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 10:29:54 -0700 (PDT)
Message-ID: <375eac04-dbfd-080a-3003-cae3eda1f42b@gmail.com>
Date:   Fri, 12 Aug 2022 10:29:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] memory: Add Broadcom STB memory controller driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <26ad247d-a4b3-4051-b8d9-505c09b76f6b@linaro.org>
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

On 8/9/22 02:58, Krzysztof Kozlowski wrote:
> On 02/08/2022 01:09, Florian Fainelli wrote:
>> Add support for configuring the Self Refresh Power Down (SRPD)
>> inactivity timeout on Broadcom STB chips. This is used to conserve power
>> when the DRAM activity is reduced.
>>
> 
> 
>> +static int __maybe_unused brcmstb_memc_resume(struct device *dev)
>> +{
>> +	struct brcmstb_memc *memc = dev_get_drvdata(dev);
>> +
>> +	if (memc->timeout_cycles == 0)
>> +		return 0;
>> +
>> +	return brcmstb_memc_srpd_config(memc, memc->timeout_cycles);
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(brcmstb_memc_pm_ops, brcmstb_memc_suspend,
>> +			 brcmstb_memc_resume);
>> +
>> +static struct platform_driver brcmstb_memc_driver = {
>> +	.probe = brcmstb_memc_probe,
>> +	.remove = brcmstb_memc_remove,
>> +	.driver = {
>> +		.name		= "brcmstb_memc",
>> +		.owner		= THIS_MODULE,
> 
> No need, run coccinelle.
> 
>> +		.of_match_table	= brcmstb_memc_of_match,
>> +		.pm		= &brcmstb_memc_pm_ops,
> 
> Shouldn't this be pm_ptr()? and then no need for __maybe_unused in
> brcmstb_memc_resume/suspend.

How can one can remove __maybe_unused without causing a warning for the 
CONFIG_PM=n case, not that I needed to build to convince myself, but 
still did anyway:

drivers/memory/brcmstb_memc.c:275:12: warning: 'brcmstb_memc_resume' 
defined but not used [-Wunused-function]
  static int brcmstb_memc_resume(struct device *dev)
             ^~~~~~~~~~~~~~~~~~~
drivers/memory/brcmstb_memc.c:252:12: warning: 'brcmstb_memc_suspend' 
defined but not used [-Wunused-function]
  static int brcmstb_memc_suspend(struct device *dev)
             ^~~~~~~~~~~~~~~~~~~~

unless you also implied enclosing those functions under an #if 
IS_ENABLED(CONFIG_PM) or something which is IMHO less preferable.
-- 
Florian
