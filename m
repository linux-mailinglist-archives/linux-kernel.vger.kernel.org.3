Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC3524694
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350788AbiELHLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350824AbiELHL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:11:26 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE35960AB5;
        Thu, 12 May 2022 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652339484; x=1683875484;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ObP7VaZsDWS7LC/cevYn2R7VTmW0ytKg4J8XTG8Bs2Y=;
  b=qF5aHuKwmsTbq3dViZXSScRPKIzFd8lp2oW7OuSJdmE8NQ9Y2YgziOQI
   VlvLpm5NzVDYLUHaKBNbvv2xR6qaN/xl65QEGiOKsQ5y/3Nms2kRrW7U6
   1uZR4WuYoIePoY1vPO+C5HXUSd02Phuvna7DT5IZTQOwmDsEGit74klga
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 May 2022 00:11:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 00:11:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 00:11:22 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 12 May
 2022 00:11:18 -0700
Subject: Re: [PATCH v3 2/2] dt-bindings: remoteproc: qcom: Add SC7280 MSS
 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        Sireesh Kodali <sireeshkodali1@gmail.com>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <mka@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>
References: <1652257162-23874-1-git-send-email-quic_sibis@quicinc.com>
 <1652257162-23874-3-git-send-email-quic_sibis@quicinc.com>
 <436e497f-b43c-4543-62d4-e7aea3d37ac7@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <e3543961-1645-b02a-c869-f8fa1ad2d41c@quicinc.com>
Date:   Thu, 12 May 2022 12:41:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <436e497f-b43c-4543-62d4-e7aea3d37ac7@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Hey Krzysztof,

Thanks for taking time to review the patch series.

On 5/11/22 11:40 PM, Krzysztof Kozlowski wrote:
> On 11/05/2022 10:19, Sibi Sankar wrote:
>> Add MSS PIL loading bindings for SC7280 SoCs.
> 
> Why not converting existing bindings? The compatible is already there,
> so you duplicated its binding.

I'll make sure that all references to the sc7280 mss gets deleted from
the main binding doc in the next-respin.


https://lore.kernel.org/lkml/CAE-0n51KBYjZvwGNy06_okmEWjEfRLQO54CYaY6-JnbBk6kOhA@mail.gmail.com/

https://lore.kernel.org/lkml/YUps1JfGtf6JdbCx@ripper/

Bjorn/Stephen gave the above comments when the wpss bindings was in the 
process of being merged. It was agreed that a single big clunky binding
with a lot of if/else would be confusing and Bjorn wanted a separate
file for it specifically because it overrides a pas compatible. SC7280 
mss satisfies both the requirements.

> 
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
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
> 
> s/This document defines the binding for//
> Instead describe the hardware.

ack

> 
> 
> Anyway, similar patch was already sent:
> https://lore.kernel.org/all/20220511161602.117772-7-sireeshkodali1@gmail.com/
> Except its several issues, it is much more complete and specific.

same reason as detailed above.

> 
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
> 
> This should be defined by core schema and ref should not be needed.
> 
>> +    description: Phandle reference to the reserved-memory for the MBA region followed
>> +                 by the modem region.
> 
> maxItems

ack

> 
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
> 
> For some reason you decided to make the same mistakes as the
> https://lore.kernel.org/all/20220511161602.117772-7-sireeshkodali1@gmail.com/
> 
> even though all other bindings with this property looks correct.
> 
> Please, re-use existing bindings, do not reinvent things in incorrect way.
> 
> I'll stop the review, you need to align first.
> 
> What is weird, your v2 was before Sireesh's patch, and you both made the
> same mistakes which do not exist in current bindings.

I guess he used the qcom,sc7280-wpss-pil.yaml for reference as well lol.
Sure I'll allign with him and who gets to post what.

> 
> All comments from his set apply here. It seems that his patchset came
> after yours and copied stuff from your bindings, so yours would be FIFO,
> if you made proper binding conversion.
> 
> Best regards,
> Krzysztof
> 
