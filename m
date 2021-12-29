Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB1481544
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbhL2QrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbhL2QrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:47:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9FC06173E;
        Wed, 29 Dec 2021 08:47:02 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20AC1D6E;
        Wed, 29 Dec 2021 17:47:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640796420;
        bh=ymKJuUNIvrp3/QHbIsO0gRO9KwKbQnHDSoAKgx7VMMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITKgtCJX60ss+aEn430yirkaZ87nHCGVxRYHuRLK9nKW4bYLGp60z3za9VwQDGQKU
         4PG9K2RbnCA2zq7wBUgknmGoRC7wIBRKVI+sDiJRYh/C5C5vUu9lfai9XrNhR2cMJX
         utWApJhZOqssm/2yqr1sXcuVNAxqFB0jh932HRvU=
Date:   Wed, 29 Dec 2021 18:46:58 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: display: bridge: renesas,lvds: Document
 r8a77961 bindings
Message-ID: <YcyRAk/d2728mDgH@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-4-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211224052309.1997096-4-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch.

On Fri, Dec 24, 2021 at 08:23:09AM +0300, Nikita Yushchenko wrote:
> Document the R-Car M3-W+ (R8A77961) SoC in the R-Car LVDS encoder
> bindings.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  .../devicetree/bindings/display/bridge/renesas,lvds.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> index acfc327f70a7..ca5443e5c2e3 100644
> --- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> @@ -27,6 +27,7 @@ properties:
>        - renesas,r8a7791-lvds # for R-Car M2-W compatible LVDS encoders
>        - renesas,r8a7793-lvds # for R-Car M2-N compatible LVDS encoders
>        - renesas,r8a7795-lvds # for R-Car H3 compatible LVDS encoders
> +      - renesas,r8a77961-lvds # for R-Car M3-W+ compatible LVDS encoders

I'll move this line after the next to keep them sorted. No need to
resubmit.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>        - renesas,r8a7796-lvds # for R-Car M3-W compatible LVDS encoders
>        - renesas,r8a77965-lvds # for R-Car M3-N compatible LVDS encoders
>        - renesas,r8a77970-lvds # for R-Car V3M compatible LVDS encoders

-- 
Regards,

Laurent Pinchart
