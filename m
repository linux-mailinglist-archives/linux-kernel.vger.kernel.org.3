Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076714D2FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiCINZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCINZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:25:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1ED3AF4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:24:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso5307052pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rhjOIEJAil5r1VPDQV4Zr+iVbr3FvcR2IWBFJpwONYc=;
        b=E3bTouXTZ8bPZLFpQO5rMdE9CsBEmzmlnt6Fm4XQWZtgsVI35VabX4l6ZNJ08U/gfJ
         mrLy40R/DKvIgp/X01aYgoEFFuJ7e+8Jol+71WU/X00NRxnWSO0TduEuS/pzMnfBtizV
         Z6x0Rauw15BfK/yj/lgCWipsa+QVnn+KAp3x403N/YvBtMq2A72bhEXYTA4DJikWyP5K
         VZOHvo19GRbrxVBOhXFlhpLDzrYoYlwijUdWqdtBq6oKR4805hf8Lofmv2B8mocT+wKB
         E68UMbsA7HWXNPaynB6YzZI3rbNDBlMy52wJlieVVlbw2+HYf1Pu0z1wj5+eYFxJSPfh
         s8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rhjOIEJAil5r1VPDQV4Zr+iVbr3FvcR2IWBFJpwONYc=;
        b=n9Sg7uMUcx5QyYncAD/Hr07vCLFMuhDtY/5g22Lx2EycEQzvjlDdVcYrPcFWuGSjcl
         hgeH2fBsLmDLBxgKB/pkp98PgWyYwF96bAUT/bMe2bC5n3EStM9a8VKcgMHRdWalrgky
         Zgz0eioPuPvsRVe62yxpzawfKS0KhvBhAJMCXpY8ge7cp3t/SVbEJbA9aV8Db+QJNCjp
         QC3RAFK9bn0J6Z0xZC6dsIyibfHvGCahofulJ/6vIkYHag/Jb5NVL64QkRP13pV+C+AS
         W/89tqov0VNHmdwYuQyfYb5fkqwm0nyw/tOo8+pGEuYCy8oJiNC+6FMestjTAsXK2AtD
         1l1g==
X-Gm-Message-State: AOAM531n6u8zwE4OA0Ma865P5EBiQUnirGj+SljUN0ZOYBtK1XvvpmBD
        PdtclkM8K0S7xvQUEqdeI9CwRH2epJl3T4zcCjq15g==
X-Google-Smtp-Source: ABdhPJxwv4E9xh8eX7Ke5zJtcF1Erlu1Pg7Es9C5GP40cqVoU6fXShAFkauux6pBu3y5QnnpUN8GICji++3FrRj8POs=
X-Received: by 2002:a17:90b:124c:b0:1bc:369b:7db5 with SMTP id
 gx12-20020a17090b124c00b001bc369b7db5mr10406788pjb.179.1646832274117; Wed, 09
 Mar 2022 05:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
 <20220308110615.3.I04f99fbcc14b8c09610b4b18f0696c992a44d2b7@changeid>
In-Reply-To: <20220308110615.3.I04f99fbcc14b8c09610b4b18f0696c992a44d2b7@changeid>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 9 Mar 2022 14:24:22 +0100
Message-ID: <CAG3jFyuf2GLF8xQX+G_wOJ2hng0VWoBMYL9HZoU-NC-tL3m0Rw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/bridge: Add myself as a reviewer for the Parade
 PS8640 bridge chip
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 at 20:07, Douglas Anderson <dianders@chromium.org> wrote=
:
>
> Though the parade bridge chip is a little bit of a black box, I'm at
> least interested in hearing about changes to the driver since this
> bridge chip is used on some Chromebooks that I'm involved with.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d25d0b4dccc..db7fe53643c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6171,6 +6171,11 @@ S:       Maintained
>  F:     Documentation/devicetree/bindings/display/panel/olimex,lcd-olinux=
ino.yaml
>  F:     drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
>
> +DRM DRIVER FOR PARADE PS8640 BRIDGE CHIP
> +R:     Douglas Anderson <dianders@chromium.org>
> +F:     Documentation/devicetree/bindings/display/bridge/ps8640.yaml
> +F:     drivers/gpu/drm/bridge/parade-ps8640.c
> +
>  DRM DRIVER FOR PERVASIVE DISPLAYS REPAPER PANELS
>  M:     Noralf Tr=C3=B8nnes <noralf@tronnes.org>
>  S:     Maintained
> --
> 2.35.1.616.g0bdcbb4464-goog
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
