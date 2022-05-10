Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A32521E23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbiEJPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbiEJPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:24:46 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30B5A59F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:09:27 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id l9-20020a4abe09000000b0035eb3d4a2aeso3172745oop.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xz5dj/sAI16FlyJ/oMGNXUrGgnVqkXZ5u3e0YW3gpHs=;
        b=PtrL5qWveEvv6rrV6LCRolslMgz2D5A05Filc1C4eA/tW3SXB586KpETA/BPDuw2K5
         tVQWrrkFShOhj3P6/zbYLmkTeglTiwkevgQdp68+vQSDDARFHbkFUEtM0/MN1b3aFSm4
         vM/9ukGaR4N8+FdJQZeUQaN7qjGEXqBZBSiqrzPoBePqORYTC1liLmB/DdIfiAg4g7q1
         zHfiJzsNz9JOtXIFaCk7cGYgEdfiZGcGQx1TtIERtkEQPkPEhNVSM/ySzvupMxrSR52u
         jy+sDL6AjEId0S5DG5lJBft0cwUUMVx1gPu+uaePTy2tmzSA1s3ekTM0htfITXWHskKE
         1Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xz5dj/sAI16FlyJ/oMGNXUrGgnVqkXZ5u3e0YW3gpHs=;
        b=lLBKl3i/Q1EEJcIE6Lw6rSCEpUMMdC9qD+ZpwAXcYpToe425GL4cPgc/UOgxn+NIJs
         v0y5Ns4808oMr90fxU2u5N08BLbZ2gzpYY1avD/tSTltA8nuGBP5jP1OeG/pKTIDrWQM
         mLb1+EHsEsadPuJHgTrqpKqirRh4pLaUZ/1bhnqN1wyvjWIyJ5acUYizlt7WjwWHYRdM
         Gb8RkUkKJLQwTjYyVeI8VquB4Jfhdo8HVitsTGOR19EH6KLcBywLBeBUewvKNSy4ocvz
         JUGhXGma11waOORTQKEQRUn2myneNJ8ttfpeuZuR/12O1sESfwwjXY1pjuO2AVCf074c
         AhFQ==
X-Gm-Message-State: AOAM530f5o6hOc7hHjDXWJGXK6G9s42l6DNMcOZbmTxM0c/o0/jXJirs
        00skcXNCE7pu1xC1lYWw9oC5qK5ftt4EMyDzuTs=
X-Google-Smtp-Source: ABdhPJxNg9Nb8TbOJv6OiCoApQXhEYw+7atDL1anmm12hsxZez/BrbxD1eJXy1tAN/8hP0gam/1pP6JWHg2zwDu7Gjg=
X-Received: by 2002:a4a:4a86:0:b0:35e:a2d3:763b with SMTP id
 k128-20020a4a4a86000000b0035ea2d3763bmr8169819oob.23.1652195366837; Tue, 10
 May 2022 08:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220510060440.67178-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220510060440.67178-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 May 2022 11:09:15 -0400
Message-ID: <CADnq5_NxH5WzL6=5ZG2Cb0CBPU3FwP7ZS2ZMzyYHZ00XKe3E5w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up some inconsistent indenting
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

On Tue, May 10, 2022 at 2:05 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
>
> drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c:35 nbio_v7_7_get_rev_id() warn:
> inconsistent indenting.
>
> drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c:214 nbio_v7_7_init_registers()
> warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> index e32c874b42b5..cdc0c9779848 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> @@ -32,8 +32,7 @@ static u32 nbio_v7_7_get_rev_id(struct amdgpu_device *adev)
>  {
>         u32 tmp;
>
> -               tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
> -
> +       tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
>         tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
>         tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
>
> @@ -211,14 +210,14 @@ static void nbio_v7_7_init_registers(struct amdgpu_device *adev)
>  {
>         uint32_t def, data;
>
> -               def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3);
> -               data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
> -                       CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
> -               data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
> -                       CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
> +       def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3);
> +       data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
> +                            CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
> +       data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
> +                            CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
>
> -               if (def != data)
> -                       WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
> +       if (def != data)
> +               WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
>
>  }
>
> --
> 2.20.1.7.g153144c
>
