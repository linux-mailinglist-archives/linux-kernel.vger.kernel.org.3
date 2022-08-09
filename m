Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54D558D6CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiHIJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbiHIJve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:51:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A887205FF;
        Tue,  9 Aug 2022 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1660038690; x=1691574690;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=boOuUkuvsMQj9qtjLZ7R73HsFE4j6vAV4uRtaTs6n0I=;
  b=RJipSEg+MVoJfSV8UzEKwD2LewgpO6HlVBYX4zNojsBNuuwrmnRgTOqH
   AKYS5tkJa4RJ+Q/Pfmw4JZPc6Yp9cv/4Riv6/xmm9mOwKqOjqz3Wiz0/z
   I7qrjhGV9BYCD49NbjxadaWVpDLGdiN9af25vkaloQ7M9uJkKPowtvSuN
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Aug 2022 02:51:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 02:51:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 02:51:14 -0700
Received: from [10.216.39.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 9 Aug 2022
 02:51:08 -0700
Message-ID: <290ea12a-e19f-cab2-af28-ff8c7aad5b60@quicinc.com>
Date:   Tue, 9 Aug 2022 15:21:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/8] dt-bindings: remoteproc: qcom: adsp: Make ADSP pil
 loader as generic
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <PLL_L3rk0As4iT923EpBfGe-uDR4XZZWQS3zFNrfS3m5TCPUtK0E58AEjofIncTglWcpEXVbYj2b1vWjEZgJBA==@protonmail.internalid>
 <1659536480-5176-2-git-send-email-quic_srivasam@quicinc.com>
 <a59add1a-7e33-a47b-a804-b98c132d78f2@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <a59add1a-7e33-a47b-a804-b98c132d78f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 8/5/2022 1:17 AM, Caleb Connolly wrote:
