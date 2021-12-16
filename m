Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73059477151
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhLPMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhLPMF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:05:57 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E33C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:05:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n8so19285005plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H9EMWcxNE3MmWqEWI7uZzzhhZUDkalTYtdIjgNw5Dc=;
        b=teae7+Rhl19M4VEPLx685yvVeu8Acpi1N/Q35d7UqM35OMBXKsYtbOvxs/oPnKEPHA
         uU2ND/nWUiX7tr+jD35MeS4paRLxt/v6E2Exr0ipkKMPiXYpRjTeUGF0zBUERw8i+Rph
         oofYWwiuh7mvVbrDLrID0c93OHC/yIAZZceQsrsBXfy+NZmvUgRQh/exOrnDfs06Zk7I
         grzU/3eXm1NKpr0mwckRW0DBxad1qY+XU6UkjXsn4QTIMqHv24vUdt7GgisQJG0Tlbdo
         DKM15Q7K9WSwX1WcCQIhs0UVI+MUpdwcRLJ6A7uZvlQS9MlsanqeM5W22oVrIrI9swQQ
         ecCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H9EMWcxNE3MmWqEWI7uZzzhhZUDkalTYtdIjgNw5Dc=;
        b=COidWA7yKF7Y8WyLZq2fLVqFqV5Z0nrzLpbcRSRjd4yrs0ALr4YFl+njsR3P/ISpAQ
         Y/LbJNMZgZTCE7U7eoQiGZXntaR5+Emzi07Yv00O1F21eaD8rsTFzKRn4Zhi+GslDdOP
         X20brthzr3C91QmObN32aJasCuNsAsTefgiq1JOtjXULTxKCdFsFsnIXVL00QQqH2mr4
         AL5zU9x4+3XmWPT1jJzB6aqSBKKO/aOY7s9NEm3X+vWb9gQjdIp/1hwPMzxfl7zweRO6
         WBgbD8lv0LY3Lk8un/N9B+ZLDnwehdQ56np3sDPIxstJyIqGb4EfA8DjksJJCSwcgHDO
         EHDg==
X-Gm-Message-State: AOAM5335EcCQqY6HSigmruon8atxq4aaHpOUvTtMWDbMh47m++kA4e7o
        ahn/rBGXTIxd/LVmWNACSOBShB75yDBqfvhGQcbGag==
X-Google-Smtp-Source: ABdhPJxt4oYy09frB9H5orpzx03e+FHCldURdWKv5OSg4sNb7f/HwpftIGM+WCx1aCNgmg4+AiDJcZ04o+hK2r1rFk0=
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr5723305pjb.232.1639656357229;
 Thu, 16 Dec 2021 04:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20211215002529.382383-1-swboyd@chromium.org>
In-Reply-To: <20211215002529.382383-1-swboyd@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 16 Dec 2021 13:05:45 +0100
Message-ID: <CAG3jFysdAbHYXWv_87vB87Wf75Hev=bpjpNppdhcapb0_-dAfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Set max register for regmap
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for submitting this fix.

On Wed, 15 Dec 2021 at 01:25, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Set the maximum register to 0xff so we can dump the registers for this
> device in debugfs.
>
> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 6154bed0af5b..83d06c16d4d7 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -188,6 +188,7 @@ static const struct regmap_config ti_sn65dsi86_regmap_config = {
>         .val_bits = 8,
>         .volatile_table = &ti_sn_bridge_volatile_table,
>         .cache_type = REGCACHE_NONE,
> +       .max_register = 0xFF,
>  };
>
>  static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
>
> base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
> --
> https://chromeos.dev
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next
