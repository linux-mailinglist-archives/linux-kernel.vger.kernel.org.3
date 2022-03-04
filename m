Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4494CD422
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiCDMVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiCDMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:21:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741EC1AF8EA;
        Fri,  4 Mar 2022 04:21:00 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A279651C;
        Fri,  4 Mar 2022 13:20:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646396458;
        bh=oIDe/f8B9cn87MHXgHXk87sK0s0dk8BfabHrG4XHYD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRL/LjPiTjiAls3MikIQdkLhAmW/kDjyUryPHWK1ojr/2N9y0Ac0aZOg9FxYZQe4P
         JZvO5JOHF2RoxQ4Ik7EBmBB9o7o5OC4P01Sn47U7+frUFdDRDq9IQy4AQQVwZENId8
         9U+x7KGQzRTPpWXEsV4Qq4JwlhC6AefEG/j8Nvl4=
Date:   Fri, 4 Mar 2022 14:20:46 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: display: bridge: renesas,lvds: Document
 r8a77961 bindings
Message-ID: <YiIEHpI3ltyOwumx@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-4-nikita.yoush@cogentembedded.com>
 <YcyRAk/d2728mDgH@pendragon.ideasonboard.com>
 <CAMuHMdWkgEwgSEBrNt57nMPuMvyCSPsSbKFuQTGX8qX0-mrDLA@mail.gmail.com>
 <YiCG7xSHx6qqFlrc@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiCG7xSHx6qqFlrc@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:14:24AM +0200, Laurent Pinchart wrote:
> On Wed, Mar 02, 2022 at 06:00:08PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 29, 2021 at 5:47 PM Laurent Pinchart wrote:
> > > On Fri, Dec 24, 2021 at 08:23:09AM +0300, Nikita Yushchenko wrote:
> > > > Document the R-Car M3-W+ (R8A77961) SoC in the R-Car LVDS encoder
> > > > bindings.
> > > >
> > > > Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > > > ---
> > > >  .../devicetree/bindings/display/bridge/renesas,lvds.yaml         | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > > > index acfc327f70a7..ca5443e5c2e3 100644
> > > > --- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > > > @@ -27,6 +27,7 @@ properties:
> > > >        - renesas,r8a7791-lvds # for R-Car M2-W compatible LVDS encoders
> > > >        - renesas,r8a7793-lvds # for R-Car M2-N compatible LVDS encoders
> > > >        - renesas,r8a7795-lvds # for R-Car H3 compatible LVDS encoders
> > > > +      - renesas,r8a77961-lvds # for R-Car M3-W+ compatible LVDS encoders
> > >
> > > I'll move this line after the next to keep them sorted. No need to
> > > resubmit.
> > 
> > Any chance this will happen soon? Same for patch 1/3 .
> > Patch 2/3 is already queued in soc/for-next.
> 
> Oops. I can send a pull request right away, but we're already at -rc6,
> so I'm afraid it will get delayed to v5.19.

The patch has been merged in the drm-next branch, thanks to Dave being
very reactive before the tree freeze period begins. Thank you Dave.

-- 
Regards,

Laurent Pinchart
