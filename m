Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE12853BB70
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiFBPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiFBPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:14:13 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3DD9D4CC;
        Thu,  2 Jun 2022 08:14:11 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-f2cbceefb8so7074172fac.11;
        Thu, 02 Jun 2022 08:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ZadL1zw6i8KMO5fh9Q5arKi4oyBgssFPCtUsRXeJWQ=;
        b=74Xls42noV6dGVcgYIu8X9xYwxmbYLGOqzzFjW9r0irpBqOHNa/4RElXKXQAy5wYbf
         Zfe/fBOzyIoY937OyWBClGQ8YhWC/p7HrTMbb+/Qe4AP/QynfSLCFCnxoKtfHycaTYHu
         TM77sT0teh7gxtm0OGhUtT+kBVytCf1Q5SXvkP/XAhDvNu0W8Er345aNCY1FRyNmtEu4
         k97498Jprrg+nRZ0uirCv1TP+SIYmSJtogB1APlmksqLujK+M60inKWf/XwfLgOmdMcV
         1zp61AQRKEVTM7L2mwXTHQBtj86av5sdaM8v9MYyd/ENsHaTjv2pzNntQeex7ULKxu7s
         vSVw==
X-Gm-Message-State: AOAM532eVkIK+oLoT8wjheFl8+ZPWTJVScRXjhnwYHd6ltdChk1IP3wt
        pm64ZIfGUJsnAyHDvVkP0HsI0d71tNB6
X-Google-Smtp-Source: ABdhPJzAwCQkxG7V7ktiZLgQzY3iiWykAD/DDTVfLswQC6nHYlfO/vO82ui1Cc1rqBIYY5AbTW/+Kw==
X-Received: by 2002:a05:6870:348c:b0:e2:6df1:b1db with SMTP id n12-20020a056870348c00b000e26df1b1dbmr20482904oah.33.1654182850598;
        Thu, 02 Jun 2022 08:14:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b36-20020a056870392400b000f349108868sm2179826oap.44.2022.06.02.08.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 08:14:10 -0700 (PDT)
Received: (nullmailer pid 2339298 invoked by uid 1000);
        Thu, 02 Jun 2022 15:14:09 -0000
Date:   Thu, 2 Jun 2022 10:14:09 -0500
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
Message-ID: <20220602151409.GA2333778-robh@kernel.org>
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
 <20220531234308.3317795-2-tanmay.shah@xilinx.com>
 <20220601184240.GA188558-robh@kernel.org>
 <d7854ce0-3553-3286-809c-651780fb91e5@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7854ce0-3553-3286-809c-651780fb91e5@xilinx.com>
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

On Wed, Jun 01, 2022 at 12:05:09PM -0700, Tanmay Shah wrote:
> Hi Rob,
> 
> Thanks for reviews. Please find my comments below:
> 
> On 6/1/22 11:42 AM, Rob Herring wrote:
> > On Tue, May 31, 2022 at 04:43:05PM -0700, Tanmay Shah wrote:
> > > Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> > > Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> > > (cluster).
> > > 
> > > Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> > > ---
> > > 
> > > Changes in v6:
> > >    - Add maxItems to sram and memory-region property
> > > 
> > > Changes in v5:
> > > - Add constraints of the possible values of xlnx,cluster-mode property
> > > - fix description of power-domains property for r5 core
> > > - Remove reg, address-cells and size-cells properties as it is not required
> > > - Fix description of mboxes property
> > > - Add description of each memory-region and remove old .txt binding link
> > >    reference in the description
> > > 
> > > Changes in v4:
> > >    - Add memory-region, mboxes and mbox-names properties in example
> > > 
> > > Changes in v3:
> > >    - None
> > > 
> > > 
> > >   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 129 ++++++++++++++++++
> > >   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
> > >   2 files changed, 135 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> > > new file mode 100644
> > > index 000000000000..cbff1c201a89
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> > > @@ -0,0 +1,129 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Xilinx R5F processor subsystem
> > > +
> > > +maintainers:
> > > +  - Ben Levinsky <ben.levinsky@xilinx.com>
> > > +  - Tanmay Shah <tanmay.shah@xilinx.com>
> > > +
> > > +description: |
> > > +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
> > > +  real-time processing based on the Cortex-R5F processor core from ARM.
> > > +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
> > > +  floating-point unit that implements the Arm VFPv3 instruction set.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: xlnx,zynqmp-r5fss
> > > +
> > > +  xlnx,cluster-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1, 2]
> > > +    description: |
> > > +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
> > > +      lock-step mode(Both RPU cores execute the same code in lock-step,
> > > +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
> > > +      core 1 runs normally). The processor does not support dynamic configuration.
> > > +      Switching between modes is only permitted immediately after a processor reset.
> > > +      If set to  1 then lockstep mode and if 0 then split mode.
> > > +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> > > +
> > > +patternProperties:
> > > +  "^r5f-[a-f0-9]+$":
> > > +    type: object
> > > +    description: |
> > > +      The RPU is located in the Low Power Domain of the Processor Subsystem.
> > > +      Each processor includes separate L1 instruction and data caches and
> > > +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
> > > +      memory space is non-cacheable.
> > > +
> > > +      Each RPU contains one 64KB memory and two 32KB memories that
> > > +      are accessed via the TCM A and B port interfaces, for a total of 128KB
> > > +      per processor. In lock-step mode, the processor has access to 256KB of
> > > +      TCM memory.
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: xlnx,zynqmp-r5f
> > > +
> > > +      power-domains:
> > > +        description: RPU core PM domain specifier
> > > +        maxItems: 1
> > > +
> > > +      mboxes:
> > > +        minItems: 1
> > > +        items:
> > > +          - description: mailbox channel to send data to RPU
> > > +          - description: mailbox channel to receive data from RPU
> > > +
> > > +      mbox-names:
> > > +        minItems: 1
> > > +        items:
> > > +          - const: tx
> > > +          - const: rx
> > > +
> > > +      sram:
> > > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +        maxItems: 8
> > minItems: 1
> > maxItems: 8
> > items:
> >    maxItems: 1
> 
> I have posted v7 which adds "minItems: 1".
> 
> However, I didn't get items: part. Is it required to have items: now?

Yes.
> 
> Can I add items: part once TCM bindings are posted?

No.

> I understand that minItems and maxItems under sram property decides how many
> phandles sram can have.
> 
> However, maxItems: 1 under items: field what it describes?

'phandle-array' is really a matrix type because we can have phandles 
plus argument cells. So you have to define each of the 1-8 entries is a 
single phandle cell (and no arg cells).

Rob
