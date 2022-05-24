Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9D5320BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiEXCLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiEXCLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:11:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92495A1C;
        Mon, 23 May 2022 19:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653358260; x=1684894260;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5WVK+3J/e3DWjxlM7BbtBXssvc4YNv10JrtCWDaEZqM=;
  b=WYp3bLpqaRviG2DF7y0/SbuDcLwzVUhRGUzGiuWy8TwXrAd2Nyja2lvQ
   69moJPJHbKZQ4DPjKRY2G3t1IQuUwPpMn8AdqBthGDwT9hsbdxBb/8YVF
   J5r2dE16pREBK0GMe9k/+71wE96vFNX5e7v6lgqfiQXIG6oRYemEJaA54
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 May 2022 19:10:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 19:10:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 19:10:58 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 19:10:54 -0700
Subject: Re: [PATCH v4 3/3] dt-bindings: remoteproc: qcom: Convert SC7180 MSS
 bindings to YAML
To:     Rob Herring <robh@kernel.org>
CC:     <bjorn.andersson@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <mka@chromium.org>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-4-git-send-email-quic_sibis@quicinc.com>
 <20220520224011.GA374485-robh@kernel.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <b495fa6c-6964-d8fa-0baf-acd719cd8779@quicinc.com>
Date:   Tue, 24 May 2022 07:40:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220520224011.GA374485-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
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

Hey Rob,
Thanks for taking time to review the series.

On 5/21/22 4:10 AM, Rob Herring wrote:
> On Thu, May 19, 2022 at 10:17:05PM +0530, Sibi Sankar wrote:
>> Convert SC7180 MSS PIL loading bindings to YAML.
> 
> I suppose there is a reason the sc7180 is being split out and the only
> one converted, but this doesn't tell me.

https://lore.kernel.org/all/e3543961-1645-b02a-c869-f8fa1ad2d41c@quicinc.com/#t

The reason for the split was discussed on the list ^^, thought it
wouldn't make much sense adding any of it to the commit message.

