Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0691C5295FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiEQA1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiEQA1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:27:54 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE272E6A7;
        Mon, 16 May 2022 17:27:52 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id v65so20590611oig.10;
        Mon, 16 May 2022 17:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AjIgoIzuU0qN1OneU4nydD9785iHKfz2mgfXgmyiwBA=;
        b=t6GiBiN8hoSr+YE4N1QrzPwAF/yMnch94pg8ER5wAUQ8QaWJO6ZQBJm2yx7pcEXhUT
         TE96eSjoKNGIDzb26HQinVEbxn8Jy0TjmbmY01q32MibS6CkabNVvI3EmwXAbsdcvabI
         I4boRywo3jrnIqiBF+ibELzBYHPwMS9ucncNfnKXNoWRVeru6dq5xq6MCjpLW1vhGSWA
         vz8RURS3TpDsyJIIKRIqN0tEoeDfF2cyBfdagccw2dZ9Zu2JV8BVMSwyV5lY/O/oa7lS
         WfOwxrtidUEG4+tXDm+Ci2ezuj77KTK5KuaxO0hXXK1MhDsf41XH4YMBgkcTQ32jFbfM
         7NPg==
X-Gm-Message-State: AOAM533CFLnYewzuvbG3x9IGHWl2pEqCYd1FEzMtUx+3kYtPJtCvDq6e
        somglRGPOjO1ax7cb3GJPw==
X-Google-Smtp-Source: ABdhPJxT0vsAGu7gI2XEFSb7VXPXh7GjkIgGl9JGJgCiHApDSgmjmwIdM+VP2LsLjTK10XA7StATnw==
X-Received: by 2002:a05:6808:1496:b0:326:e2de:63ec with SMTP id e22-20020a056808149600b00326e2de63ecmr9397520oiw.271.1652747272138;
        Mon, 16 May 2022 17:27:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t129-20020aca5f87000000b00328a1be5c3asm4429079oib.25.2022.05.16.17.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:27:51 -0700 (PDT)
Received: (nullmailer pid 3649667 invoked by uid 1000);
        Tue, 17 May 2022 00:27:50 -0000
Date:   Mon, 16 May 2022 19:27:50 -0500
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
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
Message-ID: <20220517002750.GA3638680-robh@kernel.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
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

On Sat, May 07, 2022 at 09:19:06PM +0300, Oleksandr Tyshchenko wrote:
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
> 
> Changes V1 -> V2:
>    - update text in description
>    - change the maintainer of the binding
>    - fix validation issue
>    - reference xen,dev-domid.yaml schema from virtio/mmio.yaml
> ---
>  .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/virtio/mmio.yaml |  7 ++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> new file mode 100644
> index 00000000..750e89e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen specific binding for virtualized devices (e.g. virtio)
> +
> +maintainers:
> +  - Stefano Stabellini <sstabellini@kernel.org>
> +
> +select: true

Omit. No need to apply this on every single node.

> +
> +description:
> +  This binding indicates that Xen grant mappings need to be enabled for
> +  the device, and it specifies the ID of the domain where the corresponding
> +  device (backend) resides. The property is required to restrict memory
> +  access using Xen grant mappings.
> +
> +properties:
> +  xen,dev-domid:

I kind of think 'dev' is redundant. Is there another kind of domid 
possible? Maybe xen,backend-domid or just xen,domid? I don't know Xen 
too well, so ultimately up to you all.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The domid (domain ID) of the domain where the device (backend) is running.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    virtio@3000 {
> +            compatible = "virtio,mmio";
> +            reg = <0x3000 0x100>;
> +            interrupts = <41>;
> +
> +            /* The device is located in Xen domain with ID 1 */
> +            xen,dev-domid = <1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> index 10c22b5..29a0932 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -13,6 +13,9 @@ description:
>    See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
>    more details.
>  
> +allOf:
> +  - $ref: /schemas/arm/xen,dev-domid.yaml#
> +
>  properties:
>    compatible:
>      const: virtio,mmio
> @@ -33,6 +36,10 @@ properties:
>      description: Required for devices making accesses thru an IOMMU.
>      maxItems: 1
>  
> +  xen,dev-domid:
> +    description: Required when Xen grant mappings need to be enabled for device.
> +    $ref: /schemas/types.yaml#/definitions/uint32

No need to define the type again nor describe it again.

Instead, just change additionalProperties to unevaluateProperties in 
this doc. The diff is the latter takes $ref's into account.

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.7.4
> 
> 
