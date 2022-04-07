Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA294F8493
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbiDGQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiDGQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:10:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D880A94D9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:08:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so6068100oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZc922TCkE49F8hGZOnYik1JaLOlZX3dBUSjrkm78qo=;
        b=ef8hjGCXAvHCiEwP6/S3w3yGSEbo8Mowe/AtutAkNNHKu0/c/vnFP35yO+oTCmSXzv
         7CcwjhjDaDUQBc7Qbw9hvKlzTLlSrsskExp4bs12YtSgM9cRoDazvi7w51bbpe2E0rvz
         sgOAHUj1aIDePV8roZ1gK6DDwg8Hj+hsfCHCn2tpUni/RrBz8aHMJfqUaJxl0T/pVaqa
         taEKsGaudGSREFpHiLeIaBB5n6PCsKOPnMBZPKbQSiz3myMpqjFk4NkCdq+VqC6Ld3HR
         a8Gvyp53Ju7Qiczm5KgjH4fBESrXXwgNmrWI/oAfbkInLUZM3JRJ1Y7hQiXTH1Ves/Fs
         OF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZc922TCkE49F8hGZOnYik1JaLOlZX3dBUSjrkm78qo=;
        b=zXUu36a05W7xjogNYMb6pPjzZ0YE1K2vO+DHktrfuFNPGkDt/GmQQk4sKr0F1QOE/y
         Eg4CAKrOBiNiq2a+FzDMCSg76OQj+ypBNqoIiy2ahE5HtM3HSUCbvfNOObFRKzh/GtZn
         EdHFue+uAEVXOt/1j36uDuz1cDMrWKnhX/CIHVSv4+t+VkmyCVDo8PPoPLRNmYEtdfXJ
         J3/mbHs+t8rEcqSO6joioQY2dNEMgouWzHP7iZW64tdUBVVtNujQ41CJSPr4yXRQwLqQ
         2+9royF1k54kw8wYegf+qM+J0qQ0fHJ108Arr7+B2NvBp7uFTNtjM3461TpWkWPtAF4f
         qbtA==
X-Gm-Message-State: AOAM531vzvK4Lam2ETOLicxEQv+6xxkd9Jvigy+Ago6DrJF2YiKeTEKz
        W0QfSUeiFVlN88bZtfvSmNDvzbunxs1nmIYXjPk=
X-Google-Smtp-Source: ABdhPJzIL4EpK3DQnR+LNMct9rhw7zo1YuFYfIGktjGBWN36b1ZLz75mvni1P6FT0iILO3UJhNrH8W9NdLLOwXv14oY=
X-Received: by 2002:aca:6006:0:b0:2f9:c685:f4e2 with SMTP id
 u6-20020aca6006000000b002f9c685f4e2mr317231oib.200.1649347678620; Thu, 07 Apr
 2022 09:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <1649311250-17077-1-git-send-email-baihaowen@meizu.com>
 <bb7635cf-461e-7abd-6092-4be67099c846@amd.com> <CADnq5_Ogke7XuVsQaB8pskreXam1ASTE2jna=U6iuKuuyR4r-Q@mail.gmail.com>
In-Reply-To: <CADnq5_Ogke7XuVsQaB8pskreXam1ASTE2jna=U6iuKuuyR4r-Q@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Apr 2022 12:07:47 -0400
Message-ID: <CADnq5_Phw7SvfdtX_RN7N4xEzceYpZLvRv971y3YyOdrg5Lz_w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix indenting mistakes in dcn10_hw_sequencer.c
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Haowen Bai <baihaowen@meizu.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Actually this just causes another warning.  Dropped for now.  More below.

On Thu, Apr 7, 2022 at 11:52 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Applied.  Thanks!
>
> Alex
>
> On Thu, Apr 7, 2022 at 10:18 AM Harry Wentland <harry.wentland@amd.com> wrote:
> >
> >
> >
> > On 2022-04-07 02:00, Haowen Bai wrote:
> > > Smatch reports the following:
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2174
> > > dcn10_enable_vblanks_synchronization() warn: if statement not indented
> > >
> > > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> >
> > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >
> > Harry
> >
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > index ee22f4422d26..3c338b85040c 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > @@ -2172,13 +2172,13 @@ void dcn10_enable_vblanks_synchronization(
> > >       if (master >= 0) {
> > >               for (i = 0; i < group_size; i++) {
> > >                       if (i != master && !grouped_pipes[i]->stream->has_non_synchronizable_pclk)
> > > -                     grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
> > > -                             grouped_pipes[master]->stream_res.tg,
> > > -                             grouped_pipes[i]->stream_res.tg,
> > > -                             grouped_pipes[master]->stream->timing.pix_clk_100hz,
> > > -                             grouped_pipes[i]->stream->timing.pix_clk_100hz,
> > > -                             get_clock_divider(grouped_pipes[master], false),
> > > -                             get_clock_divider(grouped_pipes[i], false));
> > > +                             grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
> > > +                                     grouped_pipes[master]->stream_res.tg,
> > > +                                     grouped_pipes[i]->stream_res.tg,
> > > +                                     grouped_pipes[master]->stream->timing.pix_clk_100hz,
> > > +                                     grouped_pipes[i]->stream->timing.pix_clk_100hz,
> > > +                                     get_clock_divider(grouped_pipes[master], false),
> > > +                                     get_clock_divider(grouped_pipes[i], false));
> > >                               grouped_pipes[i]->stream->vblank_synchronized = true;

@Harry Wentland should this last statement be part of the if clause or
the for loop?

Alex

> > >               }
> > >               grouped_pipes[master]->stream->vblank_synchronized = true;
> >
