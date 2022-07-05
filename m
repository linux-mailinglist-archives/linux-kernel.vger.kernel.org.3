Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80E567269
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiGEPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGEPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:22:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5028E186FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:22:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ay16so22250526ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3kw5vLPMONRD7S5nAa5Acr9enRSFx2J1QfhaJiVIgE=;
        b=TIROAxwTY1iB5sL609Gl6MrUwmy3R8AXy0J1bpxcm9zICOP9DFZSzru39IUqURPuEK
         iTt90s3LIu9Xgk0P/KBSwYjx4cBdABieWvDEvSRK/u6OjlV8VHVvP+m8a1NxFluaZsrQ
         zXK4PS71s/Oc/OxkLMDh10TSMt3XGjw89fe9q85QNxdNW5OusF7mEU16kWjfoVEuPNTF
         LxIZA0e1sBao40mVDNpfLaQEXB9gduQJ5BduLdZavTm18whHvQ6Ht0O7KVJ5mjRVRL7C
         E1zSuyZ0S0YzPd/bx0IVszHwNLycOcZVwjEoOZfZl47tNYdJ0BhChaOy5K+ENK/byQsx
         Z9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3kw5vLPMONRD7S5nAa5Acr9enRSFx2J1QfhaJiVIgE=;
        b=sid2gYVS9pknkPKKGt/jJfXynaJsBqjyrT3FSw2GpYQ5qCZG6MtivOWNOErNoBqUw9
         FWHBQ8nT70epPNmJ+OROqz2CMN1FUr/UJpmDVa/grYKGvUmZlEHkXv23aYCW8LDd8OE0
         3oPsLh9mS6xD0ndayCXu8jM3vv6FmnBj+op1l19MuKRyTFAlxgpR7RCloq+ERapkDNNP
         PuX1dKmABh+CYjK4xXGz29L6xa/TzWovWWURRk1qpGR/87uyjOs2qrPYnNvWQJSOwEcE
         rezZAKnOfTVB96vrOt4BkZyRIyLP7tG60tbgQ49dhBGYxcgWbHrwCwfL6+qzc1TXAZ+E
         22kw==
X-Gm-Message-State: AJIora/3EenV5nm1Zd4zWygL0pZx+fIYxY22+ePpA1Etd7PfvRv+cFSx
        viQJkDn/h9aaZp4tgCb9y3v/9YYy+85OAL+ICLs=
X-Google-Smtp-Source: AGRyM1v4gB0anp60LYGJSv3NCpT4PwXU9pjtzc5CtQCfQqYHslGRV+JPypMsQXcndoEZi7DwxQ830AffeKk8osvxygM=
X-Received: by 2002:a17:907:2706:b0:72a:3216:96bd with SMTP id
 w6-20020a170907270600b0072a321696bdmr33656915ejk.658.1657034539799; Tue, 05
 Jul 2022 08:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220701091914.66476-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220701091914.66476-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Jul 2022 11:22:06 -0400
Message-ID: <CADnq5_PXiddTKAPs_0H83sOcr1UqxSkcA9E=gNAZsm4izXE=Bw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: clean up some inconsistent indenting
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
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

On Fri, Jul 1, 2022 at 5:24 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3151 commit_planes_for_stream() warn: inconsistent indenting
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 146fd4b864b2..d31da9c0256a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3148,15 +3148,15 @@ static void commit_planes_for_stream(struct dc *dc,
>                 else
>                         dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
>
> -       if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
> -               if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> -                       top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> +               if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
> +                       if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> +                               top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
>                                         top_pipe_to_program->stream_res.tg,
>                                         CRTC_STATE_VACTIVE);
> -                       top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> +                               top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
>                                         top_pipe_to_program->stream_res.tg,
>                                         CRTC_STATE_VBLANK);
> -                       top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> +                               top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
>                                         top_pipe_to_program->stream_res.tg,
>                                         CRTC_STATE_VACTIVE);
>
> --
> 2.20.1.7.g153144c
>
