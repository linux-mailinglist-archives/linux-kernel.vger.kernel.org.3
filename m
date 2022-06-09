Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE454532E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbiFIRlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344696AbiFIRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:41:13 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79516B2C0;
        Thu,  9 Jun 2022 10:41:12 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id f7so19272904ilr.5;
        Thu, 09 Jun 2022 10:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vvuEZ+ahbF/TjJmGRAqIakqEcaAp2NfM45XvNptvRrY=;
        b=a6tBnRgkD27NQl88p14bOvImXsIhiAhdKlsiaRBzB/GbL6/9HDm64cBUPtcMgi2hlk
         wlBNb1skoGieIJ0HKepQMKCdX7XY/3RJNot64aScuwEkKThV/qXwapI3PK635hNIY7IC
         Ub1DsbC9HO9/SXhkaVeRMiG7v7EkiecvEGwYZCNa/lDnTEugERHiUFlQfXZXNqf2H0Nv
         iG7USmtlcyBFXU4gfd7hF/pXJQ10pBl5KROun9rTvV0o0z2NMYt0BF+ypb6tbnvBoqPY
         GTw+igHk0sxQ1gt/A/REVqTMaZ6MFvavGX8kMmk6LkT1LyBk0TVJKbCDtni7e6KAXluQ
         WBbw==
X-Gm-Message-State: AOAM532jGjbyQ60FW9RXNiC+nNkyZXIE/8PPUDryNVr/EUCxX9TaH/H3
        SqqdsOy2+Cn0XIKzUDbkzQ==
X-Google-Smtp-Source: ABdhPJw05Q21QpLVW1caJjvIBqdflv0+c5+2dJLA0xkQFgTBityuX+S4qVzYLVgwKtEADXxlB58Klw==
X-Received: by 2002:a05:6e02:188f:b0:2d3:c38f:7e9b with SMTP id o15-20020a056e02188f00b002d3c38f7e9bmr22830438ilu.151.1654796471217;
        Thu, 09 Jun 2022 10:41:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056602368a00b0065a47e16f38sm8214473iob.10.2022.06.09.10.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:41:10 -0700 (PDT)
Received: (nullmailer pid 4010790 invoked by uid 1000);
        Thu, 09 Jun 2022 17:41:08 -0000
Date:   Thu, 9 Jun 2022 11:41:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     Tanmay Shah <tanmay.shah@xilinx.com>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, krzk+dt@kernel.org,
        michal.simek@xilinx.com, ben.levinsky@xilinx.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        openamp-system-reference@lists.openampproject.org
