Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EEA59D2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbiHWHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbiHWHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:52:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2681C65252
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9FA03CE1B0B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E279EC433C1;
        Tue, 23 Aug 2022 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661241151;
        bh=iSO3PHv91eS3Mg/NxRVM4R0uyfbRFbYAiJtmZp7lFO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oK4Vrj3+oRe77PnPSsTGrWx4aKWHOHTYyEeYSGf/YMOMu0z0ngkuIh4o8yd3Ojltc
         IcufgUnnfDEwdzKGUFlb/qbosJkgMNin1AATxWzi1o7vpIusBabt1QlIWRso/qTjac
         v9R16zDH2woBfaki20os5n/O0RZu3BmKY6bz7r3OpHsPorWQy3cPI1jGA1rPpK+nq4
         V7Pta4MOymBDbvyMmCXFsjhqYrkjZi52BET5WdzRyT0YHRXSRvgwK4BLKTvvDE1T7+
         +7ZQlbytw6srR1AkqR8vCpRWUkdlCC57ViXXZkXYnxdW32hb063znF/XZWxyShCvib
         ik4RPoO0CHAQg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQOi6-0004ZR-Ps; Tue, 23 Aug 2022 09:52:31 +0200
Date:   Tue, 23 Aug 2022 09:52:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/panel-edp: add AUO B133UAN02.1 panel entry
Message-ID: <YwSHPooA189qn/Qx@hovoldconsulting.com>
References: <20220711075202.21775-1-johan+linaro@kernel.org>
 <YtpyeCHojFovBKxv@hovoldconsulting.com>
 <YwOGCPFTx0+MNfN2@hovoldconsulting.com>
 <CAD=FV=XRjpbeMnh_dtLh1hb-zfWOk6UJwqFBr+otk=sq9vjm3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XRjpbeMnh_dtLh1hb-zfWOk6UJwqFBr+otk=sq9vjm3A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:33:40AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Aug 22, 2022 at 6:35 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Jul 22, 2022 at 11:48:40AM +0200, Johan Hovold wrote:
> > > On Mon, Jul 11, 2022 at 09:52:02AM +0200, Johan Hovold wrote:
> > > > Add an eDP panel entry for AUO B133UAN02.1.
> > > >
> > > > Due to lack of documentation, use the delay_200_500_e50 timings like
> > > > some other AUO entries for now.
> > > >
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> > This one still hasn't been picked up.
> >
> > Is this something you can do, Doug? I noticed you applied a couple of
> > patches to this driver recently.
> >
> > Or who is really responsible for this driver?
> 
> Officially it falls within this section of maintainers:
> 
> DRM PANEL DRIVERS
> M:      Thierry Reding <thierry.reding@gmail.com>
> R:      Sam Ravnborg <sam@ravnborg.org>
> L:      dri-devel@lists.freedesktop.org
> S:      Maintained
> T:      git git://anongit.freedesktop.org/drm/drm-misc
> F:      Documentation/devicetree/bindings/display/panel/
> F:      drivers/gpu/drm/drm_panel.c
> F:      drivers/gpu/drm/panel/
> F:      include/drm/drm_panel.h
> 
> ...and then you just have to know that if the "tree" is drm-misc that
> it falls under drm-misc rules. That means that anyone who is a
> drm-misc-next committer can commit it.
> 
> I've been trying to keep an eye on panel-edp ever since I split it out
> from panel-simple, though. I'll post up a MAINTAINERS entry to try to
> make that more official.

Sounds good.

> In any case, I've landed this on drm-misc-next:
> 
> ee50b0024408 drm/panel-edp: add AUO B133UAN02.1 panel entry

Thanks for that! Perhaps you can take look also at this one:

	https://lore.kernel.org/all/20220720054152.2450-1-steev@kali.org/

which is for another panel found on some X13s?

Johan