>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  20 +-
>>   .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml   | 236 +++++++++++++++++++++
>>   2 files changed, 238 insertions(+), 18 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 1ec9093c3a82..1a691c1435f3 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -14,7 +14,6 @@ on the Qualcomm Hexagon core.
>>   		    "qcom,msm8974-mss-pil"
>>   		    "qcom,msm8996-mss-pil"
>>   		    "qcom,msm8998-mss-pil"
>> -		    "qcom,sc7180-mss-pil"
>>   		    "qcom,sdm845-mss-pil"
>>   
>>   - reg:
>> @@ -46,7 +45,6 @@ on the Qualcomm Hexagon core.
>>   		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
>>   	qcom,msm8996-mss-pil:
>>   	qcom,msm8998-mss-pil:
>> -	qcom,sc7180-mss-pil:
>>   	qcom,sdm845-mss-pil:
>>   		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
>>   		    "shutdown-ack"
>> @@ -84,9 +82,6 @@ on the Qualcomm Hexagon core.
>>   	qcom,msm8998-mss-pil:
>>   		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
>>   		    "snoc_axi", "mnoc_axi", "qdss"
>> -	qcom,sc7180-mss-pil:
>> -		    must be "iface", "bus", "xo", "snoc_axi", "mnoc_axi",
>> -		    "nav"
>>   	qcom,sdm845-mss-pil:
>>   		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
>>   		    "snoc_axi", "mnoc_axi", "prng"
>> @@ -98,7 +93,7 @@ on the Qualcomm Hexagon core.
>>   		    reference to the list of 3 reset-controllers for the
>>   		    wcss sub-system
>>   		    reference to the list of 2 reset-controllers for the modem
>> -		    sub-system on SC7180, SDM845 SoCs
>> +		    sub-system on SDM845 SoCs
>>   
>>   - reset-names:
>>   	Usage: required
>> @@ -107,7 +102,7 @@ on the Qualcomm Hexagon core.
>>   		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
>>   		    for the wcss sub-system
>>   		    must be "mss_restart", "pdc_reset" for the modem
>> -		    sub-system on SC7180, SDM845 SoCs
>> +		    sub-system on SDM845 SoCs
>>   
>>   For devices where the mba and mpss sub-nodes are not specified, mba/mpss region
>>   should be referenced as follows:
>> @@ -172,8 +167,6 @@ For the compatible string below the following supplies are required:
>>   	qcom,msm8996-mss-pil:
>>   	qcom,msm8998-mss-pil:
>>   		    must be "cx", "mx"
>> -	qcom,sc7180-mss-pil:
>> -		    must be "cx", "mx", "mss"
>>   	qcom,sdm845-mss-pil:
>>   		    must be "cx", "mx", "mss"
>>   
>> @@ -200,15 +193,6 @@ For the compatible string below the following supplies are required:
>>   		    by the three offsets within syscon for q6, modem and nc
>>   		    halt registers.
>>   
>> -For the compatible strings below the following phandle references are required:
>> -  "qcom,sc7180-mss-pil"
>> -- qcom,spare-regs:
>> -	Usage: required
>> -	Value type: <prop-encoded-array>
>> -	Definition: a phandle reference to a syscon representing TCSR followed
>> -		    by the offset within syscon for conn_box_spare0 register
>> -		    used by the modem sub-system running on SC7180 SoC.
>> -
>>   The Hexagon node must contain iommus property as described in ../iommu/iommu.txt
>>   on platforms which do not have TrustZone.
>>   
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
>> new file mode 100644
>> index 000000000000..b00fdf9e3eeb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
>> @@ -0,0 +1,236 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7180-mss-pil.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SC7180 MSS Peripheral Image Loader
>> +
>> +maintainers:
>> +  - Sibi Sankar <quic_sibis@quicinc.com>
>> +
>> +description:
>> +  This document describes the hardware for a component that loads and boots firmware
>> +  on the Qualcomm Technology Inc. SC7180 Modem Hexagon Core.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sc7180-mss-pil
>> +
>> +  reg:
>> +    items:
>> +      - description: MSS QDSP6 registers
>> +      - description: RMB registers
>> +
>> +  reg-names:
>> +    items:
>> +      - const: qdsp6
>> +      - const: rmb
>> +
>> +  iommus:
>> +    items:
>> +      - description: MSA Stream 1
>> +      - description: MSA Stream 2
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Watchdog interrupt
>> +      - description: Fatal interrupt
>> +      - description: Ready interrupt
>> +      - description: Handover interrupt
>> +      - description: Stop acknowledge interrupt
>> +      - description: Shutdown acknowledge interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: wdog
>> +      - const: fatal
>> +      - const: ready
>> +      - const: handover
>> +      - const: stop-ack
>> +      - const: shutdown-ack
>> +
>> +  clocks:
>> +    items:
>> +      - description: GCC MSS IFACE clock
>> +      - description: GCC MSS BUS clock
>> +      - description: GCC MSS NAV clock
>> +      - description: GCC MSS SNOC_AXI clock
>> +      - description: GCC MSS MFAB_AXIS clock
>> +      - description: RPMH XO clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: bus
>> +      - const: nav
>> +      - const: snoc_axi
>> +      - const: mnoc_axi
>> +      - const: xo
>> +
>> +  power-domains:
>> +    items:
>> +      - description: CX power domain
>> +      - description: MX power domain
>> +      - description: MSS power domain
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: cx
>> +      - const: mx
>> +      - const: mss
>> +
>> +  resets:
>> +    items:
>> +      - description: AOSS restart
>> +      - description: PDC reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: mss_restart
>> +      - const: pdc_reset
>> +
>> +  memory-region:
>> +    maxItems: 2
>> +    description: Phandle reference to the reserved-memory for the MBA region followed
>> +                 by the modem region.
> 
> Use 'items' to describe each entry.

ack

> 
>> +
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    maxItems: 2
>> +    description:
>> +      The name of the MBA and modem firmware to be loaded for this remote processor.
>> +
>> +  qcom,halt-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Phandle reference to a syscon representing TCSR followed by the
>> +      three offsets within syscon for q6, modem and nc halt registers.
> 
> You need to define this as a schema:
> 
> items:
>    - items:
>        - description: ...
>        - description: ...
>        - description: ...
>        - description: ...
> 

