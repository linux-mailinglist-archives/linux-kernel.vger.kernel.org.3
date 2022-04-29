Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F5514426
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355508AbiD2I1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355391AbiD2I1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:27:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9FC12E2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:24:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b24so8191440edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSHFrxJseu+2aYKFMzIZcdb0pTPamF/GM8qyPG4laMc=;
        b=o6bZJOkhepDUdYJuXatWdXH4hEC30djRKhajFO4TAGzOyUhhuLBwXGB9zf0legSUOI
         fB4RCZGnaC5RPKIWUlJdLFlIKMSX/HgelBjF4O7R0i0eSxA344OnxOY7aCmFa8P/cXvP
         Xc1D4GwabPI71zWDlaa3nSX0RHkcljV6vZ82w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSHFrxJseu+2aYKFMzIZcdb0pTPamF/GM8qyPG4laMc=;
        b=AtU+U2+s6/626eslMTkZFn/IF7mHhw+cpTm0uTlhK1l/s9NHCC9bs4IUJDw9RvgE4y
         iKMbwRuVXWTqWFOHhsgkzRklhTD+ErwmuBMR9snuXVsE4hKJytlwqCqguYaqzhySbUMw
         ULEPmghU+5J/I5wCK96h7vRb61wvIM2DOvOo4wnTwTH4/HRe/0flRWjBGT+rmtT4vFPY
         D+dN/Mvv8nu6dnPk70zK99Ltm5AqpPazYJ2tujYMnv++KP+YBhdmxZzVFTdltDsIsvFm
         SmB/aRr5mWPO6QSWqHYIKVU1keb6vJSs/6/Y+/0CexDKhqgKwF7YyYigGJd4speROz+b
         /uAg==
X-Gm-Message-State: AOAM530MLsxOogQqJ1Yp49Z6bRgaWLN6U1RJlXA35pvwPK1RGB1P9BP2
        x75/1AjPPnj4V+ZIeHUKG4tc77UkiIDLk5rhSRFNhQ==
X-Google-Smtp-Source: ABdhPJyIYUy77NsMEjP76/WvK8Lc+VGEiVUCUbxI/7U5MkvdeTwv5TKDnwUvI5JOBZEw22+cyLpLyc3xmDDQCgGemfU=
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id
 f1-20020a056402194100b00413282209c8mr39822301edz.13.1651220663866; Fri, 29
 Apr 2022 01:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org> <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat> <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes> <CAMty3ZBwguzvC8A9xA5c0enfoFRGS=4wWCzpfakTUXrsRS9GyA@mail.gmail.com>
 <20220427143410.bectqumq62qmlv5x@houat> <CAMty3ZDk-M3hW97_GY4-z=f+cKs1Sg4Jbq5L7L4zHgXURhFuZA@mail.gmail.com>
 <YmsSdmOEpSz4okt2@pendragon.ideasonboard.com>
In-Reply-To: <YmsSdmOEpSz4okt2@pendragon.ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 29 Apr 2022 13:54:12 +0530
Message-ID: <CAMty3ZAGxhFtxNcYHJafJxSZ5xMuyumw4gWi1v=ZDVfgvF-7pQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Apr 29, 2022 at 3:47 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jagan,
>
> On Thu, Apr 28, 2022 at 02:09:42PM +0530, Jagan Teki wrote:
> > On Wed, Apr 27, 2022 at 8:04 PM Maxime Ripard wrote:
> > > On Tue, Apr 26, 2022 at 01:40:31PM +0530, Jagan Teki wrote:
> > > > On Tue, Apr 26, 2022 at 1:24 PM Paul Kocialkowski wrote:
> > > > > On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > > > > > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > > > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > > > > > + Linus
> > > > > > > > + Marek
> > > > > > > > + Laurent
> > > > > > > > + Robert
> > > > > > > >
> > > > > > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson wrote:
> > > > > > > > >
> > > > > > > > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > > > > > > > bridge")' attempted to simplify the case of expressing a simple panel
> > > > > > > > > under a DSI controller, by assuming that the first non-graph child node
> > > > > > > > > was a panel or bridge.
> > > > > > > > >
> > > > > > > > > Unfortunately for non-trivial cases the first child node might not be a
> > > > > > > > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > > > > > > > DisplayPort, or an opp-table represented before the panel node.
> > > > > > > > >
> > > > > > > > > In these cases the reverted commit prevents the caller from ever finding
> > > > > > > > > a reference to the panel.
> > > > > > > > >
> > > > > > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> > > > > > > > > panel or bridge")', in favor of using an explicit graph reference to the
> > > > > > > > > panel in the trivial case as well.
> > > > > > > >
> > > > > > > > This eventually breaks many child-based devm_drm_of_get_bridge
> > > > > > > > switched drivers.  Do you have any suggestions on how to proceed to
> > > > > > > > succeed in those use cases as well?
> > > > > > >
> > > > > > > I guess we could create a new helper for those, like
> > > > > > > devm_drm_of_get_bridge_with_panel, or something.
> > > > > >
> > > > > > Oh wow I feel stupid for not thinking about that.
> > > > > >
> > > > > > Yeah I agree that it seems like the best option.
> > > > >
> > > > > Should I prepare a patch with such a new helper?
> > > > >
> > > > > The idea would be to keep drm_of_find_panel_or_bridge only for the of graph
> > > > > case and add one for the child node case, maybe:
> > > > > drm_of_find_child_panel_or_bridge.
> > > > >
> > > > > I really don't have a clear idea of which driver would need to be switched
> > > > > over though. Could someone (Jagan?) let me know where it would be needed?
> > > >
> > > > sun6i_mipi_dsi
> > >
> > > It doesn't look like sun6i_mipi_dsi is using devm_drm_of_get_bridge at all?
> >
> > Correct, patch for this on the mailing list.
>
> I've lost track of how we're solving the fallout of this for v5.18. I
> have received a report that the original commit (80253168dbfd) also
> broke the rcar-du driver. Could you please provide a git branch (based
> on drm-fixes or drm-misc-fixes) with any patch that you plan to get
> merged in v5.18, to let me test them locally ?

The affected patches for 80253168dbfd revert are

711c7adc4687
3730bc6147b0 and 3d7039e1e649

Both these are not present drm-misc-fixes but there in linux-next.
I've sent a patch for 711c7adc4687
https://patchwork.kernel.org/project/dri-devel/patch/20220428094808.782938-1-jagan@amarulasolutions.com/

This is my repo on top of linux-next
https://github.com/openedev/kernel/tree/linux-next/drm-misc

As I have seen before rcar-du ("155358310f013") is OF-graph and it
doesn't affect the child node lookup was introduced in
("80253168dbfd")

Let me know if you have any further information.


Jagan.
