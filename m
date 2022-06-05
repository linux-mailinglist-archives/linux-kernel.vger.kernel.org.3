Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C3753DE4F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbiFEVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiFEVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:13:33 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39F626ACB;
        Sun,  5 Jun 2022 14:13:30 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id bi27so3159718qkb.10;
        Sun, 05 Jun 2022 14:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KpfFSC1M5yGrSdZeqGTbFQEXLC9iY/J8j0nw6v1d9eA=;
        b=gQd16NOtxpBCu4nmbZtPFAGFhsvDrKvLNehq1FmbPx87arWNBQ2fd7MM9CsuctjMU0
         blTN1UraSKDGd/kxRkuEbY4avXjoe5fxON5FQwjeq7aU/UiVBko9fS3KGMXeuuQafA5m
         W8aZsdh1Oo0ivDVzQzMpQr04i2AnkbhWdj72r9ZpMLH66/BC5PXorGhNPMYsSBuH6Jxt
         lkxDii/yWLBZ6x2vwB6+3TNuvS/D1NPERyZhZAwEaEtbM5p+DqzhR2mNfEf04uACQ6f8
         IdFfh7RFNL+8tN14t1hMTAdDE9UdR6Ew3+V2iEKoLAcCoK2xnfAZjAAHclJ1GZ6bF6yv
         QTpQ==
X-Gm-Message-State: AOAM53266m5zaroi+sE12/XxLJha1IwXAohHSv9WrOGfzrVd04HLSyWN
        O+B7d77CrHMeyb7Oo+9YLRNRXN7t1w==
X-Google-Smtp-Source: ABdhPJxj+kVxZu2//p08PSHYzTQNamVKMAVwaHKls0V8bl/cpaDKySLz6Jed2QcRGNYVSKQw1ooWIA==
X-Received: by 2002:a37:97c5:0:b0:6a6:8d77:1b5f with SMTP id z188-20020a3797c5000000b006a68d771b5fmr11485785qkd.216.1654463609916;
        Sun, 05 Jun 2022 14:13:29 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a69d7f390csm6411744qko.103.2022.06.05.14.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:13:29 -0700 (PDT)
Received: (nullmailer pid 3527763 invoked by uid 1000);
        Sun, 05 Jun 2022 21:13:26 -0000
Date:   Sun, 5 Jun 2022 16:13:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
Message-ID: <20220605211326.GA3525347-robh@kernel.org>
References: <20220530180328.845692-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530180328.845692-1-fparent@baylibre.com>
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

On Mon, May 30, 2022 at 08:03:26PM +0200, Fabien Parent wrote:
> Add IOMMU binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  2 +
>  include/dt-bindings/memory/mt8365-larb-port.h | 96 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8365-larb-port.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 97e8c471a5e8..5ba688365da5 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -77,6 +77,7 @@ properties:
>            - mediatek,mt8173-m4u  # generation two
>            - mediatek,mt8183-m4u  # generation two
>            - mediatek,mt8192-m4u  # generation two
> +          - mediatek,mt8365-m4u  # generation two
>  
>        - description: mt7623 generation one
>          items:
> @@ -120,6 +121,7 @@ properties:
>        dt-binding/memory/mt8173-larb-port.h for mt8173,
>        dt-binding/memory/mt8183-larb-port.h for mt8183,
>        dt-binding/memory/mt8192-larb-port.h for mt8192.
> +      dt-binding/memory/mt8365-larb-port.h for mt8365.
>  
>    power-domains:
>      maxItems: 1
> diff --git a/include/dt-bindings/memory/mt8365-larb-port.h b/include/dt-bindings/memory/mt8365-larb-port.h
> new file mode 100644
> index 000000000000..e7d5637aa38e
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8365-larb-port.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license please.

Rob
