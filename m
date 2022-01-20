Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7C494BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376339AbiATKjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376340AbiATKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:39:34 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27088C061574;
        Thu, 20 Jan 2022 02:39:32 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 5A982E0014;
        Thu, 20 Jan 2022 10:39:26 +0000 (UTC)
Date:   Thu, 20 Jan 2022 11:40:29 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
Message-ID: <20220120104029.wenol7qdfjl2f53n@uno.localdomain>
References: <20220120012553.23295-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120012553.23295-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prabhakar

On Thu, Jan 20, 2022 at 01:25:53AM +0000, Lad Prabhakar wrote:
> CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> handled by rcar-csi2.c driver. This patch updates the data-lanes property
> to describe the same.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>
> Instead of adding uniqueItems:true into SoC binding doc's I think we could
> add this in video-interfaces.yaml for data-lanes property. Any thoughts on this?
>

As repeating items are not allowed I think it's a good idea.
In the meantime this patch looks good to me

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

> Cheers,
> Prabhakar
>
> v1->v2
> * Dropped const items
> * Added uniqueItems
>
> v1:
> https://lore.kernel.org/lkml/20220118163413.ge2b4g75yhfqvq3x@uno.localdomain/T/
> ---
>  Documentation/devicetree/bindings/media/renesas,csi2.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> index e6a036721082..a5a1b570025a 100644
> --- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> +++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> @@ -67,7 +67,11 @@ properties:
>                  maxItems: 1
>
>                data-lanes:
> -                maxItems: 1
> +                minItems: 1
> +                maxItems: 4
> +                uniqueItems: true
> +                items:
> +                  maximum: 4
>
>              required:
>                - clock-lanes
> --
> 2.17.1
>
