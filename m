Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C650B543637
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiFHPKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbiFHPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:10:24 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E3464C95;
        Wed,  8 Jun 2022 08:00:28 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id y79so557893iof.2;
        Wed, 08 Jun 2022 08:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xIHFMIqlOUk9Aus35ryVRsDFE47iiJwnIacUdLPVwY=;
        b=KMtIvoeXTLby9XTgxM6HErRYWYOhYBYMHRZq2gffG2nRLWVMZu2XGezM5eijO57GVF
         59Mqzqqw0o++kvLcheGL8oOKgHSYtBLh429EGD1i1tIkWfG/q+h4/ZQ2aEnvllMHetRZ
         PR3P//yNSSe8F3dLu1q+wRpC9wWYD5Yda488Lb9pBksqRobvDiXz6SbqyLRY88Ry9Q9p
         2UwFif72vwkB4snalBVeuUo7xOsXDWd9Yv3Bbg51OTBpKro9MsWwN0Ymit+5DzX1HgrL
         Ovku7nNjHMV1WE4ySbdR+iKNSfUpOz+RiwwYWBEu7NlzSS/B3wn9IOwFAHvdORzO5VYb
         nWTw==
X-Gm-Message-State: AOAM533Vj8/HYem7Dzx0GKAbPn4hqIatO+14xTHhD1IAeNxlChmlMY5L
        9nsQvtnjoKnnVzHcNGzDI7Dxh4fgZw==
X-Google-Smtp-Source: ABdhPJyzlGi+QzeZyTQq4zOi31iAXIn0f8Dgk2LUVJzEf1hLrggGw+NONFfZiJftfEUfxEIgASsyKg==
X-Received: by 2002:a05:6638:2503:b0:331:950a:9478 with SMTP id v3-20020a056638250300b00331950a9478mr10671602jat.211.1654700426927;
        Wed, 08 Jun 2022 08:00:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w123-20020a022a81000000b003315f06075csm7737187jaw.22.2022.06.08.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:00:26 -0700 (PDT)
Received: (nullmailer pid 1398631 invoked by uid 1000);
        Wed, 08 Jun 2022 15:00:24 -0000
Date:   Wed, 8 Jun 2022 09:00:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     kyrie wu <kyrie.wu@mediatek.com>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-media@vger.kernel.org, Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        maoguang.meng@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [V2,1/2] media: media: jpegenc: add mediatek,mt8186-jpgenc
 compatible
Message-ID: <20220608150024.GA1398383-robh@kernel.org>
References: <20220608060755.2213-1-irui.wang@mediatek.com>
 <20220608060755.2213-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608060755.2213-2-irui.wang@mediatek.com>
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

On Wed, 08 Jun 2022 14:07:54 +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8186-jpgenc compatible to binding document.
> 
> MT8186 iommu support 0~16GB iova. We separate it to four banks:
> 0~4G; 4G~8G; 8G~12G; 12G~16G.
> 
> The "dma-ranges" could be used to adjust the bank we locate.
> If we don't set this property. The default range always is 0~4G.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

