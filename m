Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4344CB3BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCBXy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCBXy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:54:27 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7D22C110;
        Wed,  2 Mar 2022 15:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646265223; x=1677801223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m3u25xMhZVEc/MJyWhaLe99ts/+HPtLY71qMZMMqvqg=;
  b=yuu1+5wcSPJJ/jZ7MBS31PsQdvc3WQC+Vef+Bv1zVq7z96vwVhTHr8z+
   mSADl1BCZceJqPAXkPRFBj7nlLmiuMhmmwLVe/jhzpV5fi0Fv1OWFvbdn
   y+lonvfeAN25GTiSw5M9QrP9LPVxCAdBsZPyr7GScSb0+P60WHrm5neyQ
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Mar 2022 15:53:42 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:53:42 -0800
Received: from [10.110.8.146] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 2 Mar 2022
 15:53:41 -0800
Message-ID: <ce19852f-8a69-3c98-cf0f-f78e37616fa6@quicinc.com>
Date:   Wed, 2 Mar 2022 15:53:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 02/11] dt-bindings: Add binding for gunyah hypervisor
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        "Andy Gross" <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220223233729.1571114-3-quic_eberman@quicinc.com>
 <Yhk1j7riufsOFUsg@robh.at.kernel.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Yhk1j7riufsOFUsg@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/2022 12:01 PM, Rob Herring wrote:
> On Wed, Feb 23, 2022 at 03:37:20PM -0800, Elliot Berman wrote:
>> When Linux is booted as a guest under the Gunyah hypervisor, Gunyah
>> applies a devicetree overlay describing the virtual platform
>> configuration of the guest VM, such as the message queue capability IDs
>> for communicating with the Resource Manager. Add the DT bindings that
>> Gunyah adheres for the hypervisor node and message queues.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   .../bindings/gunyah/message-queue.yml         | 100 ++++++++++++++
>>   .../bindings/gunyah/qcom,hypervisor.yml       | 122 ++++++++++++++++++
> 
> How did testing these files work? It didn't because .yml files are
> ignored. Get 'make dt_binding_check' actually working and resubmit.
> 
I'll double check this, thanks!

> No, you don't get your own directory.
> 
Do you have a suggestion for an alternate directory? I'm not sure if 
misc/ makes sense here?

> In general, DT is for undiscoverable hardware that we are stuck with
> because it was not made discoverable. As this is not h/w and you control
> each side of the interface, make it discoverable and don't use DT for
> your discovery mechanism.
> 
Gunyah follows a micro-kernel architecture. The EL2 hypervisor doesn't 
keep the necessary context to share initial message queue information in 
order to communicate with the resource manager VM, and it's considered 
undiscoverable in this regard.

This feedback is good for the other properties, though. I'll improve the 
discoverability for other properties and drop the bindings for them.

In summary, I can remove all of the properties and subnodes from 
/hypervisor node, except for /hypervisor/resource-manager-rpc. For that 
node, I only need to keep a few fields (reg and interrupts) because that 
information isn't discoverable.

> Incomplete review follows...
> 
>>   MAINTAINERS                                   |   1 +
>>   3 files changed, 223 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/gunyah/message-queue.yml
>>   create mode 100644 Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
>>
>> diff --git a/Documentation/devicetree/bindings/gunyah/message-queue.yml b/Documentation/devicetree/bindings/gunyah/message-queue.yml
>> new file mode 100644
>> index 000000000000..1a96d3de2a19
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gunyah/message-queue.yml
>> @@ -0,0 +1,100 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gunyah/qcom,hypervisor.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Gunyah message queue
>> +
>> +maintainers:
>> +   - Murali Nalajala <quic_mnalajal@quicinc.com>
>> +   - Elliot Berman <quic_eberman@quicinc.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: qcom,gunyah-message-queue
>> +      - const: qcom,gunyah-capability
> 
> I'm not following how capability is a fallback to message-queue.
> 

