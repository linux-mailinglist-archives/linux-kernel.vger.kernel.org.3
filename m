Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F674FAFD4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiDJTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbiDJTi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:38:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7613A5D66C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:36:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so1003847pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB5ENHQGS8KY2/OLlsEuoI/3asQ07ZG7H3vfdY5dmNA=;
        b=FQLkBNozs4/zB3PtDYJb30oZtKsl2zh+p9OILgJ2EubuUROUfSmiFp9EPNuRbwpwam
         +goowpD2srssE5Epnz9YF++Vxk0xjTW7xXDVRmnHZx8Iyut21iKFG2+IMphe8ZavebMh
         RYsw2j0S7JRUeRNbZyGKcmn5tPJRTzH6wEjZ3qBIiGP4LFkqkXLyHYvmvAf3S/VlozLh
         433iP7S0Jccajby3WzPg/wfaQd36m2zqB1/0BRZd6J11Qw+L4vJuyREO62TsulcG+4U/
         DtuebXYMW6Z5LrvoRlOJbil2KudecOtRsCSobPPFBn7znfEXCotIqwUDCAYKRBU2sZ1e
         YfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB5ENHQGS8KY2/OLlsEuoI/3asQ07ZG7H3vfdY5dmNA=;
        b=AZHSf5aEFD0BAu2BfmPRZmYKpnXEKllEh2r3ehqVSq7S+NlPcwNSwpq+xNBSUgbwh+
         plYbxl1MjyHT9evXii56H3TfgfhQs7r4cCiaW04h6Tdb0xj2JgAvWFJQDkKe3Bg+OuC/
         8mN8jVFNkLc8KoQe2jwkwCdbOJXyI21IftmmeJKLkn3Mg1rOwWZAMo1EQ6Xgb6htHfKA
         0UQhlhqrZilP79P4GeM6w24oB/yK/Y9f/f8rrImcvTyzz2h0optL1+bh3QewFjnlMfbW
         klLnOBQ9N8U16oFzC0FuI2AiXhj6Nacb8EI1VYNgBuQvN3uVh0CQKq8j1MCoYW3R1K0V
         fukA==
X-Gm-Message-State: AOAM532UhExkycy52lRzesvpjMDyEFezpJL6lqLe5m3ZejLu3pHoBgDs
        TN4+fGBLoxag1LcsazeTXKim6mBwoPDlKiT3EKQ=
X-Google-Smtp-Source: ABdhPJwh9azmPl4AAFBOfdgkJtS0Fad5CegTaWOl1giYU+A+qcd1io8t9LpwO/NFebB14sNaJJOmEnkJxBYNkjmyu5E=
X-Received: by 2002:a17:902:eb81:b0:156:febe:7e74 with SMTP id
 q1-20020a170902eb8100b00156febe7e74mr19860231plg.6.1649619406921; Sun, 10 Apr
 2022 12:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
In-Reply-To: <20220409042321.3184493-1-james.hilliard1@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Sun, 10 Apr 2022 21:36:35 +0200
Message-ID: <CAMeQTsanEow=zq=MuZLjMqpzybdS=5S0=JrkxuCdT7d5MxpEWQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 6:23 AM James Hilliard <james.hilliard1@gmail.com> wrote:
>
> Select the efi framebuffer if efi is enabled.
>
> This appears to be needed for video output to function correctly.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Hi James,
EFI_FB is its own driver and not needed by gma500 to drive its
hardware. What makes you think it's required?

-Patrik

> ---
> Changes v2 -> v3:
>   - select EFI_FB instead of depending on it
> Changes v1 -> v2:
>   - use depends instead of select
> ---
>  drivers/gpu/drm/gma500/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> index 0cff20265f97..a422fa84d53b 100644
> --- a/drivers/gpu/drm/gma500/Kconfig
> +++ b/drivers/gpu/drm/gma500/Kconfig
> @@ -2,11 +2,13 @@
>  config DRM_GMA500
>         tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
>         depends on DRM && PCI && X86 && MMU
> +       depends on FB
>         select DRM_KMS_HELPER
>         # GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
>         select ACPI_VIDEO if ACPI
>         select BACKLIGHT_CLASS_DEVICE if ACPI
>         select INPUT if ACPI
> +       select FB_EFI if EFI
>         help
>           Say yes for an experimental 2D KMS framebuffer driver for the
>           Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
> --
> 2.25.1
>
