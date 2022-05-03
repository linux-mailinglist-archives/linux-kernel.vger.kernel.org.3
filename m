Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0894518B63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbiECRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiECRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:50:45 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDA2715B;
        Tue,  3 May 2022 10:47:11 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so6312339otk.2;
        Tue, 03 May 2022 10:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aO1OGtoH2etVzYDvjSj5yfVREBvoZxIuagbUCkaDNyQ=;
        b=NK+h2mh6Qxx9mq1HzXqNZAffE5KFxHKZ1GhfmdH62lerdh8kZJdugT+ZuYBP0QKQD5
         2BmGYkAiQDMliDYPl5prBQEdrXsfTt6Ux+uzobwXNtjmnQCPS0imhuoBDuV4j18FhOYB
         8isvcMi4MHvwzN0MyBH+jVd+1HLWexpvz2fqjdAYvX0zC0H4pacaXA0r7o5eNpQinIrT
         aU+0FOuomPhFy6cNBcVISbTXlbgtrYOmS+kDqNcPpaLj/J99mzPnAX5tKxVQ1Dlrypmp
         zxUQHldJBV2ysl54l27/oYJkLAR9b4DEENNtOhcF9Vx7YetNC3I/SDcwkEDj4ORkrUvg
         n+wQ==
X-Gm-Message-State: AOAM530Re8Vcv6JhYQ5tR9xaaayIMn7iZYkwX94mkLJX1C1sWYzHB7te
        0a344lpBg1iZBdSMQ4ZOdQ==
X-Google-Smtp-Source: ABdhPJze3Fkqbmp2HHrsmVNQEF4ygGLxm/5otqwB5/dtD+F7rMTjhoKQLjNh01bIzTUwlBzUvEcyZg==
X-Received: by 2002:a05:6830:14d4:b0:606:cc5:32cd with SMTP id t20-20020a05683014d400b006060cc532cdmr5173680otq.359.1651600030474;
        Tue, 03 May 2022 10:47:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x10-20020a056830408a00b006063f1f05dfsm395787ott.18.2022.05.03.10.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:47:09 -0700 (PDT)
Received: (nullmailer pid 3943569 invoked by uid 1000);
        Tue, 03 May 2022 17:47:08 -0000
Date:   Tue, 3 May 2022 12:47:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v14 1/3] dt-binding: mediatek: add bindings for MediaTek
 MDP3 components
Message-ID: <YnFqnEI16B+xrxdQ@robh.at.kernel.org>
References: <20220427070514.10355-1-moudy.ho@mediatek.com>
 <20220427070514.10355-2-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427070514.10355-2-moudy.ho@mediatek.com>
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

On Wed, Apr 27, 2022 at 03:05:12PM +0800, Moudy Ho wrote:
> This patch adds DT binding documents for Media Data Path 3 (MDP3)
> a unit in multimedia system combined with several components and
> used for scaling and color format convert.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 82 +++++++++++++++++++
>  .../bindings/media/mediatek,mdp3-rsz.yaml     | 61 ++++++++++++++
>  .../bindings/media/mediatek,mdp3-wrot.yaml    | 66 +++++++++++++++
>  .../bindings/soc/mediatek/mediatek,ccorr.yaml | 54 ++++++++++++
>  .../bindings/soc/mediatek/mediatek,wdma.yaml  | 67 +++++++++++++++
>  5 files changed, 330 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> new file mode 100644
> index 000000000000..ce24eda14cb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Read Direct Memory Access
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> +
> +description: |
> +  Mediatek Read Direct Memory Access(RDMA) component used to do read DMA.
> +  It contains one line buffer to store the sufficient pixel data, and
> +  must be siblings to the central MMSYS_CONFIG node.
> +  For a description of the MMSYS_CONFIG binding, see
> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +  for details.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8183-mdp3-rdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    maxItems: 1

Like your other patches this needs 'items' describing each cell.

> +    description: |
> +      The register of client driver can be configured by gce with
> +      4 arguments defined in this property, such as phandle of gce, subsys id,
> +      register offset and size. Each GCE subsys id is mapping to a client
> +      defined in the header include/dt-bindings/gce/<chip>-gce.h.

Other than other cases of this property, the rest looks fine.

Rob
