Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61F52C2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbiERS7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiERS7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:59:07 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F08421A942;
        Wed, 18 May 2022 11:59:06 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id l16so3799068oil.6;
        Wed, 18 May 2022 11:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hl6vHR8m/JLovYO2gNE3ChbiYGqpt17k+OnwcqxZkjo=;
        b=hodY84OWJLzorbbOhgzV8IJNUYfsvFv4kMCVWDIFiLK5rTsCi3tNw9fuHr+WlxVv1V
         bTh96UT4WxSr/80pv244V0qdFJmTizO9vvmnuDgUWDCcZVrALBpDroPZlmQ28pqFP/5x
         YxzwT+PeHC0qDc1LCst9D9kTXLNZ2xn2PuA9aPQ45hmVjLpkCFxBuWBlkFkwe7bwBLFV
         pxQZgrIv+TvHYLhITlLBn+UGYQMJvTe+c1RWI7mY5KmxgNmlieaenV9ZhrSvEZfUxdd0
         F3uwrvA+FxzqSH6W1bWSCXzz0WnmIpKimcIh5lbe8TtClfZuJy0unaB2AGnS7vKG0nIN
         rEcg==
X-Gm-Message-State: AOAM531nXTWBx+y3CcSEs+hj9qWeX8WMI80k1JGukkggbOtmaf1xuJkR
        5QkeMkRmEddaYOwG4t4Keg==
X-Google-Smtp-Source: ABdhPJyZK52/lZYsS9R3kKj1OyynJ0P1NooNpNVdFnOOXczUhwNDyIXF2qHiL1sltyV70oHQTWK1Fg==
X-Received: by 2002:a05:6808:aa4:b0:325:91ff:43cc with SMTP id r4-20020a0568080aa400b0032591ff43ccmr623013oij.166.1652900345928;
        Wed, 18 May 2022 11:59:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd15-20020a056870d78f00b000e686d1389esm1202223oab.56.2022.05.18.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:59:05 -0700 (PDT)
Received: (nullmailer pid 3695375 invoked by uid 1000);
        Wed, 18 May 2022 18:59:04 -0000
Date:   Wed, 18 May 2022 13:59:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
Message-ID: <20220518185904.GA3685644-robh@kernel.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
 <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
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

On Wed, May 18, 2022 at 03:32:27PM +0100, Arnd Bergmann wrote:
> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
> >
> > diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> > index 10c22b5..29a0932 100644
> > --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> > +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> > @@ -13,6 +13,9 @@ description:
> >    See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
> >    more details.
> >
> > +allOf:
> > +  - $ref: /schemas/arm/xen,dev-domid.yaml#
> > +
> >  properties:
> >    compatible:
> >      const: virtio,mmio
> > @@ -33,6 +36,10 @@ properties:
> >      description: Required for devices making accesses thru an IOMMU.
> >      maxItems: 1
> >
> > +  xen,dev-domid:
> > +    description: Required when Xen grant mappings need to be enabled for device.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >  required:
> >    - compatible
> >    - reg
> 
> Sorry for joining the discussion late. Have you considered using the
> generic iommu
> binding here instead of a custom property? This would mean having a device
> node for the grant-table mechanism that can be referred to using the 'iommus'
> phandle property, with the domid as an additional argument.
> 
> It does not quite fit the model that Linux currently uses for iommus,
> as that has an allocator for dma_addr_t space, but it would think it's
> conceptually close enough that it makes sense for the binding.

Something common is almost always better.

That may also have the issue that fw_devlink will make the 'iommu' 
driver a dependency to probe.

Rob
