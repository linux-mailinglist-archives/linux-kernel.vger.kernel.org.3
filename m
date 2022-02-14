Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1374B4CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiBNKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:53:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349587AbiBNKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:53:45 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04867B541
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:18:22 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z7so11903870ilb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUDVx4TIFTRbJIuv2rupyK084bb2oTVATeZ8Fn6KFXI=;
        b=Vy5TjXpR1UvKyYsGrQDajSEdq6i7nkBrs9dNkT8ZOiRnZH7iyE4oeURkMBOCh00XOL
         yj1cTNcNbUutaQQX2/qLgSLKlQ17IGKHKIwi1Dz9PkMqdGMt4ShElCGNHNNinwT6mHPK
         oMptJF1N2bFC6U+Eyf21jelIvX6riTkU8CImg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUDVx4TIFTRbJIuv2rupyK084bb2oTVATeZ8Fn6KFXI=;
        b=OgGoBd7Awb3aSlxusnjNa+022b7HaxvlAW8gQX1GKVjywlPZ/tLLPLdu7GUoPLtNDl
         nrOoWS479czFihAMJlRBMj8aSarPgqYTutWky8jZm42RyRjbX8MPfTUE0sYu/C+54OJg
         p1A1ZzG73A6O1jfiQVI3EfyrlsZaECuqIQgZl3NmPzbuQ6QyqZu5xWbBb9JFxwgFasW2
         70L7iz3FVIZHdZ/R/48dM9p8s087P+1weXMq16LUHkBfWeZSVQ380csgCvVLKoSaNd9q
         voLJhLzieYl1M1HZMiONQ2nlgYFybz7YQPOi2dDmoqsEhEIUuCmsyeehnSROAdpgpiqd
         pEyA==
X-Gm-Message-State: AOAM532/XRSFE7vGXfnLb4SgrU/Sl+2LKcKB5rfuqVCJOnIVhwwzKE/V
        rhB+nYZclJviehIozdvcni1UAGr4mnlLICRrIh8FERuUlp/rKA==
X-Google-Smtp-Source: ABdhPJxouA9SM/xEm/8Xf2lg3Blaymfy9tRI6GOkeimZwqJOmKMUcENtZWCPXUvxeGblbu9sGRovxCTfui1pdv1kxmo=
X-Received: by 2002:a92:d90b:: with SMTP id s11mr3230734iln.105.1644833901824;
 Mon, 14 Feb 2022 02:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20220213063151.3321331-1-hsinyi@chromium.org> <7efb2a87-1b8e-5bab-651f-ffa21ea8d716@collabora.com>
In-Reply-To: <7efb2a87-1b8e-5bab-651f-ffa21ea8d716@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 14 Feb 2022 18:17:56 +0800
Message-ID: <CAJMQK-hCD7sCTODV_WPxC_eX27XQ3dWyhHJjp96KWNjzuPvquw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/panel: Add inx Himax8279d MIPI-DSI LCD panel driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 6:10 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 13/02/22 07:31, Hsin-Yi Wang ha scritto:
> > From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> >
> > Add STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
> >
> > Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> I have no way of testing this driver but the code itself looks good to me,
> so, strictly for the code:
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>

This driver is used by ASUS Chromebook Detachable CZ1 [1]. The dts
will be accepted after this panel is accepted.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20211213162856.235130-1-hsinyi@chromium.org/

> > ---
> > v2->v3:
> > rebase to next-20220211
> > ---
> >   drivers/gpu/drm/panel/Kconfig                 |   9 +
> >   drivers/gpu/drm/panel/Makefile                |   1 +
> >   .../gpu/drm/panel/panel-innolux-himax8279d.c  | 515 ++++++++++++++++++
> >   3 files changed, 525 insertions(+)
> >   create mode 100644 drivers/gpu/drm/panel/panel-innolux-himax8279d.c
> >
