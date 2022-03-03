Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A444CB9EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiCCJPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiCCJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:15:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B4119435;
        Thu,  3 Mar 2022 01:14:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC1A6885;
        Thu,  3 Mar 2022 10:14:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646298876;
        bh=OSe+PR5iWXfk7TT5SmP463t6QDDD1+tQqfbrYuJ59f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnUFRHaoCchmSwwnyhCDedhVyStwSz2xuZyQIv1ynac1QJiCugETWID5aNAINkn0p
         tpChYrzOvLoJh6Tv78+ZZ2V0KnuTwB0WmtY7iK5EbxWEh4sMnxGzLtebJZ+3LarCIN
         Z4kWWgD51SU28KPoS1cw/FwUbTe6bHkRWX6Jij/Y=
Date:   Thu, 3 Mar 2022 11:14:23 +0200
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
Message-ID: <YiCG7xSHx6qqFlrc@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-4-nikita.yoush@cogentembedded.com>
 <YcyRAk/d2728mDgH@pendragon.ideasonboard.com>
 <CAMuHMdWkgEwgSEBrNt57nMPuMvyCSPsSbKFuQTGX8qX0-mrDLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWkgEwgSEBrNt57nMPuMvyCSPsSbKFuQTGX8qX0-mrDLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:00:08PM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 29, 2021 at 5:47 PM Laurent Pinchart wrote:
> > On Fri, Dec 24, 2021 at 08:23:09AM +0300, Nikita Yushchenko wrote:
> > > Document the R-Car M3-W+ (R8A77961) SoC in the R-Car LVDS encoder
> > > bindings.
> > >
> > > Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > > ---
> > >  .../devicetree/bindings/display/bridge/renesas,lvds.yaml         | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > > index acfc327f70a7..ca5443e5c2e3 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > > @@ -27,6 +27,7 @@ properties:
> > >        - renesas,r8a7791-lvds # for R-Car M2-W compatible LVDS encoders
> > >        - renesas,r8a7793-lvds # for R-Car M2-N compatible LVDS encoders
> > >        - renesas,r8a7795-lvds # for R-Car H3 compatible LVDS encoders
> > > +      - renesas,r8a77961-lvds # for R-Car M3-W+ compatible LVDS encoders
> >
> > I'll move this line after the next to keep them sorted. No need to
> > resubmit.
> 
> Any chance this will happen soon? Same for patch 1/3 .
> Patch 2/3 is already queued in soc/for-next.

Oops. I can send a pull request right away, but we're already at -rc6,
so I'm afraid it will get delayed to v5.19.

-- 
Regards,

Laurent Pinchart
