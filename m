Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CDA513E72
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352830AbiD1WUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiD1WUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:20:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0B36B74
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:17:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6DC24496;
        Fri, 29 Apr 2022 00:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651184247;
        bh=Uzoqv2V4P+He5pMnhrC6spSgHqSYirP43shZzY8LWuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AafzOKqoNSgUWocspj+nlEbYRXni9FRZmMo79tAGUTMsvfj9HcbzLZAMVTpndnhcX
         c6oPTSr+eEUaljye0r+UXx+ZTiG7Ocx0KzsbnbH3JsVZHQ4PLMw1up9AUIBaCukQNE
         lVlR9phh9JWzZ430RuevaPameayv8VGVn7uU9TLk=
Date:   Fri, 29 Apr 2022 01:17:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or
 bridge"
Message-ID: <YmsSdmOEpSz4okt2@pendragon.ideasonboard.com>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes>
 <CAMty3ZBwguzvC8A9xA5c0enfoFRGS=4wWCzpfakTUXrsRS9GyA@mail.gmail.com>
 <20220427143410.bectqumq62qmlv5x@houat>
 <CAMty3ZDk-M3hW97_GY4-z=f+cKs1Sg4Jbq5L7L4zHgXURhFuZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZDk-M3hW97_GY4-z=f+cKs1Sg4Jbq5L7L4zHgXURhFuZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Thu, Apr 28, 2022 at 02:09:42PM +0530, Jagan Teki wrote:
> On Wed, Apr 27, 2022 at 8:04 PM Maxime Ripard wrote:
> > On Tue, Apr 26, 2022 at 01:40:31PM +0530, Jagan Teki wrote:
> > > On Tue, Apr 26, 2022 at 1:24 PM Paul Kocialkowski wrote:
> > > > On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > > > > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > > > > + Linus
> > > > > > > + Marek
> > > > > > > + Laurent
> > > > > > > + Robert
> > > > > > >
> > > > > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson wrote:
> > > > > > > >
> > > > > > > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > > > > > > bridge")' attempted to simplify the case of expressing a simple panel
> > > > > > > > under a DSI controller, by assuming that the first non-graph child node
> > > > > > > > was a panel or bridge.
> > > > > > > >
> > > > > > > > Unfortunately for non-trivial cases the first child node might not be a
> > > > > > > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > > > > > > DisplayPort, or an opp-table represented before the panel node.
> > > > > > > >
> > > > > > > > In these cases the reverted commit prevents the caller from ever finding
> > > > > > > > a reference to the panel.
> > > > > > > >
> > > > > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> > > > > > > > panel or bridge")', in favor of using an explicit graph reference to the
> > > > > > > > panel in the trivial case as well.
> > > > > > >
> > > > > > > This eventually breaks many child-based devm_drm_of_get_bridge
> > > > > > > switched drivers.  Do you have any suggestions on how to proceed to
> > > > > > > succeed in those use cases as well?
> > > > > >
> > > > > > I guess we could create a new helper for those, like
> > > > > > devm_drm_of_get_bridge_with_panel, or something.
> > > > >
> > > > > Oh wow I feel stupid for not thinking about that.
> > > > >
> > > > > Yeah I agree that it seems like the best option.
> > > >
> > > > Should I prepare a patch with such a new helper?
> > > >
> > > > The idea would be to keep drm_of_find_panel_or_bridge only for the of graph
> > > > case and add one for the child node case, maybe:
> > > > drm_of_find_child_panel_or_bridge.
> > > >
> > > > I really don't have a clear idea of which driver would need to be switched
> > > > over though. Could someone (Jagan?) let me know where it would be needed?
> > >
> > > sun6i_mipi_dsi
> >
> > It doesn't look like sun6i_mipi_dsi is using devm_drm_of_get_bridge at all?
> 
> Correct, patch for this on the mailing list.

I've lost track of how we're solving the fallout of this for v5.18. I
have received a report that the original commit (80253168dbfd) also
broke the rcar-du driver. Could you please provide a git branch (based
on drm-fixes or drm-misc-fixes) with any patch that you plan to get
merged in v5.18, to let me test them locally ?

> > > exynos_drm_dsi
> >
> > If you reference 711c7adc4687, I don't see why we would need to switch
> > it back to the old behaviour. It wasn't iterating over its child node
> > before, so what does the switch to drm_of_get_bridge broke exactly?
> 
> Exynos bindings have a child node (unlike OF-graph), the old code is
> checking panel and bridge individually so it broke once switch to
> devm_drm_of_get_bridge

-- 
Regards,

Laurent Pinchart
