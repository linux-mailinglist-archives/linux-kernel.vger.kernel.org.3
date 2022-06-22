Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E5554877
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357773AbiFVLrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357760AbiFVLrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:47:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E16344D4;
        Wed, 22 Jun 2022 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655898466; x=1687434466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8tuqwvvGAA1I2+bfUhL95W2bszJ5rSEYU9bLqn3rgLU=;
  b=kpxf8nih8GC03J/TzPE3SSaPwYkDiQ+vS8uVVjduZMs5ji/jMQWb8EMA
   rSTSFsjVFYTvDnnoUOfgEgZJMcNfhs6wXu18/u5tI8DZiuEY3qb3Yu9sx
   VYdNRGOnAdVmhaF3N+flQ4QWZiV1Jnrkn7UP8e68NO9vAFW1+rF6kL8l0
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Jun 2022 04:47:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:47:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 04:47:44 -0700
Received: from [10.216.32.54] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 04:47:39 -0700
Message-ID: <bc423d7b-df03-d4e2-2898-0873db710943@quicinc.com>
Date:   Wed, 22 Jun 2022 17:16:48 +0530
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
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
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


On 6/1/2022 3:41 PM, Krzysztof Kozlowski wrote:
> Add device node for CPU-memory BWMON device (bandwidth monitoring) on
> SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
> Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
> votes from cpufreq (CPU nodes) thus achieve high memory throughput even
> with lower CPU frequencies.
> 
> Performance impact (SDM845-MTP RB3 board, linux next-20220422):
> 1. No noticeable impact when running with schedutil or performance
>     governors.
> 
> 2. When comparing to customized kernel with synced interconnects and
>     without bandwidth votes from CPU freq, the sysbench memory tests
>     show significant improvement with bwmon for blocksizes past the L3
>     cache.  The results for such superficial comparison:
> 
> sysbench memory test, results in MB/s (higher is better)
>   bs kB |  type |    V  | V+no bw votes | bwmon | benefit %
>       1 | W/seq | 14795 |          4816 |  4985 |      3.5%
>      64 | W/seq | 41987 |         10334 | 10433 |      1.0%
>    4096 | W/seq | 29768 |          8728 | 32007 |    266.7%
>   65536 | W/seq | 17711 |          4846 | 18399 |    279.6%
> 262144 | W/seq | 16112 |          4538 | 17429 |    284.1%
>      64 | R/seq | 61202 |         67092 | 66804 |     -0.4%
>    4096 | R/seq | 23871 |          5458 | 24307 |    345.4%
>   65536 | R/seq | 18554 |          4240 | 18685 |    340.7%
> 262144 | R/seq | 17524 |          4207 | 17774 |    322.4%
>      64 | W/rnd |  2663 |          1098 |  1119 |      1.9%
>   65536 | W/rnd |   600 |           316 |   610 |     92.7%
>      64 | R/rnd |  4915 |          4784 |  4594 |     -4.0%
>   65536 | R/rnd |   664 |           281 |   678 |    140.7%
> 
> Legend:
> bs kB: block size in KB (small block size means only L1-3 caches are
>        used
> type: R - read, W - write, seq - sequential, rnd - random
> V: vanilla (next-20220422)
> V + no bw votes: vanilla without bandwidth votes from CPU freq
> bwmon: bwmon without bandwidth votes from CPU freq
> benefit %: difference between vanilla without bandwidth votes and bwmon
>             (higher is better)
> 
> Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 54 ++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 83e8b63f0910..adffb9c70566 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		pmu@1436400 {
> +			compatible = "qcom,sdm845-cpu-bwmon";
> +			reg = <0 0x01436400 0 0x600>;
> +
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnect-names = "ddr", "l3c";

Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?
Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?

> +
> +			operating-points-v2 = <&cpu_bwmon_opp_table>;
> +
> +			cpu_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/*
> +				 * The interconnect paths bandwidths taken from
> +				 * cpu4_opp_table bandwidth.
> +				 * They also match different tables from
> +				 * msm-4.9 downstream kernel:
> +				 *  - the gladiator_noc-mem_noc from bandwidth
> +				 *    table of qcom,llccbw (property qcom,bw-tbl);
> +				 *    bus width: 4 bytes;
> +				 *  - the OSM L3 from bandwidth table of
> +				 *    qcom,cpu4-l3lat-mon (qcom,core-dev-table);
> +				 *    bus width: 16 bytes;
> +				 */
> +				opp-0 {
> +					opp-peak-kBps = <800000 4800000>;
> +				};
> +				opp-1 {
> +					opp-peak-kBps = <1804000 9216000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <2188000 11980800>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <3072000 15052800>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <4068000 19353600>;
> +				};
> +				opp-5 {
> +					opp-peak-kBps = <5412000 20889600>;
> +				};
> +				opp-6 {
> +					opp-peak-kBps = <6220000 22425600>;
> +				};
> +				opp-7 {
> +					opp-peak-kBps = <7216000 25497600>;
> +				};
> +			};
> +		};
> +
>   		pcie0: pci@1c00000 {
>   			compatible = "qcom,pcie-sdm845";
>   			reg = <0 0x01c00000 0 0x2000>,
