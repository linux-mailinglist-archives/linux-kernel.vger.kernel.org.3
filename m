Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2D5440F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiFIBNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFIBM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:12:58 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13E424BA;
        Wed,  8 Jun 2022 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654737176; x=1686273176;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=06zP1AL9u1zzGGm8hB/0bmU7bVi5Ty8PW+dVOKeQnj4=;
  b=I/3FszAPRmJz8KMUboUT/dGD7jQq7LiCz9EbPgA4v//xQYMiUR4L+Ocl
   lFCN6+9E9sSS7TA9UsKhn8XHRvINI4wRvReeCO422aGXcVqIhR0EzUNVL
   O+fN0bnMI7JWCOEgk6ooRTDUBFpI+QzXGruOdExhZ4AjVGrSPtmF4wsFF
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Jun 2022 18:12:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 18:12:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 18:12:55 -0700
Received: from [10.253.11.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 18:12:50 -0700
Message-ID: <7f525d11-c738-4f45-1821-d1c617cd6401@quicinc.com>
Date:   Thu, 9 Jun 2022 09:12:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware
 definitions
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220608154705.40322-1-quic_jinlmao@quicinc.com>
 <20220608154705.40322-4-quic_jinlmao@quicinc.com>
 <20220608220150.GA2137312-robh@kernel.org>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20220608220150.GA2137312-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Rob for the review of the yaml changes.

I will check and address all you comments.

On 6/9/2022 6:01 AM, Rob Herring wrote:
> On Wed, Jun 08, 2022 at 11:46:58PM +0800, Mao Jinlong wrote:
>> Adds new coresight-tpdm.yaml file describing the bindings required
>> to define tpdm in the device trees.
>>
>> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Reviewed-by: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../bindings/arm/coresight-tpdm.yaml          | 99 +++++++++++++++++++
> qcom,coresight-tpdm.yaml
>
>>   .../devicetree/bindings/arm/coresight.txt     |  7 ++
> This file is going away[1]. I'd just drop the changes to it.
>
>>   MAINTAINERS                                   |  1 +
>>   3 files changed, 107 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>> new file mode 100644
>> index 000000000000..14bef4ce4274
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>> @@ -0,0 +1,99 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/coresight-tpdm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Trace, Profiling and Diagnostics Monitor - TPDM
>> +
>> +description: |
>> +  The TPDM or Monitor serves as data collection component for various dataset
>> +  types specified in the QPMDA spec. It covers Implementation defined ((ImplDef),
>> +  Basic Counts (BC), Tenure Counts (TC), Continuous Multi-Bit (CMB), and Discrete
>> +  Single Bit (DSB). It performs data collection in the data producing clock
>> +  domain and transfers it to the data collection time domain, generally ATB
>> +  clock domain.
>> +
>> +  The primary use case of the TPDM is to collect data from different data
>> +  sources and send it to a TPDA for packetization, timestamping, and funneling.
>> +
>> +maintainers:
>> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
>> +  - Tao Zhang <quic_taozha@quicinc.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^tpdm(@[0-9a-f]+)$"
> blank line
>
>> +  compatible:
>> +    items:
>> +      - const: qcom,coresight-tpdm
>> +      - const: arm,primecell
> You need a 'select' to fix the errors reported. See other primecell
> bindings.
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: apb_pclk
>> +
>> +  out-ports:
>> +    description: |
>> +      Output connections from the TPDM to coresight funnle/tpda.
> typo
>
>> +    $ref: /schemas/graph.yaml#/properties/ports
> blank line here.
>
>> +    properties:
>> +      port:
>> +        description: Output connection from the TPDM to coresight
>> +            funnel/tpda.
> s/tpda/TPDA/
>
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  # minimum TPDM definition. TPDM connect to coresight funnel.
>> +  - |
>> +    tpdm@6980000 {
>> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +      reg = <0x6980000 0x1000>;
>> +
>> +      clocks = <&aoss_qmp>;
>> +      clock-names = "apb_pclk";
>> +
>> +      out-ports {
>> +        port {
>> +          tpdm_turing_out_funnel_turing: endpoint {
>> +            remote-endpoint =
>> +              <&funnel_turing_in_tpdm_turing>;
>> +          };
>> +        };
>> +      };
>> +    };
>> +  # minimum TPDM definition. TPDM connect to coresight TPDA.
>> +  - |
> The only difference in the 2 examples is some external phandle. 1
> example is sufficient.
>
>> +    tpdm@684c000 {
>> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +      reg = <0x684c000 0x1000>;
>> +
>> +      clocks = <&aoss_qmp>;
>> +      clock-names = "apb_pclk";
>> +
>> +      out-ports {
>> +        port {
>> +          tpdm_prng_out_tpda_qdss: endpoint {
>> +            remote-endpoint =
>> +              <&tpda_qdss_in_tpdm_prng>;
>> +          };
>> +        };
>> +      };
>> +    };
>> +
>> +...
> Rob
>
> [1] https://lore.kernel.org/all/20220603011933.3277315-1-robh@kernel.org/
