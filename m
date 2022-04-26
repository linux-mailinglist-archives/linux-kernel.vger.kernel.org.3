Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4927510AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355035AbiDZUkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350728AbiDZUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:40:17 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932CE31208;
        Tue, 26 Apr 2022 13:37:09 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id w27-20020a056830061b00b00604cde931a0so13879181oti.2;
        Tue, 26 Apr 2022 13:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Ua/QldL7pC5LZXWxffOFe8RnQhvpw8c3zNSB5ycwY8=;
        b=laD/A1Y9qM3A0QFtpeYgmWXfcJPEnX/53nM4pGL/+soqTQvjubrjkK3cs/Y8ZcrCx5
         O6iWzLWcLdynMR0qPHnlvPGEXRuFMSBsZFhG/OJ6pO4L1iAR341bR+2dwzZJkZqPRWWF
         eggx+Q5XsbXgcroz7t6civ9aG+sWYIRVd72lPalhYuOCK/GowhpdUQ9/ug0qwXSVx5js
         f+5/jdeZzQhJhmYDaBPtQFV8iYus8m4YcPW6Vz2vYlnQOXVtZ2FsBd5qbAJSMyN0vEug
         pqvKb2eEtY54DtFFCurGd8TRBKE+etRsI4uKfBjWtcsf37qPL0H7SHPrMYXrYTSo9nye
         FyBw==
X-Gm-Message-State: AOAM5317+w6BNNfzQp3uKRrlHig12xfMtyh47HVqGFp5/4tBnmlfSSDF
        Q5MrrHmz1MeRz+yBrGa//w==
X-Google-Smtp-Source: ABdhPJzV94dg7hlsrdCIRh48Q/JHhKt1BGntT/HsErX1a5fw7wvJMn0OMxu04NvUD/iPdux9O8sz9w==
X-Received: by 2002:a9d:4e8d:0:b0:605:4f04:4863 with SMTP id v13-20020a9d4e8d000000b006054f044863mr9009729otk.204.1651005428916;
        Tue, 26 Apr 2022 13:37:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q4-20020a4a3004000000b0035e974ec923sm282663oof.2.2022.04.26.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:37:08 -0700 (PDT)
Received: (nullmailer pid 2493275 invoked by uid 1000);
        Tue, 26 Apr 2022 20:37:07 -0000
Date:   Tue, 26 Apr 2022 15:37:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        allen-kh.cheng@mediatek.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] dt-bindings: media: mtk-vcodec: Adds encoder power
 domain property
Message-ID: <YmhX89nQjkwt5qb3@robh.at.kernel.org>
References: <20220420073440.31649-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420073440.31649-1-irui.wang@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:34:39PM +0800, Irui Wang wrote:
> Adds encoder power domain property

Why? You can't add new, required properties as that breaks compatibility 
with existing DTs.

> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index deb5b657a2d5..3c069c965992 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -41,6 +41,9 @@ properties:
>  
>    assigned-clock-parents: true
>  
> +  power-domains:
> +    maxItems: 1
> +
>    iommus:
>      minItems: 1
>      maxItems: 32
> @@ -72,6 +75,7 @@ required:
>    - iommus
>    - assigned-clocks
>    - assigned-clock-parents
> +  - power-domains
>  
>  allOf:
>    - if:
> @@ -132,6 +136,7 @@ examples:
>      #include <dt-bindings/clock/mt8173-clk.h>
>      #include <dt-bindings/memory/mt8173-larb-port.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt8173-power.h>
>  
>      vcodec_enc_avc: vcodec@18002000 {
>        compatible = "mediatek,mt8173-vcodec-enc";
> @@ -153,6 +158,7 @@ examples:
>        clock-names = "venc_sel";
>        assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
>        assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
>      };
>  
>      vcodec_enc_vp8: vcodec@19002000 {
> @@ -173,4 +179,5 @@ examples:
>        clock-names = "venc_lt_sel";
>        assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
>        assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>;
> +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
>      };
> -- 
> 2.18.0
> 
> 