This node shares common properties with other Gunyah capabilities. Linux 
drivers don't need to make use of this compatible, but Gunyah needs to 
make it present for other operating systems. In that case, should I drop 
"gunyah-capability" from the bindings?

>> +  peer:
>> +    description: VMID of the VM on the other end of message queue
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +  allOf:
> 
> Check your indentation.
> 
>> +    - if:
>> +        anyOf:
>> +          - properties:
>> +              qcom,is-sender: true
>> +          - properties:
>> +              qcom,is-full-duplex: true
>> +      then:
>> +        properties:
>> +          qcom,tx-message-size:
>> +            description: Maximum size in bytes of a message which can be sent by this queue
>> +            $ref: /schemas/types.yaml#/definitions/int32
>> +          qcom,tx-queue-depth:
>> +            description: Depth of transmit queue for messages sent by this queue
>> +            $ref: /schemas/types.yaml#/definitions/int32
>> +    - if:
>> +        anyOf:
>> +          - properties:
>> +              qcom,is-receiver: true
>> +          - properties:
>> +              qcom,is-full-duplex: true
>> +      then:
>> +        properties:
>> +          qcom,rx-message-size:
>> +            description: Maximum size in bytes of a message which can be received by this queue
>> +            $ref: /schemas/types.yaml#/definitions/int32
>> +          qcom,rx-queue-depth:
>> +            description: Depth of transmit queue for messages received by this queue
>> +            $ref: /schemas/types.yaml#/definitions/int32
>> +    - if:
>> +        anyOf:
>> +          - properties:
>> +              qcom,is-receiver: true
>> +          - properties:
>> +              qcom,is-sender: true
>> +      then:
>> +        properties:
>> +          reg:
>> +            description: Hypervisor capability ID of the message queue
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            minItems: 1
>> +            maxItems: 1
>> +          interrupts:
>> +            minItems: 1
>> +            maxItems: 1
>> +    - if:
>> +        properties:
>> +          qcom,is-full-duplex: true
>> +      then:
>> +        properties:
>> +          reg:
>> +            description:
>> +              Hypervisor capability IDs of the message queue
>> +              The first is tx side, the second is rx side
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            minItems: 2
>> +            maxItems: 2
>> +          interrupts:
>> +            description: The first is tx interrupt, second is rx interrupt
>> +            minItems: 2
>> +            maxItems: 2
>> +  required:
>> +    - compatible
>> +    - reg
>> +    - interrupts
>> +
>> +
>> +examples:
>> +  - |
>> +    display-msgq-pair@abbf0da3c3c965cc {
>> +      compatible = "qcom,gunyah-message-queue", "qcom,gunyah-capability";
>> +      interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
>> +                    <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
>> +      reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>; /* TX, RX cap ids */
>> +      qcom,is-full-duplex;
>> +      qcom,tx-queue-depth = <8>;
>> +      qcom,tx-message-size = <0xf0>;
>> +      qcom,rx-queue-depth = <8>;
>> +      qcom,rx-message-size = <0xf0>;
>> +    };
>> \ No newline at end of file
> 
> Fix this.
> 
>> diff --git a/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml b/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
>> new file mode 100644
>> index 000000000000..f637d51c52f0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
>> @@ -0,0 +1,122 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gunyah/qcom,hypervisor.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hypervisor node to define virtual devices and other services provided by a Gunyah hypervisor
>> +       to this virtual machine.
>> +
>> +maintainers:
>> +   - Murali Nalajala <quic_mnalajal@quicinc.com>
>> +   - Elliot Berman <quic_eberman@quicinc.com>
>> +
>> +description: |+
>> +  On systems which support devicetree, Gunyah generates and overlays a deviceetree overlay which
>> +  describes the basic configuration of the hypervisor. Virtual machines use this information for
>> +  initial discovery that they are running as a Gunyah guest VM.
>> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: qcom,gunyah-hypervisor-1.0
>> +          - const: qcom,gunyah-hypervisor
>> +
>> +  "#address-cells":
>> +    description: Number of cells needed to represent 64-bit capability IDs.
>> +    const: 2
>> +  "#size-cells":
>> +    description: must be 0, because capability IDs are not memory address
>> +                  ranges and do not have a size.
>> +    const: 0
>> +
>> +  qcom,gunyah-vm:
>> +    type: object
>> +    description:
>> +      The VM Identification is a virtual node that conveys to the VM information
>> +      about this virtual machine in the context of the hypervisor-based system
>> +    properties:
>> +      compatible:
>> +        oneOf:
>> +          - items:
>> +            - const: qcom,gunyah-vm-id-1.0
>> +            - const: qcom,gunyah-vm-id
>> +      qcom,vendor:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        description: Vendor of the Virtual Machine, e.g. Qualcomm
> 
> Doesn't the compatible say this already?
> 

