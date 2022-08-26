Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2C5A3210
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiHZWaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiHZWaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:30:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211EF13D67;
        Fri, 26 Aug 2022 15:30:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0AF2530B;
        Sat, 27 Aug 2022 00:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661553013;
        bh=95rso+6ZK2m4ZObi0/RoJ3LOYtwF51ui1S6wgIUGExM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfSbxoiWDGp3lQH2PpLyQS3EWRyGtdHF2i+TLVByTxrCqIvt1PiIYkDWgYkqgBHXe
         Kw6N0lZ7LqOqvj/9qnCUu0yqC3tTMUzgtOQd3ZnR88dZqWxYMbE2m9P4RaHWiCdM4R
         O3mladpSy1CnYwliQ0+u3rghBNiCvkZaL7Kikt1U=
Date:   Sat, 27 Aug 2022 01:30:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 4/6] MAINTAINERS: Add entry for the Allwinner A31 ISP
 driver
Message-ID: <YwlJbXXQhFHBpJEa@pendragon.ideasonboard.com>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
 <20220826184144.605605-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826184144.605605-5-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Fri, Aug 26, 2022 at 08:41:42PM +0200, Paul Kocialkowski wrote:
> Add myself as maintainer of the Allwinner A31 ISP media driver.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bd7b7d14f08..571348195560 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -787,6 +787,15 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
>  F:	drivers/media/platform/sunxi/sun6i-csi/
>  
> +ALLWINNER A31 ISP DRIVER
> +M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> +F:	drivers/staging/media/sunxi/sun6i-isp/
> +F:	drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h
> +
>  ALLWINNER A31 MIPI CSI-2 BRIDGE DRIVER
>  M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>  L:	linux-media@vger.kernel.org

-- 
Regards,

Laurent Pinchart
