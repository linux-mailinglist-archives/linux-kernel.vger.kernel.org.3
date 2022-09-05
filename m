Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890475AD3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbiIENRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiIENRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:17:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A1642ACE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:17:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z29so13047481lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZhkcBof0q3zrbpmM2uA5kMWYiJUFwZ5O5fdP6QIJab0=;
        b=MrIIeFeWBtMBaW4j5GZ02ZWe4kO4wuXw2VJUSKnqEEy9TD/u1gJJxpCvKuuziSuyQM
         OXnfvt6rR2K3LPvyzm4rwyzOjG62v41kO0j8bWyML/yFaw98qHLB5cqe5O65iV3IygDD
         FM/HZhpyzax+RouXm4jTHjQytDMvDtu57H7WaIO9ct5gAgnMQbHAhVeyjKeYPApMa6/y
         ThZJtr08HYiB+aBezp5SKHgo4ooIFWdYnW+odXsph/QdaR3A1UEr9icfGmaSc5SyYM1+
         P9UaC2uPodO2rBzxOHd0+6JWzV/F12MOEErwU/pB0wigMannqV2ixxIBxF4Hyh5HkGGx
         b2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZhkcBof0q3zrbpmM2uA5kMWYiJUFwZ5O5fdP6QIJab0=;
        b=KCxsgjFDIOI2HDsl1dvdG+2vGbnFR8ovr0Niq1J7YzKMcZEwI/cEqmoGtJYyJKbOJi
         59SJ0xA9QWgIKsecPewa/wXaP10ryXyaMp7KXb0IzxFXO1Yk9iuC3GWvV/DIUaX67hHO
         3Nb5GMxt5q8UDOyYX5NWjca3DxzyFSyPBEQkNA13qmsbNDbHq/To9/Q2513EwKFvVml3
         kh2xuue1HLCUtHDrnIXQ12oVH74skgTBnkUOIRodYF1vCH93Lycgd0u/K2qzXjTNVrRU
         W2foMnmrC+erBC6L5eWqhKcvu6WGpKuWk9iaSlMBePPmpEkq2qPgsJHGaLCg4kI/zKF6
         Qm0g==
X-Gm-Message-State: ACgBeo20YTvc/YwkM2p+o22PG2tG/jgvzHFBfxHgyyJnGwEg+mARyGXL
        qXS/g5G7WPQOvave8Z4p5wN/Pg==
X-Google-Smtp-Source: AA6agR6sI2WOTTy4WGrN9OaHTlr18hO5P/5+l2AMjC7HicL3dypxglHg3OIg5MZDK8H2bfXIQK6Uyw==
X-Received: by 2002:a05:6512:2399:b0:494:7422:4904 with SMTP id c25-20020a056512239900b0049474224904mr11560263lfv.191.1662383859520;
        Mon, 05 Sep 2022 06:17:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u14-20020a05651220ce00b004947fcf0c0bsm1183145lfr.281.2022.09.05.06.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 06:17:39 -0700 (PDT)
Message-ID: <598bd971-0b60-31dd-c23a-89ce74213c3d@linaro.org>
Date:   Mon, 5 Sep 2022 15:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] soc: qcom: icc-bwmon: add support for sc7280 LLCC
 BWMON
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220901124730.19460-1-quic_rjendra@quicinc.com>
 <20220901124730.19460-3-quic_rjendra@quicinc.com>
 <4ca517a4-c4a1-2359-7b60-86ac529ed741@linaro.org>
 <33c61f23-6442-6d9b-492f-dd6e9c64a8c1@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <33c61f23-6442-6d9b-492f-dd6e9c64a8c1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 06:04, Rajendra Nayak wrote:
> 
> 
> On 9/1/2022 8:57 PM, Krzysztof Kozlowski wrote:
>> On 01/09/2022 15:47, Rajendra Nayak wrote:
>>> Add support for sc7280 BWMON instance measuring traffic between LLCC and
>>> memory with the v5 register layout.
>>>
>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>> ---
>>>   drivers/soc/qcom/icc-bwmon.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>>> index 47c2c3e7bb3f..44a10009b45e 100644
>>> --- a/drivers/soc/qcom/icc-bwmon.c
>>> +++ b/drivers/soc/qcom/icc-bwmon.c
>>> @@ -656,6 +656,18 @@ static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>>>   	.regmap_cfg = &sdm845_llcc_bwmon_regmap_cfg,
>>>   };
>>>   
>>> +static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
>>> +	.sample_ms = 4,
>>> +	.count_unit_kb = 64,
>>
>> This makes me wonder if I put correct count unit for SDM845 LLCC...
> 
> These numbers seem to vary from SoC to SoC, 

Hm, then it is probably ok.

> I looked up the sdm845.dtsi from
> the CAF kernels [1] and it seems like it should be 4096 instead of 1024?

The SDM845 v2 DTSI was saying 64 kB for CPU bwmon and indeed 4 MB for
LLCC. I think I took 1 MB from default value from the msm-4.9 driver and
it matched my measurements. I need to test it again and maybe fix it to
4 MB.

Best regards,
Krzysztof
