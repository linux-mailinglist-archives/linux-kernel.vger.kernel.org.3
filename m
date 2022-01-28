Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202E94A0071
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350695AbiA1SxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiA1SxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:53:12 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7AC061714;
        Fri, 28 Jan 2022 10:53:12 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id b186so7837312oif.1;
        Fri, 28 Jan 2022 10:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pu4NSwnKcN2ktpCmENizSopNqGrtbHMNjwjQQEL3R9o=;
        b=FMrK316cn1uFMuGw08XpxR3ytnj/a+OHArDyn4WZuTbrMozATGItbEp0OF5NCLdAKs
         55wlAj/pLNbR3IY3wNMdQl3KC05xFW3ejCodXst/6aJbcvoC3IM/fFTHJDl7GsH7oQBy
         H7Y3Ytxd0Q7Nh+hczHmz4zi+PNfK8YcG3iLFzzRqksyG+JcZJSXzEJxqF74+FoHNlcYC
         jUiQfgStsVfpTNx84W9cfYSSasVqiH0lk2vQqJwoQslYryCMj7ob7TyO/VVc3uORYddv
         Uau/3O3gWAWmqTVLpvUZ8Mj7cCmj+u/piSuDb5t6UzbGAFPwQzXC7a8fCCwnlP0dK3eC
         CvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pu4NSwnKcN2ktpCmENizSopNqGrtbHMNjwjQQEL3R9o=;
        b=5i+g5bI8THJ9X21GMTkGGdgGq3XKLrtC1qbkTQrZ0FLTuj+hi4LzE00HzpzGzZI0yX
         8t6F08W39VAF0Rl172I0aqnYBeCeTK/vOrDgGQgODewKW/zkCBSx6y4JAD+zVnp4uOiT
         2aX8rGaPCIV+ynFa7PBATRA7x9szSfZu9yv91Nbd/z4Pw0QY9ZLqfvlkpZH6wQ3ElEx/
         rp65RfGJA/ZvAQ/haumnhK83yq/Wbi+6+H3T7FabelvRpILBLiM6fVK2F5axTcP6DW1j
         bCIuy66M44YAIMBs6da4sTuu5l2P/aspGAr6uSuvYcOcXXdprE7X9Nbey6fJTqaOR3id
         OlKA==
X-Gm-Message-State: AOAM531Wm7Nm6SCyu+m8OH5+wGSo6UV+htAnmH5eRuvTAIZWVW5NOf15
        tRPV39XjsnQm+MYqDZ9zp+SLw/G2NR2AniSlaqM=
X-Google-Smtp-Source: ABdhPJwKCzD8Rt5qit1gwag3Yzd6XxPW5CpF0ZA2+xx+dEK0So5xF+3/9NNczU849tHElw52wJ2ouSprPSX7g2wTnww=
X-Received: by 2002:a05:6808:2189:: with SMTP id be9mr11097293oib.93.1643395991750;
 Fri, 28 Jan 2022 10:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20220128173502.594099-1-colin.i.king@gmail.com> <6a5b1f8e-22a1-9c26-aea4-6bb38c4aa084@amd.com>
