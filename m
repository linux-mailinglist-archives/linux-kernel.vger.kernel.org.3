Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833E84E3463
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiCUXbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiCUXbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:31:38 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15721355B91;
        Mon, 21 Mar 2022 16:30:09 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-d39f741ba0so317229fac.13;
        Mon, 21 Mar 2022 16:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jcbOalPGoZlPVOYBNp+MHPtkQGuUqsNk0ulK/GNGgc8=;
        b=lq72NR4GPvdOAcKPyE3cVfmm49pHbwlMcgxdq333WHG0g3o0tTtRX+a7Zl+iew19pb
         aA1w5aploCGvDrBv/+PpaxrpehiJHwPB2k5iXfaNQ1GjUzxc1zuKF/0RTi7jcJxXz6xK
         kOLJu+teT6K80A92EuK/thFy/RQfeKA5NyGDyHufQmWW1PcPymvAKd6fJi3UjGCHMgGQ
         XTjtOnkThV9iD/1XO2teXnzLnmjRTjIadaV8Rc1cQVA22871SXnqpGQbA5FxnshrtlHR
         MCmFfNACaX8LT4L4HJRXCQawf6v8OhJMFcX5b2DoAKT0ppWxatJktku0x3NqllriHn26
         lw7g==
X-Gm-Message-State: AOAM533tcIWUrj2BngHwZbSSEDpydWIjxyGTd1aOh52bL/nBJ7PcHbFJ
        Sm4eE9CoBq8B2P1GFIInvw==
X-Google-Smtp-Source: ABdhPJwus8FT5y2o3/MJA9opEbTL/aWgDuKhBeOv7vLJJLqBbRBk4A9XVfafmZwyivYO4tXGW68qrQ==
X-Received: by 2002:a05:6870:5687:b0:dd:d21b:4e54 with SMTP id p7-20020a056870568700b000ddd21b4e54mr604717oao.184.1647905407981;
        Mon, 21 Mar 2022 16:30:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm7795352ott.2.2022.03.21.16.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:30:07 -0700 (PDT)
Received: (nullmailer pid 746077 invoked by uid 1000);
        Mon, 21 Mar 2022 23:30:06 -0000
Date:   Mon, 21 Mar 2022 18:30:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH V6 2/3] dt-bindings: spi: support hclk
Message-ID: <YjkKfjeJ5cuSyE3d@robh.at.kernel.org>
References: <20220321013922.24067-1-leilk.liu@mediatek.com>
 <20220321013922.24067-3-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321013922.24067-3-leilk.liu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 09:39:21 +0800, Leilk Liu wrote:
> this patch support hclk for AHB bus.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
