Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97C58142B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiGZN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiGZN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:29:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E444D2AE12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:29:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bf9so22556140lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kzYEowobG1GCcVsGATTfBQVx4ZYoqtGaYqMt9Le464E=;
        b=lHoxWQovthKA2GrOxGoHuCbLjZpwWr3Wlh7056dot4DKAFfIVgkG0X9/r6cqb6+TDZ
         OZPgf3/NLfKQ46hCkQI5oLLcIlzfQnWXPLnp8qei5lfUKUkHHv0wruzLTH3mim3BdFnM
         1xeKuBtdw2mmbMsOWQUku7r1wAsGnlGA5nckVX+WpWLD+hK487Sn8T4gv2i33F3a65uT
         24ALNXmSTxaVq71Lw4aQLmo0yKJw2DwMNFFklMhsmGexYn3qNzpQyosSSkGmYyPSsdP6
         no+INldFjim//84rveKiIerJUAFYM6dFjuSXJrLJE5voGvjXv0ei+RCSVB3/WRewDOu/
         +7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kzYEowobG1GCcVsGATTfBQVx4ZYoqtGaYqMt9Le464E=;
        b=AoQvBrs/VSbEs1s8w+3fGQfasV5O0ndRdvynWKoPTH1fDLhpFxEi4UJ6ws2pobGa/q
         cMeqEk0xyM5cV86/aUPBEqyxYXv2hHZ+bbSLLVg+PDY8JdQo1tUmATNmoY8NeNREdhIa
         pUZLF7FGJkwo496UeYcB4zCb+eOOdeSkSKR9jeit+K+RDEZpLIAZfTjNm4Y8VIAJVCrQ
         txsctqXl8GyquboO5XM1OS5PUwblMsK29/KNXIWhzYuV7uyKiRbiITux2FPZ2rPndZkC
         GsTqx3ujwK9kGLdWJ4O7T6TRMMNkmikj/X05bobu4WTMbjpEmsokgycqfN/HU2qv5S0R
         pnGA==
X-Gm-Message-State: AJIora+SHpQw+dtf7pWGsREQjf0IsWPHHVyjxxB8tzXFXMXFIEeNindw
        UiElh0yn3XldSGjnSnLgi3DnNQ==
X-Google-Smtp-Source: AGRyM1uzPgOgi6yIT6lZAK0SxMjw4dz41VaKCAnAeaO5QC0g8ea4Em13uGgJdkaREsyjbsOtBTUaHQ==
X-Received: by 2002:ac2:4e07:0:b0:48a:18f3:e5fe with SMTP id e7-20020ac24e07000000b0048a18f3e5femr6931153lfr.357.1658842159247;
        Tue, 26 Jul 2022 06:29:19 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512318600b0048a78d5c4b5sm1698072lfe.165.2022.07.26.06.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:29:18 -0700 (PDT)
Message-ID: <2e928ad6-f11a-145a-d3d3-8ba3ce068a37@linaro.org>
Date:   Tue, 26 Jul 2022 15:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 03/10] soc: qcom: icc-bwmon: drop unused BWMON_ZONE_COUNT
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-4-krzysztof.kozlowski@linaro.org>
 <689ae7a0-bb23-8264-a2ff-40b1b5bbf0af@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <689ae7a0-bb23-8264-a2ff-40b1b5bbf0af@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 26/07/2022 13:25, Sibi Sankar wrote:
> Hey Krzysztof,
> 
> Thanks for working on the llcc bwmon patch series!
> 
> 
> On 7/21/22 12:58 AM, Krzysztof Kozlowski wrote:
>> BWMON_ZONE_COUNT define is not used.
>>
>> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/soc/qcom/icc-bwmon.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>> index 3415f42523cd..b76a59d9002c 100644
>> --- a/drivers/soc/qcom/icc-bwmon.c
>> +++ b/drivers/soc/qcom/icc-bwmon.c
>> @@ -105,7 +105,6 @@
>>   
>>   /* BWMONv4 count registers use count unit of 64 kB */
>>   #define BWMON_COUNT_UNIT_KB			64
>> -#define BWMON_ZONE_COUNT			0x2d8
> 
> Apart from ^^ a few more defines like BWMON_GLOBAL_IRQ_STATUS,

I will remove it in v2.

> THRESHOLD_COUNT_ZONE2_SHIFT were unused as well.

This one was used in the code and later replaced by reg_field shifts.

> 
> Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

Thanks!

Best regards,
Krzysztof
