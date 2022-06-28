Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5BE55D993
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbiF1KuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345086AbiF1KuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:50:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75024BF7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:50:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k22so17080314wrd.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D5Yp5z0uikP6kZlGS2YEDpfiM1NMX3Tdy1o4tE54EkA=;
        b=Hg+wVajBl/9GBW5iP5GGK542lVYHM9R+b6dZWTYA7FDr47v9J6UeJGHXiLJTbCEJ6v
         WHjCoMSJdZ/W6vpEsQ5wQ8FEm7LOHPqGbY0/janBLRCclpjjR2ahzmumZgpjhQ3mU3Zz
         9Zd9+YgvoVxJqzunjKGfA0ap0YWqSuM1NOp6Nb1YWaucHgh5uj0+kiJB3QEMS7cJvl9t
         /1Czsxg+/cWEall8YwkcLog2xVRlmlTZ2hu2padxJJOQno/eXf8hOissbXfcF5yMrBM3
         dUvj3+OeReeO1KrwnNRbUjw5g9Qcs6be3RoB7VM0Agk3ajrl8Rx4r6pyVdncShKfdlB3
         QuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D5Yp5z0uikP6kZlGS2YEDpfiM1NMX3Tdy1o4tE54EkA=;
        b=whoI21A1K0HxXgAS00YBX5ZnTNjlrmTNTGUQM8mJVyuuUTK0kuEqfjr0lib5pg/mPt
         HvSUmVB29p0ECOwsZ4AT4Je95Pu+a/vDIJPrsboskzmoZ/cfF39cCRIStV003ljiJXks
         pMHbSoNoI/Zj++qMBaa46FDfPrFMiDE/ka8RB1nIKRo3IbQoS/Y+Vkt8xxG+X6+9qtEK
         hKs4xg9v8403hwhp1J32YY5RJHlS5i3WEnL0f8mocWS+jGAPPOf+dNpYJqFf5BAQtXW0
         ZB6KDYozZkdQMO2Ssmru16piUTbK15SXRcI+kjE0d9vMSMPAFVA4KOsJK0RFpbbVmGuw
         Pu2g==
X-Gm-Message-State: AJIora9bri1c4KpqTgSapZsJWloyCmvNTA7/uP4U1gNKN5BJooCer45B
        B6HqdctL7sJLkXhpywnTyvItr+cJs35V0w==
X-Google-Smtp-Source: AGRyM1t7ldsuF7FbFQ8lRlxojUnda3gtbTbepfnR5FLUMtmeZyXYf5l0XxZNFLDSGICVmiAPYzeSbg==
X-Received: by 2002:adf:ed0d:0:b0:21b:978f:e53 with SMTP id a13-20020adfed0d000000b0021b978f0e53mr17045714wro.8.1656413408515;
        Tue, 28 Jun 2022 03:50:08 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a04d19dab3sm3538689wmr.3.2022.06.28.03.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 03:50:07 -0700 (PDT)
Message-ID: <c43d4c9e-54d6-7b00-0ff7-e114850302ad@linaro.org>
Date:   Tue, 28 Jun 2022 12:50:06 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <59b5115e-0fe5-dbe1-552b-c29e771c0583@quicinc.com>
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

