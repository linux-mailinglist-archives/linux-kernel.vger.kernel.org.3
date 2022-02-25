Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2806B4C4F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiBYUB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbiBYUBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:01:55 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAD4186BAE;
        Fri, 25 Feb 2022 12:01:22 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id 12so8386746oix.12;
        Fri, 25 Feb 2022 12:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frBFZJiDgvdrAxS1HtE7V8w1olhciF/WOn+PoYUmIUc=;
        b=ILClbmVbz5DizoeAjiz4/c2BGD+wUVt083+2LvghpN6d6i3KEF7a48EVkUZgxrVrkH
         2yEd54MeT2x74neWnsWqm3/IQmsBV0yJRUvoP6qbEZ4BAMLT8SDAji6y2owHbsj6qfmU
         gqlUxpp+lsWFxFIe6robpQjEBXUgPcYFAbO5SxgG5dJj2SUsOtYRRsIGtY/m7nvFl6Vu
         tS7lTyRf/wEPf/sJiE43SuB9z/Ah0/nf9d0esMtyLR8NoVvg6gMv6Tl+hR9cd0syq9Li
         +LgcAUMoZXDbpXz6nEr3dJV2AdpELOvsqObTTQH9AeT8d/18dpvVMVFk0c/zhrIUDSiz
         Nc8Q==
X-Gm-Message-State: AOAM533SOckCFO/q2X+9jpPwi4ONH4E8ymhjzntxbg6NOQZ4d3bj2bix
        SP/YdjxlIi4L4dPXrKBkhQ==
X-Google-Smtp-Source: ABdhPJz8st9yo0vrY6CZcQClZDZVHnhrApDOTl4TJlhf2MS6fabvM7dryg2lgz/O7OSdsijWCDlLAQ==
X-Received: by 2002:a05:6808:1305:b0:2d5:42b0:5e1a with SMTP id y5-20020a056808130500b002d542b05e1amr2724884oiv.34.1645819281295;
        Fri, 25 Feb 2022 12:01:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t9-20020a056871054900b000c53354f98esm1693953oal.13.2022.02.25.12.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:01:20 -0800 (PST)
Received: (nullmailer pid 1338190 invoked by uid 1000);
        Fri, 25 Feb 2022 20:01:19 -0000
Date:   Fri, 25 Feb 2022 14:01:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: Add binding for gunyah hypervisor
Message-ID: <Yhk1j7riufsOFUsg@robh.at.kernel.org>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220223233729.1571114-3-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223233729.1571114-3-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 03:37:20PM -0800, Elliot Berman wrote:
> When Linux is booted as a guest under the Gunyah hypervisor, Gunyah
> applies a devicetree overlay describing the virtual platform
> configuration of the guest VM, such as the message queue capability IDs
> for communicating with the Resource Manager. Add the DT bindings that
> Gunyah adheres for the hypervisor node and message queues.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../bindings/gunyah/message-queue.yml         | 100 ++++++++++++++
>  .../bindings/gunyah/qcom,hypervisor.yml       | 122 ++++++++++++++++++

How did testing these files work? It didn't because .yml files are 
ignored. Get 'make dt_binding_check' actually working and resubmit.

No, you don't get your own directory.

In general, DT is for undiscoverable hardware that we are stuck with 
because it was not made discoverable. As this is not h/w and you control 
each side of the interface, make it discoverable and don't use DT for 
your discovery mechanism.

Incomplete review follows...

>  MAINTAINERS                                   |   1 +
>  3 files changed, 223 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gunyah/message-queue.yml
>  create mode 100644 Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
> 
> diff --git a/Documentation/devicetree/bindings/gunyah/message-queue.yml b/Documentation/devicetree/bindings/gunyah/message-queue.yml
> new file mode 100644
> index 000000000000..1a96d3de2a19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gunyah/message-queue.yml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gunyah/qcom,hypervisor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gunyah message queue
> +
> +maintainers:
> +   - Murali Nalajala <quic_mnalajal@quicinc.com>
> +   - Elliot Berman <quic_eberman@quicinc.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,gunyah-message-queue
> +      - const: qcom,gunyah-capability

I'm not following how capability is a fallback to message-queue.

> +  peer:
> +    description: VMID of the VM on the other end of message queue
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +  allOf:

Check your indentation.

> +    - if:
> +        anyOf:
> +          - properties:
> +              qcom,is-sender: true
> +          - properties:
> +              qcom,is-full-duplex: true
> +      then:
> +        properties:
> +          qcom,tx-message-size:
> +            description: Maximum size in bytes of a message which can be sent by this queue
> +            $ref: /schemas/types.yaml#/definitions/int32
> +          qcom,tx-queue-depth:
> +            description: Depth of transmit queue for messages sent by this queue
> +            $ref: /schemas/types.yaml#/definitions/int32
> +    - if:
> +        anyOf:
> +          - properties:
> +              qcom,is-receiver: true
> +          - properties:
> +              qcom,is-full-duplex: true
> +      then:
> +        properties:
> +          qcom,rx-message-size:
> +            description: Maximum size in bytes of a message which can be received by this queue
> +            $ref: /schemas/types.yaml#/definitions/int32
> +          qcom,rx-queue-depth:
> +            description: Depth of transmit queue for messages received by this queue
> +            $ref: /schemas/types.yaml#/definitions/int32
> +    - if:
> +        anyOf:
> +          - properties:
> +              qcom,is-receiver: true
> +          - properties:
> +              qcom,is-sender: true
> +      then:
> +        properties:
> +          reg:
> +            description: Hypervisor capability ID of the message queue
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minItems: 1
> +            maxItems: 1
> +          interrupts:
> +            minItems: 1
> +            maxItems: 1
> +    - if:
> +        properties:
> +          qcom,is-full-duplex: true
> +      then:
> +        properties:
> +          reg:
> +            description:
> +              Hypervisor capability IDs of the message queue
> +              The first is tx side, the second is rx side
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minItems: 2
> +            maxItems: 2
> +          interrupts:
> +            description: The first is tx interrupt, second is rx interrupt
> +            minItems: 2
> +            maxItems: 2
> +  required:
> +    - compatible
> +    - reg
> +    - interrupts
> +
> +
> +examples:
> +  - |
> +    display-msgq-pair@abbf0da3c3c965cc {
> +      compatible = "qcom,gunyah-message-queue", "qcom,gunyah-capability";
> +      interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
> +                    <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
> +      reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>; /* TX, RX cap ids */
> +      qcom,is-full-duplex;
> +      qcom,tx-queue-depth = <8>;
> +      qcom,tx-message-size = <0xf0>;
> +      qcom,rx-queue-depth = <8>;
> +      qcom,rx-message-size = <0xf0>;
> +    };
> \ No newline at end of file

