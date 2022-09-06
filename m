Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C525AF145
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiIFQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbiIFQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:54:54 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7598C03A;
        Tue,  6 Sep 2022 09:41:35 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso8429790otb.6;
        Tue, 06 Sep 2022 09:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Lgh3vIwdeNSYx8GlCKAtAtQt9YyclbM6HZvbQmSZCu8=;
        b=YX794g43YeLY3Qsdkkr5e/mfJb8wEgJQcYP1YiTy9a8jOkO0uibYhLUpni5zF13VpG
         UHLBqzscjpB3akWjrvRPxF9b4VDU+et48/CxMbThNiHpQYLYepZNVFD+PfoGkCkgd82z
         yHzMHQuTaCDeVRNp4jSN+NztBh2+i2eALR9WOVvdNrpSj5FlNxS6TYjb1fSePf4y+gXR
         fXVfc0eWnuctgKORUo4ewYbp7ioo25fJGaXsrZbWFvu0ZPFgRc9HquEt6loRKX2SiM2t
         twE/au4LtlKMAYHVWfxi572mbPZov9Ykjcie65RwSxceMQaDcPrbKrft1hHpAWF+m+7Z
         H4Rg==
X-Gm-Message-State: ACgBeo0BoejzGPEDdVGvbkMWwkcT7DxQl1msE0dJg+Xgg0NM3J/W48iY
        B5OoPZe8u+IaUtdUdu8xMg==
X-Google-Smtp-Source: AA6agR6eT3W44N2T2/Zyuy68L3b4LyOQqPBPocAIz0OHE0repCmWb71KdiOTZdYsmijS/X/CKy0Jvg==
X-Received: by 2002:a05:6830:910:b0:637:18dd:7743 with SMTP id v16-20020a056830091000b0063718dd7743mr21298945ott.226.1662482494616;
        Tue, 06 Sep 2022 09:41:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d23-20020a056830139700b0061cd208fadesm6018600otq.71.2022.09.06.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:41:33 -0700 (PDT)
Received: (nullmailer pid 670571 invoked by uid 1000);
        Tue, 06 Sep 2022 16:41:33 -0000
Date:   Tue, 6 Sep 2022 11:41:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     Matthias Brugger <mbrugger@suse.com>, mandyjh.liu@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lee@kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: Rename mediatek,mt8195-scpsys.yaml
Message-ID: <20220906164133.GA670491-robh@kernel.org>
References: <20220830091110.27857-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830091110.27857-1-matthias.bgg@kernel.org>
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

On Tue, 30 Aug 2022 11:11:10 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The file describes the scpsys node for all SoCs and not only the mt8195.
> Rename it to reflect this fact.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Fix id
> 
>  .../mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml}   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml} (96%)
> 

Acked-by: Rob Herring <robh@kernel.org>