ack

>> +
>> +  qcom,spare-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Phandle reference to a syscon representing TCSR followed by the
>> +      offset within syscon for conn_box_spare0 register.
> 
> Same here.

ack

> 
>> +
>> +  qcom,qmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Reference to the AOSS side-channel message RAM.
>> +
>> +  qcom,smem-states:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> I believe there's a common schema for this now or one pending so you
> should drop the type here.

Last time I checked all the other remoteprocs handle
them this way and there wasn't a common schema for it.

> 
>> +    description: States used by the AP to signal the Hexagon core
>> +    items:
>> +      - description: Stop the modem
> 
> That's not sufficient for a phandle-array which is really a matrix.

will update the description.

> 
>> +
>> +  qcom,smem-state-names:
>> +    description: The names of the state bits used for SMP2P output
>> +    const: stop
>> +
>> +  glink-edge:
>> +    $ref: qcom,glink-edge.yaml#
>> +    description:
>> +      Qualcomm G-Link subnode which represents communication edge, channels
>> +      and devices related to the DSP.
>> +
>> +    properties:
>> +      interrupts:
>> +        items:
>> +          - description: IRQ from MSS to GLINK
>> +
>> +      mboxes:
>> +        items:
>> +          - description: Mailbox for communication between APPS and MSS
>> +
>> +      label:
>> +        items:
> 
> Only 1, you can drop 'items'. And 'label' is always 1 entry.

ack

> 
>> +          - const: modem
>> +
>> +      apr: false
>> +      fastrpc: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - iommus
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +  - power-domains
>> +  - power-domain-names
>> +  - resets
>> +  - reset-names
>> +  - qcom,halt-regs
>> +  - qcom,spare-regs
>> +  - memory-region
>> +  - qcom,qmp
>> +  - qcom,smem-states
>> +  - qcom,smem-state-names
>> +  - glink-edge
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>> +    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>> +
>> +    remoteproc_mpss: remoteproc@4080000 {
>> +        compatible = "qcom,sc7180-mss-pil";
>> +        reg = <0x04080000 0x10000>, <0x04180000 0x48>;
>> +        reg-names = "qdsp6", "rmb";
>> +
>> +        iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
>> +
>> +        interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
>> +                              <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +                              <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +                              <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +                              <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
>> +                              <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
>> +
>> +        interrupt-names = "wdog", "fatal", "ready", "handover",
>> +                          "stop-ack", "shutdown-ack";
>> +
>> +        clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>> +                 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
>> +                 <&gcc GCC_MSS_NAV_AXI_CLK>,
>> +                 <&gcc GCC_MSS_SNOC_AXI_CLK>,
>> +                 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
>> +                 <&rpmhcc RPMH_CXO_CLK>;
>> +        clock-names = "iface", "bus", "nav", "snoc_axi",
>> +                      "mnoc_axi", "xo";
>> +
>> +        power-domains = <&rpmhpd SC7180_CX>,
>> +                        <&rpmhpd SC7180_MX>,
>> +                        <&rpmhpd SC7180_MSS>;
>> +        power-domain-names = "cx", "mx", "mss";
>> +
>> +        memory-region = <&mba_mem>, <&mpss_mem>;
>> +
>> +        qcom,qmp = <&aoss_qmp>;
>> +
>> +        qcom,smem-states = <&modem_smp2p_out 0>;
>> +        qcom,smem-state-names = "stop";
>> +
>> +        resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
>> +                 <&pdc_reset PDC_MODEM_SYNC_RESET>;
>> +        reset-names = "mss_restart", "pdc_reset";
>> +
>> +        qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
>> +        qcom,spare-regs = <&tcsr_regs 0xb3e4>;
>> +
>> +        glink-edge {
>> +            interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
>> +            mboxes = <&apss_shared 12>;
>> +            qcom,remote-pid = <1>;
>> +            label = "modem";
>> +        };
>> +    };
>> -- 
>> 2.7.4
>>
>>
