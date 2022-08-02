Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCC958758A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiHBC3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiHBC3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:29:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05879326FA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:29:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s11so4501956edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Saw05UbzeLU4x42pdH6Ov1+fGLmaoiI2fVR2aA4FGOI=;
        b=PuWABKd9mqgWfOp3GFE6NSnZwEdPEog9wdEbqUKAbcfJgAT5VVgPyUkUhkZ5akacVt
         pzc7EY+92Mp8v4kT0hDpUhWsy/bfeqeseMPsaCqgLFsHfHWWqf77H7jrG+8foGShZDn7
         BrlHtFb1POlCymwP5emBo6OPa0Qo0qFYHetX9oup9YlBQaYhP6YcaPJf8aVG8QxzeRfT
         vZpvqfF4r+V75F/uQ4b7j/2ApDv5c+9DY9fzZZkywjp6zH8fTjxSVkAu0tNyBOSUegeM
         sGF6IoQUSWdcTBI2inVPRxSID2rKZVXPhw1LYzlHywbUQhx6CZ+yOzWDU7I7fzY5VEsP
         5ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Saw05UbzeLU4x42pdH6Ov1+fGLmaoiI2fVR2aA4FGOI=;
        b=WsFnIOlk2jWqIJpeWv30JHoIOKlEcj7VvexvEC+0JUyTeZMDCi4kB5V8EXMKlKi9v0
         M/ylRIaKSaocn3XfHzO6VcWQ6+K+TUOHIfRsGuZHume1r6/h8sRA8HY0i3Z4L16rFwaK
         dGPMi2AvvMbbzpayMEmBpeK4G6uQnS+KKotzAB8IGfmAy4XBcolAXiD0YcityhQHGNiP
         hPfXJNam0Oz5BOML4GIGk2PhNWZoZ7GVRtdeMCH9+SnPP+nD0dvQTgbmTJVB91wPN6MC
         eKzcbfp0irnWfhTyqize7kkqVxL1sZivXb/qTZiZKNTlVKJauazIzj+1o/SUtzo1om2w
         0RNQ==
X-Gm-Message-State: ACgBeo2OmjAZAPrSMVsCpI3EOYMMXYGSy1T4C3GxXzSTZX2hvqzBz1Al
        Bhmmz8dizDpO4tKIpN3lnGk20WT2jwU593AL4V4=
X-Google-Smtp-Source: AA6agR7UrWWcdefjI5jUoxo77LkjqTPIhxNnO4p1T26x2Mt+qW+0cnDlhMncW2H1YORPKYARPrDRD0mMizgKXkCDXao=
X-Received: by 2002:a05:6402:1e8c:b0:43d:db52:78a8 with SMTP id
 f12-20020a0564021e8c00b0043ddb5278a8mr3233023edf.324.1659407391399; Mon, 01
 Aug 2022 19:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com>
 <20220801225538.qtdb5zd66g6ipewz@pengutronix.de> <CAOMZO5DUTxQKbpTVOgaVC0V7hPqJG77sgmkW8p=aNpG8th-aLw@mail.gmail.com>
 <CAHCN7xL2w7a=SeXbwcNNxqb3kpRV9Bs0AbK0Nmjbj+dm0NDaVA@mail.gmail.com> <CAOMZO5BQWnUj4Ouq3=vhqq55zN8otO_9vPX8ht+muFM_5pg9Fg@mail.gmail.com>
In-Reply-To: <CAOMZO5BQWnUj4Ouq3=vhqq55zN8otO_9vPX8ht+muFM_5pg9Fg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 1 Aug 2022 21:29:40 -0500
Message-ID: <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>, robert.chiras@nxp.com,
        laurentiu.palcu@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 8:53 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 10:39 PM Adam Ford <aford173@gmail.com> wrote:
>
> > I managed to get my HDMI output working. I had the lanes set to 2
> > instead of 4.  Once I switched to 4-lanes, the monitor came up in
> > 1080p.  I haven't yet been able to get other modes to work.
>
> Ok, good. On another thread, you mentioned that you were also trying
> to get LVDS to work via SN65DSI83.
>
> Does LVDS work for you on this branch?

I haven't tried with Marek's latest suggestion.  In the other thread
he mentioned a burst mode and setting the DSI speeds to higher
frequencies, but the patch he had didn't look like it would apply
cleanly, so I will need to dig into that a bit further.  Since my
company doesn't really ship the LVDS displays with the kits, the HDMI
is the default video, so I've been focusing on it.

To answer Marco's question, I was able to revert "MLK-21958-13:
drm/bridge: adv7511: Limit supported clocks" and still get a display
at 1080p, but all the other resolutions I tried appear to come up
blank.  I didn't try every one.  With that revert, more options come
available, but 1440x900 and 800x600 were options I tried
unsuccessfullyl.

adam
