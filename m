Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4CF470596
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbhLJQ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhLJQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:28:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB36C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:25:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9B03CCE2C17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C30C341CA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639153500;
        bh=m3sNyHFjcFUZW2r34fX9cAwltyg7xeL6h5eHyuCWzc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GOs/tJidGceWMDBPiaEHLrZ75sou0j6qPJrzl8sxAMzU7QI1+WDfUDQxGSQe7khln
         UFFvFbPY/SEThZUwmc5GPR5RXIHVjCsNPNovPqtJeW2DKcRPyHzbsMw5zbitsNNjmm
         chPb0L2BYq78YhqyONc2RMvddsMH9pNcpO634Opfg20HqLKnS2vnbjIDFEhMPxMYnY
         3TqmyLUzRc4wIZye12jBNUUW6Bm7TY2mqwVoHFuuSV5lAFbPj58tVt53Q5rYNmimxN
         wIQ9+eAFxHXdt3TIMqTLYOQAD9LTkyq82wHi23FGPy05ik36RFYMmuko/3FX7GhQDH
         URsKFh8ACum9g==
Received: by mail-ed1-f54.google.com with SMTP id x15so32422728edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:25:00 -0800 (PST)
X-Gm-Message-State: AOAM532Y9Ruhy5RB56miKn+B09MXMxqbt37rZDaKHzxa0cvsVOy4YBn9
        Z5ak50OPzAicQKIDIPysaSFdyEps9XPctyOMLg==
X-Google-Smtp-Source: ABdhPJxjCxliga8nYVwXlovtAcHvS7Ku6/w30eyy8A3Q8G61IMUB7ZV9QEDabmdc5s/EneEMAablKoa97VrdPvtzkX8=
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr40538337edd.250.1639153498690;
 Fri, 10 Dec 2021 08:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20210915223117.7857-1-jitao.shi@mediatek.com> <20210915223117.7857-2-jitao.shi@mediatek.com>
 <CAAOTY_8H=TE8574xB3FFcGVgN_fTb_83+FT8ei1CDuB4k4-Oew@mail.gmail.com> <ad925a6c1438b78f3c79b37fd0a545c9eb153a59.camel@mediatek.com>
In-Reply-To: <ad925a6c1438b78f3c79b37fd0a545c9eb153a59.camel@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 11 Dec 2021 00:24:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY__hcWKT=DTkKyb6J1N2bnpuP1rpqUHivhg-syaetCgNBQ@mail.gmail.com>
Message-ID: <CAAOTY__hcWKT=DTkKyb6J1N2bnpuP1rpqUHivhg-syaetCgNBQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] drm/dsi: transer dsi hs packet aligned
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        CK Hu <ck.hu@mediatek.com>, stonea168@163.com,
        huijuan.xie@mediatek.com, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        shuijing.li@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave & Daniel:

This patch looks good to me, how do you think about it?

Regards,
Chun-Kuang.

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B411=E6=9C=884=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:36=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi sirs
>
> Pls help to review this change.
>
> Best Regards
> Jitao.
>
> On Tue, 2021-10-05 at 07:53 +0800, Chun-Kuang Hu wrote:
> > Hi, Jitao:
> >
> > Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=886:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Some DSI devices reqire the hs packet starting and ending
> > > at same time on all dsi lanes. So use a flag to those devices.
> > >
> >
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > ---
> > >  include/drm/drm_mipi_dsi.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/include/drm/drm_mipi_dsi.h
> > > b/include/drm/drm_mipi_dsi.h
> > > index af7ba8071eb0..8e8563792682 100644
> > > --- a/include/drm/drm_mipi_dsi.h
> > > +++ b/include/drm/drm_mipi_dsi.h
> > > @@ -177,6 +177,7 @@ struct mipi_dsi_device_info {
> > >   * @lp_rate: maximum lane frequency for low power mode in hertz,
> > > this should
> > >   * be set to the real limits of the hardware, zero is only
> > > accepted for
> > >   * legacy drivers
> > > + * @hs_packet_end_aligned: transfer dsi hs packet ending aligned
> > >   */
> > >  struct mipi_dsi_device {
> > >         struct mipi_dsi_host *host;
> > > @@ -189,6 +190,7 @@ struct mipi_dsi_device {
> > >         unsigned long mode_flags;
> > >         unsigned long hs_rate;
> > >         unsigned long lp_rate;
> > > +       bool hs_packet_end_aligned;
> > >  };
> > >
> > >  #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
> > > --
> > > 2.25.1
