Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91A487341
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiAGHDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:03:41 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:5267 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbiAGHDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641539020; x=1673075020;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=jzLQhRXBbbds/xkaF7CP3l/Idp5WJKmhBZ3vmgviI2A=;
  b=TJcizHSjEBCMuERAdCO/MhcBkwWgOOWiis1PMtCtL1q++C+LCbnm/V+d
   atdAcYrYqVmtkARsCYMZcPv2SRlyU9/MIQLRr7r5gLIY+gWByg2tSoUn/
   vtyB+lZYID7qCCGmvYRJnL6nlvKzDYCkoG8agCP38FDpIP8g983kdYL/i
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jan 2022 23:03:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:03:24 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 6 Jan 2022 23:03:20 -0800
Received: from [10.231.205.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 6 Jan 2022
 23:03:17 -0800
Message-ID: <5ef25022-b53b-4002-7de8-e31bfb236009@quicinc.com>
Date:   Fri, 7 Jan 2022 15:03:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 11/11] dt-bindings: convert qcom,spmi-pmic-arb binding
 to YAML format
Content-Language: en-US
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        <devicetree@vger.kernel.org>, <collinsd@codeaurora.org>,
        <subbaram@codeaurora.org>, <tglx@linutronix.de>, <maz@kernel.org>
References: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
 <1640071211-31462-12-git-send-email-quic_fenglinw@quicinc.com>
 <YcHn0MLuqvMHbmuO@robh.at.kernel.org>
 <b35d0f12-1de2-9e15-2d87-5049614eeff1@quicinc.com>
In-Reply-To: <b35d0f12-1de2-9e15-2d87-5049614eeff1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/22 8:45, Fenglin Wu wrote:
> resend with plain text
> 
> 
> On 2021/12/21 22:42, Rob Herring wrote:
>> On Tue, Dec 21, 2021 at 03:20:09PM +0800, Fenglin Wu wrote:
>>> Convert the SPMI PMIC arbiter documentation to JSON/yaml.
>>>
>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>> ---
>>>   .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 ----------
>>>   .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 146 
>>> +++++++++++++++++++++
>>>   2 files changed, 146 insertions(+), 67 deletions(-)
>>>   delete mode 100644 
>>> Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>>>
>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml 
>>> b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>>> new file mode 100644
>>> index 0000000..df8cfb7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>>> @@ -0,0 +1,146 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/spmi/qcom,spmi-pmic-arb.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm SPMI PMIC Arbiter
>>> +
>>> +maintainers:
>>> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
>>> +  - Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
>>> +
>>> +description: |
>>> +  The SPMI PMIC Arbiter is found on Snapdragon chipsets. It is an SPMI
>>> +  controller with wrapping arbitration logic to allow for multiple
>>> +  on-chip devices to control a single SPMI master.
>>> +
>>> +  The PMIC Arbiter can also act as an interrupt controller, providing
>>> +  interrupts to slave devices.
>>> +
>>> +  See Documentation/devicetree/bindings/spmi/spmi.yaml for the generic
>>> +  SPMI controller binding requirements for child nodes.
>>> +
>>> +allOf:
>>> +  - $ref: spmi.yaml#
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^spmi@.*"
>>> +
>>> +  compatible:
>>> +    const: qcom,spmi-pmic-arb
>>> +
>>> +  reg-names:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>
>> reg-names already has a type defined.
> I understand there is a pattern property defined in dt-core.yaml and it 
> defines ".*-names" as a "non-unique-string-array" type. But here, the 
> strings in "reg-names" needs to be unique and it has to be ["core", 
> "intr", "cnfg"] or ["core", "intr", "cnfg", "chnls", "obsrvr"] , that's 
> why I redefined it as "string-array" type which requires each string to 
> be unique. Otherwise, if any dtsi nodes define the "reg-name" as 
> ["core", "core", "core"] will not be caught as a fault.
> 
>>
>>> +    anyOf:
>>> +      - minItems: 3
>>> +      - maxItems: 3
>>> +      - enum: ["core", "intr", "cnfg"]
>>> +
>>> +      - minItems: 5
>>> +      - maxItems: 5
>>> +      - enum: ["core", "intr", "cnfg", "chnls", "obsrvr"]
>>
>> I think you want something like this:
>>
>> minItems: 3
>> items:
>>    - const: core
>>    - const: intr
>>    - const: cnfg
>>    - const: chnls
>>    - const: obsrvr
>>
>>
> As I said, the content for "reg-names" here only has two options , 
> either ["core", "intr", "cnfg"] or ["core", "intr", "cnfg", "chnls", 
> "obsrvr"]. In patch V3, I defined it as below and "make dtbs_check" 
> threw out warnings because some of existing nodes defined "reg-names" 
> with these strings are not having the same order as I defined here (I 
> understood from the warnings that const items need to be followed 
> strictly even in order wise, is this correct?), and I guess the order of 
> the strings doesn't matter here and the schema here shouldn't have such 
> limitation, so I updated it as the "array-string" type and specified the 
> tuples can only be one of the strings defined in the enum. With this, 
> the previous warning regarding "reg-names" in "make dtbs_check" are all 
> fixed.
> 
>    reg-names:
>      oneOf:
>        - items:
>            - const: core
>            - const: intr
>            - const: cnfg
>        - items:
>            - const: core
>            - const: intr
>            - const: cnfg
>            - const: chnls
>            - const: obsrvr
>
Can you help to confirm if I need to change this back to what has been 
defined in PATCH v3 but just ignore those "make dtbs_check" warnings?
Thanks

