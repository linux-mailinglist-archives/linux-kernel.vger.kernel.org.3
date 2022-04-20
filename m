Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04CF508AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379715AbiDTOkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357135AbiDTOkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:40:41 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208B610FD9;
        Wed, 20 Apr 2022 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650465475; x=1682001475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/65Q/A5qV4iH0TpXNaEEaR3xz1DwV3pVArJz55Dk5PU=;
  b=cshiz6P9C7FpxJzkly9jP7WaG5Kwf+RKbJKxZVi2eajHmhvJvv6IdXcP
   yFchMajK2OTGylxr07eUY2oG0jQrMBbivwVUIQmbMwI0t8VD8E1xDT51p
   Q5AFdCRWL+BL1SJeG48yIbaOMarB7HiX8jYxIf9gtYMgbPN/gv4FJuauN
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Apr 2022 07:37:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 07:37:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 07:37:54 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Apr
 2022 07:37:50 -0700
Message-ID: <7926128f-c547-495e-5ae2-d069f31cc3a1@quicinc.com>
Date:   Wed, 20 Apr 2022 22:37:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 08/10] dt-bindings: arm: Adds CoreSight TPDA hardware
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
 <20220412125035.40312-9-quic_jinlmao@quicinc.com>
 <CAJ9a7VjgHwPcLFZdApPcLdsOZ_s=nkRXar5hqrFtDscrc0CqBw@mail.gmail.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAJ9a7VjgHwPcLFZdApPcLdsOZ_s=nkRXar5hqrFtDscrc0CqBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/2022 4:32 PM, Mike Leach wrote:
> Hi
>
> On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>> Adds new coresight-tpda.yaml file describing the bindings required
>> to define tpda in the device trees.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../bindings/arm/coresight-tpda.yaml          | 119 ++++++++++++++++++
>>   1 file changed, 119 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>> new file mode 100644
>> index 000000000000..2c79de0a7928
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>> @@ -0,0 +1,119 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/coresight-tpda.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Trace, Profiling and Diagnostics Aggregator - TPDA
>> +
>> +description: |
>> +  TPDAs are responsible for packetization and timestamping of data sets
>> +  utilizing the MIPI STPv2 packet protocol. Pulling data sets from one or
>> +  more attached TPDM and pushing the resultant (packetized) data out a
>> +  master ATB interface. Performing an arbitrated ATB interleaving (funneling)
>> +  task for free-flowing data from TPDM (i.e. CMB and DSB data set flows).
>> +
>> +maintainers:
>> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
>> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
>> +
> as mentioned in patch 03 - these should be bindings maintainers.
>
> with the above change
>
> Reviewed by: Mike Leach <mike.leach@linaro.org>
>
>
Thank you Mike. I will address the comments in next version.
>
>> +properties:
>> +  $nodename:
>> +    pattern: "^tpda(@[0-9a-f]+)$"
>> +  compatible:
>> +    items:
>> +      - const: qcom,coresight-tpda
>> +      - const: arm,primecell
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
>> +  in-ports:
>> +    type: object
>> +    description: |
>> +      Input connections from TPDM to TPDA
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
>> +
>> +      '#size-cells':
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^port@[0-9a-f]+$":
>> +        type: object
>> +        required:
>> +          - reg
>> +
>> +    required:
>> +      - '#size-cells'
>> +      - '#address-cells'
>> +
>> +  out-ports:
>> +    type: object
>> +    description: |
>> +      Output connections from the TPDA to legacy CoreSight trace bus.
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +     port:
>> +       description:
>> +         Output connection from the TPDA to legacy CoreSight Trace bus.
>> +       $ref: /schemas/graph.yaml#/properties/port
>> +
>> +required:
>> +    - compatible
>> +    - reg
>> +    - clocks
>> +    - clock-names
>> +    - in-ports
>> +    - out-ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  # minimum tpda definition.
>> +  - |
>> +    tpda@6004000 {
>> +       compatible = "qcom,coresight-tpda", "arm,primecell";
>> +       reg = <0x6004000 0x1000>;
>> +
>> +       qcom,tpda-atid = <65>;
>> +
>> +       clocks = <&aoss_qmp>;
>> +       clock-names = "apb_pclk";
>> +
>> +       in-ports {
>> +         #address-cells = <1>;
>> +         #size-cells = <0>;
>> +
>> +        port@0 {
>> +          reg = <0>;
>> +          tpda_qdss_0_in_tpdm_dcc: endpoint {
>> +            remote-endpoint =
>> +              <&tpdm_dcc_out_tpda_qdss_0>;
>> +            };
>> +        };
>> +      };
>> +
>> +       out-ports {
>> +         port {
>> +                 tpda_qdss_out_funnel_in0: endpoint {
>> +                    remote-endpoint =
>> +                    <&funnel_in0_in_tpda_qdss>;
>> +                  };
>> +          };
>> +       };
>> +    };
>> +
>> +...
>> --
>> 2.17.1
>>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
