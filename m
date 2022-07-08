Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEBD56B566
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiGHJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbiGHJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:25:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48457DEA2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:25:20 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31c89653790so141901917b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bt6M2SPn7sqPgDE+o3lCFpdJOEHPR/4P0J6bq+ZpLW0=;
        b=a56cDZTYX/zgUIqGbEScQvxd1p0LoQBd/n8XEeW0tgNp77yiXtbSvD0ucj/mFN0v9j
         vhAsMdLZDPmfkX5ajXmtqBkGDgzK/LrZTvExCBIC4OpX3YaaSNEckkp5Jw1hDcDBS0X+
         pBxpLcEGLkSFKdnmOpp6M0+5dVv7WGLIOEeZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bt6M2SPn7sqPgDE+o3lCFpdJOEHPR/4P0J6bq+ZpLW0=;
        b=wX28nuzzSGAT2pZcnkcyqqrSo0hE8D/RA3cSpdod+QO+WFKq2NjRfUtelmDTAUQxi6
         iZ133CSoWRvvR29apc6DvSz3E32YbyEAir4srUBGQgSf1fcgWfTD4dShHa+f0ulJQjUM
         RHjDsEzxystsYLXRXnLBRQKPWCxesG23MtlgchPHBOFLR4u/gGE4LcnfFJmxqx0rKCOO
         xNch8sxk/kgFzCCV6Baxme1S8iy9u765mahKiziI6tRBKnqfJUxSH3/IX6lmqFjOouJR
         JpJceUEUWdWxcH50s2xMvFNreOZCYyoevddl0APOdpACnsB1FFP8iKl1s0uNcMN9x2eQ
         OMcQ==
X-Gm-Message-State: AJIora+VUFuJgib7gyMFk/BxfImqIxy/w3sQEHlBG5gEWNvZbuUqUo6G
        2Xmkq0XgxjeI08kklcj6LvtNHQkK5PC2jdsicss9pg==
X-Google-Smtp-Source: AGRyM1vtGSuisdYLfNmPZk8yOb9MscT55bQFKNkQSzG0DCwoxrkPWyEk/g0cOBLqJZgs0WE7ycZ7QLAAiDX16u49jQY=
X-Received: by 2002:a05:690c:316:b0:314:2147:2b90 with SMTP id
 bg22-20020a05690c031600b0031421472b90mr2782649ywb.318.1657272319442; Fri, 08
 Jul 2022 02:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220701105237.932332-1-wenst@chromium.org> <20220701105237.932332-5-wenst@chromium.org>
 <daf5e3e6-8a13-3c16-5fa6-9c4e69883c49@xs4all.nl>
In-Reply-To: <daf5e3e6-8a13-3c16-5fa6-9c4e69883c49@xs4all.nl>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 8 Jul 2022 17:25:08 +0800
Message-ID: <CAGXv+5GR1+fgabiVR6SbxsqAKd03gDoByYO0KMSoX3-i2eLbWw@mail.gmail.com>
Subject: Re: [PATCH 4/6] media: mediatek: vcodec: Revert driver name change in
 encoder capabilities
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 5:19 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
>
>
> On 7/1/22 12:52, Chen-Yu Tsai wrote:
> > This partially reverts commit fd9f8050e355d7fd1e126cd207b06c96cde7f783.
> >
> > The driver name field should contain the actual driver name, not some
> > otherwise unused string macro from the driver. To make this clear,
> > copy the name from the driver's name field.
> >
> > Fixes: fd9f8050e355 ("media: mediatek: vcodec: Change encoder v4l2 capability value")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 1 +
> >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 6 ++++--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > index 4140b4dd85bf..dc6aada882d9 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > @@ -22,6 +22,7 @@
> >  #define MTK_VCODEC_DRV_NAME  "mtk_vcodec_drv"
>
> Note that this patch removes the last user of this define, so
> you can drop that define as well.
>
> >  #define MTK_VCODEC_DEC_NAME  "mtk-vcodec-dec"
> >  #define MTK_VCODEC_ENC_NAME  "mtk-vcodec-enc"
> > +#define MTK_PLATFORM_STR     "platform:mt8173"
>
> Why add this?
>
> >
> >  #define MTK_VCODEC_MAX_PLANES        3
> >  #define MTK_V4L2_BENCHMARK   0
> > diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> > index ccc753074816..30aac54d97fa 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> > @@ -232,11 +232,13 @@ static int mtk_vcodec_enc_get_chip_name(void *priv)
> >  static int vidioc_venc_querycap(struct file *file, void *priv,
> >                               struct v4l2_capability *cap)
> >  {
> > +     struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
> > +     struct device *dev = &ctx->dev->plat_dev->dev;
> >       int platform_name = mtk_vcodec_enc_get_chip_name(priv);
> >
> > -     strscpy(cap->driver, MTK_VCODEC_DRV_NAME, sizeof(cap->driver));
> > -     strscpy(cap->card, MTK_VCODEC_ENC_NAME, sizeof(cap->card));
> > +     strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
> >       snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-enc", platform_name);
> > +     strscpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));
>
> The next patch changes cap->card again, and leaves MTK_PLATFORM_STR unused.
>
> >
> >       return 0;
> >  }
>
> I think it makes more sense to combine patches 1-3 and 4-6 into single
> patches, one for the decoder, one for the encoder. It's easier to follow
> since they all touch on the same querycap function.

I wrote this series as a revert plus additional changes. As you said, it
makes sense to squash three patches into one.

I'll respin.

ChenYu
