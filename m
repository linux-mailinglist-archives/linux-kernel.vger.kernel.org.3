Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3453C888
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbiFCKTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243620AbiFCKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:19:30 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B683B3C5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:19:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i19so5244873qvu.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UMpW2GQFjbsAh4Z5E0cvPjEi6lZODEcP2+hYnwC+bE=;
        b=zkYz2hGQ1rahMqWa937cH83pVnLOTqmdXNQFV1d1uS6u6aMj6SPNQ9yOFFN00ysLMX
         jUuAr5G7K4WTsp3BRQ/W+wjUDU3Dd0I0+Ku7oPNjCuEGNCC0Ww7/T88ekjo7m8hkooCW
         wZjrIspW94cmLUoBhvkgkad+qwItBz0RGN2yAH9oxYP1JhVS2lT+VSN2HdfejhqjN+sP
         VxYoY7vUAdFgjk8lpGRJ9ntj+LeaIt5Ri18B5vb3zKIVQ3Se/4O7f/hKLIJl6Qj3nHnT
         N1RcbTDKcuGHQzkJbstZ9TgqQiLmHFFS8rpdNWxYzMk5r2oy4EqRV1nLAUM2gu4ezrOb
         XicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UMpW2GQFjbsAh4Z5E0cvPjEi6lZODEcP2+hYnwC+bE=;
        b=BBn6KY89HzVRqBu+pUxjHT20Giua6RLfrfTf8R30eIIgarQi/9p8PfF32de6PpXZb2
         NapzaMVTWXQWoLees/bmJt68EBFpnMNvHHfIPaEJfzJRlHp79I6F5zMf0ssb4wyqDqKd
         CQHZaoDPklHbyBbzIhHvtgCDg6Hzm8yjPMDSFViyi7DCm1aaV2BGgZNrQeTu8TO2ILiZ
         KiCLEOa+gwzGQMftOoZ+yyBH70tLvBatxf7qAvTr6Nt3AKDbFCChDgpa+qHF1dpQs2sh
         qbvtbxv9ykx3DTLmojrhYBhaTvUs66LW4/VoxBT7/xh11tvAz0deW5rK3ZMwFB31Kmz+
         vk0A==
X-Gm-Message-State: AOAM532ZvyqlaH3D4D3nYQ+6dp37kBSz4FQ4jm4XJkUrbWI/bjMhZ6rT
        dSVTXCniaA1SIVTvRF1yQrDCkBJaRSUgi9UiPHYi3g==
X-Google-Smtp-Source: ABdhPJw8iJoGhy2MD45IsbCDP/yP/cDddSg1Ox604Dq9yoEDEqKfDIRzqKkUy7GFMX8kjhbpUdHowJBaBXsYNKHA+So=
X-Received: by 2002:ad4:5b81:0:b0:465:ded8:780 with SMTP id
 1-20020ad45b81000000b00465ded80780mr8480006qvp.119.1654251567078; Fri, 03 Jun
 2022 03:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192944.2408515-1-dianders@chromium.org>
 <20220510122726.v3.3.Iba4b9bf6c7a1ee5ea2835ad7bd5eaf84d7688520@changeid>
 <20220521091751.opeiqbmc5c2okdq6@houat> <CAD=FV=Wea0LT5umK4Xg87cDikim+dSuyLndfydO3_DnTujZr9Q@mail.gmail.com>
 <CAD=FV=XqJuPHxm7HYMvyHBL_zC-BBA_f0MBsZX-jHt7Pk9ngsQ@mail.gmail.com> <20220603082139.sfdxb5ndwpvlhklh@penduick>
