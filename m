Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A3508D19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380494AbiDTQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380415AbiDTQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:22:48 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C05765E;
        Wed, 20 Apr 2022 09:20:02 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-e656032735so1195490fac.0;
        Wed, 20 Apr 2022 09:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4wNQpDsXtJxhnvH20Z3+ZVt5KBTN3mlzQxKe6VzUSMU=;
        b=q77xSGskodpzGj67UPGNa0gzYTewSJY2cXCoJQRuk1AoWDaLF35FCJf2htQcv6h2KL
         g//dPsYgOtOFwo9InLLNpSQhjpLWrfhkYeB9Iv52yGk8OK92FeqYUmmdffZzOx83w+nT
         /loq9OfDwqmbGexqd362J3I7lnYNSLOtQvl5xhk4CirSYDEZCNm7ERmaxurKdATYdjgF
         /ypTw3uuYij36DcO0zbQtB8qhAcc2XWsMjDnAj9McETA+fh8iwH6p7I9VP2IJ2GaNjTl
         6nYcOb6J/M3JF/aBUaS2NFtYNailq+gGFFOnuqfW2MrIevv8CThXv2kucilKCr4sUuxB
         ReIA==
X-Gm-Message-State: AOAM530a3yKcHHawGk9zhB3Ui4rff+3ynk/9nOT1Zaf8mswmozuNfekI
        qMfF9m9XcfHhkmVqrZ2M2w==
X-Google-Smtp-Source: ABdhPJyFDGzvkuLBDNOHCYtbkcqXp8jhoHSTHMVganFNXtZpFpev677iq4zGD+x/GQzQQd8c69FZDA==
X-Received: by 2002:a05:6870:b4a7:b0:e5:bff5:b537 with SMTP id y39-20020a056870b4a700b000e5bff5b537mr2080931oap.64.1650471601284;
        Wed, 20 Apr 2022 09:20:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f21-20020a056830205500b005cdb59d5d34sm6592605otp.81.2022.04.20.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:20:00 -0700 (PDT)
Received: (nullmailer pid 1416786 invoked by uid 1000);
        Wed, 20 Apr 2022 16:19:59 -0000
Date:   Wed, 20 Apr 2022 11:19:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
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
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v13 1/3] dt-binding: mt8183: add Mediatek MDP3 dt-bindings
Message-ID: <YmAyrzjtWGrk5pNn@robh.at.kernel.org>
References: <20220418022213.23826-1-moudy.ho@mediatek.com>
 <20220418022213.23826-2-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418022213.23826-2-moudy.ho@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 10:22:11AM +0800, Moudy Ho wrote:
> This patch adds DT binding documents for Media Data Path 3 (MDP3)
> a unit in multimedia system combined with several components and
> used for scaling and color format convert.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 166 ++++++++++++++++++
>  .../bindings/media/mediatek,mdp3-rsz.yaml     |  54 ++++++
>  .../bindings/media/mediatek,mdp3-wrot.yaml    |  57 ++++++
>  .../bindings/soc/mediatek/mediatek,ccorr.yaml |  47 +++++
>  .../bindings/soc/mediatek/mediatek,wdma.yaml  |  58 ++++++
>  5 files changed, 382 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> new file mode 100644
> index 000000000000..45b7c075ebf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -0,0 +1,166 @@
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
> +
> +description: |
> +  Mediatek Read Direct Memory Access(RDMA) component used to do read DMA.
> +  It contains one line buffer to store the sufficient pixel data, and
> +  must be siblings to the central MMSYS_CONFIG node.
> +  For a description of the MMSYS_CONFIG binding, see
> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +  for details.
> +  The 1st RDMA is also used to be a controller node in Media Data Path 3(MDP3)
> +  that containing MMSYS, MUTEX, GCE and SCP settings.
> +
> +properties:
> +  compatible:
> +    items:
> +      # MDP3 controller node
> +      - const: mediatek,mt8183-mdp3
> +      - const: mediatek,mt8183-mdp3-rdma

This *still* makes no sense. I'm not looking at this further.

Rob
