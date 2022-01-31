Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9234A4C47
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbiAaQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380516AbiAaQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:37:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06FC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:37:15 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g20so12686400pgn.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pq2lioXdRgfbbAgrjb+0HwzuycY8mIpT20OJghTqzwk=;
        b=TV/ZHqyoB8BfyZubWHTiSyaTd4Bua2KKp6Wgz7Rx3QwKn5TZ06c6vsokHA3UGOLxZL
         qWV/9fXEn3FqJLBb3Qro2sPIGrnMgLRjPXlsEu8tbjg4Ou23uszuDYI7LvzZ3aF6LON4
         WrjsyTSo3K4SZESxazXNyefQwMNEhKeNcgT6KZcuwzUeOiver0zXC9qBU/iDjf7xq/mA
         Ljl1sNSX07CLemNmdnB9vnLl3icovO3JsF/Tuj4xu/FRcgBIxeKyuonmWfJCDHiJIs8q
         L6XgOVvpf3m15iqIe762QVHp/+IDzYUDntA2QuUVFV+fW9BttgARPXmkbW3SYIcp/AmN
         C3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pq2lioXdRgfbbAgrjb+0HwzuycY8mIpT20OJghTqzwk=;
        b=eVSlXhjhu/o3FDGG+SiwSnacxVzwGDZM0iDv+1xZKzXqaxAI9DkUfi5cZ2iSG1RbvY
         1Hf+Zo+LT60IsMaKDNmGxTWgbCQFEax2t9SU+5BtY+3vY8FPKKrM+/otmdVz+HQmD8d9
         Z4m9HbMPnxBPkpI02A1LrK9jETyC+IVjqoH65ysQ1W2qRzcZVi8i2Ap3ByHFV0kK7mXA
         EO7AC1vWCxI0g06dXI617qMH1hoWEXNSoAaGW+Um2n9RavhIkSX6GyOzJEkDANjdV17o
         zBnXLM9sukOcbZcFGPmpWHtiZo4lRN8ly89uBI3fSJ6bbrwitdkbGJxrrpFxRTubBCEs
         JN2w==
X-Gm-Message-State: AOAM531HaIbUog9Ot1H9gQbn/B/527udVreNFskrexiRdbHfHlpgFQqb
        IcDxL1yQtBb4G3um6yaKa1nuCtvclRpUL+18+38Itg==
X-Google-Smtp-Source: ABdhPJxCVjGCmcB+SRLMnrxP4w9hsLJuDvvvXUNn/mVl7jcD6wQqJ/j68/Ao/S71VIOvwOEhPqZ6xemhbuhfGR2YRb4=
X-Received: by 2002:aa7:8490:: with SMTP id u16mr20859502pfn.1.1643647035064;
 Mon, 31 Jan 2022 08:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20220114091502.333083-1-allen.chen@ite.com.tw> <f4696a8d-5c1d-1007-7814-b2e6cbe334ae@collabora.com>
In-Reply-To: <f4696a8d-5c1d-1007-7814-b2e6cbe334ae@collabora.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 Jan 2022 17:37:03 +0100
Message-ID: <CAG3jFytN9iu0BteAxFCLVRorxM20Q3Zrfn1T4k8bnDYy5oL7bg@mail.gmail.com>
Subject: Re: [PATCH v11] drm/bridge: add it6505 driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     allen <allen.chen@ite.com.tw>,
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
        Hsin-yi Wang <hsinyi@chromium.org>,
        Hsin-Yi Wang <hsinyi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 at 16:25, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 14/01/22 10:14, allen ha scritto:
> > This adds support for the iTE IT6505.
> > This device can convert DPI signal to DP output.
> >
> > From: Allen Chen <allen.chen@ite.com.tw>
> > Tested-by: Hsin-yi Wang <hsinyi@chromium.org>
> > Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
> > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > ---
> > v10 -> v11 : remove drm_bridge_new_crtc_state
> > ---
> >   drivers/gpu/drm/bridge/Kconfig      |    8 +
> >   drivers/gpu/drm/bridge/Makefile     |    1 +
> >   drivers/gpu/drm/bridge/ite-it6505.c | 3352 +++++++++++++++++++++++++++
> >   3 files changed, 3361 insertions(+)
> >   create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
> >
>
> ...snip...
>
> > +static const struct of_device_id it6505_of_match[] = {
> > +     { .compatible = "ite,it6505" },
> > +     { }
> > +};
>
> If you want to have a DT compatible and DT properties, you have to also add
> dt-bindings (yaml) for this driver, otherwise, any SoC/device DT will fail
> the dt binding check.... So, please, add that.

Let me second this. A dt-binding is needed for this driver to be
complete, it functions as both documentation and a way to test the DTS
that use this device, so it is really important.

>
> For the driver by itself, though:
>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> > +
> > +static struct i2c_driver it6505_i2c_driver = {
> > +     .driver = {
> > +             .name = "it6505",
> > +             .of_match_table = it6505_of_match,
> > +             .pm = &it6505_bridge_pm_ops,
> > +     },
> > +     .probe = it6505_i2c_probe,
> > +     .remove = it6505_i2c_remove,
> > +     .shutdown = it6505_shutdown,
> > +     .id_table = it6505_id,
> > +};
> > +
> > +module_i2c_driver(it6505_i2c_driver);
> > +
> > +MODULE_AUTHOR("Allen Chen <allen.chen@ite.com.tw>");
> > +MODULE_DESCRIPTION("IT6505 DisplayPort Transmitter driver");
> > +MODULE_LICENSE("GPL v2");
> >
>
