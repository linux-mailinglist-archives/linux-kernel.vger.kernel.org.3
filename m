Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8848C57E590
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiGVRa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiGVRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:30:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DDB3ED4F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:30:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z22so8721119lfu.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t7veweybfk179UKb3IrKCj03NDdZ/nZzV2xlu4JwTvY=;
        b=fTr3nDukdMHnjKx6uluoCUVKArChghwSQVlLC95LtJoIOzZUBplkH96Ev/HvC9u4vT
         PtjX7MKC0woAjFWYCXfayxLdNaZXxahDfey8ymfG1o09wTowceMfOqCj8wwzXPtN3RWK
         nUnd66s8ZSNw06b8nruU+EcB1cSbWOnlsUh/twQm4sosNyKAxMDTf0RuVL6algAqMhw5
         RU15IYmlaere/r/cmEtq80mxEQhy8jazZ3D/d5w7kdEX9TmKGLZ0dZIcG7pQNmbxKASa
         okmJJCdtREThG3Y82TFJCOxfPHY9hdUwrVco2SPfx+7yIWQgXcaoNYP4VdGksLLXSB8Z
         AZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t7veweybfk179UKb3IrKCj03NDdZ/nZzV2xlu4JwTvY=;
        b=3CDR6iztwNdBc35JDtNiYn9njh3nh/ruc54vm+p138JfuO1ppCdC+10oxA1/VFe495
         OeXhc/eMt24H4NdXFpUqYNzhyreQ9exHPghg25aXY0KXnGXSc9PJhzjTvcD4AqacdkNj
         5n0/ydnoXZQiq1SRsllEQFaJOIvSNcdd+xrITsOXM5AR0a2Y1NssiRHgCyCL4BYW30kI
         LrIygXJmE8tinijMyJ6BcHLKFkmwiDgv1WAOWwVG+drOnSF88uldA6VHwQCNItJmNsr3
         +D6xcIwzdIjqGyy52WrvSLtiZ0XgRenQLM0xtLsA+h5v5rmRKskl5p5vjpOp/6x3IbqE
         3WVQ==
X-Gm-Message-State: AJIora+mkwSVapfc6l26sPaQB/h+0EQ6RdFSuU94ixvBBk+RyW2gCv+K
        aHzhh5p+B2WPL2pePPjwjaLVfA==
X-Google-Smtp-Source: AGRyM1siPOzdeE10dzF1RJ3lwq97+AZtUXchbYEQBCidalf1ASbVKSR6WXG1WpaNUU5I14Nq/ewfag==
X-Received: by 2002:a05:6512:3d19:b0:48a:7d10:b972 with SMTP id d25-20020a0565123d1900b0048a7d10b972mr290173lfv.615.1658511053797;
        Fri, 22 Jul 2022 10:30:53 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id o18-20020ac24c52000000b0047f933622c8sm1162386lfk.163.2022.07.22.10.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:30:53 -0700 (PDT)
Message-ID: <96552a95-8939-3ac2-c9b3-14dabaf53923@linaro.org>
Date:   Fri, 22 Jul 2022 19:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <25673493-4171-62b0-f696-1316d115f388@kali.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 03:22, Steev Klimaszewski wrote:
> Hi Krzysztof,
> 
> On 7/20/22 2:28 PM, Krzysztof Kozlowski wrote:
>> The SDM845 comes with few instances of Bandwidth Monitor.  The already
>> supported one monitors traffic between CPU and Last Level Cache
>> Controller (LLCC) and in downstream sources is called BWMON v4 (or v4 of
>> register layout).
>>
>> SDM845 also has also BWMON instance measuring traffic between LLCC and
>> memory with different register layout: called v5.
>>
>> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index fe14f7e7523b..4aab464e2bd6 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -2053,6 +2053,43 @@ llcc: system-cache-controller@1100000 {
>>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>>   
>> +		pmu@114a000 {
>> +			compatible = "qcom,sdm845-llcc-bwmon";
>> +			reg = <0 0x0114a000 0 0x1000>;
>> +			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
>> +			interconnects = <&mem_noc MASTER_LLCC 3 &mem_noc SLAVE_EBI1 3>;
>> +
>> +			operating-points-v2 = <&llcc_bwmon_opp_table>;
>> +
>> +			llcc_bwmon_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				/*
>> +				 * The interconnect path bandwidth taken from
>> +				 * cpu4_opp_table bandwidth for gladiator_noc-mem_noc
>> +				 * interconnect.  This also matches the
>> +				 * bandwidth table of qcom,llccbw (qcom,bw-tbl,
>> +				 * bus width: 4 bytes) from msm-4.9 downstream
>> +				 * kernel.
>> +				 */
>> +				opp-0 {
>> +					opp-peak-kBps = <800000>;
>> +				};
>> +				opp-1 {
>> +					opp-peak-kBps = <1804000>;
>> +				};
>> +				opp-2 {
>> +					opp-peak-kBps = <3072000>;
>> +				};
>> +				opp-3 {
>> +					opp-peak-kBps = <5412000>;
>> +				};
>> +				opp-4 {
>> +					opp-peak-kBps = <7216000>;
>> +				};
>> +			};
>> +		};
>> +
>>   		pmu@1436400 {
>>   			compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
>>   			reg = <0 0x01436400 0 0x600>;
> 
> 
> With this series applied, testing on a Lenovo Yoga C630, which has an 
> SDM850, I see the following:
> 
> [    3.673660] qcom-bwmon 114a000.pmu: can't request region for resource 
> [mem 0x0114a000-0x0114afff]
> [    3.673673] qcom-bwmon 114a000.pmu: error -EBUSY: failed to map bwmon 
> registers
> [    3.673678] qcom-bwmon: probe of 114a000.pmu failed with error -16
> 

Thanks for the report. What are you running there? `uname -r`? Maybe
your secure world uses it?

Best regards,
Krzysztof
