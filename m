Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F74479883
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 05:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhLREBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 23:01:52 -0500
Received: from mx.ucr.edu ([138.23.62.67]:44713 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhLREBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 23:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1639800111; x=1671336111;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=/VVCqZDQO03dzWiJK64rx87Z42N8S970ztCyWoWKxH0=;
  b=rGVJbuGO89WDPYV8nGxcS2HIHA3G6LRkwUViyggMjjDlPsiaTWchjFMG
   Uj2806nu9NRpxpJzJJvR5jkUl964V1ldRpZO+jBrCs738W3l9SsBbJzut
   j3fQI+cD6h1AqKlmBB5146awIveblKzMutCBLwS5hU/tcn8HqF98sWLCI
   yyPNsA3nAFP5GJM93HWQ1fMPZlh4OVczkDccq3Z00wswapqmCusAtPbx9
   K0Ee6bnMSeC7CX65GYxMCqsD6tr9AUB2EdaQpWWocrjQAD1Y1Ga4LUNmZ
   q9fTJLe39fpODG3FUVs2ciMfpIvUny2+S2+DHk7XPi2v9dJ8r8tg0cT/J
   A==;
IronPort-SDR: qu2oj2BWJwdu+kd+tfzSxk7iE+5y447D2lo6fbxmUm0dSdUPvyieNWmnT0EDqhUY6Q+fcgj69H
 ml7FS/NbONm+fatp9dmboWkHuSRL7ssBsMN0fO5O8bVFgyGiSGvedMnCShT+ygSVTAprTaVgpc
 5unc8REH3ElgYYlk6i+oFdr1KoktVeOfv4J3G7sg+MVVWYKSVh6J06QPqdNEWG2clY1v9l0K+g
 qo7MgOwqAyIW815HKzL9UApyl4g4aPbnfLxl/ry+Ek0hEdOL8eOxPknHV9yAhZuxD2oHBm3tnw
 Oaez1QaIoxvGY4KphynhIwo/
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="263265803"
Received: from mail-yb1-f198.google.com ([209.85.219.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2021 20:01:51 -0800
Received: by mail-yb1-f198.google.com with SMTP id i187-20020a2522c4000000b006093b616e65so7066201ybi.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 20:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lxy7tam3G965VJ+yVFHi/Lwb6UbeZwM4+7surRJM9Y=;
        b=njHTQAfUCl+25gpnFfB2B2YAaly9Uab9QzuXaxwgaSIcyEY/GJitKzSJMTAn22UAmO
         C7tZ7ebJpzcZUl8AdOcZpu7TrgqqYWdlnEVHpLLfNbL0Jzfmued1MoicQpLyZ2YMPGk8
         RuS2dAgysaUVDknPGc/035cQzjaDpuyGCJo40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lxy7tam3G965VJ+yVFHi/Lwb6UbeZwM4+7surRJM9Y=;
        b=JQOOSI2wn47nIiSnxTCJQUzvgZ26g7FX8seOF46ryOme+VmLxj/g1OLmCgqznbByRl
         J4dFiWIISkX4UMLpt3ziOtvdEBLfc1qAYDfnO93A1LsTGfnsoGt/SxEP5daLTKtrtyuZ
         Qlf4zpEMwqswJOQBQdAP2oRfsLS/toPgb4rNAnwIP5i5LcyPfQyYXAa0oFSmJ22/aCYS
         Po4mIsNBHqEV235qhUdwwiCjUW/utrkcypJ0HU1M6uCjsKBBh0exRfS4wFFM69FngwKg
         0oDBfM9cpDYBw3vFjY5liunc/Vgq4JglrCqoAbEJnMc8lrPZOKKeVup4hDByKlcLtCI5
         i0eQ==
X-Gm-Message-State: AOAM533skmKsd014SJZLzT7H5Da3+czA1YFGUXylvVUlsdGXlcC7ZuQH
        Ape9OK9A1BSZgcmxbolpUHM1X2L4Ny4z2sp7/wlYgYvZspv0mYl0EUSXIQHRl7x8xAXQIlmIJFy
        me6j0ilBApSW7dlt+Sie8PXv9Wd76OMLwANHcpW2j2A==
X-Received: by 2002:a25:d188:: with SMTP id i130mr9136804ybg.475.1639800109230;
        Fri, 17 Dec 2021 20:01:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyb7TYo+RtQKFAc8gUdrgaAtdVg+syE3D6jWsnLVF1eU8K2KyI+1hocLp5CTYT5pHGjaTzbwOyyPUBHKF3R56s=
X-Received: by 2002:a25:d188:: with SMTP id i130mr9136784ybg.475.1639800109031;
 Fri, 17 Dec 2021 20:01:49 -0800 (PST)
MIME-Version: 1.0
References: <CABvMjLSXpg00KKkqXH35C7Op0xC3mPaOAhj_xbAOEXL_4Ys_aw@mail.gmail.com>
 <52f808a3-7e2d-7ae2-ca62-400137a0b92f@amd.com>
In-Reply-To: <52f808a3-7e2d-7ae2-ca62-400137a0b92f@amd.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Fri, 17 Dec 2021 20:01:38 -0800
Message-ID: <CABvMjLRUy40yq76S3qggCmKNKvQ3+njNX5XqgsuGzgp4S=XoEg@mail.gmail.com>
Subject: Re: Potential Bug in drm/amd/display/dc_link
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harry:
Thanks for your feedback, I will submit the patch for variable
"old_downspread" in the function enable_stream_features().
And I double checked the code in the mainline and found that the buggy
function wait_for_training_aux_rd_interval() has been removed, and the
corresponding bug has been fixed in v5.1-rc1 by a memset. Sorry for
the confusion.

On Thu, Dec 9, 2021 at 2:30 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
> On 2021-12-09 03:02, Yizhuo Zhai wrote:
> > Hi All:
> > I just found a bug in the cramfs using the static analysis tool, but
> > not sure if this could happen in reality, could you please advise me
> > here? Thanks for your attention : ) And please ignore the last one
> > with HTML format if you did not filter it out.
> >
> > In function enable_stream_features(), the variable
> > "old_downspread.raw" could be uninitialized if core_link_read_dpcd
> > fails(), however, it is used in the later if statement, and further,
> > core_link_write_dpcd() may write random value, which is potentially
> > unsafe. But this function does not return the error code to the up
> > caller and I got stuck in drafting the patch, could you please advise
> > me here?
> >
>
> Thanks for highlighting this.
>
> Unfortunately we frequently ignore DPCD error codes.
>
> In this case I would do a memset as shown below.
>
> > The related code:
> > static void enable_stream_features(struct pipe_ctx *pipe_ctx)
> > {
> >      union down_spread_ctrl old_downspread;
>
>         memset(&old_downspread, 0, sizeof(old_downspread));
>
> >     core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
> >                          &old_downspread.raw, sizeof(old_downspread);
> >
> >         //old_downspread.raw used here
> >         if (new_downspread.raw != old_downspread.raw) {
> >                core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
> >                          &new_downspread.raw, sizeof(new_downspread));
> >         }
> > }
> > enum dc_status core_link_read_dpcd(
> >     struct dc_link *link,
> >     uint32_t address,
> >     uint8_t *data,
> >     uint32_t size)
> > {
> >         //data could be uninitialized if the helpers fails and log
> > some error info
> >         if (!dm_helpers_dp_read_dpcd(link->ctx,
> >                link,address, data, size))
> >                       return DC_ERROR_UNEXPECTED;
> >         return DC_OK;
> > }
> >
> > The same issue in function wait_for_training_aux_rd_interval() in
> > drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>
> I don't see this. Do you mean this one?
>
> > void dp_wait_for_training_aux_rd_interval(
> >       struct dc_link *link,
> >       uint32_t wait_in_micro_secs)
> > {
> > #if defined(CONFIG_DRM_AMD_DC_DCN)
> >       if (wait_in_micro_secs > 16000)
> >               msleep(wait_in_micro_secs/1000);
> >       else
> >               udelay(wait_in_micro_secs);
> > #else
> >       udelay(wait_in_micro_secs);
> > #endif
> >
> >       DC_LOG_HW_LINK_TRAINING("%s:\n wait = %d\n",
> >               __func__,
> >               wait_in_micro_secs);
> > }
>
> Thanks,
> Harry
>
> >
>
>
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
