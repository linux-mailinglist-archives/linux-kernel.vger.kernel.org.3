Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDEF55FEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiF2LcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiF2LcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:32:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22543EF0F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:32:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q6so31876790eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z7YdxvHVrANcl7/MwaXyOEvtHd06mWAjfHecZi9wxDA=;
        b=wGH6hq8FO42nMsH7uuRTjyg1xyAs0bk732kzq6bPIZKP0VVWLVmchGvj9wufryAbMo
         7EbCmPP9FkNAA5gjUP1pNiMUBQpHEvmLP0S30OiA++FnBwbAlKpc9MLUms6jkTLdjSCy
         dBeCogdBD6h+ETxna6DBOJw17214BgCxfr7+Ctyda3FWsG1Dnu1KWxS8VxeURS92tSmC
         K7qMbqF0eGzhSNME+tftxIeWCND/9y0h9zRR9DE6NLa6i+0639DI4Zg57KZ40NkKK0gA
         DgaReJvdAUvZrO5GjBW7M4kCsaxdbP9kOQ1F7VobumPa3sa3E68YFkr95E6aWjEQepk+
         tZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z7YdxvHVrANcl7/MwaXyOEvtHd06mWAjfHecZi9wxDA=;
        b=AlWP/gNYBJ2wwNrCBJwXTJIy5GE+msDNMcAni+V1/nAE11wf+fgHqEZPz015N9dTXq
         H1u4pSGk9mqx3gclL6u0yAA2gPyn6Bbmwu31rDRmywfILXdSt8jDEKucB9unPLHXd1qi
         IPppr3BgWeeEfihupYbgLdYHbnapIf04vabpThmCqM2Z6pEFXsuRto+wDnK53vjg2WPB
         LwoYJL1g1VpqSZzicEMWB7htU/VqU4pBWq4qU/C3+qkHIsdMwbdWEAnzx1a8P2NXni+z
         aToYm545O6X7pgj1Rnk5f5qKlbliTE4lAwxt5IL21qMb/U7HOAP/TNuX6UfzZDrHLdYF
         DGlg==
X-Gm-Message-State: AJIora/RmbRoG81ALrlQI613MbAU/H0lO+soDdJmd59D8j905gUAWn11
        bGptpi7Wr6rXIp7AUs2CfwJN+g==
X-Google-Smtp-Source: AGRyM1vCAkX9bFVsQfuTLGX2ok/ViPnL2u3W6VZSGnPeXBWryLaSYEnMX7e/7rGW7Grc+BVzqHHXaw==
X-Received: by 2002:a17:906:1ca:b0:715:73f3:b50f with SMTP id 10-20020a17090601ca00b0071573f3b50fmr2799072ejj.374.1656502324385;
        Wed, 29 Jun 2022 04:32:04 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id fx24-20020a170906b75800b006fec63e564bsm7616985ejb.30.2022.06.29.04.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:32:03 -0700 (PDT)
Message-ID: <479a021a-36eb-7b44-9e14-51e16d1b64fb@linaro.org>
Date:   Wed, 29 Jun 2022 13:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
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
Cc:     Thara Gopinath <thara.gopinath@gmail.com>
References: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
 <20220629075250.17610-5-krzysztof.kozlowski@linaro.org>
 <87b83a0c-0ea2-6839-1d90-8f1145ed9ed2@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87b83a0c-0ea2-6839-1d90-8f1145ed9ed2@quicinc.com>
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

On 29/06/2022 13:22, Rajendra Nayak wrote:
> 
> 
> On 6/29/2022 1:22 PM, Krzysztof Kozlowski wrote:
>> Add device node for CPU-memory BWMON device (bandwidth monitoring) on
>> SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
>> Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
>> votes from cpufreq (CPU nodes) thus achieve high memory throughput even
>> with lower CPU frequencies.
>>
>> Co-developed-by: Thara Gopinath <thara.gopinath@gmail.com>
>> Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 83e8b63f0910..e0f088996390 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -2026,6 +2026,44 @@ llcc: system-cache-controller@1100000 {
>>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>>   
>> +		pmu@1436400 {
>> +			compatible = "qcom,sdm845-cpu-bwmon", "qcom,msm8998-cpu-bwmon";
>> +			reg = <0 0x01436400 0 0x600>;
>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
>> +
>> +			operating-points-v2 = <&cpu_bwmon_opp_table>;
>> +
>> +			cpu_bwmon_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				/*
>> +				 * The interconnect paths bandwidths taken from
>> +				 * cpu4_opp_table bandwidth.
>> +				 * They also match different tables from
>> +				 * msm-4.9 downstream kernel:
>> +				 *  - the OSM L3 from bandwidth table of
>> +				 *    qcom,cpu4-l3lat-mon (qcom,core-dev-table);
>> +				 *    bus width: 16 bytes;
>> +				 */
> 
> Maybe the comment needs an update?

Yes, a bit.

Best regards,
Krzysztof
