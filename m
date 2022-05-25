Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3085345A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbiEYVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiEYVI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:08:27 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69517BA57E;
        Wed, 25 May 2022 14:08:26 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 1-20020a4a1701000000b0040e90b56d03so1684044ooe.12;
        Wed, 25 May 2022 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaCYLf7kRedBe+2EoHW9DrMiYYCRi0awPrgRA1lZnEk=;
        b=blydpWvrsBy9tEUoVG4ffsFO/xJP4nrXC+7rieZbPqWER6T3GKKOsWoMKYs5XYHSIH
         Ibvd8k71EtDFjvFDjGYiRHkrQMKVc8YATLu9aJZUYstDfrBCqcn+MpXiJxA4sSWfjgGS
         FXWZKD8sfRRwlNvzIvAlcIeLexpGvPG6uVoc365XEs1WV08dtsIt4XgFz7vSsgQLFzzg
         7/ARMXSkky0+5LOP857bXubBqb9hU2Z77O0C4pc1tiWR7fD9kP/fhWYwUZYSaeuwOnbM
         1VAvOftERug7SSsXdoY01tCKDBJBCPRx09xh54YXmJ66v2JNkylW2LvkUuboUnTtk0Ik
         bGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaCYLf7kRedBe+2EoHW9DrMiYYCRi0awPrgRA1lZnEk=;
        b=OBeygwALdIt/uvlvV8BKrUWH7kdFUawcVzjakr9Ede2TVuZ2NCIC8TS+b1XE6c4A8V
         uxsb3EZLXoxhWc1XB3NU5aZ+qc1dHGTst7W0B00ezc5DRakaLZMu3kFtBZlyohBCNhZg
         UZJIYwTyR/JJ59kTFbaNX4SLZyQkOnZMVhLcIIJ13MimGsHfeu+UsqtrqFUWLZOD2lxX
         LEGX+pM0QhFZAQq3/AFEaibsurbFzabxk7IA5R8yQO8jS0MTmCzqtlQnl56gfzS/drgh
         gynx3W6PQ0RErIi56UswJmcPJ5zFmSsTu2r9mV3ogsQVfAh4La1MyAScFGCyZexZ2YIt
         p8xg==
X-Gm-Message-State: AOAM530RPEZnQT+jNLmuDjgJzQ3n+otlZ8XQC91k/Xz3AYc3IiTtBeoC
        R5xzthsAv8s9C56X7r/4NVuONbmC+BiVpFyIdTg=
X-Google-Smtp-Source: ABdhPJzbqKxYwN6Ji1qWni1pwlJhdkinYGiZvGryQoI5D2KswOZYkUHSjFnHi5UMtATztbRrWUIHys0RHaMggMtMZHY=
X-Received: by 2002:a4a:2857:0:b0:40e:5d49:da1b with SMTP id
 c23-20020a4a2857000000b0040e5d49da1bmr11718303oof.23.1653512905762; Wed, 25
 May 2022 14:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220525190914.60544-1-kernel@mitchellaugustin.com>
In-Reply-To: <20220525190914.60544-1-kernel@mitchellaugustin.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 25 May 2022 17:08:14 -0400
Message-ID: <CADnq5_Oeb81h+x+9XoTX_8fDDxAvPgGPAHndjNq7jB+bbvENfg@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: amdgpu_device.c: Removed trailing whitespace
To:     Mitchell Augustin <kernel@mitchellaugustin.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        "Chen, Guchun" <guchun.chen@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
        Lang Yu <lang.yu@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        linux-media <linux-media@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
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

On Wed, May 25, 2022 at 4:38 PM Mitchell Augustin
<kernel@mitchellaugustin.com> wrote:
>
> Removed trailing whitespace from end of line in amdgpu_device.c
>
> Signed-off-by: Mitchell Augustin <kernel@mitchellaugustin.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 49f734137f15..c531c05163cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3365,7 +3365,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>   */
>  bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_sriov_vf(adev) ||
> +       if (amdgpu_sriov_vf(adev) ||
>             adev->enable_virtual_display ||
>             (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
>                 return false;
> @@ -5762,7 +5762,7 @@ int amdgpu_in_reset(struct amdgpu_device *adev)
>  {
>         return atomic_read(&adev->reset_domain->in_gpu_reset);
>         }
> -
> +
>  /**
>   * amdgpu_device_halt() - bring hardware to some kind of halt state
>   *
> --
> 2.36.1
>
