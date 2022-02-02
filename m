Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AEA4A7B85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348021AbiBBXKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiBBXKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:10:53 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ECBC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:10:53 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id m9so1207664oia.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFPvU3m3nNCphV2xKrhWgV0aqhe4pVrtWvbA9ob9jJA=;
        b=XPwWJPECu0OQvpbmvXKFvImCF/9S/T5giVTWJ73LDI2jTIACSbfixnl/qm9fsPvIV/
         muY2r7sLlegn9A+mZfYx0wdffcufqt5U2SE8zV43u+CsCUJ9frDKlsrybXpubFhbj0Mz
         Bhxgo6+I6nRhmjD/IgmX0J19CEPHf+YG1/AqD2UJtPFlHSZM3LdIsZwOPcMvBnFBtPrz
         FVPqbsB/utqoh2hVHsqM+D7YY1ASQ53wMgfEAQSOgAfWytidX5yL2V/GK/3U98VHeZ7x
         QbD0pYR4EPfOZmei9c6Ixw3ow4IUT1NBOiFjouwIwp/iWhBDbIQeZbwA6TiRNN1xxKJs
         hPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFPvU3m3nNCphV2xKrhWgV0aqhe4pVrtWvbA9ob9jJA=;
        b=S+IV0MK2yh3KJkJjZnoqVGtV0znrNCUYpm/Jq90LAz1Va1KfuEzvKfc+0MkmeGN+bp
         rUM9uO3iPYmj7QId90pGh/vPd2SNvekfe5IO9IoABfniTpETm0a2wMWzzlFmlxczfbQy
         ptnATrH7ady0ual1O5n75HIApLeEGBgtk7hknppcJbDryir24e72rpNlGGZIVGDGBHf9
         tt1H+ARu4IW+VqrmRUurbqJk+utoDAkAtqUploJRRCGRcFvTHqsCFBFN1o+oTV+xZe9I
         t3pijUjYLJuZhQaJCo4VZx15EohzvdFKujWymjH/OgYeJc6KNdesQI5sin8vM5GB6SLd
         ZRbQ==
X-Gm-Message-State: AOAM533k9np1gUkGuTyRxbR7KNlBti6AKiVlVrKDDieUxNdN+0lxz8Xp
        gtKnMAT5jxoTDWN4u8eHHBohZoDZA8t2Z7PSQ1w=
X-Google-Smtp-Source: ABdhPJxQpJPdMWGuc5v2246SX0mSPx1BcVp8or5TappW5d2BJQ7794woOwsy2AQnf4yWVgn2gfaDHD2seTU1QUHxHIY=
X-Received: by 2002:a05:6808:159e:: with SMTP id t30mr3720621oiw.132.1643843453063;
 Wed, 02 Feb 2022 15:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20220202213856.409403-1-magalilemes00@gmail.com>
In-Reply-To: <20220202213856.409403-1-magalilemes00@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Feb 2022 18:10:41 -0500
Message-ID: <CADnq5_N2GtUciR7agvCR6d=C5r9Ek2mcRsT3qcOUFfEYk57ksA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use NULL pointer instead of plain integer
To:     Magali Lemes <magalilemes00@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        kernel test robot <lkp@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Feb 2, 2022 at 5:20 PM Magali Lemes <magalilemes00@gmail.com> wrote:
>
> Assigning 0L to a pointer variable caused the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/rc_calc_fpu.c:71:40:
> warning: Using plain integer as NULL pointer
>
> In order to remove this warning, this commit assigns a NULL pointer to
> the pointer variable that caused this issue.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> index ec636d06e18c..ef75eb7d5adc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> @@ -68,7 +68,7 @@ static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
>         int sel = table_hash(mode, bpc, max_min);
>         int table_size = 0;
>         int index;
> -       const struct qp_entry *table = 0L;
> +       const struct qp_entry *table = NULL;
>
>         // alias enum
>         enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
> --
> 2.25.1
>
