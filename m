Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FBD55FE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiF2LXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiF2LXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:23:03 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECCC21E37;
        Wed, 29 Jun 2022 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656501782; x=1688037782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oi/Y3Lwem/ep9m5oRQmqeMMbPdIOqFH+Z1EL7otxjlA=;
  b=ZylyCAJEFCCgjx3KzRq/7yYWN3eZzYQTwFmMBt4gunKGKyVFl1RZ/Ab/
   Jl7tATVeI9nNyOkWV+UlAEEk/9AyUh7xQnIMDR6JB+wGF2EsyXu09BInl
   TUlcBh9eNOHA2PWj04NNbNZ4vMPpCKFVvDEFtVOltL/EWaFFxckimQJSV
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Jun 2022 04:23:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:23:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 29 Jun 2022 04:23:01 -0700
Received: from [10.216.26.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 29 Jun
 2022 04:22:55 -0700
Message-ID: <87b83a0c-0ea2-6839-1d90-8f1145ed9ed2@quicinc.com>
Date:   Wed, 29 Jun 2022 16:52:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
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
CC:     Thara Gopinath <thara.gopinath@gmail.com>
References: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
 <20220629075250.17610-5-krzysztof.kozlowski@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220629075250.17610-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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



On 6/29/2022 1:22 PM, Krzysztof Kozlowski wrote:
> Add device node for CPU-memory BWMON device (bandwidth monitoring) on
> SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
> Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
> votes from cpufreq (CPU nodes) thus achieve high memory throughput even
> with lower CPU frequencies.
> 
> Co-developed-by: Thara Gopinath <thara.gopinath@gmail.com>
> Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 83e8b63f0910..e0f088996390 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2026,6 +2026,44 @@ llcc: system-cache-controller@1100000 {
>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		pmu@1436400 {
> +			compatible = "qcom,sdm845-cpu-bwmon", "qcom,msm8998-cpu-bwmon";
> +			reg = <0 0x01436400 0 0x600>;
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
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
> +				 *  - the OSM L3 from bandwidth table of
> +				 *    qcom,cpu4-l3lat-mon (qcom,core-dev-table);
> +				 *    bus width: 16 bytes;
> +				 */

Maybe the comment needs an update?

> +				opp-0 {
> +					opp-peak-kBps = <4800000>;
> +				};
> +				opp-1 {
> +					opp-peak-kBps = <9216000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <15052800>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <20889600>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <25497600>;
> +				};
> +			};
> +		};
> +
>   		pcie0: pci@1c00000 {
>   			compatible = "qcom,pcie-sdm845";
>   			reg = <0 0x01c00000 0 0x2000>,
