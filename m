Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878C5398A0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347974AbiEaVWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347971AbiEaVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:22:38 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889A6590B3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:22:36 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w130so175473oig.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNsVAgAOaHBeTW3uh6pa2YZZKM4GP68jx8jpyunwFns=;
        b=XjasywrCMQ2pl8wC1KYGo2pSOLjGyfKW/h8uK/C8gGc2ZwM07WIcx2WjPq4glWpVMk
         uQj3ixsCVywkyoraZKoNb3dym5R74OpRPyeQfm9N0XGL+knCvyK7N52ET6d5xqAYvZDY
         D+qHu6/O5dSbDzqLdvAOBFMdqUuusYPWkfj1Xj0Nbrs1VlVPoK+geDPWSqqxB+8GNIFH
         sE6HYEEOV9X2Xp8QMOE9fTaHAH2UWSMPhyppkkboq0/6Ae9H1y64CIiM4j9AbQXZCasu
         6jua8F6hw8uE6XNjOqjclD/eFH13AwZ31YdPgVes3M8g9t4jeVFTWj9Or08/qqP6QjpG
         sVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNsVAgAOaHBeTW3uh6pa2YZZKM4GP68jx8jpyunwFns=;
        b=xZYiFTCtk2It4dZMzePUiyiqwjDmSXcqX77lBWk/A8BSMpPm6I5sOgLz8falsg24Ce
         bn/7syFKX7m+07NYQH72CMDZRbl47niz/quA/tjp4MYJvfBrUzZ9e4m2Xj+c1yon1LTg
         1sp1zLQ6zLAc9c5/TYzbm+a8YehBK0U81+bPVno19Nn6bG185acKFLo0eWgIInEsypW5
         FJN7P+nO8vOtgzc/0NfBtTHvLbxnrjaZYra2e3Cn384wU5rbK6S16TpLWGBt0vnyC+zB
         Y5ncWK+ZTtM7r4E8u4PdoD6HW6OmKCLOBVzHuHAFaeWxP/CV2Kze279xZlSc5Wk91ttZ
         XBzg==
X-Gm-Message-State: AOAM530IYASmaL4/gr2pdVmVitmRHv8WJvxlCKk1fu6epFp8Ch691AMU
        84lZcYLjaRiiarW1sAxS4juG4R4Y+JfzGbVcnBs=
X-Google-Smtp-Source: ABdhPJzh4fJZOKIURodl4DucHPyqo5K3DTZ+seM4qZE6q57I5p519DBcqrSHJnow/0/s07Cb7Hy539r0j9t7QEWPBN0=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr12747067oiu.200.1654032155821; Tue, 31
 May 2022 14:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220529062631.304316-1-sunliming@kylinos.cn>
In-Reply-To: <20220529062631.304316-1-sunliming@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 May 2022 17:22:24 -0400
Message-ID: <CADnq5_N0SRW94Vvis16kyCmpZxLemOhPS5O-Yr2YQe=5BL6x8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make gfx_v11_0_rlc_stop static
To:     sunliming <sunliming@kylinos.cn>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        hristian.koenig@amd.com, xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        kernel test robot <lkp@intel.com>, kelulanainsley@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
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

On Sun, May 29, 2022 at 7:50 AM sunliming <sunliming@kylinos.cn> wrote:
>
> This symbol is not used outside of gfx_v11_0.c, so marks it static.
>
> Fixes the following w1 warning:
>
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:6: warning: no previous
> prototype for function 'gfx_v11_0_rlc_stop' [-Wmissing-prototypes].
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 8c0a3fc7aaa6..cb581cfc7464 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1983,7 +1983,7 @@ static int gfx_v11_0_init_csb(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
> +static void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
>  {
>         u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
>
> --
> 2.25.1
>
