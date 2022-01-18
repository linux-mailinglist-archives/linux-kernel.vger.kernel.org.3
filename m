Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A9E492F66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349242AbiARUbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349064AbiARUbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:31:38 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4ADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:31:38 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id v10-20020a4a860a000000b002ddc59f8900so78457ooh.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS3GFrM29kfkWwvPWQIw4Pk6eycOPGCpsobayljmZkw=;
        b=V9sBl3RXniA+oUbr5FnqqjPErpemmaL+yQmC7+wieMHA1rxEIMHEQP4+Yptu/ZLS1i
         PEb6tz7rCo33HvMdh7OcQja7l54gxG1OQkx/I16eDZl2rqjp/r94C6LWg44v2DfNBmtA
         0EaLrgcMP1wz+isVMSFmc+gYMUFLz4Pj9ARee4dTHPwiZhYkLt4phILDKcaG73lFo/sV
         ENoGra2xi3AHouWAArmOgW0QlglmwS1brr0rku2pyW+BtwB6bf2NvKuSwW6sy1MJs+Yy
         Dyy4HsBshi0av2Ut3fHrmL5RkRBuZ6T6l2slmxtTrIrHNPK5llCW0hUK4jh6ZHcrqwbg
         KtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS3GFrM29kfkWwvPWQIw4Pk6eycOPGCpsobayljmZkw=;
        b=1GqpwL6CQwEn3SEF5Hj1CZGuqN6zKWPoPDyQNPbK3birowc6BJWwpkc3CLhhz8zxMJ
         7NofUackMwm6F/liF0Yf6Yhu3NNkfotg6xLn0unUNZRAlBWEPTzxaPocX0BMQtNvYTGF
         1NwUZ7FfJq97G0sdXMFBvTS39oKrUyGNmYLnljjqy5lWrcwUpL94JoELBIHbLNpxUQsn
         n87UIHe+I7Z2fi8p3bronQ6l/LuBYvmCqrw3jqJH5SNBiRxiVtY/RONhaMTWESzvKq1d
         Rupm629K1Yhd2O3y0/1UW7+3h2OmHpdraRWL8bOaLsD6aod4Vwxn879kFrSisdBRDy4S
         GT7Q==
X-Gm-Message-State: AOAM531779Z4q+UpW0BcrGPw7FB2lIwjm/tzp0vWRlrQyVqChzSfE2xc
        0rNNK/rHJpHmAcDzpFMhH0S3a00yTRQkM/Zmk1Q=
X-Google-Smtp-Source: ABdhPJwC6J2yTtkomxVb1nBmVSS2A70Zz3uGg1xsukouvEGbNDpuyzjryP5ofkkY9baDzG+BHEx+p8BzBJelYa2CRdA=
X-Received: by 2002:a4a:3412:: with SMTP id b18mr19430884ooa.23.1642537897267;
 Tue, 18 Jan 2022 12:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20220118075702.925929-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220118075702.925929-1-chi.minghao@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 18 Jan 2022 15:31:26 -0500
Message-ID: <CADnq5_OeWEJq7Re-usY=m8vThD2jLyXObL6Cn_k3mZweFW_+Pg@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/amdgpu_psp: remove unneeded ret variable
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Lazar, Lijo" <lijo.lazar@amd.com>, Dave Airlie <airlied@linux.ie>,
        Lang Yu <lang.yu@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "Kim, Jonathan" <jonathan.kim@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Li, Candice" <candice.li@amd.com>,
        John Clements <john.clements@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Jan 18, 2022 at 2:57 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Return value from amdgpu_bo_create_kernel() directly instead
> of taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index dee17a0e1187..ac2b87f81ef9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -914,19 +914,15 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>  static int psp_ta_init_shared_buf(struct psp_context *psp,
>                                   struct ta_mem_context *mem_ctx)
>  {
> -       int ret;
> -
>         /*
>         * Allocate 16k memory aligned to 4k from Frame Buffer (local
>         * physical) for ta to host memory
>         */
> -       ret = amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_size,
> +       return amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_size,
>                                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
>                                       &mem_ctx->shared_bo,
>                                       &mem_ctx->shared_mc_addr,
>                                       &mem_ctx->shared_buf);
> -
> -       return ret;
>  }
>
>  static void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
> --
> 2.25.1
>
