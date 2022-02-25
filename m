Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814DA4C4E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiBYS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiBYS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:58:34 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCDB1E5A7E;
        Fri, 25 Feb 2022 10:58:00 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id s5so8286169oic.10;
        Fri, 25 Feb 2022 10:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSJqpyXOMhS5kw8V/AvAh+G8eD23sLN1cYoPcwgSo8E=;
        b=118+1Rxu2UaqJraskJQQigouB7XOUHGYv0ly0Rwqn/sA0L9zK+RdAFbBUjkLx1p1oe
         Wvnd74PI1oGuh54WfXO4BJdx9eDFTgfFsjNCIahd6GpKVANpRQWGrvj6ff7r3XtrxZNX
         bL+tQt4D9PwtSS+5fYYi1FIgGCSkdtlz/7T2narTyLoynYZ3dnSquXKt2lDk1NVmFqYp
         R0yzeHGS92W5OXpDFE+/9RQ9lspZkVYvDFfSfKYsCHkObFBZueo6edifE1Q1vrESn86S
         AoUr6NWicQmFlqF1NaBlIE4TvYG2sUkIToe4UNrZsIOtteoyKQlgYyX4n64aOS/baBvq
         wuTg==
X-Gm-Message-State: AOAM530Hs/GRKy82q5HxbzsSSx9xlNvwSZzMaPo4hp7XOJbXaQiCcj2W
        T0zR4ouf6PLOO6c1V+epcA==
X-Google-Smtp-Source: ABdhPJzRL9I3juGZd4RbqTGsMJXhz2hWy20wQ1cZOx4PfY+9S5H2lzmLZ7u4WHIoeRBMZsSwD3TCkQ==
X-Received: by 2002:a05:6808:13d6:b0:2d5:1d7e:5f1 with SMTP id d22-20020a05680813d600b002d51d7e05f1mr2542906oiw.41.1645815480271;
        Fri, 25 Feb 2022 10:58:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s30-20020a056870611e00b000d2672a8d13sm1732106oae.12.2022.02.25.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:57:59 -0800 (PST)
Received: (nullmailer pid 1247848 invoked by uid 1000);
        Fri, 25 Feb 2022 18:57:58 -0000
Date:   Fri, 25 Feb 2022 12:57:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/6] dt-bindings: spi: Add compatible for Mediatek IPM
 IP with single mode
Message-ID: <YhkmtgZzKiFn8ntK@robh.at.kernel.org>
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
 <20220221040717.3729-2-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221040717.3729-2-leilk.liu@mediatek.com>
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

On Mon, 21 Feb 2022 12:07:12 +0800, Leilk Liu wrote:
> This patch adds dt-binding documentation for Mediatek SPI IPM IP with
> single mode.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
