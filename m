Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2AC4E3B32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiCVIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiCVIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:53:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67777DAB3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:52:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so22897376wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zq9OA5jF5EJtQjULWMX9R5+C3ktkDDoBC5HCaRF17Gs=;
        b=ZAwLHC2i/rp8MSAK1bkjmZORoPzVnPazmnmRTI7SU0/1hUZ5x3fpsHVORP9yIDbV3O
         2FdRphnHZbkiMQEQUB39g8nD8ZdD+GHdXP81Tuzvoh8lvwQ5k8qYPZHRzQNTsNzVr+tw
         EjKskTOkkyW7aXZWDH0YIk5+RIkwIiPtvf59Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zq9OA5jF5EJtQjULWMX9R5+C3ktkDDoBC5HCaRF17Gs=;
        b=gIXt+hSG+f3Aq6cWQmLBwhz13clNIlZ8p/ea+MAX5jGY/SJ9X3GzhZCkOG1yJRzaMx
         VPvR9aHXByZkvbks0NvlTOPu+rTeO1XmNn0dZgBgclzaf+ZsTDSoWbu5fswGgQmjDK32
         mKMLSajGxofDZJARX9mWdxwA1VlpWCO5ia9qe3er7IC0cDNghCvYoXiFsYV6gU/lo2Y8
         EYt6JkAFZGoA4wVH3dzkX2qT/ELxCcyKtLdXjyvGyCpgTuUyja34l3dMzUfu6ivRz/NB
         fSNdXUsZXoERzQniRoMtQ5viJYltmdMfMb6O7Vtq86NcAEXEY2kVH+Rl1VLR0cj1//G3
         J4dg==
X-Gm-Message-State: AOAM533y3B0KSQ8nspZKDN+ujsW/1zjUq7JXY5PYKKYrCbM+WWqLO4N0
        JJ/ntiQaadotYWbRhwsUbM/sA3G5gQgXyTLejScPIA==
X-Google-Smtp-Source: ABdhPJzMSH5CseguBpvPLp5eAYnBHCBroj8HEpPt0qVmUNVxUXLzExr/SkTT5kMAsOuxc2KWnaWj0LDWcNAdKkoARls=
X-Received: by 2002:adf:eb81:0:b0:1e3:2bf5:132 with SMTP id
 t1-20020adfeb81000000b001e32bf50132mr21256230wrn.246.1647939139335; Tue, 22
 Mar 2022 01:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220322080213.1487134-1-xji@analogixsemi.com> <CAJMQK-j+PhB6dZBuKG3NtW94oT0bVkp9G1bXhmyZLgYOmTCgog@mail.gmail.com>
In-Reply-To: <CAJMQK-j+PhB6dZBuKG3NtW94oT0bVkp9G1bXhmyZLgYOmTCgog@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 22 Mar 2022 16:52:08 +0800
Message-ID: <CAEXTbpc2zFmKWGtP-fDa=96rwGWjKT7YJOMRceBbrbTsGvzOGQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Set downstream sink into normal status
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, pihsun@chromium.org, tzungbi@google.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM_DEV_* macros have been deprecated:
https://www.kernel.org/doc/html/latest/gpu/drm-internals.html#c.DRM_DEV_DEBUG_DRIVER

On Tue, Mar 22, 2022 at 4:43 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Tue, Mar 22, 2022 at 4:02 PM Xin Ji <xji@analogixsemi.com> wrote:
> >
> > As downstream sink was set into standby mode while bridge disabled,
> > this patch used for setting downstream sink into normal status
> > while enable bridge.
> >
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > Reviewed-by: Pin-Yen Lin <treapking@chromium.org>
> >
> > ---
> > V1 -> V2: use dev_dbg replace of dev_info
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 9a2a19ad4202..dcf3275a00fe 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -924,12 +924,20 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
> >  {
> >         int ret;
> >         struct device *dev = &ctx->client->dev;
> > +       u8 data;
> >
> >         if (!ctx->display_timing_valid) {
> >                 DRM_DEV_ERROR(dev, "mipi not set display timing yet.\n");
> >                 return;
> >         }
> >
> > +       dev_dbg(dev, "set downstream sink into normal\n");
> > +       /* Downstream sink enter into normal mode */
> > +       data = 1;
> > +       ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
> > +       if (ret < 0)
> > +               dev_err(dev, "IO error : set sink into normal mode fail\n");
> > +
>
> The driver uses DRM_DEV_* for logs. Can we use this?
>
> >         /* Disable HDCP */
> >         anx7625_write_and(ctx, ctx->i2c.rx_p1_client, 0xee, 0x9f);
> >
> > --
> > 2.25.1
> >
