Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC84A4C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380568AbiAaQz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiAaQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:55:56 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20835C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:55:56 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q11so3761762ild.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YAk2qmL1jvKsAvHFxP+29GfF6Oz1VRnK3+46u7RjKg=;
        b=l4jC6Fnvz4YWeocB1LDcxqIYS1XhOhwypDQk9XyVGOfwBi9dxSsAf/3+ql8devyalw
         1Ov0Ww3huiiRc9tzmqI2mpZ5w66MUcOHqg2RZvBVZNBKTfFWLGNJAFwyQ/BnEVWdXjMo
         6R1UPzgaiOgOMljHT1KBW9dC/G2EJvKqSpJXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YAk2qmL1jvKsAvHFxP+29GfF6Oz1VRnK3+46u7RjKg=;
        b=u8Ln1GHMpTNhhAe4ut4zDYX+XA9+VNI+NqoWT4h6PyWyI/E5q6vklway+SNsZn4Z3Y
         JnDKavmco1pMPXdtHEx2s9umFES7ZIeppaicLoO6fqcQ5XeInie+cmAhZff74hk07Db9
         9OWi76en+5/XowMGflNKe4wJqw//hcOmTEeasHPYpz1eYFrKt5rZV9uuj1B2kOvOTr7z
         +GrWBibTVrkPreN9J+lHt11tSVBJqYHNxwJeqmq/eDj2eo/dUdMyEkpqy8Hust5RWQGX
         LvG1vDA1um5c/44S72p7AqffK8br+A54xz8EFoQrio8AETkegM9/BZXUay0ATM6zhdCd
         1uAQ==
X-Gm-Message-State: AOAM531/P33RRYxbDGizP6y4t77Y4fa5CHRQIrp+pep6BLFCBiseL6mk
        KZV5BBBf/grYWPINGIj8GqV2XVeiYaECkdPEgNpySA==
X-Google-Smtp-Source: ABdhPJyd73gdzNkAKgPqoqagZosOcDjuFtL0VeW7Y8IsXZcflCr0xQ+DJqfmx/F4zZ5QP13j90ibe75mUlj2Y2lugZc=
X-Received: by 2002:a05:6e02:12e6:: with SMTP id l6mr12825345iln.10.1643648155481;
 Mon, 31 Jan 2022 08:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20220114091502.333083-1-allen.chen@ite.com.tw>
 <f4696a8d-5c1d-1007-7814-b2e6cbe334ae@collabora.com> <CAG3jFytN9iu0BteAxFCLVRorxM20Q3Zrfn1T4k8bnDYy5oL7bg@mail.gmail.com>
In-Reply-To: <CAG3jFytN9iu0BteAxFCLVRorxM20Q3Zrfn1T4k8bnDYy5oL7bg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 1 Feb 2022 00:55:29 +0800
Message-ID: <CAJMQK-i6M1hwESSA5OJ6TpdBBBEG8K9esSbLv-Xjb_zqCoB5ug@mail.gmail.com>
Subject: Re: [PATCH v11] drm/bridge: add it6505 driver
To:     Robert Foss <robert.foss@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        allen <allen.chen@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hsin-Yi Wang <hsinyi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 12:37 AM Robert Foss <robert.foss@linaro.org> wrote:
>
> On Thu, 20 Jan 2022 at 16:25, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 14/01/22 10:14, allen ha scritto:
> > > This adds support for the iTE IT6505.
> > > This device can convert DPI signal to DP output.
> > >
> > > From: Allen Chen <allen.chen@ite.com.tw>
> > > Tested-by: Hsin-yi Wang <hsinyi@chromium.org>
> > > Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
> > > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > > ---
> > > v10 -> v11 : remove drm_bridge_new_crtc_state
> > > ---
> > >   drivers/gpu/drm/bridge/Kconfig      |    8 +
> > >   drivers/gpu/drm/bridge/Makefile     |    1 +
> > >   drivers/gpu/drm/bridge/ite-it6505.c | 3352 +++++++++++++++++++++++++++
> > >   3 files changed, 3361 insertions(+)
> > >   create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
> > >
> >
> > ...snip...
> >
> > > +static const struct of_device_id it6505_of_match[] = {
> > > +     { .compatible = "ite,it6505" },
> > > +     { }
> > > +};
> >
> > If you want to have a DT compatible and DT properties, you have to also add
> > dt-bindings (yaml) for this driver, otherwise, any SoC/device DT will fail
> > the dt binding check.... So, please, add that.
>
> Let me second this. A dt-binding is needed for this driver to be
> complete, it functions as both documentation and a way to test the DTS
> that use this device, so it is really important.
>
The binding seems to be accepted before the driver:
https://elixir.bootlin.com/linux/v5.16.4/source/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml

> >
> > For the driver by itself, though:
> >
> > Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > > +
> > > +static struct i2c_driver it6505_i2c_driver = {
> > > +     .driver = {
> > > +             .name = "it6505",
> > > +             .of_match_table = it6505_of_match,
> > > +             .pm = &it6505_bridge_pm_ops,
> > > +     },
> > > +     .probe = it6505_i2c_probe,
> > > +     .remove = it6505_i2c_remove,
> > > +     .shutdown = it6505_shutdown,
> > > +     .id_table = it6505_id,
> > > +};
> > > +
> > > +module_i2c_driver(it6505_i2c_driver);
> > > +
> > > +MODULE_AUTHOR("Allen Chen <allen.chen@ite.com.tw>");
> > > +MODULE_DESCRIPTION("IT6505 DisplayPort Transmitter driver");
> > > +MODULE_LICENSE("GPL v2");
> > >
> >
