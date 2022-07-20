Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0A257B1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiGTHkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiGTHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:40:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5CD45070
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:40:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b9so15804658pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/uorVJjayDp26n5/7TH/fkLv17qD1Lr/KLk9s+h90+0=;
        b=Ts9NhKBm4+5EfTgPBR18LYv9VuF55ILpwh49nw9HQrOBr34uZshzvvZ09DZRgHF7pr
         UK8hDTPPsZBQlvW5tyjwWzEOesHwGW8DXBJYB+xZVg+5xjD2y+GSFdyvDbovpThr7fWV
         2NeQhF6bUmc5bWXrx1XVZk9i2JDlmGo3ui6C52gUpdfCzY0b19lGr8QxmK6RUbTsd55x
         h8ZCvSBXZ53e2daxdHA4s4mnyaWfZWgcnk9Um8olBTBLkEheFyIKKP4O0yJCVCBR7Ufg
         5KdDDHd+okbiPyWcBXvLqLfXLXhRMV937LpSiTc3G4ihdJzY/F6pOKKkXME/fhRjTyWY
         BOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/uorVJjayDp26n5/7TH/fkLv17qD1Lr/KLk9s+h90+0=;
        b=kyuh8ddUB+B10khO8EJ9k9UOH9ENxYzwpzyzbMMVyUpGZ6t4vnrHizFzs47TiOn7tY
         uUgAouT4NdpQQBIQBqECEFO6wb5BAx3by7zL+p3jtfOmJH14YKtXaIpMx4+W+RmoyWoB
         x4cd9rt5cuABLmU8PwCXPqKfun2Dbipe2uR06qg8EAYgy6helsz0aq2XgelclB4NrvOm
         GcvTsxoakl0SD98drWQpr6wPBG403WqpzETxmBuW/ZX4w6qbitoM5bSkjTSmh0mQi2mQ
         blsA101zQx1JZFNQVBi028Nt/IZnD3zA03I1lklBBshwo6LsAFsHmtD6XYR+xKRAYxXS
         PYww==
X-Gm-Message-State: AJIora8bflggGpqYQRifAkU2MkXsX/Qy3tZ4jXMdyC0u5nUnK9CKp/hs
        F9s7pKIBNOEkQNgGjz9IdIWxvW4auL7KDg==
X-Google-Smtp-Source: AGRyM1uvWY8UYC1O0aM9uxm8tQ5KpzBVbvqjfd4qOjmrkdR6XIfTKDcLYwkiSoACsGbb1gRJ6BosjQ==
X-Received: by 2002:a63:4a12:0:b0:419:9ede:b7a0 with SMTP id x18-20020a634a12000000b004199edeb7a0mr30064067pga.167.1658302830924;
        Wed, 20 Jul 2022 00:40:30 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id y20-20020aa79434000000b005289f594326sm6408369pfo.69.2022.07.20.00.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 00:40:30 -0700 (PDT)
Message-ID: <edb7bb13-0e34-dab2-d3a4-51bd73e38174@linaro.org>
Date:   Wed, 20 Jul 2022 13:10:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: ipq8074: Fix 'max-frequency'
 value for sdhci node
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh@kernel.org
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
 <20220514215424.1007718-7-bhupesh.sharma@linaro.org>
 <Yr4psYiCCbi15RMe@builder.lan>
 <772dc5d2-c3b2-685b-3a38-b86e8877424a@linaro.org>
 <CAPDyKFpUpvHWMZmU0RxLAoFQG7RzOnqvTQPQBOm0s5MkkMHChw@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <CAPDyKFpUpvHWMZmU0RxLAoFQG7RzOnqvTQPQBOm0s5MkkMHChw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,


On 7/18/22 6:21 PM, Ulf Hansson wrote:
> On Mon, 18 Jul 2022 at 10:47, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>>
>> On 7/1/22 4:24 AM, Bjorn Andersson wrote:
>>> On Sat 14 May 16:54 CDT 2022, Bhupesh Sharma wrote:
>>>
>>>> Since the Qualcomm sdhci-msm device-tree binding has been converted
>>>> to yaml format, 'make dtbs_check' reports issues with
>>>> 'max-frequency' value for ipq8074 sdhci node:
>>>>
>>>>    arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
>>>>     max-frequency:0:0: 384000000 is greater than the maximum of 200000000
>>>>
>>>> Fix the same.
>>>>
>>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>>> index ab2a1e7955b5..b2d71af9b419 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>>> @@ -388,7 +388,7 @@ sdhc_1: mmc@7824900 {
>>>>                                <&gcc GCC_SDCC1_APPS_CLK>,
>>>>                                <&xo>;
>>>>                       clock-names = "iface", "core", "xo";
>>>> -                    max-frequency = <384000000>;
>>>> +                    max-frequency = <200000000>;
>>> This might match the binding, but someone put 384000000 there for a
>>> reason. Perhaps the binding needs to be updated instead?
>>
>> I was waiting for getting access to ipq8074 reference manual / documentation.
>> I double-checked and it seems SDCC1 on this SoC does support a max frequency
>> of 384 MHz which is strange as the SDCC2 supports 200 MHz as max frequency
>> instead.
> 
> I guess it depends on what the property is being used for from the mmc
> host driver perspective. So, to answer the question, we probably need
> to look at the code in the host driver to best understand what to do
> here.
> 
>>
>> Also the eMMC and MMC controllers on other SoCs (i.MX etx( usually support only
>> a max frequency of 200 MHz, so may be we need an exceptional addition to the
>> binding documentation here.
>>
>> @Ulf - what's your view on updating the binding documentation here? I can
>> send a v3 accordingly.
> 
> The point with the property is to let host controllers specify whether
> there is an upper limit of the frequency that it can support. No
> matter what, the mmc core will not use a frequency greater than stated
> by the eMMC/SD/SDIO specs.
> 
> For eMMC, 200MHz is the maximum frequency.
> 
> For SD/SDIO cards, the SDR104 mode has 208MHz. So it seems like we
> need an update to the binding, no matter what. :-)
> 
> I have no strong opinions around this, but perhaps just raising the
> limit of the binding to cover the qcom case makes best sense.

Thanks for your inputs. I will send a v3 version with the udpated
binding soon.

Regards,
Bhupesh
