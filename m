Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356FE5267B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381661AbiEMQ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiEMQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:57:44 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3AF1408E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:57:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id m6-20020a05683023a600b0060612720715so5348210ots.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7inaUSclrf0VoHqtvyXb/+X2/367hf5aKqzQDTPP0w=;
        b=dmrJnjeUII3S5RbtkSzGhvHYK+zHcs0jNahICu8kyZal4PwidiPCR8MXTLSss19D9e
         xaSsvyZmh9pAVCzBKCjqPupfbsCBVc4oD8fiZIY78PAdar7S2x1o6H2dQN/PHuS4/+Ge
         mFf/j+mmuCNN776nELbHkivXdWsaqtFw5q8tbEST9hUvoOyEawC1CHHbtFCwOFetptVl
         nsOJviRovcwSWCHChEFQDxCGlhU67YZ8JQgbUhkEovWbK0Ddj2tTMyBXE6VH/NXsjPil
         28y376u5hCKOEkhz4pdKFUgpTomLaMmumQF9GVYcwQ+IJkp6nH+CJzIXNgWLODambtnD
         oWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7inaUSclrf0VoHqtvyXb/+X2/367hf5aKqzQDTPP0w=;
        b=RoZAFazF5Z6ag0ZqXuisDfeNfKvCsGmR14iky6UGx8hk8X9IYdW1nvGJzw0lTEZK0b
         FPspXiFRBiR9JfK7ExASSv+FXclFUaktbBcXcvwxsgxjiJHjTuGuMB4HKV+GANv/dWz0
         AKJFzr7wonP+16WXkUzNGanIjWtCESIY9kJRiKwCeEuP2mCyOnjUGKBE44UI01zexjSe
         x1dUG4LX5/0tOQi/ooYT39C+M2l+5UpX7en6pVthHXJsVxtAxHst8iAnqXQmK5ped3hp
         96zN/dEc0EXnjLksoupC7qAyKBknff/FUbcctNXGfPGKwvUcrzcQZGa/FMlDevwGiUTl
         ikdQ==
X-Gm-Message-State: AOAM530DRNUQyN7+BFe7xk3fBnQmmK+4f4MXK5iaGIfxaqCzwJ2J0bEi
        FCXSICN+p8zuUd13eTveweEFNyTALkxf3o2PBi8=
X-Google-Smtp-Source: ABdhPJyS8xlu00GejRMagYrsXXjuTB9+4YR4559CIPKjUVksi4LMvOtB1f54GGhUBnv4wW2Tf1tGLa/KctH0vmH00ek=
X-Received: by 2002:a9d:195:0:b0:605:eb43:5b84 with SMTP id
 e21-20020a9d0195000000b00605eb435b84mr2216769ote.357.1652461062958; Fri, 13
 May 2022 09:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220512071934.119922-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220512071934.119922-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 May 2022 12:57:31 -0400
Message-ID: <CADnq5_PvrX_C96=PDk-+hk_BzqtLZ8LvUqWtLKb0gm30Y-s8Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up some inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
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

On Thu, May 12, 2022 at 3:19 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9687
> amdgpu_dm_atomic_commit_tail() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e2b57cf6506c..a92cfb055c15 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9681,9 +9681,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                 dm_enable_per_frame_crtc_master_sync(dc_state);
>                 mutex_lock(&dm->dc_lock);
>                 WARN_ON(!dc_commit_state(dm->dc, dc_state));
> -               /* Allow idle optimization when vblank count is 0 for display off */
> -               if (dm->active_vblank_irq_count == 0)
> -                   dc_allow_idle_optimizations(dm->dc,true);
> +
> +               /* Allow idle optimization when vblank count is 0 for display off */
> +               if (dm->active_vblank_irq_count == 0)
> +                       dc_allow_idle_optimizations(dm->dc, true);
>                 mutex_unlock(&dm->dc_lock);
>         }
>
> --
> 2.20.1.7.g153144c
>
