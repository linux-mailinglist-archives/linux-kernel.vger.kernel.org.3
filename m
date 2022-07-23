Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692B257EAA2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiGWA33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWA30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:29:26 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D389672
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:29:25 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10d6ddda695so8253280fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XMJLK4N2d4z2/xpDSbgYVPQ0Elbz9cHd//yyo9mjRjE=;
        b=Jhr3P4pTESjuxQwPIictRPqfMcuCjWtUBrDyroeCNcICrJc6LxCb4H0EyET5JnpSMd
         XDx6lLSrqEOtCnpGAe2AExylN9Agt6X7Zqbb6FcRf7NdFKEGcx95RF+/Z8J6bP5ONORO
         wG1OMLM7lhCQAxPhd/NbHo632jhBUqU+NN4pS5iereARDmvcU0lod/1KdbUs32GcNnUd
         xo6G3S5D/tiCbuRAvoUuWlw46UH+hPIlaLjH0xI2mHweheNtAtPoYArDRG3DTVd87hSJ
         W0wQqtjb+XWZ0TXUtD8JifIwS2UCdctr2gHw2zHhmm+GQ95/1roZg+LzCoBqXVT1MQ7H
         BuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XMJLK4N2d4z2/xpDSbgYVPQ0Elbz9cHd//yyo9mjRjE=;
        b=C9xq4tPT1/Gcdq1KhJJ4AYvrD4i9o5VSYTlXqVHiRzhhaYbcgIyx/IP/5PehTzLeyt
         rUty14cnATCYd0ilyJ1MYr6Vfc4eVzQUXkMSP9iE5F8EQ18r8qV7j3gXJagGgKpl0RZq
         8xI2O3tkupdsqQw3FeLTFeMKxi3YgFbaUfIdE8P7UZ94YZxtqtwzqAHQJ/OTL0bqmt3r
         bL1C5pyuM/CcnsK7oKWSNH3lQHfSBk/7Zemcz3Ht+g2RbzsuQynJuirdWq1/FKl76as/
         UvfKysa1ldDq2bkoFCFCwKB9q0PMVmhkFw3VJRggHXqc9ZLdnRy+stJqTABBf5+0BNJh
         +puA==
X-Gm-Message-State: AJIora8cOQ6DWsjlKFdnMKReNambXT1razKdWHzL1Qh8C9U9+QPDCX6z
        93Er4rxzM94Z4hRbvQE/4sdXtA==
X-Google-Smtp-Source: AGRyM1tCTcWe90z0MM9J9/c7EoRTCWxHMKek0a8/PeZFTw2MzmGKZsUe/j9Ar7345GylSDGdj8qm9Q==
X-Received: by 2002:a05:6870:c189:b0:101:b203:d870 with SMTP id h9-20020a056870c18900b00101b203d870mr8788813oad.267.1658536164645;
        Fri, 22 Jul 2022 17:29:24 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id cm36-20020a056870b62400b000fb2aa6eef2sm2939297oab.32.2022.07.22.17.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 17:29:24 -0700 (PDT)
Message-ID: <d814a6da-b0d7-2fd1-fd14-8f1f3b88666f@kali.org>
Date:   Fri, 22 Jul 2022 19:29:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
 <25673493-4171-62b0-f696-1316d115f388@kali.org>
 <96552a95-8939-3ac2-c9b3-14dabaf53923@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <96552a95-8939-3ac2-c9b3-14dabaf53923@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/22 12:30 PM, Krzysztof Kozlowski wrote:
> On 22/07/2022 03:22, Steev Klimaszewski wrote:
>> Hi Krzysztof,
>>
>> On 7/20/22 2:28 PM, Krzysztof Kozlowski wrote:
>>> The SDM845 comes with few instances of Bandwidth Monitor.  The already
>>> supported one monitors traffic between CPU and Last Level Cache
>>> Controller (LLCC) and in downstream sources is called BWMON v4 (or v4 of
>>> register layout).
>>>
>>> SDM845 also has also BWMON instance measuring traffic between LLCC and
>>> memory with different register layout: called v5.
>>>
>>> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
>>>    1 file changed, 37 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index fe14f7e7523b..4aab464e2bd6 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -2053,6 +2053,43 @@ llcc: system-cache-controller@1100000 {
>>>    			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>>    		};
>>>    
>>> +		pmu@114a000 {
>>> +			compatible = "qcom,sdm845-llcc-bwmon";
>>> +			reg = <0 0x0114a000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
>>> +			interconnects = <&mem_noc MASTER_LLCC 3 &mem_noc SLAVE_EBI1 3>;
>>> +
>>> +			operating-points-v2 = <&llcc_bwmon_opp_table>;
>>> +
>>> +			llcc_bwmon_opp_table: opp-table {
>>> +				compatible = "operating-points-v2";
>>> +
>>> +				/*
>>> +				 * The interconnect path bandwidth taken from
>>> +				 * cpu4_opp_table bandwidth for gladiator_noc-mem_noc
>>> +				 * interconnect.  This also matches the
>>> +				 * bandwidth table of qcom,llccbw (qcom,bw-tbl,
>>> +				 * bus width: 4 bytes) from msm-4.9 downstream
>>> +				 * kernel.
>>> +				 */
>>> +				opp-0 {
>>> +					opp-peak-kBps = <800000>;
>>> +				};
>>> +				opp-1 {
>>> +					opp-peak-kBps = <1804000>;
>>> +				};
>>> +				opp-2 {
>>> +					opp-peak-kBps = <3072000>;
>>> +				};
>>> +				opp-3 {
>>> +					opp-peak-kBps = <5412000>;
>>> +				};
>>> +				opp-4 {
>>> +					opp-peak-kBps = <7216000>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>>    		pmu@1436400 {
>>>    			compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
>>>    			reg = <0 0x01436400 0 0x600>;
>>
>> With this series applied, testing on a Lenovo Yoga C630, which has an
>> SDM850, I see the following:
>>
>> [    3.673660] qcom-bwmon 114a000.pmu: can't request region for resource
>> [mem 0x0114a000-0x0114afff]
>> [    3.673673] qcom-bwmon 114a000.pmu: error -EBUSY: failed to map bwmon
>> registers
>> [    3.673678] qcom-bwmon: probe of 114a000.pmu failed with error -16
>>
> Thanks for the report. What are you running there? `uname -r`? Maybe
> your secure world uses it?
>
> Best regards,
> Krzysztof

Currently it's 5.19.0-rc7 (torvalds tree at 4ba1329c) with a few extra 
patches on top, the bwmon set included.  It's possible that secure world 
uses it, but I do not know enough about that to say one way or the other.

-- steev

