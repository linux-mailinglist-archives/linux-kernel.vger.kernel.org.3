Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9553BA1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiFBNvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiFBNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:50:57 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C422A1411;
        Thu,  2 Jun 2022 06:50:53 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id p129so1940527oig.3;
        Thu, 02 Jun 2022 06:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jdOjrDyA7N80Kr2XJDTR1sTUxUj7yflrK/c+RDOiH7Q=;
        b=c3mJsVsYFt07X9qT68MayvLv1IB3b2gMUEpnyuJGXG1clN2N20F2v28F9rulA18FOr
         2+XL8xvxW4Bjx6DAw8F7QTvkWvZ+FcectoHojCB3W5NxPT9GypKcCNCOnNfyRaMeimGV
         0fP/kOfRjxujVAP9H3HaO5REYvpdL9zPI5ImZJwmrxbsvk/AQOTG7VRR2fWgqxf2hxv8
         CJXxlnUsa+8m7Nwgnk/TRbXQDZZtPBSudy5c5LUpWeckK1BwBPJS2LZrVW9X+tWCfx/n
         VKy8q5Cgrq5us5jSRHx6Cx/1rTVQGalhPSP/0WY6sKfYbdXIWAQjTQLYF+aNmLoQeP0f
         covw==
X-Gm-Message-State: AOAM533kGx8MOqdMKOZ8nIlxDK5Azl38tJKfz5c3BVJfJFm/8TkRRzcm
        HIe9nFWxMsOUiaWR/4q4jA==
X-Google-Smtp-Source: ABdhPJzzid12tQ8/0sk2mtJnB6ChA7jIEzHwVF8O3v1rFbLifzEkZET93h3PoIs/zk6pfvnr4NUigg==
X-Received: by 2002:a05:6808:1828:b0:32a:dc9e:bc62 with SMTP id bh40-20020a056808182800b0032adc9ebc62mr17279222oib.239.1654177852958;
        Thu, 02 Jun 2022 06:50:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mv26-20020a0568706a9a00b000f5701f240csm1920694oab.19.2022.06.02.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:50:52 -0700 (PDT)
Received: (nullmailer pid 2187942 invoked by uid 1000);
        Thu, 02 Jun 2022 13:50:51 -0000
Date:   Thu, 2 Jun 2022 08:50:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 1/7] dt-bindings: interconnect: sunxi: Add V3s mbus
 compatible
Message-ID: <20220602135051.GA2187908-robh@kernel.org>
References: <20220525185853.695931-1-paul.kocialkowski@bootlin.com>
 <20220525185853.695931-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525185853.695931-2-paul.kocialkowski@bootlin.com>
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

On Wed, 25 May 2022 20:58:47 +0200, Paul Kocialkowski wrote:
> Since the V3s uses the internal mbus for DMA with multimedia devices,
> document its compatible in accordance with the extended mbus binding.
> 
> This will enable adding support for the V3s in the full-fledged
> devfreq driver eventually.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
