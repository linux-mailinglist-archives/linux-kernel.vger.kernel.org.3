Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73F531863
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiEWURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiEWURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:17:06 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66C6941AA;
        Mon, 23 May 2022 13:16:56 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e5e433d66dso19847230fac.5;
        Mon, 23 May 2022 13:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=039/Q2AZDShC4cyR0ddlH/eUG3odzlEnwcuXrDMGe4g=;
        b=ozdSJJMUIKWXk58MINckgl2jY3Z70UCArhlPG8akBVn45Lo1OKbzhd+iiYTQgxgSov
         ttTLYVO422DGVP6TIA4i9bUQBs5/7JdzC3dRQG0sXHQi4PlhyOLmRvjkcdy1OJs3F/A6
         Zj8bx6wJDHfGS6hEHmgv2drWd4mphIk8dTMhCdJ0yi2fh9CCWlyHS1hHK9ZdyqmSpJuy
         vEbpb+MNTAgOj3yHkpuw8kEJMDHrtlMeBs/ve0ejcAbFRFGGUCDeElzbTxViEoz/z/PZ
         uhfBKKWWALl1+PfA4XOANV8E4H54v5kXIPBLeUAmsB3yS11kLTm1r84BSI6jXTy7SDXx
         XGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=039/Q2AZDShC4cyR0ddlH/eUG3odzlEnwcuXrDMGe4g=;
        b=KJnXiwPbhz9bdAnYcbWhxvDtDbhPR1YK/J9E/YXl/i4c94JkoUsHQAFKWgO+LOpT/7
         R/W+8iav3FtBiS1EdINO6VcXrx5qgCFAqdCeG3rb4ETWbFWFdroYPWhrBfUS2rgDOnyd
         KBhELMJDB3OWTbrFxE35i3eCOqOHeynzDnEURd5OX8oPRQxMAYbi19LnfyPKArCJhuP5
         N4TAdaP3uvSoqCII+26SUQo1MCjzIVgGbRVC1cQDQYmwoBb4ouOPoVyTXbzEjROIkVlv
         jNxELJcONFzhqxHx8mBbnmJ4HDRbq5wYQ473t1mRWaNT3kQm7rge/dr461ZV1V1eu4GO
         xKgw==
X-Gm-Message-State: AOAM530l3XfsJanxINypY0pfZ+39iPIeKqMN+JMdFAa0LHmoKlzFjWIV
        hVnds4IhjsnR28hvUYxTgdzvrvxF48N77m8gtKg=
X-Google-Smtp-Source: ABdhPJxfyiY9/f8uwqjjKiNK+axja1wE9SKzm/To6uvgNb57tvVlaqYEVifVWkoHs8ZnkdFpD7+KqQu3lp9PzJiBG0M=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr460362oap.253.1653337015741; Mon, 23 May
 2022 13:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220521111145.81697-64-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-64-Julia.Lawall@inria.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 23 May 2022 16:16:44 -0400
Message-ID: <CADnq5_POfEC8QgmbhR0UXZfHfYehUkLN8yMTjZ-vjARbpw+hZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: fix typos in comments
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

On Sat, May 21, 2022 at 7:12 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Spelling mistakes (triple letters) in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |    2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  |    4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 02754ee86c81..c5f46d264b23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5111,7 +5111,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>         mutex_unlock(&adev->srbm_mutex);
>
>         /* Initialize all compute VMIDs to have no GDS, GWS, or OA
> -          acccess. These should be enabled by FW for target VMIDs. */
> +          access. These should be enabled by FW for target VMIDs. */
>         for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>                 WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>                 WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fb9302910742..7f0b18b0d4c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3714,7 +3714,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>         mutex_unlock(&adev->srbm_mutex);
>
>         /* Initialize all compute VMIDs to have no GDS, GWS, or OA
> -          acccess. These should be enabled by FW for target VMIDs. */
> +          access. These should be enabled by FW for target VMIDs. */
>         for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>                 WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>                 WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
> @@ -5815,7 +5815,7 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>                 /* wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
>                 gfx_v8_0_wait_for_rlc_serdes(adev);
>
> -               /* write cmd to Set CGCG Overrride */
> +               /* write cmd to Set CGCG Override */
>                 gfx_v8_0_send_serdes_cmd(adev, BPM_REG_CGCG_OVERRIDE, SET_BPM_SERDES_CMD);
>
>                 /* wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index f12ae6e2359a..5349ca4d19e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2535,7 +2535,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>         mutex_unlock(&adev->srbm_mutex);
>
>         /* Initialize all compute VMIDs to have no GDS, GWS, or OA
> -          acccess. These should be enabled by FW for target VMIDs. */
> +          access. These should be enabled by FW for target VMIDs. */
>         for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>                 WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>                 WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>
