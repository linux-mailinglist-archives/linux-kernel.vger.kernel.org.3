Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F495618D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiF3LOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiF3LOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:14:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F944579E;
        Thu, 30 Jun 2022 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656587677; x=1688123677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NZB5eT/e1Inc1VOY7M0kCfqzfvY8zcHVSIKYNkjKTxI=;
  b=rnJPqlCJdij/kgH+Svk2qFpfLarGyCSlBstebonEY6Xm6vuTfa+jkuKq
   md0zHIeLyr7YdY4Ul1TQSA8kupTSFtAxLvqKHp3eD3qPPrcJwgL/sYeGi
   zpEFDpUGrXruh4fZw2m+/ByPKteXXDAuWhJ0SPpUsfRxClDkxajVz6P9/
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Jun 2022 04:14:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 04:14:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 30 Jun 2022 04:14:35 -0700
Received: from [10.216.5.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 30 Jun
 2022 04:14:30 -0700
Message-ID: <55cf5a2f-7be2-bb65-09d6-d4d5af4d2f0f@quicinc.com>
Date:   Thu, 30 Jun 2022 16:44:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/4] dt-bindings: interconnect: qcom,msm8998-cpu-bwmon:
 add BWMON device
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
CC:     Rob Herring <robh@kernel.org>
References: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
 <20220629140302.236715-2-krzysztof.kozlowski@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220629140302.236715-2-krzysztof.kozlowski@linaro.org>
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


On 6/29/2022 7:32 PM, Krzysztof Kozlowski wrote:
> Add bindings for the Qualcomm Bandwidth Monitor device providing
> performance data on interconnects.  The bindings describe only BWMON CPU
> (version 4), e.g. the instance which appeared for the first on Qualcomm
> MSM8998 SoC and is also used on SDM845.  This BWMON device sits between
> CPU and Last Level Cache Controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Georgi Djakov <djakov@kernel.org>
> ---
>   .../interconnect/qcom,msm8998-llcc-bwmon.yaml | 85 +++++++++++++++++++
>   1 file changed, 85 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
> new file mode 100644
> index 000000000000..76e09658d615
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8998-llcc-bwmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Interconnect Bandwidth Monitor
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description: |
> +  Bandwidth Monitor measures current throughput on buses between various NoC
> +  fabrics and provides information when it crosses configured thresholds.
> +
> +  Certain SoCs might have more than one Bandwidth Monitors, for example on SDM845::
> +   - Measuring the bandwidth between CPUs and Last Level Cache Controller -
> +     called LLCC BWMON,
> +   - Measuring the bandwidth between Last Level Cache Controller and memory (DDR).
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,sdm845-llcc-bwmon
> +          - const: qcom,msm8998-llcc-bwmon
> +      - const: qcom,msm8998-llcc-bwmon       # BWMON v4
> +
> +  interconnects:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  operating-points-v2: true
> +  opp-table: true
> +
> +  reg:
> +    # BWMON v4 (currently described) and BWMON v5 use one register address
> +    # space.  BWMON v2 uses two register spaces - not yet described.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interconnects
> +  - interrupts
> +  - operating-points-v2
> +  - opp-table
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pmu@1436400 {
> +        compatible = "qcom,sdm845-llcc-bwmon", "qcom,msm8998-llcc-bwmon";

so with this compatible fallback scheme, I am trying to understand what
do I need to do if I have to add support for another SoC for instance.

I just update the binding with the new SoC compatible (lets say qcom,sc7280-llcc-bwmon)
and in the device tree node use it as
	compatible = "qcom,sc7280-llcc-bwmon", "qcom,sdm845-llcc-bwmon", "qcom,msm8998-llcc-bwmon";
without any updates in the driver?

> +        reg = <0x01436400 0x600>;
> +        interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +        interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
> +
> +        operating-points-v2 = <&llcc_bwmon_opp_table>;
> +
> +        llcc_bwmon_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +            opp-0 {
> +                opp-peak-kBps = <4800000>;
> +            };
> +            opp-1 {
> +                opp-peak-kBps = <9216000>;
> +            };
> +            opp-2 {
> +                opp-peak-kBps = <15052800>;
> +            };
> +            opp-3 {
> +                opp-peak-kBps = <20889600>;
> +            };
> +            opp-4 {
> +                opp-peak-kBps = <25497600>;
> +            };
> +        };
> +    };