In-Reply-To: <6a5b1f8e-22a1-9c26-aea4-6bb38c4aa084@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 28 Jan 2022 13:53:00 -0500
Message-ID: <CADnq5_PxSH6e-QgN7_srR4w47WCNdXTp6VGNZz0=sXp-ivw4Mg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix spelling mistake: synatpics -> synaptics
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jan 28, 2022 at 12:59 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2022-01-28 12:35, Colin Ian King wrote:
> > There are quite a few spelling mistakes in various function names
> > and error messages. Fix these.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 32 +++++++++----------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > index 75b5299b3576..db4ab01267e4 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > @@ -539,7 +539,7 @@ bool dm_helpers_submit_i2c(
> >  }
> >
> >  #if defined(CONFIG_DRM_AMD_DC_DCN)
> > -static bool execute_synatpics_rc_command(struct drm_dp_aux *aux,
> > +static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
> >               bool is_write_cmd,
> >               unsigned char cmd,
> >               unsigned int length,
> > @@ -578,7 +578,7 @@ static bool execute_synatpics_rc_command(struct drm_dp_aux *aux,
> >       ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_COMMAND, &rc_cmd, sizeof(rc_cmd));
> >
> >       if (ret < 0) {
> > -             DRM_ERROR("     execute_synatpics_rc_command - write cmd ..., err = %d\n", ret);
> > +             DRM_ERROR("     execute_synaptics_rc_command - write cmd ..., err = %d\n", ret);
> >               return false;
> >       }
> >
> > @@ -600,7 +600,7 @@ static bool execute_synatpics_rc_command(struct drm_dp_aux *aux,
> >               drm_dp_dpcd_read(aux, SYNAPTICS_RC_DATA, data, length);
> >       }
> >
> > -     DC_LOG_DC("     execute_synatpics_rc_command - success = %d\n", success);
> > +     DC_LOG_DC("     execute_synaptics_rc_command - success = %d\n", success);
> >
> >       return success;
> >  }
> > @@ -618,54 +618,54 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
> >       data[3] = 'U';
> >       data[4] = 'S';
> >
> > -     if (!execute_synatpics_rc_command(aux, true, 0x01, 5, 0, data))
> > +     if (!execute_synaptics_rc_command(aux, true, 0x01, 5, 0, data))
> >               return;
> >
> >       // Step 3 and 4
> > -     if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x220998, data))
> > +     if (!execute_synaptics_rc_command(aux, false, 0x31, 4, 0x220998, data))
> >               return;
> >
> >       data[0] &= (~(1 << 1)); // set bit 1 to 0
> > -     if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x220998, data))
> > +     if (!execute_synaptics_rc_command(aux, true, 0x21, 4, 0x220998, data))
> >               return;
> >
> > -     if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x220D98, data))
> > +     if (!execute_synaptics_rc_command(aux, false, 0x31, 4, 0x220D98, data))
> >               return;
> >
> >       data[0] &= (~(1 << 1)); // set bit 1 to 0
> > -     if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x220D98, data))
> > +     if (!execute_synaptics_rc_command(aux, true, 0x21, 4, 0x220D98, data))
> >               return;
> >
> > -     if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x221198, data))
> > +     if (!execute_synaptics_rc_command(aux, false, 0x31, 4, 0x221198, data))
> >               return;
> >
> >       data[0] &= (~(1 << 1)); // set bit 1 to 0
> > -     if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x221198, data))
> > +     if (!execute_synaptics_rc_command(aux, true, 0x21, 4, 0x221198, data))
> >               return;
> >
> >       // Step 3 and 5
> > -     if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x220998, data))
> > +     if (!execute_synaptics_rc_command(aux, false, 0x31, 4, 0x220998, data))
> >               return;
> >
> >       data[0] |= (1 << 1); // set bit 1 to 1
> > -     if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x220998, data))
> > +     if (!execute_synaptics_rc_command(aux, true, 0x21, 4, 0x220998, data))
> >               return;
> >
> > -     if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x220D98, data))
> > +     if (!execute_synaptics_rc_command(aux, false, 0x31, 4, 0x220D98, data))
> >               return;
> >
> >       data[0] |= (1 << 1); // set bit 1 to 1
> >               return;
> >
> > -     if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x221198, data))
> > +     if (!execute_synaptics_rc_command(aux, false, 0x31, 4, 0x221198, data))
> >               return;
> >
> >       data[0] |= (1 << 1); // set bit 1 to 1
> > -     if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x221198, data))
> > +     if (!execute_synaptics_rc_command(aux, true, 0x21, 4, 0x221198, data))
> >               return;
> >
> >       // Step 6
> > -     if (!execute_synatpics_rc_command(aux, true, 0x02, 0, 0, NULL))
> > +     if (!execute_synaptics_rc_command(aux, true, 0x02, 0, 0, NULL))
> >               return;
> >
> >       DC_LOG_DC("Done apply_synaptics_fifo_reset_wa\n");
>
