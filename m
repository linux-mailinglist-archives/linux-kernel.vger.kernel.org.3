Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF024A4E88
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356757AbiAaSg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355341AbiAaSgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:36:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC684C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:36:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r59so14805708pjg.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVP1HoXA+fkjiP7dYZEx1JX7fEwo0mBNJ8T54jUWwpw=;
        b=XfhmwR2k8wqx6HUMq6ZupVxiE0Wdd7dCjnqYGD7rZZuDiyRZFhEpyT3IU+nyUz+Tge
         qPQCJxrP3ecoE6CXTV5vRrCVepB8RHbRptQtQf4d/GUg9z/3fpFD25W6GclQxbGIpkmf
         P4kYt8Xw+mhsiezNivRxgw1rhC63mmCkzWeRLJgKciEaPpsWmQNpJ9Bj/Z0es+p9rUfI
         5FZ7kFPCUwATfhF6oKx8iM7CM1Hn9Qo7776Vnjtil3VXt80RvtUziCWWkwHa1uonkDkc
         B8NioUeunqVoGvNGpm8YeeroaXqZ5ijGO5nHrcqIIs/Yf6RL/DOUlREz30cV1arb7fLl
         +T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVP1HoXA+fkjiP7dYZEx1JX7fEwo0mBNJ8T54jUWwpw=;
        b=PpO6edCdOqmIfqJETfoB/zQKlmv2NgNT1DLrbOFI5Sxi2Ur2Su5goOnaXpvn31EZHP
         mQDdHt9VA7uNWB6JRS2ow361DryurAIIZj6VxQrJQe5TWbOlHZ3RN7b0lx/FXb7vDCz+
         vFY31uPK15vYG5Jh6fQBGLZNAV2YbGly/Cjz9gYTEkXTOotS1q98/c/DFfbc8mh8vgID
         q6cdFjzDwa2arw3/WrjTIHKQZ4Ec1kvrFrIrhwvFB7N1iCWIxGEqfsQO55/LuhN/GCdk
         JHs8o6+R+oOiAqFTvH9Q06q1G94v8Pb/JjojqyDiwqh2k1/LvACORxlOaAFtTU/+2e6n
         PV2w==
X-Gm-Message-State: AOAM530qzC8H+0GHuZyzr/9HddBHYC0F34CSkFHiwigVPd5FW84Bd8mI
        duSHyp1buhroBrTTWbzXX4dCr9769Dx2tMrMrpkWRQ==
X-Google-Smtp-Source: ABdhPJxCbA+UQG5DBRt46s+7C8j0EEXnshLl5hVCa52l6TVZnQPrsgHmMu98JhjPS4p0imQZYu4Q5i9X4KXBxLVSHgg=
X-Received: by 2002:a17:90b:1802:: with SMTP id lw2mr26223360pjb.232.1643654213164;
 Mon, 31 Jan 2022 10:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20220114091502.333083-1-allen.chen@ite.com.tw>
 <f4696a8d-5c1d-1007-7814-b2e6cbe334ae@collabora.com> <CAG3jFytN9iu0BteAxFCLVRorxM20Q3Zrfn1T4k8bnDYy5oL7bg@mail.gmail.com>
 <CAJMQK-i6M1hwESSA5OJ6TpdBBBEG8K9esSbLv-Xjb_zqCoB5ug@mail.gmail.com>
In-Reply-To: <CAJMQK-i6M1hwESSA5OJ6TpdBBBEG8K9esSbLv-Xjb_zqCoB5ug@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 Jan 2022 19:36:41 +0100
Message-ID: <CAG3jFyvgvfjo-HgL8wWWXtaoJvUupd2zJt=neVJZn5uVESyZFA@mail.gmail.com>
Subject: Re: [PATCH v11] drm/bridge: add it6505 driver
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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

On Mon, 31 Jan 2022 at 17:55, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Tue, Feb 1, 2022 at 12:37 AM Robert Foss <robert.foss@linaro.org> wrote:
> >
> > On Thu, 20 Jan 2022 at 16:25, AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > >
> > > Il 14/01/22 10:14, allen ha scritto:
> > > > This adds support for the iTE IT6505.
> > > > This device can convert DPI signal to DP output.
> > > >
> > > > From: Allen Chen <allen.chen@ite.com.tw>
> > > > Tested-by: Hsin-yi Wang <hsinyi@chromium.org>
> > > > Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
> > > > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > > > ---
> > > > v10 -> v11 : remove drm_bridge_new_crtc_state
> > > > ---
> > > >   drivers/gpu/drm/bridge/Kconfig      |    8 +
> > > >   drivers/gpu/drm/bridge/Makefile     |    1 +
> > > >   drivers/gpu/drm/bridge/ite-it6505.c | 3352 +++++++++++++++++++++++++++
> > > >   3 files changed, 3361 insertions(+)
> > > >   create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
> > > >
> > >
> > > ...snip...
> > >
> > > > +static const struct of_device_id it6505_of_match[] = {
> > > > +     { .compatible = "ite,it6505" },
> > > > +     { }
> > > > +};
> > >
> > > If you want to have a DT compatible and DT properties, you have to also add
> > > dt-bindings (yaml) for this driver, otherwise, any SoC/device DT will fail
> > > the dt binding check.... So, please, add that.
> >
> > Let me second this. A dt-binding is needed for this driver to be
> > complete, it functions as both documentation and a way to test the DTS
> > that use this device, so it is really important.
> >
> The binding seems to be accepted before the driver:
> https://elixir.bootlin.com/linux/v5.16.4/source/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml

I completely missed that. In that case we're only missing the
reviewed-by tag from someone.

>
> > >
> > > For the driver by itself, though:
> > >
> > > Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > >
> > > > +
> > > > +static struct i2c_driver it6505_i2c_driver = {
> > > > +     .driver = {
> > > > +             .name = "it6505",
> > > > +             .of_match_table = it6505_of_match,
> > > > +             .pm = &it6505_bridge_pm_ops,
> > > > +     },
> > > > +     .probe = it6505_i2c_probe,
> > > > +     .remove = it6505_i2c_remove,
> > > > +     .shutdown = it6505_shutdown,
> > > > +     .id_table = it6505_id,
> > > > +};
> > > > +
> > > > +module_i2c_driver(it6505_i2c_driver);
> > > > +
> > > > +MODULE_AUTHOR("Allen Chen <allen.chen@ite.com.tw>");
> > > > +MODULE_DESCRIPTION("IT6505 DisplayPort Transmitter driver");
> > > > +MODULE_LICENSE("GPL v2");
> > > >
> > >
