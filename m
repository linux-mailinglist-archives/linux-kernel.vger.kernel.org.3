Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F343530BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiEWJCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiEWJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:02:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49AB52181E;
        Mon, 23 May 2022 02:02:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 184B51FB;
        Mon, 23 May 2022 02:02:19 -0700 (PDT)
Received: from [10.57.34.201] (unknown [10.57.34.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93FA13F73D;
        Mon, 23 May 2022 02:02:15 -0700 (PDT)
Message-ID: <ab027359-02be-2204-8a09-b1e5170bdba8@arm.com>
Date:   Mon, 23 May 2022 10:02:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v7 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware
 definitions
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
 <20220509133947.20987-4-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220509133947.20987-4-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Rob Herring

Hi

Please Cc Rob for any new DT/Yaml additions. I have done so now.




On 09/05/2022 14:39, Mao Jinlong wrote:
> Adds new coresight-tpdm.yaml file describing the bindings required
> to define tpdm in the device trees.
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   .../bindings/arm/coresight-tpdm.yaml          | 99 +++++++++++++++++++
>   .../devicetree/bindings/arm/coresight.txt     |  7 ++
>   MAINTAINERS                                   |  1 +
>   3 files changed, 107 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> new file mode 100644
> index 000000000000..451342d3d8b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/coresight-tpdm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Trace, Profiling and Diagnostics Monitor - TPDM
> +
> +description: |
> +  The TPDM or Monitor serves as data collection component for various dataset
> +  types specified in the QPMDA spec. It covers Implementation defined ((ImplDef),
> +  Basic Counts (BC), Tenure Counts (TC), Continuous Multi-Bit (CMB), and Discrete
> +  Single Bit (DSB). It performs data collection in the data producing clock
> +  domain and transfers it to the data collection time domain, generally ATB
> +  clock domain.
> +
> +  The primary use case of the TPDM is to collect data from different data
> +  sources and send it to a TPDA for packetization, timestamping, and funneling.
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^tpdm(@[0-9a-f]+)$"
> +  compatible:
> +    items:
> +      - const: qcom,coresight-tpdm
> +      - const: arm,primecell
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +   items:
> +     - const: apb_pclk
> +
> +  out-ports:
> +    description: |
> +      Output connections from the TPDM to coresight funnle/tpda.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port:
> +        description: Output connection from the TPDM to coresight
> +            funnel/tpda.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  # minimum TPDM definition. TPDM connect to coresight funnel.
> +  - |
> +    tpdm@6980000 {
> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
> +      reg = <0x6980000 0x1000>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      out-ports {
> +        port {
> +          tpdm_turing_out_funnel_turing: endpoint {
> +            remote-endpoint =
> +              <&funnel_turing_in_tpdm_turing>;
> +          };
> +        };
> +      };
> +    };
> +  # minimum TPDM definition. TPDM connect to coresight TPDA.
> +  - |
> +    tpdm@684c000 {
> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
> +      reg = <0x684c000 0x1000>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      out-ports {
> +        port {
> +          tpdm_prng_out_tpda_qdss: endpoint {
> +            remote-endpoint =
> +              <&tpda_qdss_in_tpdm_prng>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index c68d93a35b6c..f7ce8af48574 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -52,6 +52,10 @@ its hardware characteristcs.
>   			"arm,coresight-cti", "arm,primecell";
>   			See coresight-cti.yaml for full CTI definitions.
>   
> +		- Trace, Profiling and Diagnostics Monitor (TPDM):
> +			"qcom,coresight-tpdm", "arm,primecell";
> +			See coresight-tpdm.yaml for full TPDM definitions.
> +
>   	* reg: physical base address and length of the register
>   	  set(s) of the component.
>   
> @@ -82,6 +86,9 @@ its hardware characteristcs.
>   * Required properties for Coresight Cross Trigger Interface (CTI)
>   	See coresight-cti.yaml for full CTI definitions.
>   
> +* Required properties for Trace, Profiling and Diagnostics Monitor (TPDM)
> +	See coresight-tpdm.yaml for full TPDM definitions.
> +
>   * Required properties for devices that don't show up on the AMBA bus, such as
>     non-configurable replicators and non-configurable funnels:
>   
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc96cdb85e8..28d32b3f3f5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1978,6 +1978,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
>   F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
>   F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
>   F:	Documentation/devicetree/bindings/arm/coresight-cti.yaml
> +F:	Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>   F:	Documentation/devicetree/bindings/arm/coresight.txt
>   F:	Documentation/devicetree/bindings/arm/ete.yaml
>   F:	Documentation/devicetree/bindings/arm/trbe.yaml

