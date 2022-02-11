Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F64B2B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351848AbiBKQ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:59:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351850AbiBKQ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:59:31 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7343CD4;
        Fri, 11 Feb 2022 08:59:27 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id o25so8766016qkj.7;
        Fri, 11 Feb 2022 08:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yxTDG3L66sv6/x75/eI7qWhPShuWXXpishkPZKHjZQ=;
        b=PZjfqg32RMolQdu2GdXF4Bxxdg6a7i77WiS/h4UU3BqX9UzHFVchD9wAcoT6ChUBEL
         u7IPh7bxpckCf0D2y0G3dF3EvwOyZFJ1pW9e7jLnmIfQNwr3w5IkA5lWKgcVon2nfHCt
         wOT7v1GUJzZjvA++InGSWXjtT4aXb6K1WDI3zsD9FYdrOLHdKNA+AJddzWGHnZ+Kmg++
         wqNh6nNfYEL66GEPW7/lFL66ijsY/zEbiEho85i0yKHTmeeDeDbiLGPFE+najlVy5Mq9
         hmc78oUREzfnPA866WffjjqsBTnR+73PL7wx8zF/vfV2RAmsWqhFBqiW1AjtzEznfoCw
         DMxQ==
X-Gm-Message-State: AOAM531K0X/MnHLvl+JeA+r94ztl54ojheAS7C0qpTsy2L85XUDl7G+R
        h18enJGvGhiOgQGZ97dXUA==
X-Google-Smtp-Source: ABdhPJxkD6HcPp0yjhgHl6Xpz1CUtP20uJOD7KXrALJK1CT6iJ4t6RJgnsP1PtESdzRNUItNx1QrAw==
X-Received: by 2002:a05:620a:1712:: with SMTP id az18mr1225926qkb.626.1644598766892;
        Fri, 11 Feb 2022 08:59:26 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id g20sm12384144qko.27.2022.02.11.08.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:59:26 -0800 (PST)
Received: (nullmailer pid 518102 invoked by uid 1000);
        Fri, 11 Feb 2022 16:59:23 -0000
Date:   Fri, 11 Feb 2022 10:59:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5/6] dt-bindings: spi: support mediatek,need_ahb_clk flag
Message-ID: <YgaV6w1ooAzTpYNz@robh.at.kernel.org>
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
 <20220209111938.16137-6-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209111938.16137-6-leilk.liu@mediatek.com>
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

On Wed, Feb 09, 2022 at 07:19:37PM +0800, Leilk Liu wrote:
> this patch support mediatek,need_ahb_clk flag.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index 241c0f5880d3..af12c1711182 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -71,6 +71,11 @@ properties:
>        specify which pins group(ck/mi/mo/cs) spi controller used.
>        This is an array.
>  
> +  mediatek,need_ahb_clk:

s/_/-/

But really, this should be implied by the compatible string or presence 
of the clock in 'clocks'.

Rob