We'll drop "qcom," vendor prefix.

>> +      qcom,vmid:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: contains the VMID of this VM as a 32-bit value
>> +      qcom,owner-vmid:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: Contains the hypervisor VMID of the VM's owner. The owner
>> +                     is the VM that allocated and created the VM. VMs directly
>> +                     managed by the resource manager, such as the primary VM do
>> +                     not have an owner.
>> +    required:
>> +      - compatible
>> +      - qcom,vmid
>> +      - qcom,owner-vmid
>> +
>> +patternProperties:
>> +  "^qcom,resource-manager-rpc(@.*)?":
> 
> We don't use vendor prefixes in node names. QCom really liked to though.
> 

We'll drop "qcom," vendor prefix.

>> +    type: object
>> +    description:
>> +      Resource Manager node which is required to communicate to Resource
>> +      Manager VM using Gunyah Message Queues.
>> +    allOf: "message-queue.yml#"
> 
> Not valid json-schema...
> 
Will double check this in next patch.

>> +
>> +    properties:
>> +      compatible:
>> +        oneOf:
>> +          items:
>> +            - const: qcom,resource-manager-1-0
>> +            - const: qcom,resource-manager
>> +      qcom,console-dev:
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description: if set, the resource-manger will accept console logs from the VM
>> +      qcom,free-irq-start:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: Set on ARM systems which use a GIC. First VIRQ number which is free
>> +                     for virtual interrupt use.
>> +    required:
>> +      - qcom,is-full-duplex
>> +
>> +
>> +required:
>> +- compatible
>> +- "#address-cells"
>> +- "#size-cells"
>> +
>> +examples:
>> +  - |
>> +    hypervisor {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        compatible = "qcom,gunyah-hypervisor-1.0", "qcom,gunyah-hypervisor", "simple-bus";
>> +        name = "hypervisor";
>> +
>> +        qcom,gunyah-vm {
>> +            compatible = "qcom,gunyah-vm-id-1.0", "qcom,gunyah-vm-id";
>> +            qcom,vendor = "Qualcomm Technologies, Inc.";
>> +            qcom,vmid = <45>;
>> +            qcom,owner-vmid = <3>;
>> +        };
>> +
>> +        qcom,resource-manager-rpc@0000000000000001 {
>> +            compatible = "qcom,resource-manager-1-0", "qcom,resource-manager",
>> +                          "qcom,gunyah-message-queue", "qcom,gunyah-capability";
>> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
>> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
>> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
>> +                  /* TX, RX cap ids */
>> +            qcom,is-full-duplex;
>> +            qcom,free-irq-start = <0>;
>> +            qcom,tx-queue-depth = <8>;
>> +            qcom,tx-message-size = <0xf0>;
>> +            qcom,rx-queue-depth = <8>;
>> +            qcom,rx-message-size = <0xf0>;
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bed175adc4c3..6a918f653eac 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8400,6 +8400,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
>>   M:	Murali Nalajala <quic_mnalajal@quicinc.com>
>>   L:	linux-arm-msm@vger.kernel.org
>>   S:	Maintained
>> +F:	Documentation/devicetree/bindings/gunyah/
>>   F:	Documentation/virt/gunyah/
>>   
>>   H8/300 ARCHITECTURE
>> -- 
>> 2.25.1
>>
>>
