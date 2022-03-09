Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF384D2FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiCINZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCINZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:25:02 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FFF9BBB9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:24:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so5235810pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oRZXC1BJWU5wHBAMKvr18W/wUSl+kSjeSXIhLz/2sU=;
        b=DPR3zH9WhDgp67OFBrXbywIYtj2eZKwfu4g+rxaQCZ1w925pDwdZomMek8ZYOf4IHT
         hyJSoj5YpW2KK/n4/cnYUOh3xKOE64v2u65le43o/E7vtXZS+phCqAKsJyAmAOF9f00z
         9VSopSF0UdM1BKdhSy+pzPQDR2WQ13NzsnHYfjuF6PV2ibawnnrOOaWmmPAb7Sf2R++Q
         VUZeVGnwEsjwmk7z8SqP3fUnnbQPrqbPFdOu97dI0b0LgBZlP/H81jvy47EZmh+q4KP8
         mSiCeyQHggeLkG1bDpisnGtm0uvUwsXI8XdcB9wzVJ5cRxwgWHHT9VjMd3chIpetf7Mo
         C5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oRZXC1BJWU5wHBAMKvr18W/wUSl+kSjeSXIhLz/2sU=;
        b=K42CoVB0WzhbpjFWZeL6HxlzBe3ObmA+PE8PXxUd3ouiSh4fWLa+f7QeGwxEFc2Gzp
         Ov+V61xEi+YkXiuQp+K/sBWPv5HAu+1eqC9f3KCqOx8K4gaw1qFmS+TkvXnSjvsmNDWv
         T3YgfmA8QFCexMQ9MIiGUv7gAGlXC3KT7xOQBYMqn6VtkQcJBixHpXlhlyJprFiBWylI
         XpwYMcJmlaWYJosE6UgZ51jtptX4QjDqOrPNc64A0vXPpHm2Ey1TXVBxYTGFWmJWyZ7T
         xUBde9hR0lljTSlZXvaugT4Eln41RZ1hgaea62cjxoaEkS9m7jacLX4Gx5oSfYicmb0F
         0Kgg==
X-Gm-Message-State: AOAM532sjK+9xvIhXplXBLWfzA9dMjhDau7eMKzqb43kxeAlYcK3DrYQ
        3szCzl9XGN38ztK42Sa5qxNIjKPibV56+RJ2lfacbg==
X-Google-Smtp-Source: ABdhPJw5MkFq8UxSrUjKLChZQOA3kh2aek7Niglg0YrY5Z592yyqMyuGw5kuIMEZSJNh1lQBO4g/snUreHdp++oeCCQ=
X-Received: by 2002:a17:902:7044:b0:14e:e1b1:bb0e with SMTP id
 h4-20020a170902704400b0014ee1b1bb0emr22504279plt.65.1646832243062; Wed, 09
 Mar 2022 05:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
 <20220308110615.2.I4485769d5b25a8096508e839b8fea12ce7b836d3@changeid>
In-Reply-To: <20220308110615.2.I4485769d5b25a8096508e839b8fea12ce7b836d3@changeid>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 9 Mar 2022 14:23:52 +0100
Message-ID: <CAG3jFytkSsmN0H3N-ARqLJ16+ughHZqdas09Her_ZOkSTvCydw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/bridge: Add myself as a reviewer for the TI
 SN65DSI86 bridge chip
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 at 20:07, Douglas Anderson <dianders@chromium.org> wrote:
>
> I've spent quite a bit of time poking at this driver and it's used on
> several Chromebooks I'm involved with. I'd like to get notified about
> patches. Add myself as a reviewer. It's expected that changes will
> still be landed through drm-misc as they always have been.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a73179d55d00..7d25d0b4dccc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6284,6 +6284,11 @@ DRM DRIVER FOR TDFX VIDEO CARDS
>  S:     Orphan / Obsolete
>  F:     drivers/gpu/drm/tdfx/
>
> +DRM DRIVER FOR TI SN65DSI86 BRIDGE CHIP
> +R:     Douglas Anderson <dianders@chromium.org>
> +F:     Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> +F:     drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +
>  DRM DRIVER FOR TPO TPG110 PANELS
>  M:     Linus Walleij <linus.walleij@linaro.org>
>  S:     Maintained
> --
> 2.35.1.616.g0bdcbb4464-goog
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
