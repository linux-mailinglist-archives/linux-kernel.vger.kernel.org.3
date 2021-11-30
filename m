Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4046414E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbhK3WfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbhK3WfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:35:15 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6758BC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:31:55 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id x10so28273818ioj.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXXJ26Wt6dMZ0zORFCiW5WUqSHwbGwHJdBTa4iT2mVM=;
        b=azsCj/Xo7luiuJG3TgVodDC6kPkHmTnZZNjFIQRBNJHvod/t5kJhL+3sFQ39CkElhi
         qt3gxzzWZL6bhROlbkR5eapdsFYRXgJvxPC9b0UY4E9okDXc8IOHgyDgrYh5Q5UWRunb
         JE/nIziF8kLAGWW57/42rdDqwwrIzGEOnYhCLrUiXYTRjXkG2CzIfUEGzdCLHGe95wSX
         o6YclUuvPm1AyWV2P10GHzFCDsgH+tDrL3O8A1mmwmDxOxYyNMdJIFCBOM/oxjFc1KgJ
         XnlwphAl1r9BlxtMri+YDJ429Mz34xzM3IkHZjidJeqgQB/Yf1TqgKk/jRRJvi4iE3OJ
         7D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXXJ26Wt6dMZ0zORFCiW5WUqSHwbGwHJdBTa4iT2mVM=;
        b=NYMsUy/KHOGhvIDWTc7WVIyc63Gi7sXAk05XOE2ja1K/9sb+3JA2afbRXkcRKdaE2c
         mR2QA60ztUhW+KSdkUNY1xqjEmGfHyR5LG86deKUiroy9QCzG6aVhJbNYHr8cEEUcnf3
         Ry8rDsyeXr72iabWfrIv43qTXXD83TSd5VEgje5Z4YJCWHpWQwMTFfxoJugFR2/zMnFj
         SBr0wse2MQWtvjiEXOsGXUlp4Vjl+nZjCrxbHrJoIFZYv49ogsPGxV+3VnJgvG4xN06X
         khtBfGoGOx1W5/l+xnMMHYSIQs1x+XHS/dXf34+y8C9X8LHsYDWNbra9FK4pb25Os9Dp
         uP/g==
X-Gm-Message-State: AOAM531NU25D+UiXeKT/3CryygnoyWel8VuNl0NL5k4DIxrh2V5U5tN8
        EMZRSo2nMB9PO+K13hQB1kPZO0vYJapLphngdPMaqg==
X-Google-Smtp-Source: ABdhPJz1icdhjs029/3/wHzP6fD9o5E170eQhe4Tn7lyO0TJjPeJHsCU8ig12rKaMR80FMbMdbWkBs5TIS+o+SzjSuI=
X-Received: by 2002:a02:cc91:: with SMTP id s17mr3959716jap.3.1638311514465;
 Tue, 30 Nov 2021 14:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20211123075205.2457975-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20211123075205.2457975-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 30 Nov 2021 14:31:42 -0800
Message-ID: <CAD=FV=W=9Ux4ym4GsFME2L9Qjis-pJckOinRXaese4aO4YCq2w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Update BOE and INX initial code
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 22, 2021 at 11:52 PM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> At present, we have enough panel to confirm the effect,
> update the initial code to achieve the best effect.
> such as gamma, Gtp timing. They are all minor modifications
> and doesn't affect the lighting of the panel.
>
> a)Boe panel Optimized touch horizontal grain.
> b)Inx panel Optimized GOP timming and gamma.

s/timming/timing


> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 108 ++++++++++++------
>  1 file changed, 71 insertions(+), 37 deletions(-)

Please resend and include the panel model in "${SUBJECT}". Right now
your subject makes it sound as if this affects _all_ BOE and INX
panels but it only affects two particular ones.


> @@ -111,18 +111,16 @@ static const struct panel_init_cmd boe_tv110c9m_init_cmd[] = {
>         _INIT_DCS_CMD(0xB0, 0x00, 0x00, 0x00, 0x1B, 0x00, 0x45, 0x00, 0x65, 0x00, 0x81, 0x00, 0x99, 0x00, 0xAE, 0x00, 0xC1),
>         _INIT_DCS_CMD(0xB1, 0x00, 0xD2, 0x01, 0x0B, 0x01, 0x34, 0x01, 0x76, 0x01, 0xA3, 0x01, 0xEF, 0x02, 0x27, 0x02, 0x29),
>         _INIT_DCS_CMD(0xB2, 0x02, 0x5F, 0x02, 0x9E, 0x02, 0xC9, 0x03, 0x00, 0x03, 0x26, 0x03, 0x53, 0x03, 0x63, 0x03, 0x73),
> -       _INIT_DCS_CMD(0xB3, 0x03, 0x86, 0x03, 0x9A, 0x03, 0xAF, 0x03, 0xDF, 0x03, 0xF5, 0x03, 0xF7),
> -
> +       _INIT_DCS_CMD(0xB3, 0x03, 0x86, 0x03, 0x9A, 0x03, 0xA7, 0x03, 0xCF, 0x03, 0xDE, 0x03, 0xE0),

You would know better than I would, but it seems like you've randomly
added / removed some blank lines in this patch. Since these are
totally opaque to me (which I hate) I don't know which is better or
worse, but it seems rather arbitrary to be messing with the spacing.


> @@ -428,10 +452,10 @@ static const struct panel_init_cmd inx_init_cmd[] = {

I should have noticed before, but the name "inx_init_cmd" is way too
generic. Can you also include a patch to rename this to
"inx_hj110iz_init_cmd" ?


Other than nits then I guess this is fine. I'll probably wait about a
week from whenever you send the next version and then plan to land it
in drm-misc-next barring any other feedback.

-Doug
