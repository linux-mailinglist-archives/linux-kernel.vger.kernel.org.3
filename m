Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6E517996
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387772AbiEBWDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiEBWDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:03:17 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392471FF;
        Mon,  2 May 2022 14:59:47 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id l9-20020a4abe09000000b0035eb3d4a2aeso1929899oop.0;
        Mon, 02 May 2022 14:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OfkNLJQzEZ7e5xPqfxUYJG64Wv+bQWkevq09mi7Lx3c=;
        b=aH+vPtiB8afc82+9H3j0WhIkxZLLh2yOvX15hoqRTWu+pf00Mw6OjT8FxUtH1nOulL
         avYb0UoOcu/e6YvBWKVpZwu8/U8OZ9XKJqs04JrrZIcjoaqgzf1b3Z1Wb4cPED0aavaQ
         JZ5kdvUuk3N9jT8YNmJsqxA5DvNnlDl2kykBYPGkwWSfmNjtQ3i9jcZ8qE9SxtHKPoCo
         kw5SJAR0gvf3pODtIGTHcLYNBWjdNCJLsi3yvDsrj/wuUfkGpMiPa2i+YjqGRfwGqbZd
         qYmY7ZsosJZ0qP5DqtyOwO8sttB7YQ7FW2EI+Y85w8I6/0swidZ8+KSnC/ZfXy3QPVu/
         xOHA==
X-Gm-Message-State: AOAM532+2NohzzVA++hkcrUyRpD6yeDGFWOOpZACaswhTWzCEVbqt6II
        co+ZJs8cpFaRJy9XJZD+ag==
X-Google-Smtp-Source: ABdhPJx1LDExPGSXpHz8IMEURBsoMHXT9iZfDmEKZxw3kRgHSp4/DSf2T1IKY9UfgGxULbEh9lAUBQ==
X-Received: by 2002:a4a:ac45:0:b0:35e:a8f2:7f55 with SMTP id q5-20020a4aac45000000b0035ea8f27f55mr4805941oon.46.1651528786470;
        Mon, 02 May 2022 14:59:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s1-20020a4ae541000000b0035eb4e5a6c8sm4329464oot.30.2022.05.02.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:59:46 -0700 (PDT)
Received: (nullmailer pid 1863055 invoked by uid 1000);
        Mon, 02 May 2022 21:59:45 -0000
Date:   Mon, 2 May 2022 16:59:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V1 4/6] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
Message-ID: <YnBUUclJqkvKsV2o@robh.at.kernel.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-5-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650646263-22047-5-git-send-email-olekstysh@gmail.com>
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

On Fri, Apr 22, 2022 at 07:51:01PM +0300, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Introduce Xen specific binding for the virtualized device (e.g. virtio)
> to be used by Xen grant DMA-mapping layer in the subsequent commit.
> 
> This binding indicates that Xen grant mappings scheme needs to be
> enabled for the device which DT node contains that property and specifies
> the ID of Xen domain where the corresponding backend resides. The ID
> (domid) is used as an argument to the grant mapping APIs.
> 
> This is needed for the option to restrict memory access using Xen grant
> mappings to work which primary goal is to enable using virtio devices
> in Xen guests.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Changes RFC -> V1:
>    - update commit subject/description and text in description
>    - move to devicetree/bindings/arm/
> ---
>  .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> new file mode 100644
> index 00000000..ef0f747
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen specific binding for the virtualized device (e.g. virtio)
> +
> +maintainers:
> +  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> +
> +select: true

Do we really need to support this property everywhere?

> +
> +description:
> +  This binding indicates that Xen grant mappings scheme needs to be enabled
> +  for that device and specifies the ID of Xen domain where the corresponding
> +  device (backend) resides. This is needed for the option to restrict memory
> +  access using Xen grant mappings to work.
> +
> +properties:
> +  xen,dev-domid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The domid (domain ID) of the domain where the device (backend) is running.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    virtio_block@3000 {

virtio@3000

> +            compatible = "virtio,mmio";
> +            reg = <0x3000 0x100>;
> +            interrupts = <41>;
> +
> +            /* The device is located in Xen domain with ID 1 */
> +            xen,dev-domid = <1>;

This fails validation:

Documentation/devicetree/bindings/arm/xen,dev-domid.example.dtb: virtio_block@3000: xen,dev-domid: [[1]] is not of type 'object'
        From schema: /home/rob/proj/git/linux-dt/Documentation/devicetree/bindings/virtio/mmio.yaml

The property has to be added to the virtio/mmio.yaml schema. If it is 
not needed elsewhere, then *just* add the property there.

Rob
