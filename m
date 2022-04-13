Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0414FFDBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiDMS3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbiDMS3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:29:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021DD50E39
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:27:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so5063066lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=evNdnFlztHFMuk1KFy7a+r2V+6GxCGpL2xRUgYQrCNI=;
        b=SJ9s+6oNOpeXNETNkmIBRwFI6nz5q0dVpBUNZTU3FRblP/zvHvAq+LunGszMn+U/N8
         Yfc9iDiglJQEXXka1gCag3YKKqDjUdhCdOL5rhEVeIRHHsosqtt7+HRbtAgib8qniMf5
         wDmiKOf1Sy0jByybF9yhEp81Fa7yOoJEx2/3qpbUwSzrVqdRihktzxWML9eiFewnWgI6
         FtjjeXKPJ7UIFBhYoy3RLefTD27QSKxtswuSVKTZlG7EF/teLvk3OSp+7nFq25tLT9+S
         eUjwTASNTpmQtWEkdb9uIUi2y26d1YGKR8EH8jemjY/O9Wy4STByMEoJfC5PKU3ZGmpv
         K7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=evNdnFlztHFMuk1KFy7a+r2V+6GxCGpL2xRUgYQrCNI=;
        b=4M3RNJWP5xj/0nqRoa9CAmOBbHZTfZUg9J/m5WgrL8IeKj4ZDPsBEshG16C3hWu5CX
         JHXm0r4wAZhFT7FHVRDDPx4TgvTiZiUmQBjm5e+s99lUZVaFS+CpwXXUnPzLUyhQsUk3
         G6RHEqUKRbLjKsXPcuxtzxTbltDaM0WVx36554tzyePwD/0WBz8vUdOEZgv1hO+UrfeH
         81TIATHFpiugpdnbHQvZtXQF7JQvih+57Tk8VJoucsI9l3KYed0IVszg+D/79Ellq71h
         sQ9G5FTXd4gOT5BAqea1Txg2CG0Zl1H1mk84DvCQYU8bDQ9HskXQYoCDAwbLSmVlWuI0
         Dv4Q==
X-Gm-Message-State: AOAM532qQEv4V8D81AtQOUbJn4ZxySMI4a1Ma5PsORMDwiMA8c08weKh
        fCSGwkiXhoEAiH6daXHaOmCRNg==
X-Google-Smtp-Source: ABdhPJzN1zALQp60Sj96QlkcmVqI6vxvbY3CVJAGYAFaV5TOpu9RM/EhIy2ftk/gqVOuhSIkBrFzbg==
X-Received: by 2002:a05:6512:2252:b0:44a:3038:cbc with SMTP id i18-20020a056512225200b0044a30380cbcmr29213760lfu.252.1649874426159;
        Wed, 13 Apr 2022 11:27:06 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p3-20020a056512312300b0046b83c2f92fsm1980155lfd.58.2022.04.13.11.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 11:27:05 -0700 (PDT)
Message-ID: <3805180e-a5df-7a5e-ce08-1a998a8bcf69@linaro.org>
Date:   Wed, 13 Apr 2022 21:27:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 07/18] ARM: dts: qcom: reduce pci IO size to 64K for
 ipq8064
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-8-ansuelsmth@gmail.com>
 <a7034b5e-24de-ef17-ae93-c626beb35a41@linaro.org>
In-Reply-To: <a7034b5e-24de-ef17-ae93-c626beb35a41@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 16:19, Dmitry Baryshkov wrote:
> On 09/03/2022 22:01, Ansuel Smith wrote:
>> The current value for pci IO is problematic for ath10k wifi card
>> commonly connected to ipq8064 SoC.
>> The current value is probably a typo and is actually uncommon to find
>> 1MB IO space even on a x86 arch.
> 
> I checked other Qualcomm platforms (including downstream apq8084.dtsi). 
> All of them list 1MB region as IO space.
> 
> Interesting enough I couldn't get PCI to work on my IFC6410 (apq8064). 
> It has an ethernet adapter AR8151 sitting on the PCIe bus. The driver 
> probes, transmits packets successfully, but receives only garbage. I'm 
> not sure if it is the hardware or a software problem. Same adapter works 
> fine on db820c.

I noticed that it looks like the packet is shifted by two bytes. Maybe 
it's some weird maths somewhere. Maybe it's the lack of iommu on 
apq8064. Anyway, it seems to be unrelated to the issue being discussed.

> 
>> Also with recent changes to the pci
>> driver, pci1 and pci2 now fails to function as any connected device
>> fails any reg read/write. Reduce this to 64K as it should be more than
>> enough and 3 * 64K of total IO space doesn't exceed the IO_SPACE_LIMIT
>> hardcoded for the ARM arch.
>>
>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>> Tested-by: Jonathan McDowell <noodles@earth.li>
>> ---
>>   arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi 
>> b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>> index e247bf51df01..36bdfc8db3f0 100644
>> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>> @@ -918,7 +918,7 @@ pcie0: pci@1b500000 {
>>               #address-cells = <3>;
>>               #size-cells = <2>;
>> -            ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 
>> 0x00100000   /* downstream I/O */
>> +            ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 
>> 0x00010000   /* downstream I/O */
>>                     0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; 
>> /* non-prefetchable memory */
>>               interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -969,7 +969,7 @@ pcie1: pci@1b700000 {
>>               #address-cells = <3>;
>>               #size-cells = <2>;
>> -            ranges = <0x81000000 0 0x31e00000 0x31e00000 0 
>> 0x00100000   /* downstream I/O */
>> +            ranges = <0x81000000 0 0x31e00000 0x31e00000 0 
>> 0x00010000   /* downstream I/O */
>>                     0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; 
>> /* non-prefetchable memory */
>>               interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -1020,7 +1020,7 @@ pcie2: pci@1b900000 {
>>               #address-cells = <3>;
>>               #size-cells = <2>;
>> -            ranges = <0x81000000 0 0x35e00000 0x35e00000 0 
>> 0x00100000   /* downstream I/O */
>> +            ranges = <0x81000000 0 0x35e00000 0x35e00000 0 
>> 0x00010000   /* downstream I/O */
>>                     0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; 
>> /* non-prefetchable memory */
>>               interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> 
> 


-- 
With best wishes
Dmitry
