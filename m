Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842CA4CD81B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiCDPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiCDPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:40:28 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397356E295;
        Fri,  4 Mar 2022 07:39:41 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso9256831oou.5;
        Fri, 04 Mar 2022 07:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IO1zrbMJCIdW27ZYcLkomHz9MZD/3xTBxiCCeGbY4nY=;
        b=ziCoo6WiQVWDIkZjm3cC80T9nAG0I8q2Bt/JaEZkId3WoMtoINNGWNUxpsBasbW7/R
         eTAobw0Y3dGou/Pjkr2EbN1JLQAZvabx6xAKTRwls9aekQM9HX75FoKBorjhq/nDG7Xq
         3bIDEOITjrNsyzX6s10nOxRFHPWPirRowLvr5fNAW91JM/7wGcqqFUbdJb6kBZnAmPr7
         qV4Y/BgNvGT0hnj1zFy+vwu3cZTgER+hc3OVdoM7lbjFZhhlOCtrUjXHDI0ojYsN27Og
         dkPBXmeKSVLodagbvtX9ss+err+oX5p5VQQCT+khs9LVGk7WFx02RBrR4vsU9X+zFqGd
         zReA==
X-Gm-Message-State: AOAM531xDKixJY3oRvTJ5R/aIBknOqMcbQE2KKlUm1JfogQPc1YdM2f6
        fCwKGpL8zbiCsnJgrpkV5A==
X-Google-Smtp-Source: ABdhPJzV3nnvTE6V/swPLdnnc8Rt2egbCzhY1OPkkrIIw8e54gAgN9Xe2bv5Gl3lRvSRncaFjcChng==
X-Received: by 2002:a05:6870:248c:b0:d7:19f3:a52c with SMTP id s12-20020a056870248c00b000d719f3a52cmr8397016oaq.149.1646408380509;
        Fri, 04 Mar 2022 07:39:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 35-20020a9d0026000000b005ad363440a2sm2376353ota.64.2022.03.04.07.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:39:39 -0800 (PST)
Received: (nullmailer pid 3987557 invoked by uid 1000);
        Fri, 04 Mar 2022 15:39:38 -0000
Date:   Fri, 4 Mar 2022 09:39:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     jason-jh.lin@mediatek.com, daniel@ffwll.ch,
        chunkuang.hu@kernel.org, linux-mediatek@lists.infradead.org,
        p.zabel@pengutronix.de, krzysztof.kozlowski@canonical.com,
        robh+dt@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        jitao.shi@mediatek.com, ck.hu@mediatek.com,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com
Subject: Re: [PATCH 3/3] dt-bindings: display: mediatek: Fix examples on new
 bindings
Message-ID: <YiIyupjEgdiaj0Dv@robh.at.kernel.org>
References: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com>
 <20220304095458.12409-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304095458.12409-4-angelogioacchino.delregno@collabora.com>
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

On Fri, 04 Mar 2022 10:54:58 +0100, AngeloGioacchino Del Regno wrote:
> To avoid failure of dt_binding_check perform a slight refactoring
> of the examples: the main block is kept, but that required fixing
> the address and size cells, plus the inclusion of missing dt-bindings
> headers, required to parse some of the values assigned to various
> properties.
> 
> Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each block to individual yaml")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,aal.yaml        | 24 +++--
>  .../display/mediatek/mediatek,ccorr.yaml      | 23 +++--
>  .../display/mediatek/mediatek,color.yaml      | 23 +++--
>  .../display/mediatek/mediatek,dither.yaml     | 23 +++--
>  .../display/mediatek/mediatek,dpi.yaml        |  3 +-
>  .../display/mediatek/mediatek,dsc.yaml        | 23 +++--
>  .../display/mediatek/mediatek,ethdr.yaml      | 99 ++++++++++---------
>  .../display/mediatek/mediatek,gamma.yaml      | 23 +++--
>  .../display/mediatek/mediatek,merge.yaml      | 49 +++++----
>  .../display/mediatek/mediatek,mutex.yaml      | 25 +++--
>  .../display/mediatek/mediatek,od.yaml         | 14 ++-
>  .../display/mediatek/mediatek,ovl-2l.yaml     | 26 +++--
>  .../display/mediatek/mediatek,ovl.yaml        | 26 +++--
>  .../display/mediatek/mediatek,postmask.yaml   | 23 +++--
>  .../display/mediatek/mediatek,rdma.yaml       | 28 ++++--
>  .../display/mediatek/mediatek,split.yaml      | 17 +++-
>  .../display/mediatek/mediatek,ufoe.yaml       | 19 ++--
>  .../display/mediatek/mediatek,wdma.yaml       | 26 +++--
>  18 files changed, 316 insertions(+), 178 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
