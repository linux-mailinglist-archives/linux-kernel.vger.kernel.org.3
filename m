Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07C146F24F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbhLIRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbhLIRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:44:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF35C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:40:55 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c32so13471553lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zJn8EMJ3bNTEj0rup3ByEhFgEv6FqrmSjpgYx9Y6/fs=;
        b=THwfLzEETO2LotDmBtfbO7GVo9RpDWd/aau1pNnNfsL6iDlKF9rpdpO1h3BsBtGnhA
         oNeqsvZXCU1qeXPhTr4vG+yWl6NMh8+Wsfo7HT50hxY+ZjFl3uYp4t18U4MpPo4ln7eZ
         SxdNiF7oQN9JM2NE+8KH++oZIRxEumMj/LFAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zJn8EMJ3bNTEj0rup3ByEhFgEv6FqrmSjpgYx9Y6/fs=;
        b=gDWpCWnzV56O+yQG8IDh08tMG22uodrmsBYuC40LA0nv3kcJN9wbtjIe20m3ufwzAZ
         7GPSvS0N1rQmq9OO9HQUlz+JiY/lQDBDEO0yLH7khWjhcr+895TIoMhfHsX8nokQnXXW
         Dzjz1cMmE1HmDPc4o7oykFP3EqkWaUmiO7pkP8o32KLoLtYVgVRUSe1rGPFnsjhZMo8m
         5FOvKyMSMc7CNicY8TetmnLaMSNP3CbC7QTa+oDgqJ9Ea/Lcn1/fEAiz7/01UgwLw0N8
         9BYnXe58OCnGKjHQFV8Zcy3lbJminSSjiZ1jO0dx8kg0kqrs1Q8rvG3ev8djbdnJjV+u
         LcEQ==
X-Gm-Message-State: AOAM531rpQUDTJlK2TKPAaMRg7znYpS0nUwPAOHbjWvmGBcJqkvyjFeU
        61qBy/CRh+2dg12ywRzYgQlQQWeWGXd0IquYOXEvQA==
X-Google-Smtp-Source: ABdhPJxRc2UmoPypurDhZ/h36kJMpMBzWRNG3CHeSoDYXQgKpHDaTngOxX39repphKbLrvMBnrfWmkuPkEZQBYrwrUQ=
X-Received: by 2002:a05:6512:1510:: with SMTP id bq16mr6888001lfb.628.1639071654062;
 Thu, 09 Dec 2021 09:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20211027162806.2014022-1-markyacoub@chromium.org> <CAAOTY_9xG5NrPZjxcV-SY1q+44WDLLk3UsDJt74FEEnx6kVYug@mail.gmail.com>
In-Reply-To: <CAAOTY_9xG5NrPZjxcV-SY1q+44WDLLk3UsDJt74FEEnx6kVYug@mail.gmail.com>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Thu, 9 Dec 2021 12:40:43 -0500
Message-ID: <CAJUqKUrZcd4KX3zHbPMS=XJddqedSmdELSdv5jzU9ouB9JdSBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Set the default value of rotation to DRM_MODE_ROTATE_0
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Mark Yacoub <markyacoub@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 7:16 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wrot=
e:
>
> Hi Mark:
>
> Mark Yacoub <markyacoub@chromium.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=882=
8=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:28=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > From: Mark Yacoub <markyacoub@google.com>
> >
> > At the reset hook, call __drm_atomic_helper_plane_reset which is
> > called at the initialization of the plane and sets the default value of
> > rotation on all planes to DRM_MODE_ROTATE_0 which is equal to 1.
>
> This patch looks good to me, but please fix this checkpatch warning:
Uploaded a new revision. Thanks!
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Mark
> Yacoub <markyacoub@google.com>' !=3D 'Signed-off-by: Mark Yacoub
> <markyacoub@chromium.org>'
>
> total: 0 errors, 1 warnings, 11 lines checked
>
> Regards,
> Chun-Kuang.
>
> >
> > Tested on Jacuzzi (MTK).
> > Resolves IGT@kms_properties@plane-properties-{legacy,atomic}
> >
> > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm=
/mediatek/mtk_drm_plane.c
> > index e6dcb34d30522..accd26481b9fb 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > @@ -44,9 +44,10 @@ static void mtk_plane_reset(struct drm_plane *plane)
> >                 state =3D kzalloc(sizeof(*state), GFP_KERNEL);
> >                 if (!state)
> >                         return;
> > -               plane->state =3D &state->base;
> >         }
> >
> > +       __drm_atomic_helper_plane_reset(plane, &state->base);
> > +
> >         state->base.plane =3D plane;
> >         state->pending.format =3D DRM_FORMAT_RGB565;
> >  }
> > --
> > 2.33.0.1079.g6e70778dc9-goog
> >
