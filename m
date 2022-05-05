Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7551B5DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiEEC1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiEEC1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:27:02 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD94B87C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:23:24 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-ed9a75c453so3013569fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3ItVx1AlgQz9xrG3sUVb2odNuGC9onNLhKh26bH4o0=;
        b=nqO9L2ccR2RLv0hwu7Of1bMPd1ToYdb0OEmTNEdEXWBBQWWrawL5nsIcTfe7LHb8rk
         XgqmKSrJuZbBKIOQDX45VSItS592sCDghequZ1qAlJmU9Clu1OZ6+oCtugZLex8ADpz3
         NXe5rNZQlEtA7Sw/KGoatTdL8Egct9qIxptDzk/2kqUizNV5NMZYtq+ZXhwzpbXHSfUm
         JnXcUYoQdez9wkcQm573XA8sLUCgCBXZtSOKDQEn3Ka7c0x9DuLx05KfOCyi7xNoQOuZ
         dWlhsjjy6e9g/ti7uTyFr/djsXjmgf8dSERB2FWDic5SpEstVrFuzbb0ZnrKdSWUmRcq
         D2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3ItVx1AlgQz9xrG3sUVb2odNuGC9onNLhKh26bH4o0=;
        b=E0UtQKQHOBKTy3RILwHPWz0fw9Be9QQWwQfOqcTbDVQgvPojM3oAC/BZDMgr81XTWL
         pvgLwTKGyanDgfitg2fDeKjNwU/CEN2UQ4/GdIzI9sDIotAStDDXV5of/agh+QZH6a2U
         ueBnAc7E7zH0Z96AKx6NJIfKloptZAw6zsaWQ8gVt+2pn0+NBeIOtJjo+9ium2b50XcH
         ly7X1AzPfXhFAKvUqEMd8hpnRY3IlaCW0ftdI2BlMBwrp308rdUZ3EiKqm5r3zCDD/4y
         bSUbtdy8AdwitybjZDiFuLaWK1JImAaDTIR9Q1hQAqS2B2lOmhA1xbai275GjDwh0scH
         Z7Wg==
X-Gm-Message-State: AOAM5302wyRLnoIFfpbujoWYS/y/mwMekbl6nDa3naF9h2xiVChVJV1m
        YVeuwbYK/DA4YAiZaejzInHPJrFBSPshxvFwCOc=
X-Google-Smtp-Source: ABdhPJxi2y6RMZ/DLsjgBCaLyfBSFPZir8BNrMgCe9x6p7v8seLLkdib9jOl2z7FHT9uGxCW8VAhJpM6K4D0fMy4Pdg=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1186962oaa.200.1651717403721; Wed, 04
 May 2022 19:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220505021057.54044-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220505021057.54044-1-chi.minghao@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 4 May 2022 22:23:12 -0400
Message-ID: <CADnq5_MQRLDUD_XzHOBw=xBudLrHLbp4qGnYe-pTPouvGLD5sA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify the return expression
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Zeal Robot <zealci@zte.com.cn>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
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

On Wed, May 4, 2022 at 10:11 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Simplify the return expression.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 54446162db8b..3d8093bf1679 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4688,7 +4688,6 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
>  static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
>                                    int me, int pipe, int queue)
>  {
> -       int r;
>         struct amdgpu_ring *ring;
>         unsigned int irq_type;
>
> @@ -4708,17 +4707,13 @@ static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
>         sprintf(ring->name, "gfx_%d.%d.%d", ring->me, ring->pipe, ring->queue);
>
>         irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
> -       r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
> +       return amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
>                              AMDGPU_RING_PRIO_DEFAULT, NULL);
> -       if (r)
> -               return r;
> -       return 0;
>  }
>
>  static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>                                        int mec, int pipe, int queue)
>  {
> -       int r;
>         unsigned irq_type;
>         struct amdgpu_ring *ring;
>         unsigned int hw_prio;
> @@ -4743,12 +4738,8 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>         hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
>                         AMDGPU_RING_PRIO_2 : AMDGPU_RING_PRIO_DEFAULT;
>         /* type-2 packets are deprecated on MEC, use type-3 instead */
> -       r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
> +       return amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
>                              hw_prio, NULL);
> -       if (r)
> -               return r;
> -
> -       return 0;
>  }
>
>  static int gfx_v10_0_sw_init(void *handle)
> --
> 2.25.1
>
>