Fix this.

> diff --git a/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml b/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
> new file mode 100644
> index 000000000000..f637d51c52f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gunyah/qcom,hypervisor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hypervisor node to define virtual devices and other services provided by a Gunyah hypervisor
> +       to this virtual machine.
> +
> +maintainers:
> +   - Murali Nalajala <quic_mnalajal@quicinc.com>
> +   - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |+
> +  On systems which support devicetree, Gunyah generates and overlays a deviceetree overlay which
> +  describes the basic configuration of the hypervisor. Virtual machines use this information for
> +  initial discovery that they are running as a Gunyah guest VM.
> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: qcom,gunyah-hypervisor-1.0
> +          - const: qcom,gunyah-hypervisor
> +
> +  "#address-cells":
> +    description: Number of cells needed to represent 64-bit capability IDs.
> +    const: 2
> +  "#size-cells":
> +    description: must be 0, because capability IDs are not memory address
> +                  ranges and do not have a size.
> +    const: 0
> +
> +  qcom,gunyah-vm:
> +    type: object
> +    description:
> +      The VM Identification is a virtual node that conveys to the VM information
> +      about this virtual machine in the context of the hypervisor-based system
> +    properties:
> +      compatible:
> +        oneOf:
> +          - items:
> +            - const: qcom,gunyah-vm-id-1.0
> +            - const: qcom,gunyah-vm-id
> +      qcom,vendor:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Vendor of the Virtual Machine, e.g. Qualcomm

Doesn't the compatible say this already?

> +      qcom,vmid:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: contains the VMID of this VM as a 32-bit value
> +      qcom,owner-vmid:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Contains the hypervisor VMID of the VM's owner. The owner
> +                     is the VM that allocated and created the VM. VMs directly
> +                     managed by the resource manager, such as the primary VM do
> +                     not have an owner.
> +    required:
> +      - compatible
> +      - qcom,vmid
> +      - qcom,owner-vmid
> +
> +patternProperties:
> +  "^qcom,resource-manager-rpc(@.*)?":

We don't use vendor prefixes in node names. QCom really liked to though.

> +    type: object
> +    description:
> +      Resource Manager node which is required to communicate to Resource
> +      Manager VM using Gunyah Message Queues.
> +    allOf: "message-queue.yml#"

Not valid json-schema...

> +
> +    properties:
> +      compatible:
> +        oneOf:
> +          items:
> +            - const: qcom,resource-manager-1-0
> +            - const: qcom,resource-manager
> +      qcom,console-dev:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: if set, the resource-manger will accept console logs from the VM
> +      qcom,free-irq-start:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Set on ARM systems which use a GIC. First VIRQ number which is free
> +                     for virtual interrupt use.
> +    required:
> +      - qcom,is-full-duplex
> +
> +
> +required:
> +- compatible
> +- "#address-cells"
> +- "#size-cells"
> +
> +examples:
> +  - |
> +    hypervisor {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        compatible = "qcom,gunyah-hypervisor-1.0", "qcom,gunyah-hypervisor", "simple-bus";
> +        name = "hypervisor";
> +
> +        qcom,gunyah-vm {
> +            compatible = "qcom,gunyah-vm-id-1.0", "qcom,gunyah-vm-id";
> +            qcom,vendor = "Qualcomm Technologies, Inc.";
> +            qcom,vmid = <45>;
> +            qcom,owner-vmid = <3>;
> +        };
> +
> +        qcom,resource-manager-rpc@0000000000000001 {
> +            compatible = "qcom,resource-manager-1-0", "qcom,resource-manager",
> +                          "qcom,gunyah-message-queue", "qcom,gunyah-capability";
> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> +                  /* TX, RX cap ids */
> +            qcom,is-full-duplex;
> +            qcom,free-irq-start = <0>;
> +            qcom,tx-queue-depth = <8>;
> +            qcom,tx-message-size = <0xf0>;
> +            qcom,rx-queue-depth = <8>;
> +            qcom,rx-message-size = <0xf0>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bed175adc4c3..6a918f653eac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8400,6 +8400,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
>  M:	Murali Nalajala <quic_mnalajal@quicinc.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/gunyah/
>  F:	Documentation/virt/gunyah/
>  
>  H8/300 ARCHITECTURE
> -- 
> 2.25.1
> 
> 