Thanks for Your TIme Celeb!!
>
> Hi,
> On 03/08/2022 15:21, Srinivasa Rao Mandadapu wrote:
>> Rename sdm845 adsp pil bindings to generic name, for using same binings
>> file for subsequent SoCs.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   .../bindings/remoteproc/qcom,lpass-adsp-pil.yaml   | 160 
>> +++++++++++++++++++++
>>   .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  | 160 
>> ---------------------
>>   2 files changed, 160 insertions(+), 160 deletions(-)
>>   create mode 100644 
>> Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>>   delete mode 100644 
>> Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
> This should be a rename, I think passing the -M flag to "git 
> format-patch" detects it.
Okay. Will do accordingly in next version of patches.
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>> new file mode 100644
>> index 0000000..9f11332
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>> @@ -0,0 +1,160 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,lpass-adsp-pil.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm LPASS ADSP Peripheral Image Loader
>> +
>> +maintainers:
>> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>> +
>> +description:
>> +  This document defines the binding for a component that loads and 
>> boots firmware
>> +  on the Qualcomm Technology Inc. ADSP.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sdm845-adsp-pil
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description:
>> +      The base address and size of the qdsp6ss register
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Watchdog interrupt
>> +      - description: Fatal interrupt
>> +      - description: Ready interrupt
>> +      - description: Handover interrupt
>> +      - description: Stop acknowledge interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: wdog
>> +      - const: fatal
>> +      - const: ready
>> +      - const: handover
>> +      - const: stop-ack
>> +
>> +  clocks:
>> +    items:
>> +      - description: XO clock
>> +      - description: SWAY clock
>> +      - description: LPASS AHBS AON clock
>> +      - description: LPASS AHBM AON clock
>> +      - description: QDSP XO clock
>> +      - description: Q6SP6SS SLEEP clock
>> +      - description: Q6SP6SS CORE clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xo
>> +      - const: sway_cbcr
>> +      - const: lpass_ahbs_aon_cbcr
>> +      - const: lpass_ahbm_aon_cbcr
>> +      - const: qdsp6ss_xo
>> +      - const: qdsp6ss_sleep
>> +      - const: qdsp6ss_core
>> +
>> +  power-domains:
>> +    items:
>> +      - description: CX power domain
>> +
>> +  resets:
>> +    items:
>> +      - description: PDC AUDIO SYNC RESET
>> +      - description: CC LPASS restart
>> +
>> +  reset-names:
>> +    items:
>> +      - const: pdc_sync
>> +      - const: cc_lpass
>> +
>> +  memory-region:
>> +    maxItems: 1
>> +    description: Reference to the reserved-memory for the Hexagon core
>> +
>> +  qcom,halt-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Phandle reference to a syscon representing TCSR followed by the
>> +      three offsets within syscon for q6, modem and nc halt registers.
>> +
>> +  qcom,smem-states:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: States used by the AP to signal the Hexagon core
>> +    items:
>> +      - description: Stop the modem
>> +
>> +  qcom,smem-state-names:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: The names of the state bits used for SMP2P output
>> +    items:
>> +      - const: stop
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +  - power-domains
>> +  - resets
>> +  - reset-names
>> +  - qcom,halt-regs
>> +  - memory-region
>> +  - qcom,smem-states
>> +  - qcom,smem-state-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> +    #include <dt-bindings/clock/qcom,lpass-sdm845.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>> +    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>> +    remoteproc@17300000 {
>> +        compatible = "qcom,sdm845-adsp-pil";
>> +        reg = <0x17300000 0x40c>;
>> +
>> +        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
>> +                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>> +        interrupt-names = "wdog", "fatal", "ready",
>> +                "handover", "stop-ack";
>> +
>> +        clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +                 <&gcc GCC_LPASS_SWAY_CLK>,
>> +                 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
>> +                 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
>> +                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
>> +                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
>> +                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
>> +        clock-names = "xo", "sway_cbcr",
>> +                "lpass_ahbs_aon_cbcr",
>> +                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
>> +                "qdsp6ss_sleep", "qdsp6ss_core";
>> +
>> +        power-domains = <&rpmhpd SDM845_CX>;
>> +
>> +        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
>> +                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
>> +        reset-names = "pdc_sync", "cc_lpass";
>> +
>> +        qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
>> +
>> +        memory-region = <&pil_adsp_mem>;
>> +
>> +        qcom,smem-states = <&adsp_smp2p_out 0>;
>> +        qcom,smem-state-names = "stop";
>> +    };
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
>> deleted file mode 100644
>> index 1535bbb..0000000
>> --- 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
>> +++ /dev/null
>> @@ -1,160 +0,0 @@
>> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> -%YAML 1.2
>> ----
>> -$id: 
>> http://devicetree.org/schemas/remoteproc/qcom,sdm845-adsp-pil.yaml#
>> -$schema: http://devicetree.org/meta-schemas/core.yaml#
>> -
>> -title: Qualcomm SDM845 ADSP Peripheral Image Loader
>> -
>> -maintainers:
>> -  - Bjorn Andersson <bjorn.andersson@linaro.org>
>> -
>> -description:
>> -  This document defines the binding for a component that loads and 
>> boots firmware
>> -  on the Qualcomm Technology Inc. ADSP.
>> -
>> -properties:
>> -  compatible:
>> -    enum:
>> -      - qcom,sdm845-adsp-pil
>> -
>> -  reg:
>> -    maxItems: 1
>> -    description:
>> -      The base address and size of the qdsp6ss register
>> -
>> -  interrupts:
>> -    items:
>> -      - description: Watchdog interrupt
>> -      - description: Fatal interrupt
>> -      - description: Ready interrupt
>> -      - description: Handover interrupt
>> -      - description: Stop acknowledge interrupt
>> -
>> -  interrupt-names:
>> -    items:
>> -      - const: wdog
>> -      - const: fatal
>> -      - const: ready
>> -      - const: handover
>> -      - const: stop-ack
>> -
>> -  clocks:
>> -    items:
>> -      - description: XO clock
>> -      - description: SWAY clock
>> -      - description: LPASS AHBS AON clock
>> -      - description: LPASS AHBM AON clock
>> -      - description: QDSP XO clock
>> -      - description: Q6SP6SS SLEEP clock
>> -      - description: Q6SP6SS CORE clock
>> -
>> -  clock-names:
>> -    items:
>> -      - const: xo
>> -      - const: sway_cbcr
>> -      - const: lpass_ahbs_aon_cbcr
>> -      - const: lpass_ahbm_aon_cbcr
>> -      - const: qdsp6ss_xo
>> -      - const: qdsp6ss_sleep
>> -      - const: qdsp6ss_core
>> -
>> -  power-domains:
>> -    items:
>> -      - description: CX power domain
>> -
>> -  resets:
>> -    items:
>> -      - description: PDC AUDIO SYNC RESET
>> -      - description: CC LPASS restart
>> -
>> -  reset-names:
>> -    items:
>> -      - const: pdc_sync
>> -      - const: cc_lpass
>> -
>> -  memory-region:
>> -    maxItems: 1
>> -    description: Reference to the reserved-memory for the Hexagon core
>> -
>> -  qcom,halt-regs:
>> -    $ref: /schemas/types.yaml#/definitions/phandle-array
>> -    description:
>> -      Phandle reference to a syscon representing TCSR followed by the
>> -      three offsets within syscon for q6, modem and nc halt registers.
>> -
>> -  qcom,smem-states:
>> -    $ref: /schemas/types.yaml#/definitions/phandle-array
>> -    description: States used by the AP to signal the Hexagon core
>> -    items:
>> -      - description: Stop the modem
>> -
>> -  qcom,smem-state-names:
>> -    $ref: /schemas/types.yaml#/definitions/string
>> -    description: The names of the state bits used for SMP2P output
>> -    items:
>> -      - const: stop
>> -
>> -required:
>> -  - compatible
>> -  - reg
>> -  - interrupts
>> -  - interrupt-names
>> -  - clocks
>> -  - clock-names
>> -  - power-domains
>> -  - resets
>> -  - reset-names
>> -  - qcom,halt-regs
>> -  - memory-region
>> -  - qcom,smem-states
>> -  - qcom,smem-state-names
>> -
>> -additionalProperties: false
>> -
>> -examples:
>> -  - |
>> -    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> -    #include <dt-bindings/clock/qcom,rpmh.h>
>> -    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> -    #include <dt-bindings/clock/qcom,lpass-sdm845.h>
>> -    #include <dt-bindings/power/qcom-rpmpd.h>
>> -    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>> -    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>> -    remoteproc@17300000 {
>> -        compatible = "qcom,sdm845-adsp-pil";
>> -        reg = <0x17300000 0x40c>;
>> -
>> -        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
>> -                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> -                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> -                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> -                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>> -        interrupt-names = "wdog", "fatal", "ready",
>> -                "handover", "stop-ack";
>> -
>> -        clocks = <&rpmhcc RPMH_CXO_CLK>,
>> -                 <&gcc GCC_LPASS_SWAY_CLK>,
>> -                 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
>> -                 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
>> -                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
>> -                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
>> -                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
>> -        clock-names = "xo", "sway_cbcr",
>> -                "lpass_ahbs_aon_cbcr",
>> -                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
>> -                "qdsp6ss_sleep", "qdsp6ss_core";
>> -
>> -        power-domains = <&rpmhpd SDM845_CX>;
>> -
>> -        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
>> -                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
>> -        reset-names = "pdc_sync", "cc_lpass";
>> -
>> -        qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
>> -
>> -        memory-region = <&pil_adsp_mem>;
>> -
>> -        qcom,smem-states = <&adsp_smp2p_out 0>;
>> -        qcom,smem-state-names = "stop";
>> -    };
>> -- 
>> 2.7.4
>>
>
