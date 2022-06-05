Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482FA53DEB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351725AbiFEWpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiFEWpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:45:38 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2C44E3B1;
        Sun,  5 Jun 2022 15:45:37 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id h18so9236124qvj.11;
        Sun, 05 Jun 2022 15:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uDzznG00WmBRTYCBcArlD1mf1zVfk2p9nd9xHJn3CVw=;
        b=QLyZgAZNPM+rWgMRlc+DXzdYgBh9Ra7qyZeFJTNP28/zf3I61wuWo/962L1eLwfoG/
         UkHve7OM1ZNRY8Ff6rAlsDo5ibsayReFl0nw99WkjCd+hhgRpA9hC7y87zrKh+Q9r1Ir
         0HEyiMBBKDOds7sQSqMFekEooHi04wIyaQsu5S+UpzAY2G+SQ/c82n7UjQNk+XMpPL0q
         uwEOKjms5mUvOi67wduCpTaKYixVA4QZIKZR1xeoHOlnw1uknSDxlZMXi4Gdu7EV8SUG
         LUZs0JjZacoqV3BR3h8cO/UIhXC5Q58XYn62r0Q2QSAu/Gct2czhtHwnhWCdfsu21c6V
         102A==
X-Gm-Message-State: AOAM532tws8z8BEu6Clcy25iWx0PYsAOmib6lkDDAuO5pwpXu2urD34i
        GPI2ouj+1HamC5HUz+Vx+9qzobtLgg==
X-Google-Smtp-Source: ABdhPJwmsDYIVR7qLkG6UWB/x8H/AgliTU6o4B+wWC9F21jxx0e09sjuNDCoG74Zm/3g90Nz9x+0LQ==
X-Received: by 2002:ad4:5447:0:b0:461:d7a7:f0ec with SMTP id h7-20020ad45447000000b00461d7a7f0ecmr70549704qvt.21.1654469136911;
        Sun, 05 Jun 2022 15:45:36 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id v128-20020a37dc86000000b0069fc13ce244sm10341437qki.117.2022.06.05.15.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:45:36 -0700 (PDT)
Received: (nullmailer pid 3667844 invoked by uid 1000);
        Sun, 05 Jun 2022 22:45:33 -0000
Date:   Sun, 5 Jun 2022 17:45:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Julien Grall <julien@xen.org>, xen-devel@lists.xenproject.org,
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V4 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
Message-ID: <20220605224533.GA3667788-robh@kernel.org>
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
 <1654197833-25362-6-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654197833-25362-6-git-send-email-olekstysh@gmail.com>
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

On Thu, 02 Jun 2022 22:23:50 +0300, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> The main purpose of this binding is to communicate Xen specific
> information using generic IOMMU device tree bindings (which is
> a good fit here) rather than introducing a custom property.
> 
> Introduce Xen specific IOMMU for the virtualized device (e.g. virtio)
> to be used by Xen grant DMA-mapping layer in the subsequent commit.
> 
> The reference to Xen specific IOMMU node using "iommus" property
> indicates that Xen grant mappings need to be enabled for the device,
> and it specifies the ID of the domain where the corresponding backend
> resides. The domid (domain ID) is used as an argument to the Xen grant
> mapping APIs.
> 
> This is needed for the option to restrict memory access using Xen grant
> mappings to work which primary goal is to enable using virtio devices
> in Xen guests.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
> Changes RFC -> V1:
>    - update commit subject/description and text in description
>    - move to devicetree/bindings/arm/
> 
> Changes V1 -> V2:
>    - update text in description
>    - change the maintainer of the binding
>    - fix validation issue
>    - reference xen,dev-domid.yaml schema from virtio/mmio.yaml
> 
> Change V2 -> V3:
>    - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
>    - use generic IOMMU device tree bindings instead of custom property
>      "xen,dev-domid"
>    - change commit subject and description, was
>      "dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops"
> 
> Changes V3 -> V4:
>    - add Stefano's R-b
>    - remove underscore in iommu node name
>    - remove consumer example virtio@3000
>    - update text for two descriptions
> ---
>  .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
