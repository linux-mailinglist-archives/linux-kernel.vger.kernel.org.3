Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC94552F366
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352817AbiETSrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiETSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:47:08 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9066F941AE;
        Fri, 20 May 2022 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653072426; x=1684608426;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AmggUx1E4WjOTJi2d8/NCr6el8KzJxZxVGbSr2RIJ6M=;
  b=B+pFQJ/HxtDZkr5WWiwd4SGp0lqUVlDbv0ppUCpoY2InBBFrp6DPzjgx
   ZIx0jTZLTiG0wl6OI15Z5yytfZyp/IeFOZe9lo1zdre6AKSDP3Y4Xsrwc
   DqSjhXSs7gV/LTi8m2Z0Yz7AQgwZsvBkCVzI5ruZt/w4SvTpGlm479pRN
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 May 2022 11:47:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:47:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 11:47:05 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 11:47:01 -0700
Subject: Re: [PATCH v4 2/3] dt-bindings: remoteproc: qcom: Convert SC7280 MSS
 bindings to YAML
To:     Stephen Boyd <swboyd@chromium.org>, <bjorn.andersson@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-3-git-send-email-quic_sibis@quicinc.com>
 <CAE-0n50iYAUmj6GEdCuOJ1d_SgeeFWtoxqWf7qN=jZ_js4wBcQ@mail.gmail.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <1289c2e4-5607-b515-88b1-f44585e62cd3@quicinc.com>
Date:   Sat, 21 May 2022 00:16:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n50iYAUmj6GEdCuOJ1d_SgeeFWtoxqWf7qN=jZ_js4wBcQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Stephen,

On 5/20/22 4:05 AM, Stephen Boyd wrote:
> Quoting Sibi Sankar (2022-05-19 09:47:04)
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
>> new file mode 100644
>> index 000000000000..a936d84eefa6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
>> @@ -0,0 +1,250 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-mss-pil.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SC7280 MSS Peripheral Image Loader
>> +
>> +maintainers:
>> +  - Sibi Sankar <quic_sibis@quicinc.com>
>> +
>> +description:
>> +  This document describes the hardware for a component that loads and boots firmware
>> +  on the Qualcomm Technology Inc. SC7280 Modem Hexagon Core.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sc7280-mss-pil
>> +
> [..]
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
>> +
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    maxItems: 2
> 
> Instead of maxItems can this be
> 
>         items:
>           - description: Name of MBA firmware
> 	 - description: Name of modem firmware
> 
> so that we know the order? Same for 'memory-region' above.

ack

> 
>> +    description:
>> +      The name of the MBA and modem firmware to be loaded for this remote processor.
>> +
>> +  qcom,halt-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Should this have maxItems: 1? Or that's implicit from description?

It's implicit!

> 
>> +    description:
>> +      Phandle reference to a syscon representing TCSR followed by the
>> +      four offsets within syscon for q6, modem, nc and vq6 halt registers.
>> +
>> +  qcom,ext-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Should this have min/maxItems: 2?

ack

> 
>> +    description:
>> +      Two phandle references to syscons representing TCSR_REG and TCSR register
>> +      space followed by the two offsets within the syscon to force_clk_en/rscc_disable
>> +      and axim1_clk_off/crypto_clk_off registers respectively.
>> +
>> +  qcom,qaccept-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Phandle reference to a syscon representing TCSR followed by the
>> +      three offsets within syscon for mdm, cx and axi qaccept registers.
>> +
>> +  qcom,qmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Reference to the AOSS side-channel message RAM.
>> +
>> +  qcom,smem-states:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: States used by the AP to signal the Hexagon core
>> +    items:
>> +      - description: Stop the modem
> 
> This one did items for a phandle array so I think we should follow the
> same above.

ack

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
> [..]
>> +        power-domain-names = "cx", "mss";
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
>> +        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
>> +        qcom,ext-regs = <&tcsr 0x10000 0x10004 &tcsr_mutex 0x26004 0x26008>;
> 
> Because it's two items I'd expect:
> 	
> 	<&tcsr 0x10000 0x10004>, <&tcsr_mutex 0x26004 0x26008>;

I guess both the ways work since the driver uses
of_parse_phandle_with_fixed_args.

> 
>> +        qcom,qaccept-regs = <&tcsr_mutex 0x23030 0x23040 0x23020>;
>> +
>> +        glink-edge {
>> +            interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
>> +                                   IPCC_MPROC_SIGNAL_GLINK_QMP
>> +                                   IRQ_TYPE_EDGE_RISING>;
