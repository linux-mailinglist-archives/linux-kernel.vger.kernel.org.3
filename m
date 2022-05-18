Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C952B002
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiERBls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiERBlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:41:46 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79A54697;
        Tue, 17 May 2022 18:41:45 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id r1so1044082oie.4;
        Tue, 17 May 2022 18:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INqLY13hD2JDCbK9Kzj2SkFwh0u4TnDrvBoPZ/nTnLs=;
        b=d2Z967vAc53jzNLmdnbMUxfb3NHMWB6cARILn/WRWEX0nx2lNizqxDky5lkzmnbGmM
         kiHiwuZLxJIrbEGcN7If7r0dIEUr5ixTeOJxUTwVcFlRymR5ZYWheSUtD/KVO1uXAyMy
         Bqb9oWoiRZJwUxJWQ56ari8oH1XmHD54SHuELyJAx0ZhaF2jEFwvDYIl5H2VQCsgOBMG
         XN2jqSZQeR0tNNNRUjA0RtvF4a7XKcqSqIy9cwYmtoyuQL7icil/++VHrfYRhuKKjFl+
         mLydxXyHHYtzM8kBaVQDTWN3O4Taoc7y4ViFfRFcCRmSNi+kfGlTZVRVxfHf97szfoZl
         wD3w==
X-Gm-Message-State: AOAM5306CVWQHGgnBBdlVOAtPXNwiOCFph3FtPuyWmLsUUaQUdP3gLUr
        WkTRj/6sA5UpJ+Yn51Tj3w==
X-Google-Smtp-Source: ABdhPJx139iTWFrPfr5U9wHbjv2MePhCFY50wUeMLu11V52NqLmVBr0mHI4WiJnDdO+yAl/0Q2cQjw==
X-Received: by 2002:aca:e155:0:b0:325:6d76:da4b with SMTP id y82-20020acae155000000b003256d76da4bmr12579250oig.125.1652838105035;
        Tue, 17 May 2022 18:41:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g3-20020a056870a70300b000f174840b4fsm444606oam.17.2022.05.17.18.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:41:44 -0700 (PDT)
Received: (nullmailer pid 2044234 invoked by uid 1000);
        Wed, 18 May 2022 01:41:43 -0000
Date:   Tue, 17 May 2022 20:41:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] dt-bindings: iommu: mediatek: Require
 mediatek,infracfg for mt2712/8173
Message-ID: <20220518014143.GA2024242-robh@kernel.org>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-8-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517132107.195932-8-angelogioacchino.delregno@collabora.com>
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

On Tue, May 17, 2022 at 03:21:06PM +0200, AngeloGioacchino Del Regno wrote:
> Both MT2712 and MT8173 got a mediatek,infracfg phandle: add that to
> the required properties for these SoCs to deprecate the old way of
> looking for SoC-specific infracfg compatible in the entire devicetree.

Wait, what? If there's only one possible node that can match, I prefer 
the 'old way'. Until we implemented a phandle cache, searching the 
entire tree was how phandle lookups worked too, so not any better.

But if this makes things more consistent,

Acked-by: Rob Herring <robh@kernel.org>
