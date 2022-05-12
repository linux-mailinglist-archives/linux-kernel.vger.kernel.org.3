Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB98524615
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350520AbiELGp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243685AbiELGps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:45:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBB5CD5;
        Wed, 11 May 2022 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652337947; x=1683873947;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2biuyDFgnzEb6wCJFjhSWCD7gu2Xo4QJvuepaHaeyxY=;
  b=BKIfJiHKKV6sON/Lj2n1BAJ9StU8ASu9WHafHstUrMJOcHupnXnpiB3/
   qXUU791drVGH5id3Q7ppEWhDx90n6qayaXpUPbi+llaaVWh8Nx91aJbsE
   8OF+BIx4Ay06I7AcP5TbXXq8Aymtvb4XnXzbGAMeTQqt28ya/+im85Pfx
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2022 23:45:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 23:45:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 23:45:45 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 23:45:42 -0700
Subject: Re: [PATCH v3 2/2] dt-bindings: remoteproc: qcom: Add SC7280 MSS
 bindings
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <1652257162-23874-1-git-send-email-quic_sibis@quicinc.com>
 <1652257162-23874-3-git-send-email-quic_sibis@quicinc.com>
 <YnvrchuHVKFHE3B2@google.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <3c26d566-5c83-4322-414a-0830a0ec160c@quicinc.com>
Date:   Thu, 12 May 2022 12:15:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnvrchuHVKFHE3B2@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matthias,

On 5/11/22 10:29 PM, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> On Wed, May 11, 2022 at 01:49:22PM +0530, Sibi Sankar wrote:
>> Add MSS PIL loading bindings for SC7280 SoCs.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> 
> There is already a binding for 'qcom,sc7280-mss-pil' in
> Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt. Shouldn't
> the entries from that file be deleted?
> 
>>
>> v3:
>>   * Re-ordered clock list, fixed pdc_sync typo [Rob/Matthias]
>>
>>   .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 261 +++++++++++++++++++++
>>   1 file changed, 261 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
>> new file mode 100644
>> index 000000000000..2f95bfd7b3eb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
>> @@ -0,0 +1,261 @@
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
>> +  This document defines the binding for a component that loads and boots firmware
>> +  on the Qualcomm Technology Inc. SC7280 Modem Hexagon Core.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sc7280-mss-pil
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
>> +  interconnects:
>> +    items:
>> +      - description: Path leading to system memory
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
> 
> 
> The existing binding (qcom,q6v5.txt) also has:
> 
> - interrupts-extended:
>          Usage: required
> 	Value type: <prop-encoded-array>
> 	Definition: reference to the interrupts that match interrupt-names
> 
> That's covered implicitly by 'interrupts' I suppose?


Yeah ^^ was discussed before during the sc7280 wpss patch series. Rob
said the tooling handles both the same way.

https://lore.kernel.org/lkml/CAL_Jsq+khyhbwJ5-GPZ5ZGkY4nX_obq4t92Z0V6sZH3Oyj4Fow@mail.gmail.com/


> 
>> +
>> +  clocks:
>> +    items:
>> +      - description: GCC MSS IFACE clock
>> +      - description: GCC MSS OFFLINE clock
>> +      - description: GCC MSS SNOC_AXI clock
>> +      - description: RPMH PKA clock
>> +      - description: RPMH XO clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: offline
>> +      - const: snoc_axi
>> +      - const: pka
>> +      - const: xo
>> +
>> +  power-domains:
>> +    items:
>> +      - description: CX power domain
>> +      - description: MSS power domain
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: cx
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
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: Phandle reference to the reserved-memory for the MBA region followed
>> +                 by the modem region.
>> +
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      The name of the firmware which should be loaded for this remote
>> +      processor.
>> +
>> +  qcom,halt-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Phandle reference to a syscon representing TCSR followed by the
>> +      four offsets within syscon for q6, modem, nc and vq6 halt registers.
>> +
>> +  qcom,ext-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
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
>> +
>> +  qcom,smem-state-names:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: The names of the state bits used for SMP2P output
>> +    const: stop
>> +
>> +  glink-edge:
>> +    type: object
>> +    description: |
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
>> +        description: The names of the state bits used for SMP2P output
>> +        items:
>> +          - const: modem
>> +
>> +      qcom,remote-pid:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: ID of the shared memory used by GLINK for communication with MSS
>> +
>> +    required:
>> +      - interrupts
>> +      - mboxes
>> +      - label
>> +      - qcom,remote-pid
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - iommus
>> +  - interconnects
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +  - power-domains
>> +  - power-domain-names
>> +  - resets
>> +  - reset-names
>> +  - qcom,halt-regs
>> +  - qcom,ext-regs
>> +  - qcom,qaccept-regs
>> +  - memory-region
>> +  - qcom,qmp
> 
> 'qcom,qmp' is marked as 'optional' in qcom,q6v5.txt

Yeah even though we were forced to mark/implement it as optional in the
original bindings file/driver (since it was a single bindings file
covering all the SoCs), it is functionally required for sc7280 mss to
reach xo-shutdown.

> 

-Sibi