> 
>>> +
>>> +  reg:
>>> +    minItems: 3
>>> +    maxItems: 5
>>> +    description: |
>>> +      Specifies base physical address and size of the registers in 
>>> SPMI PMIC
>>> +      Arbiter HW module, with the following order.
>>> +        - SPMI PMIC arbiter core registers (core)
>>> +        - SPMI PMIC arbiter interrupt controller registers (intr)
>>> +        - SPMI PMIC arbiter configuration registers (cnfg)
>>> +        - SPMI PMIC arbiter tx-channel per virtual slave registers 
>>> (chnls)
>>> +        - SPMI PMIC arbiter rx-channel per virtual slave registers 
>>> (obsrvr).
>>> +      Register for "chnls" and "obsrvr" are only applicable for PMIC 
>>> arbiter
>>> +      with HW version greater than V2.
>>> +
>>> +  "#address-cells":
>>> +    const: 2
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +  interrupts:
>>> +    description: The summary interrupt for the PMIC Arb controller.
>>> +    maxItems: 1
>>> +
>>> +  interrupt-names:
>>> +    const: periph_irq
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +  "#interrupt-cells":
>>> +    const: 4
>>> +    description: |
>>> +      Specifies the number of cells needed to encode any interrupt 
>>> source.
>>> +      The 1st cell is the slave ID for the requested interrupt, its 
>>> valid
>>> +      range is [0-15].
>>> +      The 2nd cell is the  peripheral ID for requested interrupt, 
>>> its valid
>>> +      range is [0-255].
>>> +      The 3rd cell is the requested peripheral interrupt, its valid 
>>> range
>>> +      is [0-7].
>>> +      The 4th cell is interrupt flags indicating level-sense 
>>> information,
>>> +      as defined in dt-bindings/interrupt-controller/irq.h
>>> +
>>> +  qcom,ee:
>>> +    description: the active Execution Environment identifier
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1, 2, 3, 4, 5]
>>> +
>>> +  qcom,channel:
>>> +    description: which of the PMIC Arbiter provided channels to use 
>>> for accesses
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1, 2, 3, 4, 5]
>>> +
>>
>>> +patternProperties:
>>> +  "@[0-9a-f]$":
>>> +    description: up to 16 child PMIC nodes
>>> +    type: object
>>> +
>>> +    properties:
>>> +      reg:
>>> +        items:
>>> +          - minItems: 1
>>> +            items:
>>> +              - minimum: 0
>>> +                maximum: 0xf
>>> +              - enum: [ 0 ]
>>> +                description:
>>> +                  0 means user ID address. 1 is reserved for group ID
>>> +                  address.
>>> +
>>> +    required:
>>> +      - reg
>>
>> All this should be covered by spmi.yaml
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg-names
>>> +  - reg
>>> +  - "#address-cells"
>>> +  - "#size-cells"
>>> +  - qcom,ee
>>> +  - qcom,channel
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    spmi@fc4cf000 {
>>> +          compatible = "qcom,spmi-pmic-arb";
>>> +          reg-names = "core", "intr", "cnfg";
>>> +          reg = <0xfc4cf000 0x1000>,
>>> +                <0xfc4cb000 0x1000>,
>>> +                <0xfc4ca000 0x1000>;
>>> +          interrupt-names = "periph_irq";
>>> +          interrupts = <0 190 0>;
>>> +          interrupt-controller;
>>> +          #interrupt-cells = <4>;
>>> +
>>> +          qcom,ee = <0>;
>>> +          qcom,channel = <0>;
>>> +
>>> +          #address-cells = <2>;
>>> +          #size-cells = <0>;
>>> +    };
>>> -- 
>>> 2.7.4
>>>
>>>
