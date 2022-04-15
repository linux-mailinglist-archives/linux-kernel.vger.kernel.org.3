Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF755027BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351929AbiDOJ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbiDOJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:58:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321641F8B;
        Fri, 15 Apr 2022 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650016579; x=1681552579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VrpavvN2et/QbhRDrwGN8VySKZUqco0Hd4HKgd+WwoA=;
  b=GGjArlmbOWcTwfpRMxMoyk/MYW4H+J4tdZluFSzsiXMnVBaa+85m5/Hn
   hCZUI3mzY/9O6NCtbaDZjXSydtDWVXJIdcnpuhT6p0QQcuL4FSHvAIrYh
   2cTTu6Bnk5jxQMolHcWsCN6cN7OtEJ2MOD/okCOP7fdXU8meYRX9HgEja
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 15 Apr 2022 02:56:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:56:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Apr 2022 02:56:18 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Apr
 2022 02:56:15 -0700
Message-ID: <81aaa184-65f1-427a-5db8-da051f413845@quicinc.com>
Date:   Fri, 15 Apr 2022 17:56:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware
 definitions
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com>
 <20220412125035.40312-4-quic_jinlmao@quicinc.com>
 <CAJ9a7VjZiYN6g+gPZRgc4fJQCJYcSXrdzRfT+kAiK0cwRfm+iA@mail.gmail.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAJ9a7VjZiYN6g+gPZRgc4fJQCJYcSXrdzRfT+kAiK0cwRfm+iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 4/14/2022 11:22 PM, Mike Leach wrote:
> Hi,
>
> On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>> Adds new coresight-tpdm.yaml file describing the bindings required
>> to define tpdm in the device trees.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../bindings/arm/coresight-tpdm.yaml          | 99 +++++++++++++++++++
>>   .../devicetree/bindings/arm/coresight.txt     |  7 ++
>>   MAINTAINERS                                   |  1 +
>>   3 files changed, 107 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>> new file mode 100644
>> index 000000000000..05210e0fc262
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
>> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
>> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
>> +
> These should be e-mail addresses of maintainers for this binding, not
> the coresight sub-system.
> See writing-schema.rst
I will update.
>
>> +properties:
>> +  $nodename:
>> +    pattern: "^tpdm(@[0-9a-f]+)$"
>> +  compatible:
>> +    items:
>> +      - const: qcom,coresight-tpdm
>> +      - const: arm,primecell
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +   items:
>> +     - const: apb_pclk
>> +
>> +  out-ports:
>> +    description: |
>> +      Output connections from the TPDM to coresight funnle/tpda.
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    properties:
>> +      port:
>> +        description: Output connection from the TPDM to coresight
>> +            funnel/tpda.
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
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> index c68d93a35b6c..f7ce8af48574 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -52,6 +52,10 @@ its hardware characteristcs.
>>                          "arm,coresight-cti", "arm,primecell";
>>                          See coresight-cti.yaml for full CTI definitions.
>>
>> +               - Trace, Profiling and Diagnostics Monitor (TPDM):
>> +                       "qcom,coresight-tpdm", "arm,primecell";
>> +                       See coresight-tpdm.yaml for full TPDM definitions.
>> +
>>          * reg: physical base address and length of the register
>>            set(s) of the component.
>>
>> @@ -82,6 +86,9 @@ its hardware characteristcs.
>>   * Required properties for Coresight Cross Trigger Interface (CTI)
>>          See coresight-cti.yaml for full CTI definitions.
>>
>> +* Required properties for Trace, Profiling and Diagnostics Monitor (TPDM)
>> +       See coresight-tpdm.yaml for full TPDM definitions.
>> +
>>   * Required properties for devices that don't show up on the AMBA bus, such as
>>     non-configurable replicators and non-configurable funnels:
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 61d9f114c37f..0d39bb37935d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1977,6 +1977,7 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
>>   F:     Documentation/ABI/testing/sysfs-bus-coresight-devices-*
>>   F:     Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
>>   F:     Documentation/devicetree/bindings/arm/coresight-cti.yaml
>> +F:     Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>>   F:     Documentation/devicetree/bindings/arm/coresight.txt
>>   F:     Documentation/devicetree/bindings/arm/ete.yaml
>>   F:     Documentation/devicetree/bindings/arm/trbe.yaml
>> --
>> 2.17.1
>>
> With the above:
> Reviewed by: Mike Leach <mike.leach@linaro.org>
