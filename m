Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB749669C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiAUUuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiAUUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:50:11 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9ADC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 12:50:11 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id y14so15250476oia.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 12:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIhTTjelyXp1scIWoIHum/L+8mNJoJDG0RuZ6neQWBQ=;
        b=S77186CnyZMQUQqsNQ9+TmBwqAbtNfrjvvjCAAiIeT6ZZ4bYkyEhMV+NQHdB9vWhZA
         yV4LN7S8S/VpiOQwOYSkltT0g0NGMKmErw9/x5WhSzwfHsS9uHkQKi0it/i6VauNx1JC
         7vbubAvJ2qyO2mxbF8rXjx1swIiD44GaHvqYFUy2jT45AbsU7FMsOCOeBeuD05FaFAa/
         w7PcFrdWNUiuk6Nyo0xca6Wy+/Fv4Lqdamoo7NOwBlQzQPRoKdHLcHinvh1T+oK/PTlY
         6/fkIX9RqbCw295MMLrjpRTuYxrvMWJM3oBdXsiqQIFxJsRcTqm104GF0eNsFRroov/M
         DzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIhTTjelyXp1scIWoIHum/L+8mNJoJDG0RuZ6neQWBQ=;
        b=Jm5sWvt8u8hbpVoPTBqmxl9C9p/HyMuam0jN9XSUnTIkbAkL8LP0MZiCzfXfjVGnlY
         DWfpRSURwewH/bALVtgJXTQrWtkYx7rZoTR55zONNaEWoniYyFfTfrLtYFcObEb6pQrR
         SVb3x5gvL0dPSOZMWqd1A1JqmGs4nLlzzxiwPbcNzhn8TJ6varF/ZgkjPIlfCfnU6ge2
         mBF4nFCNXPdXatG8CjmdHwgdHu7aCphaJWtcuMOIgVvOUPDrBRL03Y8obJNw420RFm1m
         U1yeq8bR/M3iXLzcidC2Hw5Wk7HbwwN7p5BQUiFaA+yyiyvYkzjRa6BUzsDgrgsSR8Yu
         M+vg==
X-Gm-Message-State: AOAM5323obqKkGboCicFcRIuomb+HiY7Vo1SsqVN3auGdulOXOukNo5O
        Q/vFrBlSQ4Qayx9eC8X+zof5931KkvjNU3u+npw=
X-Google-Smtp-Source: ABdhPJyHg9DnOVLj3GXek1xX/4z2+Ys+ETYkAEGri9PQIVx4le2XsjzS4hGXn/Nystf1LQWIU/w3nB3UXfPeSOn92HQ=
X-Received: by 2002:a05:6808:ab2:: with SMTP id r18mr1994063oij.123.1642798210665;
 Fri, 21 Jan 2022 12:50:10 -0800 (PST)
MIME-Version: 1.0
References: <20220121114800.95459-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220121114800.95459-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Jan 2022 15:49:59 -0500
Message-ID: <CADnq5_NbnutwnzOttGtj37dH9eMBT3KUM=i8v=JTZ3cqCh6hoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: remove useless if
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Quan, Evan" <evan.quan@amd.com>, Dave Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jan 21, 2022 at 6:48 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Clean the following coccicheck warning:
>
> ./drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c:7035:2-4: WARNING: possible
> condition with no effect (if == else).
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 23ff0d812e4b..7427c50409d4 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7032,10 +7032,7 @@ static int si_power_control_set_level(struct amdgpu_device *adev)
>         ret = si_resume_smc(adev);
>         if (ret)
>                 return ret;
> -       ret = si_set_sw_state(adev);
> -       if (ret)
> -               return ret;
> -       return 0;
> +       return si_set_sw_state(adev);
>  }
>
>  static void si_set_vce_clock(struct amdgpu_device *adev,
> --
> 2.20.1.7.g153144c
>
