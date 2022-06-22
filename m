Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D64554BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357717AbiFVNxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357640AbiFVNw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:52:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43F0BA0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:52:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v1so34349279ejg.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i58AvAf3xFLhQ/L4OE2PIGkyGZEELgf2pk8ePev6kB4=;
        b=ZkBEZC+r/wMombXRguzU+DolPji+n50SYFb6A0PR3PacPtUpGCNYgvsZVodwBvhB+Y
         HrormOXJ+myRBnLX1j5uZOwGsLSXr9ktsBD6s6AwWO/tz+1mPzzjLyQgYzQID2Rj43GW
         OPbZM2TqykrzmCbZcIYyQpswfX0SbmVk21uxtoCDAriIIcSFrEnyXqlH7+vQ3o4S/FMW
         iiHreXsvl9piaIunAUaUmlNdw39EhsXKLbw+UBzxjHCUtuvb6c/sxy9Vd0L9F+jg2O1r
         /CroBhvjd8bv0uW0EjJE5ocqOhWF9BeMROOIPhEnMlYVCH0HypyoKfUAdyiBvH6ynf/H
         w7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i58AvAf3xFLhQ/L4OE2PIGkyGZEELgf2pk8ePev6kB4=;
        b=zPEOvmxj9DPRY8AAaTxgXoqNhnFA2h0+n+HtFMVhZmRcesAG1LLtOvpaibh2KjKo6A
         4Qk+Fb37yb/HaNvUqNh+lQi/4LcctSLkgflke0JhQTDJ7CLu5vcdI/AzmDnbrNIc1QFr
         ZgAoZss9p02BcbTkTc1oPtRy0L78vNhfY+UXluEdxfBaiSudxQPimrBrUxStuUUGaJFj
         38o+UulsCf4AQM8KUKIX/KIkOHXhQT3geTZXGvcXzdztWAhIS0/Xg224qyGDcIhPVsCk
         ZSoyx96VCb8uykoHHCieF6D4bZWvEzmSs/NQE6O+QqjSufM/YdGxewEb9ka/2v26yORK
         00yw==
X-Gm-Message-State: AJIora/19S8arbax8gqtwrWXT47yKbMss65fxLtevUO0CPjqtEOjNPUY
        WFt6FFLJpLDxLXdbMbzcJF8dIA==
X-Google-Smtp-Source: AGRyM1vah6C9m/j0HXJ9FZUYU4HSpCWgqDbDo7mMu1bIGnoxi3GAUHrMtda/2yQgJJS6TrXv5OUtPA==
X-Received: by 2002:a17:906:33db:b0:70f:12c0:4ade with SMTP id w27-20020a17090633db00b0070f12c04ademr3286585eja.320.1655905971223;
        Wed, 22 Jun 2022 06:52:51 -0700 (PDT)
Received: from [192.168.0.224] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kx10-20020a170907774a00b00722df6db8f3sm3296099ejc.115.2022.06.22.06.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 06:52:50 -0700 (PDT)
Message-ID: <64eb52ee-b3ac-3d94-cfce-ceb1c88dddb6@linaro.org>
Date:   Wed, 22 Jun 2022 15:52:49 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bc423d7b-df03-d4e2-2898-0873db710943@quicinc.com>
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

On 22/06/2022 13:46, Rajendra Nayak wrote:
> 
> On 6/1/2022 3:41 PM, Krzysztof Kozlowski wrote:
>> Add device node for CPU-memory BWMON device (bandwidth monitoring) on
>> SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
>> Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
>> votes from cpufreq (CPU nodes) thus achieve high memory throughput even
>> with lower CPU frequencies.
>>
>> Performance impact (SDM845-MTP RB3 board, linux next-20220422):
>> 1. No noticeable impact when running with schedutil or performance
>>     governors.
>>
>> 2. When comparing to customized kernel with synced interconnects and
>>     without bandwidth votes from CPU freq, the sysbench memory tests
>>     show significant improvement with bwmon for blocksizes past the L3
>>     cache.  The results for such superficial comparison:
>>
>> sysbench memory test, results in MB/s (higher is better)
>>   bs kB |  type |    V  | V+no bw votes | bwmon | benefit %
>>       1 | W/seq | 14795 |          4816 |  4985 |      3.5%
>>      64 | W/seq | 41987 |         10334 | 10433 |      1.0%
>>    4096 | W/seq | 29768 |          8728 | 32007 |    266.7%
>>   65536 | W/seq | 17711 |          4846 | 18399 |    279.6%
>> 262144 | W/seq | 16112 |          4538 | 17429 |    284.1%
>>      64 | R/seq | 61202 |         67092 | 66804 |     -0.4%
>>    4096 | R/seq | 23871 |          5458 | 24307 |    345.4%
>>   65536 | R/seq | 18554 |          4240 | 18685 |    340.7%
>> 262144 | R/seq | 17524 |          4207 | 17774 |    322.4%
>>      64 | W/rnd |  2663 |          1098 |  1119 |      1.9%
>>   65536 | W/rnd |   600 |           316 |   610 |     92.7%
>>      64 | R/rnd |  4915 |          4784 |  4594 |     -4.0%
>>   65536 | R/rnd |   664 |           281 |   678 |    140.7%
>>
>> Legend:
>> bs kB: block size in KB (small block size means only L1-3 caches are
>>        used
>> type: R - read, W - write, seq - sequential, rnd - random
>> V: vanilla (next-20220422)
>> V + no bw votes: vanilla without bandwidth votes from CPU freq
>> bwmon: bwmon without bandwidth votes from CPU freq
>> benefit %: difference between vanilla without bandwidth votes and bwmon
>>             (higher is better)
>>
>> Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 54 ++++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 83e8b63f0910..adffb9c70566 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>>   
>> +		pmu@1436400 {
>> +			compatible = "qcom,sdm845-cpu-bwmon";
>> +			reg = <0 0x01436400 0 0x600>;
>> +
>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>> +			interconnect-names = "ddr", "l3c";
> 
> Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?

To my understanding this is the one between CPU and caches.

> Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?

The interconnects are the same as ones used for CPU nodes, therefore if
we want to scale both when scaling CPU, then we also want to scale both
when seeing traffic between CPU and cache.

Maybe the assumption here is not correct, so basically the two
interconnects in CPU nodes are also not proper?


Best regards,
Krzysztof
