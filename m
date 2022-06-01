Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09B53ACF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiFASmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiFASmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:42:43 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4746664715;
        Wed,  1 Jun 2022 11:42:42 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f33f0f5b1dso3850807fac.8;
        Wed, 01 Jun 2022 11:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JtOJAt4h02utxL4GA/jDfNyfYFZdLk65MlPH3JFYnTI=;
        b=nGXIwx/HgQUC+RUkwtnDD4KHx8Xljt2EKogSKhOpU2i8g84L+MMhpSpx0A4Gk0y0ES
         7Gd5JN4005BLJWdnOWKYFllzs3KktjhDGKDl87PM5c53BiO+8j/2h+fJ8E2lGAyBiBXG
         ZcrBgrlr0Ry++xuwBQAXbCbD2fInNqlarR1WjyIv734NNxLyPcXChRrR3E8tNXbTY9Mk
         KtUQZwmedY6EiO79srhAZFLnWy36CzqDjPUSLqq6jRBM+g1Ap9Mxnr8uJ6/97cM9zuBc
         quhK0DhBhFFQPkvMfK7/9azh/p8CoK5P7ciXgg7DBenJJ9v3/h5RXFRsrS4SLa0FPiCS
         qo4w==
X-Gm-Message-State: AOAM533aY5ayBbNNjLedWYHmKIcYfLK5d275pBnUX/+AeFcHncYTvvOC
        d1d8cQ7BQ+bBD0dyRr9HQpv54hToqw==
X-Google-Smtp-Source: ABdhPJwxheeSh/pPWumL7jHozziFKetZCDOJjowSqzlN0G16OiE09mLNW7dZtlAQLdTxD1cRfk/3XA==
X-Received: by 2002:a05:6870:1781:b0:f3:101e:7685 with SMTP id r1-20020a056870178100b000f3101e7685mr540226oae.125.1654108961519;
        Wed, 01 Jun 2022 11:42:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o15-20020a4a84cf000000b0035eb4e5a6cesm1237435oog.36.2022.06.01.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:42:41 -0700 (PDT)
Received: (nullmailer pid 197951 invoked by uid 1000);
        Wed, 01 Jun 2022 18:42:40 -0000
Date:   Wed, 1 Jun 2022 13:42:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     openamp-system-reference@lists.openampproject.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        krzk+dt@kernel.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Message-ID: <20220601184240.GA188558-robh@kernel.org>
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
 <20220531234308.3317795-2-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531234308.3317795-2-tanmay.shah@xilinx.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 04:43:05PM -0700, Tanmay Shah wrote:
> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> (cluster).
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> ---
> 
> Changes in v6:
>   - Add maxItems to sram and memory-region property
> 
> Changes in v5:
> - Add constraints of the possible values of xlnx,cluster-mode property
> - fix description of power-domains property for r5 core
> - Remove reg, address-cells and size-cells properties as it is not required
> - Fix description of mboxes property
> - Add description of each memory-region and remove old .txt binding link
>   reference in the description
> 
> Changes in v4:
>   - Add memory-region, mboxes and mbox-names properties in example
> 
> Changes in v3:
>   - None
> 
> 
>  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 129 ++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> new file mode 100644
> index 000000000000..cbff1c201a89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx R5F processor subsystem
> +
> +maintainers:
> +  - Ben Levinsky <ben.levinsky@xilinx.com>
> +  - Tanmay Shah <tanmay.shah@xilinx.com>
> +
> +description: |
> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
> +  real-time processing based on the Cortex-R5F processor core from ARM.
> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
> +  floating-point unit that implements the Arm VFPv3 instruction set.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-r5fss
> +
> +  xlnx,cluster-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    description: |
> +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
> +      lock-step mode(Both RPU cores execute the same code in lock-step,
> +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
> +      core 1 runs normally). The processor does not support dynamic configuration.
> +      Switching between modes is only permitted immediately after a processor reset.
> +      If set to  1 then lockstep mode and if 0 then split mode.
> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> +
> +patternProperties:
> +  "^r5f-[a-f0-9]+$":
> +    type: object
> +    description: |
> +      The RPU is located in the Low Power Domain of the Processor Subsystem.
> +      Each processor includes separate L1 instruction and data caches and
> +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
> +      memory space is non-cacheable.
> +
> +      Each RPU contains one 64KB memory and two 32KB memories that
> +      are accessed via the TCM A and B port interfaces, for a total of 128KB
> +      per processor. In lock-step mode, the processor has access to 256KB of
> +      TCM memory.
> +
> +    properties:
> +      compatible:
> +        const: xlnx,zynqmp-r5f
> +
> +      power-domains:
> +        description: RPU core PM domain specifier
> +        maxItems: 1
> +
> +      mboxes:
> +        minItems: 1
> +        items:
> +          - description: mailbox channel to send data to RPU
> +          - description: mailbox channel to receive data from RPU
> +
> +      mbox-names:
> +        minItems: 1
> +        items:
> +          - const: tx
> +          - const: rx
> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        maxItems: 8

minItems: 1
maxItems: 8
items:
  maxItems: 1

> +        description: |
> +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
> +          the RPU can execute instructions and access data from, the OCM memory,
> +          the main DDR memory, and other system memories.
> +
> +          The regions should be defined as child nodes of the respective SRAM
> +          node, and should be defined as per the generic bindings in,
> +          Documentation/devicetree/bindings/sram/sram.yaml
> +
> +      memory-region:
> +        description: |
> +          List of phandles to the reserved memory regions associated with the
> +          remoteproc device. This is variable and describes the memories shared with
> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
> +          vrings, ...). This reserved memory region will be allocated on DDR memory.
> +        minItems: 1
> +        maxItems: 8
> +        items:
> +          - description: region used for RPU firmware image section
> +          - description: vdev buffer
> +          - description: vring0
> +          - description: vring1
> +        additionalItems: true
> +
> +    required:
> +      - compatible
> +      - power-domains
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    r5fss: r5fss {
> +        compatible = "xlnx,zynqmp-r5fss";
> +        xlnx,cluster-mode = <1>;
> +
> +        r5f-0 {
> +            compatible = "xlnx,zynqmp-r5f";
> +            power-domains = <&zynqmp_firmware 0x7>;
> +            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> +            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> +            mbox-names = "tx", "rx";
> +        };
> +
> +        r5f-1 {
> +            compatible = "xlnx,zynqmp-r5f";
> +            power-domains = <&zynqmp_firmware 0x8>;
> +            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> +            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> +            mbox-names = "tx", "rx";
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
> index 0d9a412fd5e0..618024cbb20d 100644
> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
> @@ -6,6 +6,12 @@
>  #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>  #define _DT_BINDINGS_ZYNQMP_POWER_H
>  
> +#define		PD_RPU_0	7
> +#define		PD_RPU_1	8
> +#define		PD_R5_0_ATCM	15
> +#define		PD_R5_0_BTCM	16
> +#define		PD_R5_1_ATCM	17
> +#define		PD_R5_1_BTCM	18
>  #define		PD_USB_0	22
>  #define		PD_USB_1	23
>  #define		PD_TTC_0	24
> -- 
> 2.25.1
> 
> 
