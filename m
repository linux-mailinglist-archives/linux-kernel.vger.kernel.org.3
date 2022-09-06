Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F05AF004
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiIFQMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiIFQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:11:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80E21CFE0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:36:39 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so8303670oti.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kyc7bxuF/MOj4opkZXlh6NcWSth9xN0XkkZ0B/cEQGs=;
        b=aPElF2JldDnBC7r0QU1r4YqTBzxi2E4Q+DePT5N4FZfXUjybW3gTHevWTih1Sxst5j
         j3CcULe1Z4zxdebOiynDpLujPn7dbNCyvtXNHKfD5SPYusRNkZjqxY51bPnBtpM8RD9k
         4z3Slm40kj7NPPo87I1rq/tbnTT/36X3LJB159Wo5KFoOsDyVhNia5gQig0GicvbMo1n
         0eBQrvtdnim1M14PT935GahpuNCpCYeVWBRoSME9N469Ky+tx8Oclgl5iMPPk1fhBayl
         nq97AAAHm7iZKThwREBRee6gGWL6tW672lhUfhho/KURrn8x/QfMo7LA/1442XRDi6gC
         eWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kyc7bxuF/MOj4opkZXlh6NcWSth9xN0XkkZ0B/cEQGs=;
        b=7wM1f4qySi9CBEZQSoDZbwXoWWCV4UafAs11QwUWQ2jwKZqwkjAh0ejVVMAYz7hgdM
         3wVieS/7an4US0F+A65TpnAo7pg5EU4PBtHfAagmzlb/Oqhu92WG6j3STqZl+yRKyv14
         3A1G5p/VmlnixOy4wvNxtVBOevhDgc2dC/VD4ZpVgu/IrOEtROzt0eybyxC1enCXdCU/
         bMuHkfqLzPduLppG3dWoZtIkHp80hHMipLH4rhdx4FSfwRKkx0acVIE7LOq8/FLcWzWP
         Tk4x8mF+/9NIrjQUE5rLOcsBRPiikMdwLwZOxfSphxZEE5wrDCE3iaEYoRrxAd61zkCX
         eZUQ==
X-Gm-Message-State: ACgBeo2Vyoy3rJQrNuNoiuZyv49nfeMbNPL5au3QczkutMkuoBrmw96S
        YUh93+VJtM6Mftj2yuNhW1HppZL9JCorOQkq5TU=
X-Google-Smtp-Source: AA6agR4d09ZClAbs2F8gPL7mf8Lj8ehTZw1MEqdDLPyjccmMTPR9TlMlFFr+EVa8i9RdU3LT7nA7EEVfBeH4NEyepuM=
X-Received: by 2002:a9d:6ad7:0:b0:636:f76b:638a with SMTP id
 m23-20020a9d6ad7000000b00636f76b638amr22585680otq.233.1662478599143; Tue, 06
 Sep 2022 08:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220905073922.22738-1-jingyuwang_vip@163.com>
In-Reply-To: <20220905073922.22738-1-jingyuwang_vip@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Sep 2022 11:36:28 -0400
Message-ID: <CADnq5_OeOy-X=FX19SFn+XaT0X_DAOPgf3i4cfdHUzS813H_=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: recleanup coding style in amdgpu_fence.c
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        andrey.grodzovsky@amd.com, ray.huang@amd.com,
        Hawking.Zhang@amd.com, Likun.Gao@amd.com, Jack.Xiao@amd.com,
        len.brown@intel.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Sep 5, 2022 at 3:40 AM Jingyu Wang <jingyuwang_vip@163.com> wrote:
>
> Fix everything checkpatch.pl complained about in amdgpu_fence.c,
> modified use "} else {", sent it again, thx.
>
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 8adeb7469f1e..0759d86d92da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  /*
>   * Copyright 2009 Jerome Glisse.
>   * All Rights Reserved.
> @@ -42,7 +43,6 @@
>  #include "amdgpu_reset.h"
>
>  /*
> - * Fences

What is the point of this change?

Alex

>   * Fences mark an event in the GPUs pipeline and are used
>   * for GPU/CPU synchronization.  When the fence is written,
>   * it is expected that all buffers associated with that fence
> @@ -139,7 +139,7 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>   * Returns 0 on success, -ENOMEM on failure.
>   */
>  int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
> -                     unsigned flags)
> +                     unsigned int flags)
>  {
>         struct amdgpu_device *adev = ring->adev;
>         struct dma_fence *fence;
> @@ -173,11 +173,11 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>                                        adev->fence_context + ring->idx, seq);
>                         /* Against remove in amdgpu_job_{free, free_cb} */
>                         dma_fence_get(fence);
> -               }
> -               else
> +               } else {
>                         dma_fence_init(fence, &amdgpu_fence_ops,
>                                        &ring->fence_drv.lock,
>                                        adev->fence_context + ring->idx, seq);
> +               }
>         }
>
>         amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> @@ -393,7 +393,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
>   * Returns the number of emitted fences on the ring.  Used by the
>   * dynpm code to ring track activity.
>   */
> -unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
> +unsigned int amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
>  {
>         uint64_t emitted;
>
> @@ -422,7 +422,7 @@ unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
>   */
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>                                    struct amdgpu_irq_src *irq_src,
> -                                  unsigned irq_type)
> +                                  unsigned int irq_type)
>  {
>         struct amdgpu_device *adev = ring->adev;
>         uint64_t index;
> @@ -594,6 +594,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>
>         for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>                 struct amdgpu_ring *ring = adev->rings[i];
> +
>                 if (!ring || !ring->fence_drv.initialized)
>                         continue;
>
> @@ -772,6 +773,7 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
>
>         for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>                 struct amdgpu_ring *ring = adev->rings[i];
> +
>                 if (!ring || !ring->fence_drv.initialized)
>                         continue;
>
> @@ -845,6 +847,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
>                                                   reset_work);
>
>         struct amdgpu_reset_context reset_context;
> +
>         memset(&reset_context, 0, sizeof(reset_context));
>
>         reset_context.method = AMD_RESET_METHOD_NONE;
>
> base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
> --
> 2.34.1
>
