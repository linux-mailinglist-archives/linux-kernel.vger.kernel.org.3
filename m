Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7D51C1DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380358AbiEEOHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiEEOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:07:42 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61B58E7A;
        Thu,  5 May 2022 07:04:03 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-deb9295679so4289165fac.6;
        Thu, 05 May 2022 07:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=09d4ImqgAZ5KVmnRazMqFwoFkQlwJHi+fBPthXtLfiM=;
        b=nB7dApo8qKwaT1O7A0oVXU9Fg+I3c3xhM4OgXjgACed7Ea4g0hmqypeOtXctNf5tJS
         PX29tmPnZa1adi5Cl9V7X/XLOt5aQoc3fTsgDdiNTbgTm0e+XcQZEoid0MqT1Wn7TXcv
         dBNGmCIxmY6o2o7K7dOBzBuA+bq+Bine/+v0B8EhchYAzE5lM7Hg1x9rNWqShdSIgVhH
         NU9is1yJ2ZX87l7hfiO/CtvLD7vU1JHZ7faWiCHj2pxGeQk/SgViOgG8/875sABuCSjO
         mE4aJtl3my2YryET2QpbIfiqobZ/MejQjDzCHa0utjL04eJ/+rVfAcrkQhJSqJOZlnG9
         +dnQ==
X-Gm-Message-State: AOAM532hrOWtauBAp84rlt0E8gATqIgm/1xS/Y+kcMPPj3rx2ICwBaD4
        iHXsK9L5imne4/XaN1dBJBuA4x27KA==
X-Google-Smtp-Source: ABdhPJxVnE7BVFNkJXfE9Z3JizfB5JmvCdmhkLTiODPojXNDqWINY/2OUfdNdk6qhlkMhWoZJxO4PQ==
X-Received: by 2002:a05:6870:1709:b0:ed:331a:c3cc with SMTP id h9-20020a056870170900b000ed331ac3ccmr2351299oae.31.1651759442436;
        Thu, 05 May 2022 07:04:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j28-20020a056830241c00b0060603221264sm609424ots.52.2022.05.05.07.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:04:01 -0700 (PDT)
Received: (nullmailer pid 3795326 invoked by uid 1000);
        Thu, 05 May 2022 14:04:00 -0000
Date:   Thu, 5 May 2022 09:04:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        kbuild-all@lists.01.org, bbasu@nvidia.com, vsethi@nvidia.com,
        jsequeira@nvidia.com, Thierry Reding <treding@nvidia.com>
Subject: Re: [Patch v3 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 axi2apb binding
Message-ID: <YnPZUFgZHJ9mFe0D@robh.at.kernel.org>
References: <20211221125117.6545-1-sumitg@nvidia.com>
 <20211221125117.6545-4-sumitg@nvidia.com>
 <YcNv7xm19sFTlfjW@robh.at.kernel.org>
 <226fd57c-2631-ec7a-fc48-d6547d557681@nvidia.com>
 <CAL_Jsq+=hGG-cMwvM0sKFW=Rwa56=fqS379jL4ZjSyDKOia-RA@mail.gmail.com>
 <YhY1Hhgz/O724oYL@orome>
 <e1d484b5-b755-e406-8711-62f3756759f3@nvidia.com>
 <2713db35-927b-c3de-20ba-fb9c613c9291@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2713db35-927b-c3de-20ba-fb9c613c9291@nvidia.com>
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

On Thu, Apr 07, 2022 at 11:54:16AM +0530, Sumit Gupta wrote:
> 
> > 
> > > > > > > Add device-tree binding documentation to represent
> > > > > > > the axi2apb bridges
> > > > > > > used by Control Backbone (CBB) 1.0 in Tegra194 SOC.
> > > > > > > All errors for APB
> > > > > > > slaves are reported as slave error because APB bas
> > > > > > > single bit to report
> > > > > > > error. So, CBB driver needs to further check error
> > > > > > > status registers of
> > > > > > > all the axi2apb bridges to find error type.
> > > > > > > 
> > > > > > > Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> > > > > > > Signed-off-by: Thierry Reding<treding@nvidia.com>
> > > > > > > ---
> > > > > > >    .../arm/tegra/nvidia,tegra194-axi2apb.yaml    |
> > > > > > > 40 +++++++++++++++++++
> > > > > > >    1 file changed, 40 insertions(+)
> > > > > > >    create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> > > > > > > 
> > > > > > > 
> > > > > > > diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> > > > > > > 
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..788a13f8aa93
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> > > > > > > 
> > > > > > > @@ -0,0 +1,40 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id:"http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
> > > > > > > 
> > > > > > > +$schema:"http://devicetree.org/meta-schemas/core.yaml#"
> > > > > > > +
> > > > > > > +title: NVIDIA Tegra194 AXI2APB bridge
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Sumit Gupta<sumitg@nvidia.com>
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  $nodename:
> > > > > > > +    pattern: "^axi2apb@([0-9a-f]+)$"
> > > > > > > +
> > > > > > > +  compatible:
> > > > > > > +    enum:
> > > > > > > +      - nvidia,tegra194-axi2apb
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    maxItems: 6
> > > > > > > +    description: Physical base address and length
> > > > > > > of registers for all bridges
> > > > > > > +
> > > > > > > +additionalProperties: false
> > > > > > > +
> > > > > > > +required:
> > > > > > > +  - compatible
> > > > > > > +  - reg
> > > > > > > +
> > > > > > > +examples:
> > > > > > > +  - |
> > > > > > > +    axi2apb: axi2apb@2390000 {
> > > > > > As axi2apb appears to be a bus, then all the child nodes (APB devices)
> > > > > > should be under this node.
> > > > > axi2apb is a bridge which coverts an AXI to APB interface
> > > > > and not a bus.
> > > > A bus and bridge node are pretty much one and the same in DT
> > > > representation. A PCI host bridge has a PCI bus beneath it for
> > > > example.
> > > Sorry for taking so long to reply, this fell through the cracks.
> > > 
> > > These aren't really bridges as such. CBB (which we call /bus@0 in DT) is
> > > a sort of large container for all IP. Within that there are various shim
> > > layers that connect these "legacy" interfaces to CBB. I suppose you
> > > could call them bridges, but it's a bit of a stretch. From a software
> > > point of view there is no observable translation happening. The only
> > > reason why we need this is for improved error reporting.
> > > 
> > > The TRM also doesn't make a distinction between the various bridges. The
> > > devices are all just mapped into a single address space via the CBB.
> > > 
> > > My understanding is that this is also gone in newer chips, so matters
> > > become a bit simpler there.
> > > 
> > > Reorganizing /bus@0 into multiple bridges and busses would be a lot of
> > > churn and likely confuse people that want to correlate what's in the TRM
> > > to what's in DT, so I don't think it's worth it.
> > > 
> > > For newer chips we may want to keep this in mind so we structure the DT
> > > more accurately from the beginning, though as I said, things have been
> > > simplified a bit, so this may not be an issue anymore.
> > > 
> > > Thierry
> > 
> > Hi Thierry,
> > Thank you for answering the concern.
> > 
> > Hi Rob,
> > Can you please ACK to help queue the patch series for next.
> > 
> > Regards,
> > Sumit
> 
> Ping.

No one is going to apply a 4 month old patch. For starters, the DT 
meta-schema evolves and this could now have errors. Please resend.

Rob
