Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5804E52BE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiERPB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiERPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:00:48 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031CB60;
        Wed, 18 May 2022 08:00:45 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so3009081fac.9;
        Wed, 18 May 2022 08:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tNv/PU3tpajgz+UZuLUwR95zZoInh5OzZr+nVYDtcCU=;
        b=ds+RP170LBJB6cBzfH0le5srnFUAOViYRgbiOh3iZsH5Z2wlGebTpIiEQH4lN8DF4y
         L5/EMgytiho8x0PpzBRt8PxzKNU/1FZxJBpTV/iFy7Ximyq50hgVkLgcQCYDwz2aAKJ1
         02JEdwpcQwtv146TI6hwK1eyCwgCCBVWsV5mN4g3CrXt1X/Ml7fEirilZw+w0liChCHK
         MpNS2zEuwhBPM7/vvRQUIaqyQblTd11RDOOOackCNTp8JMNDWx7SmqkCODkZwksVisWD
         drhvQ7XNrQMwLIWhwsl6duY5AUr1FCQtZpq4/k3UUGbZ8bm8xVM6BMhRHq7Fk+IWCPj+
         /m+Q==
X-Gm-Message-State: AOAM531OzdF52Lw/S+4ePIgy+QuJMyKsyPoO++DkOwjA8UhB10vvmYa0
        riOoajlY4aGMdJZxefPpkg==
X-Google-Smtp-Source: ABdhPJyRe4CU5O9j0kpuzpFKOPgxid6P7iM041ZOnMA/NGI/Vn3rvf2JlToxgf4DKzpy0RyfOOjBMQ==
X-Received: by 2002:a05:6870:ab0b:b0:ee:1ce2:82a0 with SMTP id gu11-20020a056870ab0b00b000ee1ce282a0mr283434oab.94.1652886044776;
        Wed, 18 May 2022 08:00:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r39-20020a05687108a700b000f1bc45ba21sm999317oaq.14.2022.05.18.08.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:00:44 -0700 (PDT)
Received: (nullmailer pid 3306455 invoked by uid 1000);
        Wed, 18 May 2022 15:00:43 -0000
Date:   Wed, 18 May 2022 10:00:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: add bindings for Intel HPS Copy
 Engine
Message-ID: <20220518150043.GA3302100-robh@kernel.org>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
 <20220508142624.491045-2-matthew.gerlach@linux.intel.com>
 <Ynq52E93mcTXcw9H@robh.at.kernel.org>
 <alpine.DEB.2.22.394.2205101452530.885823@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2205101452530.885823@rhweight-WRK1>
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

On Tue, May 10, 2022 at 03:23:23PM -0700, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 10 May 2022, Rob Herring wrote:
> 
> > On Sun, May 08, 2022 at 07:26:22AM -0700, matthew.gerlach@linux.intel.com wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > Add device tree bindings documentation for the Intel Hard
> > > Processor System (HPS) Copy Engine.
> > > 
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > ---
> > > v4:
> > >   - move from soc to soc/intel/
> > > 
> > > v3:
> > >   - remove unused label
> > >   - move from misc to soc
> > >   - remove 0x from #address-cells/#size-cells values
> > >   - change hps_cp_eng@0 to dma-controller@0
> > >   - remote inaccurate 'items:' tag
> > > ---
> > >  .../soc/intel/intel,hps-copy-engine.yaml      | 51 +++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml b/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
> > > new file mode 100644
> > > index 000000000000..8634865015cd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
> > > @@ -0,0 +1,51 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright (C) 2022, Intel Corporation
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/soc/intel/intel,hps-copy-engine.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Intel HPS Copy Engine
> > > +
> > > +maintainers:
> > > +  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > +
> > > +description: |
> > > +  The Intel Hard Processor System (HPS) Copy Engine is an IP block used to copy
> > > +  a bootable image from host memory to HPS DDR.  Additionally, there is a
> > > +  register the HPS can use to indicate the state of booting the copied image as
> > > +  well as a keep-a-live indication to the host.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: intel,hps-copy-engine
> > > +
> > > +  '#dma-cells':
> > > +    const: 1
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    bus@80000000 {
> > > +        compatible = "simple-bus";
> > > +        reg = <0x80000000 0x60000000>,
> > > +              <0xf9000000 0x00100000>;
> > > +        reg-names = "axi_h2f", "axi_h2f_lw";
> > 
> > A simple-bus doesn't have regs because it is simple. If you have
> > registers, then you need a specific compatible. You can have
> > 'simple-bus' as a fallback if the bus is completely setup by firmware
> > and the OS never needs to configure/manage it.
> 
> The hardware I'm trying to describe above is the connection from the HPS/SOC
> to the FPGA.  There are two ranges of physical addresses with this
> connection referred to as the "HPS to FPGA bridge" and the "Lightweight HPS
> to FPGA bridge".  Device tree subnodes of bus@80000000 are IP blocks in the
> FPGA.  The IP blocks may be connected to one or both of the
> physical address ranges.  Since these physical address ranges are not registers
> of the bus@80000000, the field names, reg and reg-names, are probably wrong.
> Should the reg field above really be ranges?

Yes, sound likes it should be.

Rob
