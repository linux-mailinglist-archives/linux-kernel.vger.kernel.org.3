Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45AE490B53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbiAQPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbiAQPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:23:50 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D53C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:23:50 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c6so13136742plh.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnjA2KHofUEKHkQNqNXo62wzKavO8JJRdKbV0UahKN4=;
        b=OE78WGgL1nowrWRV3NUTn32yF5ldeaiahSnJ5YblR9gfaPeDcPDNvdiP2XPFzLOzo5
         M5c+jvWqEK+OJ8ni0tweiYW+iuKT9iijVE5W3QtywcMa1tZrQREEqbkxDG6lce2EOXX+
         pkptFj1pMJ1kQlk5xe40o0At/1b0mDUTg57vczFNLO6k9Fw6nvagALJ0TCCCc+luHMxY
         444lbBpGdfmbGCIAYGGQMYxSR7+0YliaFZ2+f4w1LavyL3XPuyJPXw4xhM0egQvVflMl
         U7mDV7DMLUuOgc5DU2+Ty+TCqROQkGHcHYqB1PkJvS6giNlUjYUIOeht73sSB3lSns9h
         aj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnjA2KHofUEKHkQNqNXo62wzKavO8JJRdKbV0UahKN4=;
        b=lvFEoRClGO9im3YYVs55+FZJzWMUabYJw/ma6vIpK7Kkav6hfnoR314DTubRRHNayM
         6Jd2SW/Cjf2esgqQ0vx1rloHIGhKZTF7tswG8H87mCeZWOTBLp9QvLB7b28A2h/T+b/e
         6ZhXduzwlGlp7qrjFgrOSsVKcDusdr+B7UfYOW66h2/dUb/o2L0PifM0u3iQqQTyfBoo
         wlPl/Iv+2txM2ilq4pavT0xGXm+RfQtDPC+LrzQfFqbcjJgxYh8QtIz7RDaP9srpo/dv
         dpm8OmFu7W9tas35KCze5LL1cX4Iy1x7I0Y7gHjPz5Dcwp5wU+4btM8GQVF0PmWohoi/
         bNJw==
X-Gm-Message-State: AOAM531RZ3ikJ8zlWz1XIj1+r1bDFI+0787CYk726eGBJnFDikpVcJKA
        nWvtT0KLdrYHYNA7zzilAbfkTegrBLFu7mnZbS910A==
X-Google-Smtp-Source: ABdhPJwyV1xILkVOjDtTwNStAJk4uTHz5Fm7df/Lvq9bkEM2w1UKdOaqrnXM1IFq3J2cy6VzPcXnBeodoC6Bk7Xa5+8=
X-Received: by 2002:a17:90b:4a92:: with SMTP id lp18mr7416140pjb.152.1642433030103;
 Mon, 17 Jan 2022 07:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20220113125201.22544-1-lzmlzmhh@gmail.com>
In-Reply-To: <20220113125201.22544-1-lzmlzmhh@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 17 Jan 2022 16:23:39 +0100
Message-ID: <CAG3jFyuZK8BLLicm8BLCGgdZaZ4O6x1W0VY4mn4JvJLDGDxpgw@mail.gmail.com>
Subject: Re: [PATCH v2] Remove extra device acquisition method of i2c client
 in lt9611 driver
To:     Zhiming Liu <lzmlzmhh@gmail.com>
Cc:     narmstrong@baylibre.com, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Zhiming,

Again, I think the code is good, but let's fix some small stuff with
the patch submission and then I'll happily apply this.

On Thu, 13 Jan 2022 at 13:52, Zhiming Liu <lzmlzmhh@gmail.com> wrote:
>
> Signed-off-by: Zhiming Liu <lzmlzmhh@gmail.com>

The tags like Signed-off-by come after the body of the commit message.

>
> bridge : drm : Remove extra device acquisition method of i2c client in lt9611 driver.

This line has to come first, since it is the title of the commit message.

>
> We have get the device of i2c client in probe function.So we should
> remove extra device acquisition method of i2c client.

^^^ this is the body of the commit message.

Put the tags like Signed-off-by here.

> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c    | 4 ++--
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index dafb1b47c15f..feb128a4557d 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -1090,7 +1090,7 @@ static int lt9611_probe(struct i2c_client *client,
>         if (!lt9611)
>                 return -ENOMEM;
>
> -       lt9611->dev = &client->dev;
> +       lt9611->dev = dev;
>         lt9611->client = client;
>         lt9611->sleep = false;
>
> @@ -1100,7 +1100,7 @@ static int lt9611_probe(struct i2c_client *client,
>                 return PTR_ERR(lt9611->regmap);
>         }
>
> -       ret = lt9611_parse_dt(&client->dev, lt9611);
> +       ret = lt9611_parse_dt(dev, lt9611);
>         if (ret) {
>                 dev_err(dev, "failed to parse device tree\n");
>                 return ret;
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index 33f9716da0ee..3d62e6bf6892 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -860,7 +860,7 @@ static int lt9611uxc_probe(struct i2c_client *client,
>         if (!lt9611uxc)
>                 return -ENOMEM;
>
> -       lt9611uxc->dev = &client->dev;
> +       lt9611uxc->dev = dev;
>         lt9611uxc->client = client;
>         mutex_init(&lt9611uxc->ocm_lock);
>
> @@ -870,7 +870,7 @@ static int lt9611uxc_probe(struct i2c_client *client,
>                 return PTR_ERR(lt9611uxc->regmap);
>         }
>
> -       ret = lt9611uxc_parse_dt(&client->dev, lt9611uxc);
> +       ret = lt9611uxc_parse_dt(dev, lt9611uxc);
>         if (ret) {
>                 dev_err(dev, "failed to parse device tree\n");
>                 return ret;
> --
> 2.25.1
>
