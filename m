Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB41247386E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbhLMX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:27:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49932 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbhLMX1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:27:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D0A8B8170D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B4CC34604
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639438061;
        bh=5C4sKIJkDWnzqKi1DVmCPmhnZw+GJklmGaruVVfz/Us=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L3wXp/RnLW4/9jR6wjdmgG8EQfiiTfrfZjtJzJOe/983RdRo8Tg8a1IHYFf/xluk/
         HaPGDl0MK+CD823y1YjXJ3OF3TILKFHJ5NSSvKiNireTRu9HA3wHDbWfMDP2dAz3a6
         oYHaGSz9zH+PP9vlbW2RclP98XNoz563s9Ka4+NcF5oWAk/xYh6jQRMZHtx/0WF24v
         2oOwLuESKKKFL3TN6aIzzb0WWW0i5omeHOz8LzgJbzYSalbuCMajmIVXcsRy9uGkdj
         fD9zIHOZcAwN/dcR795Y/akKvDIoquqgID2pAaYlS0nwCVemPzD63mlCQaXrahxUlh
         Oq39LjEY2krqg==
Received: by mail-ed1-f53.google.com with SMTP id g14so56453570edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 15:27:41 -0800 (PST)
X-Gm-Message-State: AOAM531oCwewqrZRnxxVW87WKHdLQJ+gtTWFHDkqj6ggGznIzIJX7dL4
        HRYlry3Rvyb6iXvKyZfE2eqciciOHI4QP/s5bg==
X-Google-Smtp-Source: ABdhPJwLnov5UNyZv+LEB38x0lFU1vvX2PYYVOPjAuD4tUbrtVO8ogqV6SxarYFeSUJAf2ZA8cFBGfsyhuXRPtjbOVk=
X-Received: by 2002:a17:906:9b82:: with SMTP id dd2mr1644254ejc.406.1639438060292;
 Mon, 13 Dec 2021 15:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20211027162806.2014022-1-markyacoub@chromium.org> <20211213160742.744333-1-markyacoub@chromium.org>
In-Reply-To: <20211213160742.744333-1-markyacoub@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 14 Dec 2021 07:27:52 +0800
X-Gmail-Original-Message-ID: <CAAOTY_81KaSEWAqTWgzmshDZ9BefO3pNrqQwWbB01E4L0+mqzg@mail.gmail.com>
Message-ID: <CAAOTY_81KaSEWAqTWgzmshDZ9BefO3pNrqQwWbB01E4L0+mqzg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Set the default value of rotation to DRM_MODE_ROTATE_0
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>, tzungbi@google.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark:

Mark Yacoub <markyacoub@chromium.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:08=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> At the reset hook, call __drm_atomic_helper_plane_reset which is
> called at the initialization of the plane and sets the default value of
> rotation on all planes to DRM_MODE_ROTATE_0 which is equal to 1.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Tested on Jacuzzi (MTK).
> Resolves IGT@kms_properties@plane-properties-{legacy,atomic}
>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_plane.c
> index e6dcb34d30522..accd26481b9fb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -44,9 +44,10 @@ static void mtk_plane_reset(struct drm_plane *plane)
>                 state =3D kzalloc(sizeof(*state), GFP_KERNEL);
>                 if (!state)
>                         return;
> -               plane->state =3D &state->base;
>         }
>
> +       __drm_atomic_helper_plane_reset(plane, &state->base);
> +
>         state->base.plane =3D plane;
>         state->pending.format =3D DRM_FORMAT_RGB565;
>  }
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
