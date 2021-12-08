Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A82946D8F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhLHQ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhLHQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:57:23 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C667C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:53:51 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d14so358908ila.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onSEYhphyrw5ksP9+mtXuqQI4y1ahf7sSwREYeqo+Vk=;
        b=U8ES09t94uicogVku+ptvUrOCG/mRsH6grOV+JzFSsbgAVaN/uwhgCyghkePkEVXLa
         zfzUfGDhzHAR4iRYrxBURVKWAIt6+iK/jSxeNoU5IEY5B5fgGugasWeUljP0oNPW0xlP
         rdnTKVEVJD86L2C9awUtXBciXklKczO86CEMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onSEYhphyrw5ksP9+mtXuqQI4y1ahf7sSwREYeqo+Vk=;
        b=RLSz074MPZOc54H4z8745E8HkJlPQyt2m3ZtOIuOVXhG0/SzxsR/TnY2s2HjfQyRvX
         KYbeWEMIc1Eeg2doAUzK3s0Ah6DqQHJJRW7Jw5fk+JNyH7yrHX1jlnIWp4qUu9xm/S20
         o6nrYc0D2INea90zfiK73y45s8Y4kVErc40Mw+LITBgUZrqWX+h9ZaOcWh11yVKytsvU
         GbiBaoJQNvxhRm0dq5lX8KRZLKab5hOcuanbC4WtARvjiNYbMCD+SnZLL4PhqfyuzH1U
         C99aIla84qYtcpDEwJLXDiT/YS949S1ySK2HC5wOdjHQ3Z1DKkzWa+st/JlO5EDvDAbP
         yMsA==
X-Gm-Message-State: AOAM533m1xONRwSD64sAkd9mlVL0YZe4nROI+/6ogG2lowWRPEl+Phz+
        PWoGqMp0t3q0XkoLtWilcqo6k/ePb+MwTQ==
X-Google-Smtp-Source: ABdhPJwERST8b7oiwH8nAac/PGLDVtU4ZyMUDcNqrIrRjUT6fqKttOC91poDL5Vr0qcLUGgKjOJUkw==
X-Received: by 2002:a92:4a04:: with SMTP id m4mr7152725ilf.103.1638982430350;
        Wed, 08 Dec 2021 08:53:50 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id w10sm2439734ill.36.2021.12.08.08.53.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 08:53:49 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id y16so3467189ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:53:49 -0800 (PST)
X-Received: by 2002:a05:6638:2585:: with SMTP id s5mr958081jat.68.1638982429052;
 Wed, 08 Dec 2021 08:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20211207215753.635841-1-robdclark@gmail.com> <CAE-0n52gbwsJXG7=hdQhcttTbucjBv9SBq+kng2Ansc=TyqCKg@mail.gmail.com>
In-Reply-To: <CAE-0n52gbwsJXG7=hdQhcttTbucjBv9SBq+kng2Ansc=TyqCKg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Dec 2021 08:53:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xg+C4U0NHC6D4HMDZ1uVVstHWdV7onHwxtTvB6yh=Ciw@mail.gmail.com>
Message-ID: <CAD=FV=Xg+C4U0NHC6D4HMDZ1uVVstHWdV7onHwxtTvB6yh=Ciw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: sn65dsi86: defer if there is no dsi host
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 7, 2021 at 8:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rob Clark (2021-12-07 13:57:52)
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Otherwise we don't get another shot at it if the bridge probes before
> > the dsi host is registered.  It seems like this is what *most* (but not
> > all) of the other bridges do.
> >
> > It looks like this was missed in the conversion to attach dsi host at
> > probe time.
> >
> > Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Doug Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> One more nit below
>
> > v2: Drop DRM_ERROR() in favor of drm_err_probe() and shift around the
> >     spot where we report the error
> > v3: Add \n and cull error msgs a bit further
> >
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > index 02b490671f8f..c2928a6409b1 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -740,10 +736,8 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
> >         pdata->dsi = dsi;
> >
> >         ret = devm_mipi_dsi_attach(dev, dsi);
> > -       if (ret < 0) {
> > -               DRM_ERROR("failed to attach dsi to host\n");
> > +       if (ret < 0)
> >                 return ret;
> > -       }
> >
> >         return 0;
>
> This can be simplified further to
>
>         return devm_mipi_dsi_attach(dev, dsi);

Squahsed in Stephen's fix and pushed. Had to also remove "ret" which
was no longer used in this function after Stephen's change.

03848335b5b1 drm/bridge: sn65dsi86: defer if there is no dsi host

-Doug
