Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805764FFDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbiDMScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiDMScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:32:19 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13FA1DA4F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:29:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so3280043lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5v2yWjtsq2yE0AMVSJiuBUQWC1Qu+AF7xA3OEwCIDv8=;
        b=xrnaFkyIM9Y8sdzRSP8L1zVvkPzlRgmMiNIBITDP+nN1I76/e7wOvhqH0+w84X8dHl
         uHC8c1aDfdwk5/pskaflGmZq1ouRuQeYDsQemoJw1b9qoXSZFcCe0Qme8y1ysAyiI7HF
         vDp4XVEmcBExfH30rFxECd3/K0Svpi1Jq8c4LQrrx9wclPpE3TmjCBddQ61iwvDkFx7R
         fIXoEz5WvQEl483ccx9fu2nI58M9nRnrXU8t/QVxkn1Y56Y9h9ecjnXM1qYe03f/uMVO
         yMl7ImLoKyrcuIkP520IeIk+JW2yGEM5WHMjgA+rT85vkH9h6558b/2mSdvE9+9JOlos
         8tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5v2yWjtsq2yE0AMVSJiuBUQWC1Qu+AF7xA3OEwCIDv8=;
        b=sAf+/NITmsd4V61rQTsWhM3h8hiC+uJnBSqmAHKpNFgQztNuV1vu0gL6x0kt9EcLlK
         Bfs/EXB+46Ipfe9aWdxtntKD9+63pM9mVu09hEp7QR7PNMTfQMnxl63/6RFRYxUAAqtB
         95GmM3e6WQjD1q3czv/CBmVGxVgNjjMfnI6N6ewRMe7GlTE78L21d1fWynuH9UDz+41A
         1jngcXk1s9b5m16XHL9g4Qw4phQ2hs+jxYwvQOsnWkB7GXBtqBIJCxHGVZOX+9gDjWli
         /DflhJyD6nsoVJV1IH8Ji9XkQq3Fzo8FcnpzaF6KI9Jd/Ns/SvKmwRmc4FaOCQAlYDUV
         WCmw==
X-Gm-Message-State: AOAM530rrXHLVhaem5kdGG5Z0bSybl0EkiaHDceafsOvCVIg0rs49lRp
        FbEs6JkF40sVGbiKA7EgPYaJLA==
X-Google-Smtp-Source: ABdhPJyb61UnhRI5EkaMY9lwwwGMDWvZTuImWapdXaD5jELavgJlOP+lmvFNEEQQsLEhuFNozH12BQ==
X-Received: by 2002:a2e:9ed1:0:b0:249:3cc7:2d56 with SMTP id h17-20020a2e9ed1000000b002493cc72d56mr25778404ljk.244.1649874596002;
        Wed, 13 Apr 2022 11:29:56 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n16-20020a19ef10000000b0046ba4a33d6fsm1334552lfh.203.2022.04.13.11.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 11:29:55 -0700 (PDT)
Message-ID: <474baf12-9907-4ab4-140c-08832ce36d12@linaro.org>
Date:   Wed, 13 Apr 2022 21:29:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 07/18] ARM: dts: qcom: reduce pci IO size to 64K for
 ipq8064
Content-Language: en-GB
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-8-ansuelsmth@gmail.com>
 <a7034b5e-24de-ef17-ae93-c626beb35a41@linaro.org>
 <6256cf8e.1c69fb81.b313c.dd8b@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <6256cf8e.1c69fb81.b313c.dd8b@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 16:21, Ansuel Smith wrote:
> On Wed, Apr 13, 2022 at 04:19:42PM +0300, Dmitry Baryshkov wrote:
>> On 09/03/2022 22:01, Ansuel Smith wrote:
>>> The current value for pci IO is problematic for ath10k wifi card
>>> commonly connected to ipq8064 SoC.
>>> The current value is probably a typo and is actually uncommon to find
>>> 1MB IO space even on a x86 arch.
>>
>> I checked other Qualcomm platforms (including downstream apq8084.dtsi). All
>> of them list 1MB region as IO space.
>>
>> Interesting enough I couldn't get PCI to work on my IFC6410 (apq8064). It
>> has an ethernet adapter AR8151 sitting on the PCIe bus. The driver probes,
>> transmits packets successfully, but receives only garbage. I'm not sure if
>> it is the hardware or a software problem. Same adapter works fine on db820c.
>>
> 
> I didn't understand if device works correctly without this change.
> The alternative to this, is to change the io space globally for every arm
> target and it was pointed out that it was a strange change to do. 99%
> the 1mb region present on every qcom platform is a copy past error but
> still a region that big worked before some kernel version just because
> the kernel didn't check them.
> So it's both reduce IO in dtsi or extend IO_SPACE_LIMIT for every arm
> target.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
>>> Also with recent changes to the pci
>>> driver, pci1 and pci2 now fails to function as any connected device
>>> fails any reg read/write. Reduce this to 64K as it should be more than
>>> enough and 3 * 64K of total IO space doesn't exceed the IO_SPACE_LIMIT
>>> hardcoded for the ARM arch.
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> Tested-by: Jonathan McDowell <noodles@earth.li>
>>> ---
>>>    arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> index e247bf51df01..36bdfc8db3f0 100644
>>> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> @@ -918,7 +918,7 @@ pcie0: pci@1b500000 {
>>>    			#address-cells = <3>;
>>>    			#size-cells = <2>;
>>> -			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
>>> +			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
>>>    				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
>>>    			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>>> @@ -969,7 +969,7 @@ pcie1: pci@1b700000 {
>>>    			#address-cells = <3>;
>>>    			#size-cells = <2>;
>>> -			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
>>> +			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
>>>    				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
>>>    			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>>> @@ -1020,7 +1020,7 @@ pcie2: pci@1b900000 {
>>>    			#address-cells = <3>;
>>>    			#size-cells = <2>;
>>> -			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
>>> +			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
>>>    				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
>>>    			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>>
>>
>> -- 
>> With best wishes
>> Dmitry
> 


-- 
With best wishes
Dmitry
