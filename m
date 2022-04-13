Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B7500238
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiDMXEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiDMXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:04:53 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA1252AB;
        Wed, 13 Apr 2022 16:02:30 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so3561913fac.11;
        Wed, 13 Apr 2022 16:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YGabHpljtiGxZkQuZz7c7j1W08I1Hvt5N3od6t4IJJo=;
        b=vtNpMbBN8MKbVkiuJTsMr2vRIxZ+6PP90iIf6HrrsJ1SPRnGVcsuexPH47/7+MCOa2
         tClzeWlbL00v4ZmXtWW5seXDKNnkHGDxr3MetTDzef+CtfZwU+5vgih34JF8V1K+Tvs0
         qrCVuioMg4al3S/PuWTOKibvq05tjm1DYtXvUt+7t+HMG/jSuwPU2fWLeQvaBzq2nAma
         SxFukIM7AYmoBs3qwkKb6VLP+k9lV+aJpzpBbosHfYt2PdnWt3ugTo2eQfD039qRIgTz
         ccz/1kyw4KxLL+MlojgcPuiFyGSXCSwiRCfRigsWrB+sfYJEr2WoHx/eLFV3RF+BxRsx
         3DxA==
X-Gm-Message-State: AOAM532rIS4pRFNGrFfx9lk6aj19LHDRuQt5TVuqX+h5VkAPreWMjNux
        tWvZevD3ZOtZ+cx8PKWikw==
X-Google-Smtp-Source: ABdhPJwINphfy50/Q8dN2oFmoDIYgUuh67h7+uBixXRlKaqQgwaNIyYXpCeE6RDA7FisUjBBzeJDPw==
X-Received: by 2002:a05:6870:40c9:b0:e2:d1bb:f4e1 with SMTP id l9-20020a05687040c900b000e2d1bbf4e1mr185356oal.243.1649890950111;
        Wed, 13 Apr 2022 16:02:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x24-20020a056870a79800b000e2e53716fbsm173721oao.31.2022.04.13.16.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:02:29 -0700 (PDT)
Received: (nullmailer pid 4100836 invoked by uid 1000);
        Wed, 13 Apr 2022 23:02:28 -0000
Date:   Wed, 13 Apr 2022 18:02:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     matthias.bgg@gmail.com, yongqiang.niu@mediatek.com,
        allen-kh.cheng@mediatek.com, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, airlied@linux.ie, devicetree@vger.kernel.org,
        nancy.lin@mediatek.com, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, chunkuang.hu@kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        p.zabel@pengutronix.de, jason-jh.lin@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH V2 1/3] dt-bindings: display: mediatek: Update disp_aal
 binding for MT8183
Message-ID: <YldWhNA6SwNBGXa8@robh.at.kernel.org>
References: <20220411035843.19847-1-rex-bc.chen@mediatek.com>
 <20220411035843.19847-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411035843.19847-2-rex-bc.chen@mediatek.com>
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

On Mon, 11 Apr 2022 11:58:41 +0800, Rex-BC Chen wrote:
> The driver data of MT8183 and MT8173 are different.
> 
> For MT8173, the gamma module is inside disp_aal. When we need to adjust
> gamma value, we need to use "has_gamma" to control gamma function
> inside disp_aal to adjust the gamma value.
> 
> For successors like MT8183, disp_gamma is separated from disp_aal. We
> just need to control disp_gamma directly and don't need to control gamma
> function inside disp_aal.
> 
> With this modification, the driver doesn't require any functional changes.
> We only update the dt-binding and DTS node to make it clear.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml  | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
