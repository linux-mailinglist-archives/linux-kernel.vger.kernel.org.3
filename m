Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67C04C4E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiBYTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiBYTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:02:19 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF82023B1;
        Fri, 25 Feb 2022 11:01:46 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so7633827ooi.0;
        Fri, 25 Feb 2022 11:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FP9O1YxyGDdGfMc3m2rDm0MeKLExSjr2QWzSOURj93U=;
        b=IY8RxMqfYJRHVTarj5j6OWr/xgbifL4f7Mb3VIJPG7qgbI2+vIIXvYJ7ijDaR8sB2Q
         Q0Rg05YJCHhokRaKr8vAiLmptYe5xHwccyVY2OuwHBWT0YRgCYSKIqDb8e3H22gJRla3
         NoIuA9RD+4HYzzNvoMCQEL/4XuHzZvbjcozQb6+oWDHzWb2nPRM08FrHdxTsRqus+54T
         AJAFdf2T7GZMvt+sH6i1BSBuEs7IvP8j2LiCEZ3X/xICzzzQbLCwfFFYhvT90YOS/f0T
         0LUKnZrkCVGUzA6XuWeZ9/6MlIyAm4ADEuDvuHcAOf6WEhsWhAxdNQHoe+WdNMvsinUM
         R8lg==
X-Gm-Message-State: AOAM530GhTsTwJyKIo2rkwvNz83GAZozMUtv9xvxgj/hpN8LgsoDl0Aw
        3ux7OqXYs0BAMI9MTrmJqi+3S4Kuew==
X-Google-Smtp-Source: ABdhPJyCXqGMfApki5/NqUGzddyHbNbNMth+hf6LAv/ruJrKBsXjxKZlMizx3HI8tHzJxPCtxmJUMw==
X-Received: by 2002:a05:6870:c0cb:b0:ce:c0c9:615 with SMTP id e11-20020a056870c0cb00b000cec0c90615mr2025979oad.103.1645815705506;
        Fri, 25 Feb 2022 11:01:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i28-20020a056808055c00b002d51e377248sm1695070oig.33.2022.02.25.11.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:01:44 -0800 (PST)
Received: (nullmailer pid 1252805 invoked by uid 1000);
        Fri, 25 Feb 2022 19:01:44 -0000
Date:   Fri, 25 Feb 2022 13:01:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH V2 3/6] dt-bindings: spi: Add compatible for Mediatek IPM
 IP with quad mode
Message-ID: <YhknmEtjpN7Lmoru@robh.at.kernel.org>
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
 <20220221040717.3729-4-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221040717.3729-4-leilk.liu@mediatek.com>
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

On Mon, Feb 21, 2022 at 12:07:14PM +0800, Leilk Liu wrote:
> This patch adds dt-binding documentation for Mediatek SPI IPM IP with
> quad mode.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index 0a2fc0404cb3..241c0f5880d3 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -42,6 +42,7 @@ properties:
>                - mediatek,mt8173-spi
>                - mediatek,mt8183-spi
>                - mediatek,ipm-spi-single
> +              - mediatek,ipm-spi-quad

Can't you use the existing width properties to distinguish? Or is the 
programming not a superset?

Is 'ipm' an SoC? If not, these need to be SoC specific.

Rob
