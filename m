Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7C655E86D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347880AbiF1PYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348177AbiF1PXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:23:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA4727FE2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:23:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z7so18043049edm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZFKlj7FOo2b9LQcnUjb3W09vwFMnGukXUS289yVMoyo=;
        b=HuRGLawyw5YavugL+vTflEBxKLxBh8ri0xpFpdcF/8n9pGGlCKUQ7+UPjCWszeV3bL
         PmKz5zuHPIgLx7csg89C6GHSadtu1qcBZsne+UwdjiujgtC+dQFymSKCCAxQHRHFr3XV
         bxWMYgpLwtVPaHyU5CQymhHz82xokB03+8HSjsAqa2WfbLZIrJlrA14yy1vtu45yslV8
         e8j45yEac5uuKbQfLWMYAp2hpsOhhmHwgrjPuaSv53BQMgoM0ax/8F8kYIoWah9kzBsJ
         LxvjxPirc0vZDBjGtTsjh7gjMCTYhx4RZjNGMdjnVnGgEApU7ZAxaOWf8hI8ijQl07a/
         zytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZFKlj7FOo2b9LQcnUjb3W09vwFMnGukXUS289yVMoyo=;
        b=T2NR9z4nQ1UL4AjJmrJs75hrmjTevBVEQWbPY7wirztyTWKscf+Gi1odGRS4F9751k
         7eKQppZHz6EcJA2Tt2qx8vhmr3ftte96jbZ7jk5dIfkeZUFZBjZPWSPF+QPDwowKeKK8
         /dwk5jaVdS3w3dmm+XjYPudGARFSfGYvMh8Zx/LyY0FO8Ta/algnQLg0os7rzKXg48G5
         IE1KewaxHoXg/1Iq/RYJG/gWbRffMi/Bv126UrhMPS/VZBJ1GeQNqFZxbT+EfRF3Ptrd
         pde82L8RuANpzoVN+bcBzlIQVp+dnThEmG16raUmvYJ0ttiQBwvfl2HhiiE2fzORhG4R
         YUxw==
X-Gm-Message-State: AJIora+DugzuNWChLjMf2cAZZceo5hOcXwm6VxQrYZVxGj3V7cukWdyQ
        bS+X7yykMrQwZ6uW20bKG+rpYg==
X-Google-Smtp-Source: AGRyM1tnifAvs2SVQ/IrQuCLSACfhx6DGO3x6OqUHSTe7kRx7X7G6w4J5nE7D0z4mFX2oum6cZ67dA==
X-Received: by 2002:a50:c8cd:0:b0:435:688d:6c59 with SMTP id k13-20020a50c8cd000000b00435688d6c59mr23391571edh.271.1656429791460;
        Tue, 28 Jun 2022 08:23:11 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906940a00b006fe8bf56f53sm6683755ejx.43.2022.06.28.08.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:23:10 -0700 (PDT)
Message-ID: <21a92985-1993-635b-7e04-2481d0391544@linaro.org>
Date:   Tue, 28 Jun 2022 17:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thara Gopinath <thara.gopinath@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
 <bc423d7b-df03-d4e2-2898-0873db710943@quicinc.com>
 <64eb52ee-b3ac-3d94-cfce-ceb1c88dddb6@linaro.org>
 <042cb765-113b-9335-edae-595addf50dd0@quicinc.com>
 <23320e3c-40c3-12bb-0a1c-7e659a1961f2@linaro.org>
 <YrfSWw9Wpq5TsRUt@builder.lan>
 <47e1fcb4-237b-b880-b1b2-3910cc19e727@linaro.org>
 <59b5115e-0fe5-dbe1-552b-c29e771c0583@quicinc.com>
 <c43d4c9e-54d6-7b00-0ff7-e114850302ad@linaro.org>
 <173717b1-9cd9-9298-3a20-7dd3d95339af@quicinc.com>
 <9b6486b7-418a-0102-213d-f6a5451c8c7c@linaro.org>
 <1cb53abf-067a-25d2-1596-fe3961725e93@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1cb53abf-067a-25d2-1596-fe3961725e93@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 17:20, Rajendra Nayak wrote:
> 
> 
> On 6/28/2022 7:32 PM, Krzysztof Kozlowski wrote:
>> On 28/06/2022 15:15, Rajendra Nayak wrote:
>>>
>>>
>>> On 6/28/2022 4:20 PM, Krzysztof Kozlowski wrote:
>>>> On 28/06/2022 12:36, Rajendra Nayak wrote:
>>>>>
>>>>> On 6/27/2022 6:09 PM, Krzysztof Kozlowski wrote:
>>>>>> On 26/06/2022 05:28, Bjorn Andersson wrote:
>>>>>>> On Thu 23 Jun 07:58 CDT 2022, Krzysztof Kozlowski wrote:
>>>>>>>
>>>>>>>> On 23/06/2022 08:48, Rajendra Nayak wrote:
>>>>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>>>>>> index 83e8b63f0910..adffb9c70566 100644
>>>>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>>>>>> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>>>>>>>>>>>>       			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>>>       		};
>>>>>>>>>>>>       
>>>>>>>>>>>> +		pmu@1436400 {
>>>>>>>>>>>> +			compatible = "qcom,sdm845-cpu-bwmon";
>>>>>>>>>>>> +			reg = <0 0x01436400 0 0x600>;
>>>>>>>>>>>> +
>>>>>>>>>>>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>>> +
>>>>>>>>>>>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>>>>>>>>>>>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>>>>>>>>>>>> +			interconnect-names = "ddr", "l3c";
>>>>>>>>>>>
>>>>>>>>>>> Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?
>>>>>>>>>>
>>>>>>>>>> To my understanding this is the one between CPU and caches.
>>>>>>>>>
>>>>>>>>> Ok, but then because the OPP table lists the DDR bw first and Cache bw second, isn't the driver
>>>>>>>>> ending up comparing the bw values thrown by the pmu against the DDR bw instead of the Cache BW?
>>>>>>>>
>>>>>>>> I double checked now and you're right.
>>>>>>>>
>>>>>>>>> Atleast with my testing on sc7280 I found this to mess things up and I always was ending up at
>>>>>>>>> higher OPPs even while the system was completely idle. Comparing the values against the Cache bw
>>>>>>>>> fixed it.(sc7280 also has a bwmon4 instance between the cpu and caches and a bwmon5 between the cache
>>>>>>>>> and DDR)
>>>>>>>>
>>>>>>>> In my case it exposes different issue - under performance. Somehow the
>>>>>>>> bwmon does not report bandwidth high enough to vote for high bandwidth.
>>>>>>>>
>>>>>>>> After removing the DDR interconnect and bandwidth OPP values I have for:
>>>>>>>> sysbench --threads=8 --time=60 --memory-total-size=20T --test=memory
>>>>>>>> --memory-block-size=4M run
>>>>>>>>
>>>>>>>> 1. Vanilla: 29768 MB/s
>>>>>>>> 2. Vanilla without CPU votes: 8728 MB/s
>>>>>>>> 3. Previous bwmon (voting too high): 32007 MB/s
>>>>>>>> 4. Fixed bwmon 24911 MB/s
>>>>>>>> Bwmon does not vote for maximum L3 speed:
>>>>>>>> bwmon report 9408 MB/s (thresholds set: <9216000 15052801>
>>>>>>>> )
>>>>>>>> osm l3 aggregate 14355 MBps -> 897 MHz, level 7, bw 14355 MBps
>>>>>>>>
>>>>>>>> Maybe that's just problem with missing governor which would vote for
>>>>>>>> bandwidth rounding up or anticipating higher needs.
>>>>>>>>
>>>>>>>>>>> Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?
>>>>>>>>>>
>>>>>>>>>> The interconnects are the same as ones used for CPU nodes, therefore if
>>>>>>>>>> we want to scale both when scaling CPU, then we also want to scale both
>>>>>>>>>> when seeing traffic between CPU and cache.
>>>>>>>>>
>>>>>>>>> Well, they were both associated with the CPU node because with no other input to decide on _when_
>>>>>>>>> to scale the caches and DDR, we just put a mapping table which simply mapped a CPU freq to a L3 _and_
>>>>>>>>> DDR freq. So with just one input (CPU freq) we decided on what should be both the L3 freq and DDR freq.
>>>>>>>>>
>>>>>>>>> Now with 2 pmu's, we have 2 inputs, so we can individually scale the L3 based on the cache PMU
>>>>>>>>> counters and DDR based on the DDR PMU counters, no?
>>>>>>>>>
>>>>>>>>> Since you said you have plans to add the other pmu support as well (bwmon5 between the cache and DDR)
>>>>>>>>> how else would you have the OPP table associated with that pmu instance? Would you again have both the
>>>>>>>>> L3 and DDR scale based on the inputs from that bwmon too?
>>>>>>>>
>>>>>>>> Good point, thanks for sharing. I think you're right. I'll keep only the
>>>>>>>> l3c interconnect path.
>>>>>>>>
>>>>>>>
>>>>>>> If I understand correctly, <&osm_l3 MASTER_OSM_L3_APPS &osm_l3
>>>>>>> SLAVE_OSM_L3> relates to the L3 cache speed, which sits inside the CPU
>>>>>>> subsystem. As such traffic hitting this cache will not show up in either
>>>>>>> bwmon instance.
>>>>>>>
>>>>>>> The path <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>
>>>>>>> affects the DDR frequency. So the traffic measured by the cpu-bwmon
>>>>>>> would be the CPU subsystems traffic that missed the L1/L2/L3 caches and
>>>>>>> hits the memory bus towards DDR.
>>>>>
>>>>> That seems right, looking some more into the downstream code and register definitions
>>>>> I see the 2 bwmon instances actually lie on the path outside CPU SS towards DDR,
>>>>> first one (bwmon4) is between the CPUSS and LLCC (system cache) and the second one
>>>>> (bwmon5) between LLCC and DDR. So we should use the counters from bwmon4 to
>>>>> scale the CPU-LLCC path (and not L3), on sc7280 that would mean splitting the
>>>>> <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3> into
>>>>> <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3> (voting based on the bwmon4 inputs)
>>
>> For sdm845 SLAVE_LLCC is in mem_noc, so I guess mc_virt on sc7280?
> 
> thats correct,
> 
>>
>>>>> and <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3> (voting based on the bwmon5 inputs)
>>>>> and similar for sdm845 too.
>>>>>
>>>>> L3 should perhaps still be voted based on the cpu freq as done today.
>>>>
>>>> This would mean that original bandwidth values (800 - 7216 MB/s) were
>>>> correct. However we have still your observation that bwmon kicks in very
>>>> fast and my measurements that sampled bwmon data shows bandwidth ~20000
>>>> MB/s.
>>>
>>> Right, thats because the bandwidth supported between the cpu<->llcc path is much higher
>>> than the DDR frequencies. For instance on sc7280, I see (2288 - 15258 MB/s) for LLCC while
>>> the DDR max is 8532 MB/s.
>>
>> OK, that sounds right.
>>
>> Another point is that I did not find actual scaling of throughput via
>> that interconnect path:
>> <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>
> 
> Shouldn't this be <&gladiator_noc MASTER_APPSS_PROC 3 &gladiator_noc SLAVE_LLCC 3> on sdm845?

When I tried this, I got icc xlate error. If I read the code correctly,
it's in mem_noc:
https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/interconnect/qcom/sdm845.c#L349

Best regards,
Krzysztof
