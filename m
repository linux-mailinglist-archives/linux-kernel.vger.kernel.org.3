Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA654F841F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbiDGPyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbiDGPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:54:36 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9315C90D4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:52:34 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e1dcc0a327so6821645fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvj/6TWHlPE3u4x5qOj/MKYPFT6/Bmdp2X/t9e2Hd8Y=;
        b=CQDxXIvAORTaLH1lFp/KE84Zi+yDyH4SXv+XQEBC2Oyx8UdXxqtoLkVRDzoxXjT1Kl
         dvqd7S7bks2Rdp2q2GbnKtG5VbJ2SX8nPyMzRINh219Y9bvYBctWKRz1b5BB31xtcwMB
         QON9WWLgNfulPIpzzC2zVFMqo1k0IQQdzWDYQPJf/EiJkXgRImm0ORmd8ss6D6VbNFuj
         CM5IjjUdfZyCTfnlUOzQtoirtV6/kO7mWKoILCl4hu+IQtXxkzK0ioMpEKo/iZc6aXVt
         t5kCQOZE7FgPfPwYoeEKQJ0QuOB5wRr+48mzpcCXM1MxbDNBSjPKcJspb87V4VIPkWuL
         PhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvj/6TWHlPE3u4x5qOj/MKYPFT6/Bmdp2X/t9e2Hd8Y=;
        b=RF/lNbimrfoBvb3sgvn8ejuUj9PLMII09qgeCor5JE2JKwRU6dQSjEepePyuy1JmWJ
         cuKJcZUboSyk1RVtEDfZ9QSVCRwC4/l8hZnXCiWqJSeNsCY+iucqHJAw7uU1IbWuIvsR
         1OkAcVcNptJflp9p8I1VrXUHBkHzjROJ+kNlfUvy8EKgF4HDwviaoa+CMWBYAWng3irN
         jBI8KhciendRd6KHEMOgFXvMoWWpxnswHuuZxTcOSLgnZJkeuJ8KKLHU1FgaR8XXPdGM
         2bb9vrlwYP1HSld9Ty7vVFI69rL6Rs3amWLiuUg0nEBll5qwDQXIhJQMa8ey5ShJ7e8v
         Vd+A==
X-Gm-Message-State: AOAM532RFB71cHGfB3D9x2LGcc96Hf4DVDabsuF6smLaVlgvXTx/g6SL
        NkIwkY8Rvrxu2YWPzhh2lI5xQDHoG/uo/wmL2J2Cv0XH
X-Google-Smtp-Source: ABdhPJwbVKatWleKRKuoYIdjXNJJqi8U/WypflC2hMRpEw7pq07icfUzlhwiLHyArNuGU+u+cXNZZrxQTtUk2cOd5tY=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr6162010oaa.200.1649346753856; Thu, 07
 Apr 2022 08:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <1649311250-17077-1-git-send-email-baihaowen@meizu.com> <bb7635cf-461e-7abd-6092-4be67099c846@amd.com>
In-Reply-To: <bb7635cf-461e-7abd-6092-4be67099c846@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Apr 2022 11:52:22 -0400
Message-ID: <CADnq5_Ogke7XuVsQaB8pskreXam1ASTE2jna=U6iuKuuyR4r-Q@mail.gmail.com>
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

Applied.  Thanks!

Alex

On Thu, Apr 7, 2022 at 10:18 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2022-04-07 02:00, Haowen Bai wrote:
> > Smatch reports the following:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2174
> > dcn10_enable_vblanks_synchronization() warn: if statement not indented
> >
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > index ee22f4422d26..3c338b85040c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > @@ -2172,13 +2172,13 @@ void dcn10_enable_vblanks_synchronization(
> >       if (master >= 0) {
> >               for (i = 0; i < group_size; i++) {
> >                       if (i != master && !grouped_pipes[i]->stream->has_non_synchronizable_pclk)
> > -                     grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
> > -                             grouped_pipes[master]->stream_res.tg,
> > -                             grouped_pipes[i]->stream_res.tg,
> > -                             grouped_pipes[master]->stream->timing.pix_clk_100hz,
> > -                             grouped_pipes[i]->stream->timing.pix_clk_100hz,
> > -                             get_clock_divider(grouped_pipes[master], false),
> > -                             get_clock_divider(grouped_pipes[i], false));
> > +                             grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
> > +                                     grouped_pipes[master]->stream_res.tg,
> > +                                     grouped_pipes[i]->stream_res.tg,
> > +                                     grouped_pipes[master]->stream->timing.pix_clk_100hz,
> > +                                     grouped_pipes[i]->stream->timing.pix_clk_100hz,
> > +                                     get_clock_divider(grouped_pipes[master], false),
> > +                                     get_clock_divider(grouped_pipes[i], false));
> >                               grouped_pipes[i]->stream->vblank_synchronized = true;
> >               }
> >               grouped_pipes[master]->stream->vblank_synchronized = true;
>
