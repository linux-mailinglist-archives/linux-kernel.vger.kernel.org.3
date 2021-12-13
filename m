Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60AC472CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhLMNIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:08:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58138 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhLMNIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:08:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D36FBB80D78
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC33C34607
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639400908;
        bh=9ydNHDYKsiCtb2ZflappRnVfHZy3RsZlLzo1HG0qTQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QltArIYaie93S6C5AMwxAjh3W4jCgoXKgmk8VWFWm3IvsJ7W9sEg4tGTWdI2fKqPU
         +4DWsXNRb5Ruxd7HJySCpwFEfq6luwBPS38TuOmvwW2fd2h840wTW6bkNgyEXA2w5J
         BDi9rZKBpme8UmtF1cE0YlrrEuugLKajdTnIXgJXk/R5RxKaOB3xyIInNtNSYb2s1y
         q5DcgN0sw7DICyY1QhX4CouZS0B8AbPFLJ7IPgze3RdH052fuCj/kxgcygJ04TYSoL
         hx8wGPzsMYcGql/b4g3TvWNzOQ2+EGlLD8vgSBNm7PHxVCdc7K+paLRF32PrE2NB+7
         4HX7yqmNrc6hA==
Received: by mail-ed1-f46.google.com with SMTP id v1so52302522edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:08:28 -0800 (PST)
X-Gm-Message-State: AOAM533/VzYdOIFMO6DyKRVYtFItdP2XN13fqinpmW6BVra1zbEuuSp6
        oUYCpK3YIvgu6Xd1lmR2Xgmg4PhxqQ+GMwdJGQ==
X-Google-Smtp-Source: ABdhPJyYH9M8ZF1ALPPysi0+E5P/GHohfR0mv1DVIz4G6JHoIMRL1u/arPHp4YYjl7O+tsaAU4Q6wDrSLDSQCkFycpk=
X-Received: by 2002:a50:d883:: with SMTP id p3mr63843811edj.94.1639400906772;
 Mon, 13 Dec 2021 05:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20211028074311.57842-1-angelogioacchino.delregno@collabora.com> <000ba19e-0220-f5c3-0efd-abb8338bb8f2@collabora.com>
In-Reply-To: <000ba19e-0220-f5c3-0efd-abb8338bb8f2@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 13 Dec 2021 21:08:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_87ugiuo+nz2D1upTX+oO8r3yHHLsU3r07qkpvu3UESDQ@mail.gmail.com>
Message-ID: <CAAOTY_87ugiuo+nz2D1upTX+oO8r3yHHLsU3r07qkpvu3UESDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: hdmi: Perform NULL pointer check for mtk_hdmi_conf
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2021=E5=B9=B412=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:=
02=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 28/10/21 09:43, AngeloGioacchino Del Regno ha scritto:
> > In commit 41ca9caaae0b ("drm/mediatek: hdmi: Add check for CEA modes on=
ly")
> > a check for CEA modes was added to function mtk_hdmi_bridge_mode_valid(=
)
> > in order to address possible issues on MT8167; moreover, with commit
> > c91026a938c2 ("drm/mediatek: hdmi: Add optional limit on maximal HDMI m=
ode clock")
> > another similar check was introduced.
> >
> > Unfortunately though, at the time of writing, MT8173 does not provide
> > any mtk_hdmi_conf structure and this is crashing the kernel with NULL
> > pointer upon entering mtk_hdmi_bridge_mode_valid(), which happens as
> > soon as a HDMI cable gets plugged in.
> >
> > To fix this regression, add a NULL pointer check for hdmi->conf in the
> > said function, restoring HDMI functionality and avoiding NULL pointer
> > kernel panics.
> >
> > Fixes: 41ca9caaae0b ("drm/mediatek: hdmi: Add check for CEA modes only"=
)
> > Fixes: c91026a938c2 ("drm/mediatek: hdmi: Add optional limit on maximal=
 HDMI mode clock")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_hdmi.c | 12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/medi=
atek/mtk_hdmi.c
> > index 5838c44cbf6f..3196189429bc 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > @@ -1224,12 +1224,14 @@ static int mtk_hdmi_bridge_mode_valid(struct dr=
m_bridge *bridge,
> >                       return MODE_BAD;
> >       }
> >
> > -     if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
> > -             return MODE_BAD;
> > +     if (hdmi->conf) {
> > +             if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mod=
e))
> > +                     return MODE_BAD;
> >
> > -     if (hdmi->conf->max_mode_clock &&
> > -         mode->clock > hdmi->conf->max_mode_clock)
> > -             return MODE_CLOCK_HIGH;
> > +             if (hdmi->conf->max_mode_clock &&
> > +                 mode->clock > hdmi->conf->max_mode_clock)
> > +                     return MODE_CLOCK_HIGH;
> > +     }
> >
> >       if (mode->clock < 27000)
> >               return MODE_CLOCK_LOW;
> >
>
> Hello, friendly ping!
>
> Can I please get a review (or merge) of this commit?
>
> This is an important fix for a null pointer KP and restores HDMI function=
ality.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Thanks,
> - Angelo
