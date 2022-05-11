Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC32523588
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiEKObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbiEKOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:30:58 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01D53B66;
        Wed, 11 May 2022 07:30:56 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso3041160fac.1;
        Wed, 11 May 2022 07:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mp6dTbokvQGCqhdm89KjWBFi8stC9bHFTBWdjBNBqBw=;
        b=hP9hCRHNFua4ZCvi6c0rVeP2fEfLZ3Y1zqxuY86oPfL6JDJtjWwaK267BVWNqxkuxK
         dnWlsVRC2bsKR9X+NHO0h9bvObkxiNoCkEFwavhQP4ceY0n7+YVhf4j4u7InjNl+zJjX
         lgdmWKZu+9tGaDIPJBSpslt2Je65ni7p0wu40eKyTsHz0/qzGZbtBY4FNfT0y5eE6KfQ
         Bm8nqPQUzt/J6mXVFc9qiTe4xUGLelqBNnuxALBHRfo7pydDT0/erhh9HwVOjijXn8hr
         sAi8RFmJBolGoe4jyEefJQT93BHedZTHSB2IHEC+7Uv7D1mSijHiLHBKN7inSnDaPLBl
         dkbA==
X-Gm-Message-State: AOAM533AWLttiZ44V3LvcZ0nvFEwN5cFy4Fx0OtpfnHht8DoQyHdZREi
        hBpIt55YAdyLsm31JtICZQ==
X-Google-Smtp-Source: ABdhPJzrzFc0fZ7+LrYKUTYDibPYbzEg//RObkHsFf1tLCR7BDw2r72XuTFEFO0zWdV4Qjlt6iDktg==
X-Received: by 2002:a05:6870:2e06:b0:ee:e90:7e65 with SMTP id oi6-20020a0568702e0600b000ee0e907e65mr2780364oab.49.1652279456231;
        Wed, 11 May 2022 07:30:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 22-20020aca2116000000b00325cda1ff8esm803219oiz.13.2022.05.11.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:30:55 -0700 (PDT)
Received: (nullmailer pid 263258 invoked by uid 1000);
        Wed, 11 May 2022 14:30:54 -0000
Date:   Wed, 11 May 2022 09:30:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, chunkuang.hu@kernel.org,
        xinlei.lee@mediatek.com, dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 1/4] dt-bindings: display: mediatek: dsi: Convert
 dsi_dtbinding to .yaml
Message-ID: <20220511143054.GA263204-robh@kernel.org>
References: <20220504091923.2219-1-rex-bc.chen@mediatek.com>
 <20220504091923.2219-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504091923.2219-2-rex-bc.chen@mediatek.com>
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

On Wed, 04 May 2022 17:19:20 +0800, Rex-BC Chen wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Convert mediatek,dsi.txt to mediatek,dsi.yaml format
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dsi.txt         |  62 ----------
>  .../display/mediatek/mediatek,dsi.yaml        | 115 ++++++++++++++++++
>  2 files changed, 115 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
