Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1078155734E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiFWGs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiFWGsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:48:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672503FD82;
        Wed, 22 Jun 2022 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655966933; x=1687502933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cjAD+DIGXjOAOcIdY6Uks9HWKjVnPOfjgnTGNLABEtE=;
  b=AQbFUYy8wtW2fzCTwhAMs6rR+5llrmFXzO1Xn6qZEZfuXkjh9MYdcg0Y
   Q+Xcl+VrfAcJUsVAIk2CYwYKzSU6GJjjhqz0XBgLcLLjiwwNiS/uumgD4
   6C+afh4RviXrXInBUi2gam85iax2iHr7k8//RBMRaCd/wFiIm66z/71OY
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 22 Jun 2022 23:48:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 23:48:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 23:48:52 -0700
Received: from [10.216.32.54] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 23:48:46 -0700
Message-ID: <042cb765-113b-9335-edae-595addf50dd0@quicinc.com>
Date:   Thu, 23 Jun 2022 12:18:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Georgi Djakov" <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
 <bc423d7b-df03-d4e2-2898-0873db710943@quicinc.com>
 <64eb52ee-b3ac-3d94-cfce-ceb1c88dddb6@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <64eb52ee-b3ac-3d94-cfce-ceb1c88dddb6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/2022 7:22 PM, Krzysztof Kozlowski wrote:
> On 22/06/2022 13:46, Rajendra Nayak wrote:
>>
>> On 6/1/2022 3:41 PM, Krzysztof Kozlowski wrote:
>>> Add device node for CPU-memory BWMON device (bandwidth monitoring) on
>>> SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
>>> Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
>>> votes from cpufreq (CPU nodes) thus achieve high memory throughput even
>>> with lower CPU frequencies.
>>>
>>> Performance impact (SDM845-MTP RB3 board, linux next-20220422):
>>> 1. No noticeable impact when running with schedutil or performance
>>>      governors.
>>>
>>> 2. When comparing to customized kernel with synced interconnects and
>>>      without bandwidth votes from CPU freq, the sysbench memory tests
>>>      show significant improvement with bwmon for blocksizes past the L3
>>>      cache.  The results for such superficial comparison:
>>>
>>> sysbench memory test, results in MB/s (higher is better)
>>>    bs kB |  type |    V  | V+no bw votes | bwmon | benefit %
>>>        1 | W/seq | 14795 |          4816 |  4985 |      3.5%
>>>       64 | W/seq | 41987 |         10334 | 10433 |      1.0%
>>>     4096 | W/seq | 29768 |          8728 | 32007 |    266.7%
>>>    65536 | W/seq | 17711 |          4846 | 18399 |    279.6%
>>> 262144 | W/seq | 16112 |          4538 | 17429 |    284.1%
>>>       64 | R/seq | 61202 |         67092 | 66804 |     -0.4%
>>>     4096 | R/seq | 23871 |          5458 | 24307 |    345.4%
>>>    65536 | R/seq | 18554 |          4240 | 18685 |    340.7%
>>> 262144 | R/seq | 17524 |          4207 | 17774 |    322.4%
>>>       64 | W/rnd |  2663 |          1098 |  1119 |      1.9%
>>>    65536 | W/rnd |   600 |           316 |   610 |     92.7%
>>>       64 | R/rnd |  4915 |          4784 |  4594 |     -4.0%
>>>    65536 | R/rnd |   664 |           281 |   678 |    140.7%
>>>
>>> Legend:
>>> bs kB: block size in KB (small block size means only L1-3 caches are
>>>         used
>>> type: R - read, W - write, seq - sequential, rnd - random
>>> V: vanilla (next-20220422)
>>> V + no bw votes: vanilla without bandwidth votes from CPU freq
>>> bwmon: bwmon without bandwidth votes from CPU freq
>>> benefit %: difference between vanilla without bandwidth votes and bwmon
>>>              (higher is better)
>>>
>>> Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sdm845.dtsi | 54 ++++++++++++++++++++++++++++
>>>    1 file changed, 54 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index 83e8b63f0910..adffb9c70566 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>>>    			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>>    		};
>>>    
>>> +		pmu@1436400 {
>>> +			compatible = "qcom,sdm845-cpu-bwmon";
>>> +			reg = <0 0x01436400 0 0x600>;
>>> +
>>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>>> +			interconnect-names = "ddr", "l3c";
>>
>> Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?
> 
> To my understanding this is the one between CPU and caches.

Ok, but then because the OPP table lists the DDR bw first and Cache bw second, isn't the driver
ending up comparing the bw values thrown by the pmu against the DDR bw instead of the Cache BW?
Atleast with my testing on sc7280 I found this to mess things up and I always was ending up at
higher OPPs even while the system was completely idle. Comparing the values against the Cache bw
fixed it.(sc7280 also has a bwmon4 instance between the cpu and caches and a bwmon5 between the cache
and DDR)

> 
>> Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?
> 
> The interconnects are the same as ones used for CPU nodes, therefore if
> we want to scale both when scaling CPU, then we also want to scale both
> when seeing traffic between CPU and cache.

Well, they were both associated with the CPU node because with no other input to decide on _when_
to scale the caches and DDR, we just put a mapping table which simply mapped a CPU freq to a L3 _and_
DDR freq. So with just one input (CPU freq) we decided on what should be both the L3 freq and DDR freq.

Now with 2 pmu's, we have 2 inputs, so we can individually scale the L3 based on the cache PMU
counters and DDR based on the DDR PMU counters, no?

Since you said you have plans to add the other pmu support as well (bwmon5 between the cache and DDR)
how else would you have the OPP table associated with that pmu instance? Would you again have both the
L3 and DDR scale based on the inputs from that bwmon too?

> 
> Maybe the assumption here is not correct, so basically the two
> interconnects in CPU nodes are also not proper?
> 
> 
> Best regards,
> Krzysztof
