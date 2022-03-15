Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C04D9F29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbiCOPvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349762AbiCOPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:51:44 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C93F541B9;
        Tue, 15 Mar 2022 08:50:31 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so24925173oot.11;
        Tue, 15 Mar 2022 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz6iB+JIu3yJYB4hqkWbRgwU/6tHLowf4D8LoA0UiMw=;
        b=TEgQpnrWDc42J4tF0pQgCnTLq0H6A9/UzGwgZHtFi41RTPbMqg47bgBSG90lUlObUs
         ukznRNm+2cUYPvHhMkeg6MZcBPxDsQFKRaLwDOwDh+ewmeGwTZ3inz0O8T2F0Ze6LWm6
         QFZgBt1MptFnCfuUzXf6LoFz0aMZmpG199g8IsMHYWnrNvSD4WhAG99utpAthyc+9goQ
         LTJxDnKNP6yDsjxhYrRQpRAoiEZSxs7+S7CRWrP6S3L4z73qrWebPTQtK3a64ynL/i92
         DwF5sfRRJNoqKHBw7PWBSL82GPxeCz0IZACZkZZzo4p8AmxlObwmlEHiFBp938rnsOwM
         Y0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz6iB+JIu3yJYB4hqkWbRgwU/6tHLowf4D8LoA0UiMw=;
        b=AB7y2FMF+ebfLNhQlVhs7vIK7kXjvtky+xjOZyK1cCDicPPgF334nAZFlQFDMGPqlO
         pSGx3iOKpBK3A4cQVhuj61e496U4X54y5zWMR1Ob7Qmtqnet225Bsdo39iIwN7b0qj5U
         8GV8VbvPU6O8BL0GQbSWY8L/VUGc+lYHrarq1xCqV7QvxkxK7qS8EklkBttAe5H/lJaZ
         F09ADXffH1H2xuL22zKCacK/4LaCxqoZVGURWoHFZMJQeh5PQsaRKncVmkXct7nckkDb
         9JepZdKN4SZCDR9+4zPA8RouiTJoWPf23mCzJGxM0RZx9CtutoQU4bZhMB+XdWpZpmCe
         1s2w==
X-Gm-Message-State: AOAM532tn1vgKbLt7keStMGqlNru1WyYXt8gBdatyV5Fnrs/erQXAta9
        CLjo2ZNVYQeh0/rP7+AlzD4WGzkzu6bTrSE0VUsJ/GH8
X-Google-Smtp-Source: ABdhPJw7QSRbDRqTG+6Ui/vWDvMRavfyAT4JEfkuFfTtnQk5gqxtvGs/iiAAzRMmyjzdBv7fgSI5YeVaINK7RgsXysc=
X-Received: by 2002:a05:6870:630c:b0:da:b3f:324d with SMTP id
 s12-20020a056870630c00b000da0b3f324dmr1819828oao.253.1647359430402; Tue, 15
 Mar 2022 08:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-30-Julia.Lawall@inria.fr>
In-Reply-To: <20220314115354.144023-30-Julia.Lawall@inria.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Mar 2022 11:50:19 -0400
Message-ID: <CADnq5_O_YRtkZz5s3mkdVa24THYqMTZPZFVsQpS-+T_cDttj4g@mail.gmail.com>
Subject: Re: [PATCH 29/30] drm/amdgpu: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Mar 14, 2022 at 8:01 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index fe660a8e150f..970b065e9a6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -340,7 +340,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>         if (free_vram >= 128 * 1024 * 1024 || free_vram >= total_vram / 8) {
>                 s64 min_us;
>
> -               /* Be more aggresive on dGPUs. Try to fill a portion of free
> +               /* Be more aggressive on dGPUs. Try to fill a portion of free
>                  * VRAM now.
>                  */
>                 if (!(adev->flags & AMD_IS_APU))
> @@ -1280,7 +1280,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>                         continue;
>
>                 /*
> -                * Work around dma_resv shortcommings by wrapping up the
> +                * Work around dma_resv shortcomings by wrapping up the
>                  * submission in a dma_fence_chain and add it as exclusive
>                  * fence.
>                  */
>
