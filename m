Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E21557C58
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiFWM6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiFWM6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:58:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A4F4A3DA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:58:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ge10so9375494ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m/hz+H8zpOsqdq2iKPbughSwBYMoaruSRt5PQDIHbSc=;
        b=CFkyLPAOqxgKb1ubuX9QDvfoqC4QGmlCmmI2kuzxmnihmSbUTYsgJypMud0fdrXuJh
         if4c0LFekjFXMJ3kApfk1JSvMTvklIAHuKOrIeO0Tiq8JH676g9PVv2pVyq5XQQlSOrv
         8l5KBp7nx9EXciIScArJIUoa9CHMuSvFInvg2kvzWsw/UPrDqXwxKnyUjTsac6UONywy
         VTi1x6U7lYQ9pTiDyZiYyF+TQDBKw6TMf6q7BdegduE0+WCFNl7bPn0Wa5LHytIgW/Hh
         MK2jsVwX8rVEXykP+GZGoX5D5HEIZh7i4cG/cgpYI3q8zhv/jKbQs2HebHX+7nyky4r8
         oibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m/hz+H8zpOsqdq2iKPbughSwBYMoaruSRt5PQDIHbSc=;
        b=l6EJqe3/yL6IXiVJ/UFbiHETUVqFbGLu9YTZUdM2bW+gncdjz/Gm9m8jYpgz/3DUt3
         /MZT6KFN9Y8zMC3sInpvl98M+rvBukTX/tiX/YE2pXAWCwKkqTmREKSPusCpZ4W/v0XF
         M7AQnP9XmMgL67XpXjRruU23xJjBqE4po1USh1GbtrWARmjdn67D85/p4ob/WHO7Qe7S
         Lx8le3M8srCOX91AmM94oSIMk3YcTnYnCEBRTDsa54UlUbba4etKvn9l7IZFGlbBDRTV
         aI6h4z2fD2yVbUDLbM2aCh9AgVs3phl0EG8l7gCMuccfA7pURxegL5TfD215c8Eg8UUG
         BePg==
X-Gm-Message-State: AJIora+2x4NSkpgN5Ca1ZZZiBfbFb8LNfud1znHgPb8FA/AwAgpWRJgt
        vY7N7X5l0BVz+KvCMeCSyA4JcQ==
X-Google-Smtp-Source: AGRyM1u9g+U5RCvJJp7ZC1dPupZQ78/Srp7ghZYVffnzDcHg7uXkIjgpV/X4gN+yOZpeqRnOIVgE/g==
X-Received: by 2002:a17:907:7781:b0:6fe:4398:47b3 with SMTP id ky1-20020a170907778100b006fe439847b3mr8075969ejc.513.1655989108643;
        Thu, 23 Jun 2022 05:58:28 -0700 (PDT)
Received: from [192.168.0.230] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cb17-20020a170906a45100b00722fb3c99bcsm1804658ejb.203.2022.06.23.05.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 05:58:28 -0700 (PDT)
Message-ID: <23320e3c-40c3-12bb-0a1c-7e659a1961f2@linaro.org>
Date:   Thu, 23 Jun 2022 14:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
 <bc423d7b-df03-d4e2-2898-0873db710943@quicinc.com>
 <64eb52ee-b3ac-3d94-cfce-ceb1c88dddb6@linaro.org>
 <042cb765-113b-9335-edae-595addf50dd0@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <042cb765-113b-9335-edae-595addf50dd0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 23/06/2022 08:48, Rajendra Nayak wrote:
>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>> index 83e8b63f0910..adffb9c70566 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>>>>    			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>>>    		};
>>>>    
>>>> +		pmu@1436400 {
>>>> +			compatible = "qcom,sdm845-cpu-bwmon";
>>>> +			reg = <0 0x01436400 0 0x600>;
>>>> +
>>>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>>>> +
>>>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>>>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>>>> +			interconnect-names = "ddr", "l3c";
>>>
>>> Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?
>>
>> To my understanding this is the one between CPU and caches.
> 
> Ok, but then because the OPP table lists the DDR bw first and Cache bw second, isn't the driver
> ending up comparing the bw values thrown by the pmu against the DDR bw instead of the Cache BW?

I double checked now and you're right.

> Atleast with my testing on sc7280 I found this to mess things up and I always was ending up at
> higher OPPs even while the system was completely idle. Comparing the values against the Cache bw
> fixed it.(sc7280 also has a bwmon4 instance between the cpu and caches and a bwmon5 between the cache
> and DDR)

In my case it exposes different issue - under performance. Somehow the
bwmon does not report bandwidth high enough to vote for high bandwidth.

After removing the DDR interconnect and bandwidth OPP values I have for:
sysbench --threads=8 --time=60 --memory-total-size=20T --test=memory
--memory-block-size=4M run

1. Vanilla: 29768 MB/s
2. Vanilla without CPU votes: 8728 MB/s
3. Previous bwmon (voting too high): 32007 MB/s
4. Fixed bwmon 24911 MB/s
Bwmon does not vote for maximum L3 speed:
bwmon report 9408 MB/s (thresholds set: <9216000 15052801>
)
osm l3 aggregate 14355 MBps -> 897 MHz, level 7, bw 14355 MBps

Maybe that's just problem with missing governor which would vote for
bandwidth rounding up or anticipating higher needs.

>>> Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?
>>
>> The interconnects are the same as ones used for CPU nodes, therefore if
>> we want to scale both when scaling CPU, then we also want to scale both
>> when seeing traffic between CPU and cache.
> 
> Well, they were both associated with the CPU node because with no other input to decide on _when_
> to scale the caches and DDR, we just put a mapping table which simply mapped a CPU freq to a L3 _and_
> DDR freq. So with just one input (CPU freq) we decided on what should be both the L3 freq and DDR freq.
> 
> Now with 2 pmu's, we have 2 inputs, so we can individually scale the L3 based on the cache PMU
> counters and DDR based on the DDR PMU counters, no?
> 
> Since you said you have plans to add the other pmu support as well (bwmon5 between the cache and DDR)
> how else would you have the OPP table associated with that pmu instance? Would you again have both the
> L3 and DDR scale based on the inputs from that bwmon too?

Good point, thanks for sharing. I think you're right. I'll keep only the
l3c interconnect path.


Best regards,
Krzysztof