Subject: Re: [PATCH v8 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Message-ID: <20220609174108.GB3996953-robh@kernel.org>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
 <20220602203834.3675160-2-tanmay.shah@xilinx.com>
 <87tu921ck6.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu921ck6.fsf@dell.be.48ers.dk>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 08:33:13AM +0200, Peter Korsgaard wrote:
> >>>>> "Tanmay" == Tanmay Shah <tanmay.shah@xilinx.com> writes:
> 
> Hi,
> 
>  > Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>  > Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
>  > (cluster).
> 
>  > Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>  > ---
> 
>  > Changes in v8:
>  >   - Add 'items:' for sram property
> 
>  > Changes in v7:
>  >   - Add minItems in sram property
> 
>  > Changes in v6:
>  >   - Add maxItems to sram and memory-region property
> 
>  > Changes in v5:
>  > - Add constraints of the possible values of xlnx,cluster-mode property
>  > - fix description of power-domains property for r5 core
>  > - Remove reg, address-cells and size-cells properties as it is not required
>  > - Fix description of mboxes property
>  > - Add description of each memory-region and remove old .txt binding link
>  >   reference in the description
> 
>  > Changes in v4:
>  >   - Add memory-region, mboxes and mbox-names properties in example
> 
>  > Changes in v3:
>  >   - None
> 
>  >  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 130 ++++++++++++++++++
>  >  include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>  >  2 files changed, 138 insertions(+)
>  >  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> 
>  > diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>  > new file mode 100644
>  > index 000000000000..adfe05ff157a
>  > --- /dev/null
>  > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>  > @@ -0,0 +1,132 @@
>  > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>  > +%YAML 1.2
>  > +---
>  > +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
>  > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  > +
>  > +title: Xilinx R5F processor subsystem
>  > +
>  > +maintainers:
>  > +  - Ben Levinsky <ben.levinsky@xilinx.com>
>  > +  - Tanmay Shah <tanmay.shah@xilinx.com>
>  > +
>  > +description: |
>  > +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
>  > +  real-time processing based on the Cortex-R5F processor core from ARM.
>  > +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
>  > +  floating-point unit that implements the Arm VFPv3 instruction set.
>  > +
>  > +properties:
>  > +  compatible:
>  > +    const: xlnx,zynqmp-r5fss
>  > +
>  > +  xlnx,cluster-mode:
>  > +    $ref: /schemas/types.yaml#/definitions/uint32
>  > +    enum: [0, 1, 2]
> 
> A textual mode ("dual", "lock-step", "single") would be more readable.
> 
> 
>  > +    description: |
>  > +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
> 
> space missing before "(Dual-processor"
> 
> 
>  > +      lock-step mode(Both RPU cores execute the same code in lock-step,
>  > +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
> 
> "can be" sounds a bit weak, perhaps "is"
> 
> 
>  > +      core 1 runs normally). The processor does not support dynamic configuration.
>  > +      Switching between modes is only permitted immediately after a processor reset.
>  > +      If set to  1 then lockstep mode and if 0 then split mode.
>  > +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> 
> This looks a bit confusing. If you decide to stick to the numerical
> modes, then at least list them in numerical order, E.G.:
> 
>  0: split
>  1: lockstep
>  2: single

The bigger issue has been multiple Cortex-R5 bindings all doing their 
own thing for this feature which is not vendor specific (except TI has 
their own extra mode or something). How TCMs are described is the 
other issue. I've just stopped caring because no one listens.

> 
> > +
>  > +patternProperties:
>  > +  "^r5f-[a-f0-9]+$":
>  > +    type: object
>  > +    description: |
>  > +      The RPU is located in the Low Power Domain of the Processor Subsystem.
>  > +      Each processor includes separate L1 instruction and data caches and
>  > +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
>  > +      memory space is non-cacheable.
>  > +
>  > +      Each RPU contains one 64KB memory and two 32KB memories that
>  > +      are accessed via the TCM A and B port interfaces, for a total of 128KB
>  > +      per processor. In lock-step mode, the processor has access to 256KB of
>  > +      TCM memory.
>  > +
>  > +    properties:
>  > +      compatible:
>  > +        const: xlnx,zynqmp-r5f
>  > +
>  > +      power-domains:
>  > +        description: RPU core PM domain specifier
>  > +        maxItems: 1
> 
> A bit more detail would be good, E.G. something like arm/cpus.yaml does:
> 
>       List of phandles and PM domain specifiers, as defined by bindings of the
>       PM domain provider (see also ../power_domain.txt).
> 
> And the phandle-array ref.

Both suggestions are wrong. We don't need common properties re-described 
by every user. They already have a type definition too, so we don't need 
to repeat phandle-array ref either.

The existing description is not needed either as it doesn't provide any 
information specific to this binding. You only need to describe each 
entry when there is more than 1 entry because we need to know what each 
entry is and the order.

> > +
>  > +      mboxes:
>  > +        minItems: 1
>  > +        items:
>  > +          - description: mailbox channel to send data to RPU
>  > +          - description: mailbox channel to receive data from RPU
>  > +
>  > +      mbox-names:
>  > +        minItems: 1
>  > +        items:
>  > +          - const: tx
>  > +          - const: rx
> 
> And here as well for mailbox/mailbox.txt

Nope!

> 
> 
>  > +
>  > +      sram:
>  > +        $ref: /schemas/types.yaml#/definitions/phandle-array
>  > +        minItems: 1
>  > +        maxItems: 8
>  > +        items:
>  > +          maxItems: 1
>  > +        description: |
>  > +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
>  > +          the RPU can execute instructions and access data from, the OCM memory,
>  > +          the main DDR memory, and other system memories.
> 
> Drop the comma after "from"
> 
> 
>  > +
>  > +          The regions should be defined as child nodes of the respective SRAM
>  > +          node, and should be defined as per the generic bindings in,
> 
> Drop the comma after "in"
> 
> 
>  > +          Documentation/devicetree/bindings/sram/sram.yaml
>  > +
>  > +      memory-region:
>  > +        description: |
>  > +          List of phandles to the reserved memory regions associated with the
>  > +          remoteproc device. This is variable and describes the memories shared with
>  > +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
>  > +          vrings, ...). This reserved memory region will be allocated on DDR memory.
> 
> s/on DDR/in DDR/
> 
>  > +        minItems: 1
>  > +        maxItems: 8
>  > +        items:
>  > +          - description: region used for RPU firmware image section
>  > +          - description: vdev buffer
>  > +          - description: vring0
>  > +          - description: vring1
>  > +        additionalItems: true
>  > +
>  > +    required:
>  > +      - compatible
>  > +      - power-domains
>  > +
>  > +    unevaluatedProperties: false
>  > +
>  > +required:
>  > +  - compatible
>  > +
>  > +additionalProperties: false
>  > +
>  > +examples:
>  > +  - |
>  > +    r5fss: r5fss {
>  > +        compatible = "xlnx,zynqmp-r5fss";
>  > +        xlnx,cluster-mode = <1>;
>  > +
>  > +        r5f-0 {
>  > +            compatible = "xlnx,zynqmp-r5f";
>  > +            power-domains = <&zynqmp_firmware 0x7>;
>  > +            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
>  > +            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
>  > +            mbox-names = "tx", "rx";
>  > +        };
>  > +
>  > +        r5f-1 {
>  > +            compatible = "xlnx,zynqmp-r5f";
>  > +            power-domains = <&zynqmp_firmware 0x8>;
>  > +            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
>  > +            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
>  > +            mbox-names = "tx", "rx";
>  > +        };
>  > +    };
>  > +...
>  > diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
>  > index 0d9a412fd5e0..618024cbb20d 100644
>  > --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
>  > +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
>  > @@ -6,6 +6,12 @@
>  >  #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>  >  #define _DT_BINDINGS_ZYNQMP_POWER_H
>  
>  > +#define		PD_RPU_0	7
>  > +#define		PD_RPU_1	8
>  > +#define		PD_R5_0_ATCM	15
>  > +#define		PD_R5_0_BTCM	16
>  > +#define		PD_R5_1_ATCM	17
>  > +#define		PD_R5_1_BTCM	18
>  >  #define		PD_USB_0	22
>  >  #define		PD_USB_1	23
>  >  #define		PD_TTC_0	24
>  > -- 
> 
>  > 2.25.1
> 
> 
> -- 
> Bye, Peter Korsgaard
> 
