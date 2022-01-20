Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6E494C73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiATLDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiATLDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:03:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4D7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:03:35 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id p12so26985305edq.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n97jOmH1Hh/lQ5JREIu8WWpMZHA+pObxbgnKcQKqkdY=;
        b=OfgVg4++cjXVJlgE4V6UGTv+/DRslYaxUQwp42wmoRX703kLnHT6ZI42wX0OmSiDlZ
         SDwD6u+GkbkGAFUtJaJksGgW3PqmKgpnh610LHWTZa19Y68u4qy6t+4ixut+aX9mwwDf
         ovfVjhquX3wpszfrRqxTnakSBbHc8lkEazXCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n97jOmH1Hh/lQ5JREIu8WWpMZHA+pObxbgnKcQKqkdY=;
        b=SP/5iQLzDJ9UR65Q4fE3OXN3G3aGIls8RFERl/odCbhne3ZAOAudlzE8VmPYEvqI4y
         u7e4JuIVfiKVuLX6NV343d99R8qdXKYshZ7zCSJA/i3lHNKMDNjoC42lm3KPVvAPLwY9
         TdXeuXNDk79DGnj4pgX0FH7WxSkD5klXe22HGr15zaY/2xmY8btO6keB/ieNm2VRDxcs
         MLzYuLUOnsZa1Lw+Y5pXN6khe1gotbswWjqjvS/5X2gCPW7cpdoUsOC8LjNh7HrngKhP
         EcHsHyeupWEirFVFmf7cr7k2OSCHCm4y19Ae2NT8a53NJdJN4f5XQ/TFYgAO7n7KbEhv
         i8Ww==
X-Gm-Message-State: AOAM532UzrBUs3/9uigaQI7JhdEry3mgipjxZjWQIKNDhaPgJ1Z5oZi7
        Daze0u/J/Q5rggydJ8n+y/psCobcYN+/IuNx/IL+Yg==
X-Google-Smtp-Source: ABdhPJzNGcaoNoLJ9DIV2wfpr4vlmfC3H1ldbuvo6eEiv6LUJOZKv5Nk9JAXwwWgrS0AxorLH7OJbyk5bNnDlGJejCI=
X-Received: by 2002:a17:906:2e81:: with SMTP id o1mr9130992eji.760.1642676613863;
 Thu, 20 Jan 2022 03:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20200907081825.1654-1-narmstrong@baylibre.com>
 <20200907081825.1654-7-narmstrong@baylibre.com> <CAMty3ZBEmafG8LS_yv4eektvUoHwYFoV=-8wohUXgsvpRbZqtA@mail.gmail.com>
 <70d1af3f-bc00-4afd-1157-1cf70d3b2c88@baylibre.com>
In-Reply-To: <70d1af3f-bc00-4afd-1157-1cf70d3b2c88@baylibre.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 20 Jan 2022 16:33:22 +0530
Message-ID: <CAMty3ZC9Cp=8=iF=KYCWjwb-wk+VrPBzH+6L14H6iZcSm3CZjA@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/meson: add support for MIPI-DSI transceiver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 1:49 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 12/01/2022 08:24, Jagan Teki wrote:
> > Hi Neil,
> >
> > On Mon, Sep 7, 2020 at 1:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> The Amlogic AXg SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a), with a custom
> >> glue managing the IP resets, clock and data input similar to the DW-HDMI Glue on other
> >> Amlogic SoCs.
> >>
> >> This adds support for the Glue managing the transceiver, mimicing the init flow provided
> >> by Amlogic to setup the ENCl encoder, the glue, the transceiver, the digital D-PHY and the
> >> Analog PHY in the proper way.
> >>
> >> The DW-MIPI-DSI transceiver + D-PHY are directly clocked by the VCLK2 clock, which pixel clock
> >> is derived and feeds the ENCL encoder and the VIU pixel reader.
> >>
> >> An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
> >> DW-MIPI-DSI transceiver.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
>
> [..]
>
> >> +
> >> +static const struct component_ops meson_dw_mipi_dsi_ops = {
> >> +       .bind   = meson_dw_mipi_dsi_bind,
> >> +       .unbind = meson_dw_mipi_dsi_unbind,
> >> +};
> >
> > Do you thought of non-component based meson DSI like STM DSI? It
> > require changes from meson drm but just to understand if you have any
> > such plan.
>
> I have no such plans for now, note this serie has been rewritten at [1] but still
> with based with components.
>
> If worth it, the plan is to get it with components and than yes if it's simpler
> drop components completely.

Dropping components make the pipeline well suited for bridges as we
are moving bridge-driven pipelines in other areas.

>
> I'll have a look at how ST does

ST has no components. As I said above, eventually there would be
common bridge driver for dw-mipi-dsi if meson and rockchip moving away
from components.

Thanks,
Jagan.