On 28/06/2022 12:36, Rajendra Nayak wrote:
> 
> On 6/27/2022 6:09 PM, Krzysztof Kozlowski wrote:
>> On 26/06/2022 05:28, Bjorn Andersson wrote:
>>> On Thu 23 Jun 07:58 CDT 2022, Krzysztof Kozlowski wrote:
>>>
>>>> On 23/06/2022 08:48, Rajendra Nayak wrote:
>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>> index 83e8b63f0910..adffb9c70566 100644
>>>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>>>>>>>>     			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>     		};
>>>>>>>>     
>>>>>>>> +		pmu@1436400 {
>>>>>>>> +			compatible = "qcom,sdm845-cpu-bwmon";
>>>>>>>> +			reg = <0 0x01436400 0 0x600>;
>>>>>>>> +
>>>>>>>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>> +
>>>>>>>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>>>>>>>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>>>>>>>> +			interconnect-names = "ddr", "l3c";
>>>>>>>
>>>>>>> Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?
>>>>>>
>>>>>> To my understanding this is the one between CPU and caches.
>>>>>
>>>>> Ok, but then because the OPP table lists the DDR bw first and Cache bw second, isn't the driver
>>>>> ending up comparing the bw values thrown by the pmu against the DDR bw instead of the Cache BW?
>>>>
>>>> I double checked now and you're right.
>>>>
>>>>> Atleast with my testing on sc7280 I found this to mess things up and I always was ending up at
>>>>> higher OPPs even while the system was completely idle. Comparing the values against the Cache bw
>>>>> fixed it.(sc7280 also has a bwmon4 instance between the cpu and caches and a bwmon5 between the cache
>>>>> and DDR)
>>>>
>>>> In my case it exposes different issue - under performance. Somehow the
>>>> bwmon does not report bandwidth high enough to vote for high bandwidth.
>>>>
>>>> After removing the DDR interconnect and bandwidth OPP values I have for:
>>>> sysbench --threads=8 --time=60 --memory-total-size=20T --test=memory
>>>> --memory-block-size=4M run
>>>>
>>>> 1. Vanilla: 29768 MB/s
>>>> 2. Vanilla without CPU votes: 8728 MB/s
>>>> 3. Previous bwmon (voting too high): 32007 MB/s
>>>> 4. Fixed bwmon 24911 MB/s
>>>> Bwmon does not vote for maximum L3 speed:
>>>> bwmon report 9408 MB/s (thresholds set: <9216000 15052801>
>>>> )
>>>> osm l3 aggregate 14355 MBps -> 897 MHz, level 7, bw 14355 MBps
>>>>
>>>> Maybe that's just problem with missing governor which would vote for
>>>> bandwidth rounding up or anticipating higher needs.
>>>>
>>>>>>> Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?
>>>>>>
>>>>>> The interconnects are the same as ones used for CPU nodes, therefore if
>>>>>> we want to scale both when scaling CPU, then we also want to scale both
>>>>>> when seeing traffic between CPU and cache.
>>>>>
>>>>> Well, they were both associated with the CPU node because with no other input to decide on _when_
>>>>> to scale the caches and DDR, we just put a mapping table which simply mapped a CPU freq to a L3 _and_
>>>>> DDR freq. So with just one input (CPU freq) we decided on what should be both the L3 freq and DDR freq.
>>>>>
>>>>> Now with 2 pmu's, we have 2 inputs, so we can individually scale the L3 based on the cache PMU
>>>>> counters and DDR based on the DDR PMU counters, no?
>>>>>
>>>>> Since you said you have plans to add the other pmu support as well (bwmon5 between the cache and DDR)
>>>>> how else would you have the OPP table associated with that pmu instance? Would you again have both the
>>>>> L3 and DDR scale based on the inputs from that bwmon too?
>>>>
>>>> Good point, thanks for sharing. I think you're right. I'll keep only the
>>>> l3c interconnect path.
>>>>
>>>
>>> If I understand correctly, <&osm_l3 MASTER_OSM_L3_APPS &osm_l3
>>> SLAVE_OSM_L3> relates to the L3 cache speed, which sits inside the CPU
>>> subsystem. As such traffic hitting this cache will not show up in either
>>> bwmon instance.
>>>
>>> The path <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>
>>> affects the DDR frequency. So the traffic measured by the cpu-bwmon
>>> would be the CPU subsystems traffic that missed the L1/L2/L3 caches and
>>> hits the memory bus towards DDR.
> 
> That seems right, looking some more into the downstream code and register definitions
> I see the 2 bwmon instances actually lie on the path outside CPU SS towards DDR,
> first one (bwmon4) is between the CPUSS and LLCC (system cache) and the second one
> (bwmon5) between LLCC and DDR. So we should use the counters from bwmon4 to
> scale the CPU-LLCC path (and not L3), on sc7280 that would mean splitting the
> <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3> into
> <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3> (voting based on the bwmon4 inputs)
> and <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3> (voting based on the bwmon5 inputs)
> and similar for sdm845 too.
> 
> L3 should perhaps still be voted based on the cpu freq as done today.

This would mean that original bandwidth values (800 - 7216 MB/s) were
correct. However we have still your observation that bwmon kicks in very
fast and my measurements that sampled bwmon data shows bandwidth ~20000
MB/s.


Best regards,
Krzysztof
