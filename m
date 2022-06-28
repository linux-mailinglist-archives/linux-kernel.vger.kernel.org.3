Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C3755E79C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347221AbiF1OiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346842AbiF1OiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:38:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668992DD70;
        Tue, 28 Jun 2022 07:38:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf9so26337414ejb.0;
        Tue, 28 Jun 2022 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hQk/b0dG+ocD4kJkrdVLcqXI9aTRhPcr2tzOyCb7mk=;
        b=FftgfCRZNOFK3Y04oOXzjZwBv01ZPqBAsXGdkky+kO4cE8jNkzJjWL1lyBbv5cCMzt
         8ZHo7aDVBL4WTzIKpcJFig+44I2dHAu4WuZE2hWqbj43Oy9+kz8VZRWuxIAC1IVWr7r+
         7UVFPFEvmhpI+l8mWNF7XiuJKkzRo8CIEcU60klYX480FgZciwWg/mQsXS2iLpsukq1V
         8LC6NWfqzLKNmrE1prgCNsO9NdbH6n5xqJV7Ty70dkNZNbGOraGm3unIOTuvrQCWoh1l
         ZQbMrtIhZYzd3Ha5wSzQC8ZMAS6ZQInJTuZ9miKlPSmiuiOFX58iU+qS0nwHu6FHEvYZ
         h+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hQk/b0dG+ocD4kJkrdVLcqXI9aTRhPcr2tzOyCb7mk=;
        b=MrrNMXEansr9S42JfGAMV9IFmIuL5gzFkUv1K4wTVCvKMqO9ft6iEAG7MB+61/WFE8
         0Eo2ohHiwTuoU7Yj6LQJPHcZjJK73RPY6EdRlP+vQWSsYHb8ZTd2CFdF67ps41o+17Si
         y/Y3d66YMAeuuz6ThIKlHoavQWlk8TBZzLz5bnSsOBhQtYFWmY1XlrpCdjfbn8Fmv6o1
         63ZQ6oWqy3qTLlWmQ85MBwEWsjhZvBN+4V953AwYJzYjxBjEhhvbhY4XHDIGcL5VGpwM
         JCrjOu653LsA7LpqDlWwY83soyV/9xhGm2rB+uVvN0fZRbhZ+GjadWe9+zCvgTYc3+Ho
         p+jA==
X-Gm-Message-State: AJIora9dtcEdMGwEPGmx3JVB2cokwHZaFbjUUegBIVh198XyRRveI58s
        xEZe5K1SMKWlPhoX8BQ2rK7Rs8EUax9NiPvlbGGIsG6s
X-Google-Smtp-Source: AGRyM1sjewq/YDh9ewRpgbEn647mcNCTsFzlz2ApXt/lWtI5R9O39yhXZpkP6sUScjKV7B7HZKEprynWngvkhAfQV4M=
X-Received: by 2002:a17:907:a40f:b0:726:a8f5:1031 with SMTP id
 sg15-20020a170907a40f00b00726a8f51031mr9317125ejc.185.1656427078995; Tue, 28
 Jun 2022 07:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656409369.git.mchehab@kernel.org> <ac8ece934af1145bc16531b9f10d69c76216cb66.1656409369.git.mchehab@kernel.org>
In-Reply-To: <ac8ece934af1145bc16531b9f10d69c76216cb66.1656409369.git.mchehab@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 28 Jun 2022 10:37:47 -0400
Message-ID: <CADnq5_OxGq_rBr5-n16-5aHhG1WPDhTDjPAgMjMkWw-fG4o=8A@mail.gmail.com>
Subject: Re: [PATCH 10/22] drm: amdgpu: amdgpu_device.c: fix a kernel-doc markup
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Wang <kevin1.wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lang Yu <lang.yu@amd.com>,
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

On Tue, Jun 28, 2022 at 5:46 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> The function was renamed without renaming also kernel-doc markup:
>         drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5095: warning: expecting prototype for amdgpu_device_gpu_recover_imp(). Prototype was for amdgpu_device_gpu_recover() instead
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

I actually sent out the same patch a few days ago, however, the code
has since changed with Andrey's recent GPU reset series and the patch
is no longer applicable.

Thanks,

Alex


> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9d6418bb963e..6d74767591e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5079,7 +5079,7 @@ static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device *adev
>
>
>  /**
> - * amdgpu_device_gpu_recover_imp - reset the asic and recover scheduler
> + * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
>   * @adev: amdgpu_device pointer
>   * @job: which job trigger hang
> --
> 2.36.1
>
