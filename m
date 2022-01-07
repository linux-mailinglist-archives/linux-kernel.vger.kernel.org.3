Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70F4487EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiAGV6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiAGV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:58:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4159C061574;
        Fri,  7 Jan 2022 13:58:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j6so27015068edw.12;
        Fri, 07 Jan 2022 13:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y+yvylrq8G9K24aTv5ZnK1lCvLyWIJOHvFwGQ2S4h8=;
        b=ScsV4/GFRAfwNY22P5ppslH6X6pBUQP05JYve6o22LMyOvM0tDvdnvAq3bETEIUtrk
         5LZBAP6u5NJsnVM6ftdVURmyCsgEaNNAwGKwUfdLe2+OqAmtoJGm4Kk7+h+TMBpfR0C1
         4AinlpD7xTuax7hzDAuzJ3dN2g/esM45cQJQbOZQDTWfaPIJzoNdIq7XeqzzMlhlGusu
         vUQgV8K6kV10TaiX4ibAv2go+zM1AC68O+wTSstLvszokcZi76acZx3ZCXmzjn8AJaxB
         U71W16gexR89e0nlH1eJPmGsE0/M66Pno5L3CckNrrJGKkad/ZS9UfUdOwZRGmIzLn4q
         6yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y+yvylrq8G9K24aTv5ZnK1lCvLyWIJOHvFwGQ2S4h8=;
        b=r0rMd9Y8q+OLNpSlElrb4nau4jKKEy3Iu8NIIP85JOjFqJwmK/J2jXaSkdTG+FitkX
         d0tnlz3zRrtEoDQaTwZn7NjrAWQRjYfTyh1UZArZn2Ojl1k+Gv4Ty16MUmahJqT6Z9UW
         g/fv1POyCwCwqF36i3omW6xa/ZtoiMqdrc04hQMlda4QNN9OmCTMp3WPbeJB2THxNu7B
         EaA5cbO360gonqUrE/wyWRydN9vd6vvtBqDIePB4OdahwZP8KatnzdN9GOM01cTmmvqB
         nPnHrn4DfT0PGzv3yP0SLKvTZVA5dhtXriPrZ0MS0PzaI8wAIuhNjP9Gij/1CnzOqu15
         Icpg==
X-Gm-Message-State: AOAM532rgPBG8NwS0n8HHYvHRMhtQw35LTfDCEIJqoiTjkDMvyb2HWUf
        Bi4RMfo4BQnx0FP5KAAUYyGsHqtvkPEiTXo8RelZfdXgpYc=
X-Google-Smtp-Source: ABdhPJxwHPeEHPAjD+LC51Ae0NUSbl+DZBbSQw9QOq/pdLTaBbF3QqP9KZH8X/zObztoMoesIIbfXmUSn46MNuaZqgM=
X-Received: by 2002:a17:906:519b:: with SMTP id y27mr5429738ejk.649.1641592714281;
 Fri, 07 Jan 2022 13:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20220107023931.13251-1-zelong.dong@amlogic.com> <20220107023931.13251-4-zelong.dong@amlogic.com>
In-Reply-To: <20220107023931.13251-4-zelong.dong@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 7 Jan 2022 22:58:23 +0100
Message-ID: <CAFBinCAP66AHM4252BwJ2FMLtyw2RzUsoitahpK0jNdgZaJLXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] reset: reset-meson: add support for the Meson-S4 SoC
 Reset Controller
To:     Zelong Dong <zelong.dong@amlogic.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, khilman@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 3:40 AM Zelong Dong <zelong.dong@amlogic.com> wrote:
>
> Compared to the A1 SoCs the number of RESET registers is different
> and the offset for the level registers is the same. Add a new
> compatible string and struct meson_reset_param to add support for the
> reset controller on the S4 SoC.
>
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
