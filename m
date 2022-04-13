Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD878500115
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiDMVXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiDMVXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:23:20 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105E22BB37;
        Wed, 13 Apr 2022 14:20:58 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id k13so3457294oiw.1;
        Wed, 13 Apr 2022 14:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YzYdFiMLsDoyTU0PbwVa3WC4PKMjoqkq1VcU6L/mnM=;
        b=yb+pf7Xxtk0RKjPF3sIwSQ5W4IhFG/45tYjks9zcOcxcn9pBnmoZ2IIQbNvQg9ukyd
         Wj2bl6H9rGBGttJO8kaUtQxW1qSJpjqDr2vEYtfe1YazJ4j5q5Dqf8w9I0BbQdxJCr58
         gOR527UeIayRRvl9C1SkulfPLqnLQytTwL7hJxrR0cFEMRv4Q8vY685YXFqbjgjMqusW
         9DIMVapM8H0Unsfdh2G3LieRwmXx7oem6X0C28+GpI2HLPHe80RaU3D6itTwVzZR1JAQ
         1MYFfw/jD+BskGCQBRfrvC3nEjVL92V22Ooj5Y7gR2TuHNBKc1eTsRhhCs5ut4kaOviw
         ZXAA==
X-Gm-Message-State: AOAM53235fxd9RWDivH9bT5BmxKNBR/iydTb2F5A8oLkBZNQkgGJ9NCd
        P3cNa+J2DGwHKRutHeozww==
X-Google-Smtp-Source: ABdhPJy4XCwE/l0IcNFu8QLwKB/o4da+J+bSKytm1PrKJqmc/W/35vPD+DdPKg9ewLQ9IkLcmNk+6A==
X-Received: by 2002:a05:6808:21a3:b0:2f9:a87d:53a6 with SMTP id be35-20020a05680821a300b002f9a87d53a6mr34405oib.85.1649884857359;
        Wed, 13 Apr 2022 14:20:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a4a9445000000b00329dab1a07fsm45143ooi.17.2022.04.13.14.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:20:57 -0700 (PDT)
Received: (nullmailer pid 3948819 invoked by uid 1000);
        Wed, 13 Apr 2022 21:20:56 -0000
Date:   Wed, 13 Apr 2022 16:20:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     xinlei.lee@mediatek.com
Cc:     matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        p.zabel@pengutronix.de, rex-bc.chen@mediatek.com,
        jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chunkuang.hu@kernel.org, airlied@linux.ie,
        linux-arm-kernel@lists.infradead.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4,2/3] dt-bindings: display: mediatek: dsi: Add
 compatible for MediaTek MT8186
Message-ID: <Ylc+uMqGS0w2T72w@robh.at.kernel.org>
References: <1649495514-25746-1-git-send-email-xinlei.lee@mediatek.com>
 <1649495514-25746-3-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649495514-25746-3-git-send-email-xinlei.lee@mediatek.com>
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

On Sat, 09 Apr 2022 17:11:53 +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of dsi for MediaTek MT8186 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
