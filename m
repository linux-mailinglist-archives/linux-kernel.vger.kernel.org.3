Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F0B532428
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiEXHec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiEXHeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:34:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F062A20;
        Tue, 24 May 2022 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653377663; x=1684913663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xf83HbWSewZOtUqxluU9V0XX91cw1noJDgM/vmgA17I=;
  b=aNlNa7890SlpyEtINVyO7Qy7kBo7jgZMmQ5nVds5tV2ijdy8nZF2kDiV
   1GZN6I95RvykA1aJd4CNoq/0r3uptroBAGzh4IJLyDFQjGjpz0imAgQg6
   sClPihsT/EjY9t6asPoU7x87zUbzFjo3p2NZIPGbO7EnSxxBIun0A0Hwq
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 May 2022 00:34:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:34:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 00:34:20 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 00:34:16 -0700
Message-ID: <e253eff9-7eb2-e8ec-d27b-4727e853b07a@quicinc.com>
Date:   Tue, 24 May 2022 15:34:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 08/10] dt-bindings: arm: Adds CoreSight TPDA hardware
 definitions
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
 <20220509133947.20987-9-quic_jinlmao@quicinc.com>
 <beba5968-3115-3c09-cda6-67095ca55226@arm.com>
 <CAL_JsqK8Z_J2xaOsBM-U4hhHPgQCudd=SGmPqwdipArWmTXJYw@mail.gmail.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAL_JsqK8Z_J2xaOsBM-U4hhHPgQCudd=SGmPqwdipArWmTXJYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob and Suzuki for the review.

I will fix the warning and update in next version.

On 5/23/2022 10:24 PM, Rob Herring wrote:
> On Mon, May 23, 2022 at 4:44 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> Cc: Rob Herring
>>
> Will or will not have any effect...
>
> Please use get_maintainers.pl and send your patches to the right
> lists/maintainers. DT patches only get reviewed if sent to DT list. So
> please resend to the DT list. But before you do, I can tell this
> binding hasn't been tested so fix all the warnings first.
>
> Rob
>
>>
>> On 09/05/2022 14:39, Mao Jinlong wrote:
>>> Adds new coresight-tpda.yaml file describing the bindings required
>>> to define tpda in the device trees.
>>>
>>> Reviewed-by: Mike Leach <mike.leach@linaro.org>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>    .../bindings/arm/coresight-tpda.yaml          | 119 ++++++++++++++++++
>>>    MAINTAINERS                                   |   1 +
>>>    2 files changed, 120 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>>> new file mode 100644
>>> index 000000000000..4948ac13e7f8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>>> @@ -0,0 +1,119 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>>> +# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/coresight-tpda.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Trace, Profiling and Diagnostics Aggregator - TPDA
>>> +
>>> +description: |
>>> +  TPDAs are responsible for packetization and timestamping of data sets
>>> +  utilizing the MIPI STPv2 packet protocol. Pulling data sets from one or
>>> +  more attached TPDM and pushing the resultant (packetized) data out a
>>> +  master ATB interface. Performing an arbitrated ATB interleaving (funneling)
>>> +  task for free-flowing data from TPDM (i.e. CMB and DSB data set flows).
>>> +
>>> +maintainers:
>>> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
>>> +  - Tao Zhang <quic_taozha@quicinc.com>
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^tpda(@[0-9a-f]+)$"
>>> +  compatible:
>>> +    items:
>>> +      - const: qcom,coresight-tpda
>>> +      - const: arm,primecell
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: apb_pclk
>>> +
>>> +  in-ports:
>>> +    type: object
>>> +    description: |
>>> +      Input connections from TPDM to TPDA
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>> --->8---
>>> +    properties:
>>> +      '#address-cells':
>>> +        const: 1
>>> +
>>> +      '#size-cells':
>>> +        const: 0
>>> +
>>> +    patternProperties:
>>> +      "^port@[0-9a-f]+$":
>>> +        type: object
>>> +        required:
>>> +          - reg
>>> +
>>> +    required:
>>> +      - '#size-cells'
>>> +      - '#address-cells'
>> ---8<---
>>
>> I believe the above snippet is not needed and is covered by the generic
>> ports.
>>
>>
>>> +
>>> +  out-ports:
>>> +    type: object
>>> +    description: |
>>> +      Output connections from the TPDA to legacy CoreSight trace bus.
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>> +    properties:
>>> +     port:
>>> +       description:
>>> +         Output connection from the TPDA to legacy CoreSight Trace bus.
>>> +       $ref: /schemas/graph.yaml#/properties/port
>>> +
>>> +required:
>>> +    - compatible
>>> +    - reg
>>> +    - clocks
>>> +    - clock-names
>>> +    - in-ports
>>> +    - out-ports
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  # minimum tpda definition.
>>> +  - |
>>> +    tpda@6004000 {
>>> +       compatible = "qcom,coresight-tpda", "arm,primecell";
>>> +       reg = <0x6004000 0x1000>;
>>> +
>>> +       qcom,tpda-atid = <65>;
>>> +
>>> +       clocks = <&aoss_qmp>;
>>> +       clock-names = "apb_pclk";
>>> +
>>> +       in-ports {
>>> +         #address-cells = <1>;
>>> +         #size-cells = <0>;
>>> +
>>> +        port@0 {
>>> +          reg = <0>;
>>> +          tpda_qdss_0_in_tpdm_dcc: endpoint {
>>> +            remote-endpoint =
>>> +              <&tpdm_dcc_out_tpda_qdss_0>;
>>> +            };
>>> +        };
>>> +      };
>>> +
>>> +       out-ports {
>>> +         port {
>>> +                 tpda_qdss_out_funnel_in0: endpoint {
>>> +                    remote-endpoint =
>>> +                    <&funnel_in0_in_tpda_qdss>;
>>> +                  };
>>> +          };
>>> +       };
>>> +    };
>>> +
>>> +...
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 28d32b3f3f5c..5d2d8c0ee340 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1978,6 +1978,7 @@ T:      git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
>>>    F:  Documentation/ABI/testing/sysfs-bus-coresight-devices-*
>>>    F:  Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
>>>    F:  Documentation/devicetree/bindings/arm/coresight-cti.yaml
>>> +F:   Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>>>    F:  Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>>>    F:  Documentation/devicetree/bindings/arm/coresight.txt
>>>    F:  Documentation/devicetree/bindings/arm/ete.yaml
>> Otherwise looks good to me.
>>
>> Suzuki