In-Reply-To: <20220603082139.sfdxb5ndwpvlhklh@penduick>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 3 Jun 2022 13:19:16 +0300
Message-ID: <CAA8EJpqrw63K_xxJjawLjEqP-05eUD-k6dy21162hcq7q07jgQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: Add devm_drm_bridge_add()
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, May 31, 2022 at 02:06:34PM -0700, Doug Anderson wrote:
> > On Mon, May 23, 2022 at 10:00 AM Doug Anderson <dianders@chromium.org> wrote:
> > > On Sat, May 21, 2022 at 2:17 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > On Tue, May 10, 2022 at 12:29:43PM -0700, Douglas Anderson wrote:
> > > > > This adds a devm managed version of drm_bridge_add(). Like other
> > > > > "devm" function listed in drm_bridge.h, this function takes an
> > > > > explicit "dev" to use for the lifetime management. A few notes:
> > > > > * In general we have a "struct device" for bridges that makes a good
> > > > >   candidate for where the lifetime matches exactly what we want.
> > > > > * The "bridge->dev->dev" device appears to be the encoder
> > > > >   device. That's not the right device to use for lifetime management.
> > > > >
> > > > > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > >
> > > > If we are to introduce more managed helpers, I think it'd be wiser to
> > > > introduce them as DRM-managed, and not device managed.
> > > >
> > > > Otherwise, you'll end up in a weird state when a device has been removed
> > > > but the DRM device is still around.
> > >
> > > I'm kinda confused. In this case there is no DRM device for the bridge
> > > and, as per my CL description, "bridge-dev->dev" appears to be the
> > > encoder device. I wasn't personally involved in discussions about it,
> > > but I was under the impression that this was expected / normal. Thus
> > > we can't make this DRM-managed.
> >
> > Since I didn't hear a reply,
>
> Gah, I replied but it looks like somehow it never reached the ML...
>
> Here was my original reply:
>
> > > > This adds a devm managed version of drm_bridge_add(). Like other
> > > > "devm" function listed in drm_bridge.h, this function takes an
> > > > explicit "dev" to use for the lifetime management. A few notes:
> > > > * In general we have a "struct device" for bridges that makes a good
> > > >   candidate for where the lifetime matches exactly what we want.
> > > > * The "bridge->dev->dev" device appears to be the encoder
> > > >   device. That's not the right device to use for lifetime management.
> > > >
> > > > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > If we are to introduce more managed helpers, I think it'd be wiser to
> > > introduce them as DRM-managed, and not device managed.
> > >
> > > Otherwise, you'll end up in a weird state when a device has been removed
> > > but the DRM device is still around.
> >=20
> > I'm kinda confused. In this case there is no DRM device for the bridge
> > and, as per my CL description, "bridge-dev->dev" appears to be the
> > encoder device.
>
> bridge->dev seems right though?
>
> > I wasn't personally involved in discussions about it, but I was under
> > the impression that this was expected / normal. Thus we can't make
> > this DRM-managed.
>
> Still, I don't think devm is the right solution to this either.
>
> The underlying issue is two-fold:
>
>   - Encoders can have a pointer to a bridge through of_drm_find_bridge
>     or similar. However, bridges are traditionally tied to their device
>     lifetime (by calling drm_bridge_add in probe, and drm_bridge_remove
>     in remove). Encoders will typically be tied to the DRM device
>     however, and that one sticks around until the last application
>     closes it. We can thus very easily end up with a dangling pointer,
>     and a use-after-free.
>
>   - It's not the case yet, but it doesn't seem far fetch to expose
>     properties of bridges to the userspace. In that case, the userspace
>     would be likely to still hold references to objects that aren't
>     there anymore when the bridge is gone.
>
> The first is obviously a larger concern, but if we can find a solution
> that would accomodate the second it would be great.
>
> As far as I can see, we should fix in two steps:
>
>   - in drm_bridge_attach, we should add a device-managed call that will
>     unregister the main DRM device. We don't allow to probe the main DRM
>     device when the bridge isn't there yet in most case, so it makes
>     sense to remove it once the bridge is no longer there as well.

The problem is that I do not see a good way to unregister the main DRM
device outside of it's driver code.

>
>   - When the DRM device is removed, have the core cleanup any bridge
>     registered. That will remove the need to have drm_bridge_remove in
>     the first place.
>
> > I'll assume that my response addressed your concerns. Assuming I get
> > reviews for the other two patches in this series I'll plan to land
> > this with Dmitry's review.
>
> I still don't think it's a good idea to merge it. It gives an illusion
> of being safe, but it's really far from it.

It is more of removing the boilerplate code spread over all the
drivers rather than about particular safety.

I'd propose to land devm_drm_bridge_add (and deprecate calling
drm_bridge_remove from the bridge driver at some point) and work on
the whole drm_device <-> drm_bridge problem in the meantime.

-- 
With best wishes
Dmitry
