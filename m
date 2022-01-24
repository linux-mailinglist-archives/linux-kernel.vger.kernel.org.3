Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBC349A80A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316056AbiAYCzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3410181AbiAYA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:28:44 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FAAC046E0E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:12:07 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s185so10999907oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNPdZuTMGpmraXauVfaM+U1iXWmXev7WNI2qlgKJIbg=;
        b=nRgyGzE6AxLpCKZz2UD75e4pkIds0FuUBfoftvvaRhjfZ3obN3fcNgGyXjDJ1FUNJK
         yscYMaxHJNoZuehn/9plEiPHQFli9uS+MiJVAsTYc7Y99J1X0VTPX8pwP4RMy6O9k6+4
         kmTz3t+nLjdXXoCfa5UIMs3JrxhHUwTvO/wnbllxBZHFWKvHFdDSqzYnYfi5wMKkIAko
         CwscV3NQuKIuyYsBpzRL4/W9WqMLcbHXkBfF3T4ehrmsnRXNvJKOjJxbrHMGClil0sQ3
         8cft5Kx4N+nlQwz/ypXl/Q62QRdHGpUMGu/LmmubbtqWbXziTQ6bDV7ZifJNxOpW95Qj
         qGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNPdZuTMGpmraXauVfaM+U1iXWmXev7WNI2qlgKJIbg=;
        b=jRBAHhZflViyEkTn+68Rs8MbOgj0tQfNiIhfloMubrrXQvcXlGUcEAaWUtHuuPwUST
         AlGxMFp/c4IS3HgJ/QlT9/AWkLb6OWdGbwl8Pt8+H6vmVL9qjNLIAtiBot4/dY56SE2/
         GwN4pNZ3m0K4gYAnULKYzzTiqmD+0PNFuEw2ogztWdvvoMDLg5LnjF0qU9acSI/O/24R
         kQz4y1oe+BDEZOvK6hIx/nwiGZMw8QCMrjCm8ARFFwPIDM004jp4nlniEdE8+Poe5eZ8
         NZjXSscFQz7fFzqul78CFxkl06Kh5M6c6AUyXzjWaf0djxWYUcJlHLJrL3fkYAhs5LtL
         sM1A==
X-Gm-Message-State: AOAM530HxcO0Xhsq22CDvvATUNMKOX6NuNBXOiGUTdzv0fUkfYyjmT9M
        9GpM2IwHWUzOwdUMQ4FJtG64DnXF9pYRDuVv/NI=
X-Google-Smtp-Source: ABdhPJyR03hrjLm79a0g6SkQdoHpkJeL3qMSV6vOsoHri99vsAcedey3FSY1h0XpwgmbhXH5wNFcoPGwNC5355tPXio=
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr3244011oib.120.1643062326701;
 Mon, 24 Jan 2022 14:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20220122012343.32540-1-rdunlap@infradead.org> <fca36168-d66b-c914-a5c6-fb8d495238ad@amd.com>
In-Reply-To: <fca36168-d66b-c914-a5c6-fb8d495238ad@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jan 2022 17:11:55 -0500
Message-ID: <CADnq5_OMhZ38b-N=UVC6ckcrzRkh=xBHEMe0UqP2DbqW6-g59Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: don't use /** for non-kernel-doc comments
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jan 24, 2022 at 10:25 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-01-21 20:23, Randy Dunlap wrote:
> > Change a static function's comment from "/**" (indicating kernel-doc
> > notation) to "/*" (indicating a regular C language comment).
> > This prevents multiple kernel-doc warnings:
> >
> >   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: Function parameter or member 'max_supported_frl_bw_in_kbps' not described in 'intersect_frl_link_bw_support'
> >   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: Function parameter or member 'hdmi_encoded_link_bw' not described in 'intersect_frl_link_bw_support'
> >   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: expecting prototype for Return PCON's post FRL link training supported BW if its non(). Prototype was for intersect_frl_link_bw_support() instead
> >
> > Fixes: c022375ae095 ("drm/amd/display: Add DP-HDMI FRL PCON Support in DC")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-next-20220121.orig/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ linux-next-20220121/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -4970,7 +4970,7 @@ uint32_t dc_link_bw_kbps_from_raw_frl_li
> >       return 0;
> >  }
> >
> > -/**
> > +/*
> >   * Return PCON's post FRL link training supported BW if its non-zero, otherwise return max_supported_frl_bw.
> >   */
> >  static uint32_t intersect_frl_link_bw_support(
>
