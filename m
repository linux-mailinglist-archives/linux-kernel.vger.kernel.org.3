Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DACC4BFE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiBVQ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiBVQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:29:52 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A023166E15
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:29:26 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so6639307otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WDMkvcXrvFCIfwqXXj8ZNdlL4q1BzrbMD+9YGad2AC8=;
        b=ZQuVn+wn8BmdTuzrfTawxJB39mBQLQL6meMaDkhqzCs4+MZJo4uIj2rK2As1Iy71K8
         oHmjvuOuQ2/hifwFKaEn3a/E2gRi9N+iAghYFkZw0CskSWl8EWbfkryk/KkDw2JtjxN1
         PXTeyv7nFMk1xanQhxh6EtkS89DKWEk/d3crdZnicKat0xUdnYCTUmuqUuewk/Xy68cE
         1LIVHLaZBVB7Wh+lB/oS/pfkZ3gDPELfX4GUEh+fvXfXv/rJSyfc4Kq+YqxjuOTRyRrn
         JTo8AuCVL1VfTrTJXovPhwzaBnGDK/CeZbFKlY1kaUW8hNod961VNY18Oyc3uRx68yba
         d9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WDMkvcXrvFCIfwqXXj8ZNdlL4q1BzrbMD+9YGad2AC8=;
        b=qxMau6vSet39Kc03Ludh3kK3f4bIACmx8kD8xNT9rFp4CD6/Yxk8DrcEFI32ytxE1P
         s8g6CmQSiQQDqCcADK97aNqCDUfDxYP6T8NnqFvGBF7VAn0vlgUUzDnINCas4aRWUuT6
         x44qhMs4npy+FMOUEFmGA6BDXpoIwYXzBfvstA+s8052fAUeCPH/Yva5I7oRlaeZwwL5
         9ucXZn3h29pID5gRYLE/KeRcU8XftGoAdX+2Sz/NTem74XEeZDKRao1gqMRlwO/4uWK2
         +VxIkyOijFA5dQk/cuY/udQNomelkS2jlXoPpK/KigKumrKSktst0zadspweWIKglgL4
         BC/Q==
X-Gm-Message-State: AOAM5322tuu4BA8ryL2w+idDap54VWUHBqjzimgtBSzrDh09fDbfe+nE
        5fuUNsE9R739Q7nenB+MfJEdIvndx7BZcHEjRIVlEdeJ
X-Google-Smtp-Source: ABdhPJyqybFdBgdg9H9adcKp77StqxCc/9gl0TUfTIrR8e+SE0PRdqtKFJXe9fzrIxbFvnbqaPxtZFFSNdcyN627NEA=
X-Received: by 2002:a05:6830:573:b0:5ad:5207:41d6 with SMTP id
 f19-20020a056830057300b005ad520741d6mr6208407otc.357.1645547365691; Tue, 22
 Feb 2022 08:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-3-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-3-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:29:14 -0500
Message-ID: <CADnq5_Nj1f+6mhd-w9XC62vuvA8Ndep9dV=AQED4v7D6YjzH4w@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/amdgpu: Remove tmp unused variable
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, mwen@igalia.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Isabella Basso <isabbasso@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 8:17 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> The variable tmp is not used in the dce_v6_0_hpd_fini and
> dce_v8_0_hpd_fini functions. Therefor, the variable is removed in order t=
o
> avoid the following Clang warnings:
>
> drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:331:6: warning: variable 'tmp' set =
but
> not used [-Wunused-but-set-variable]
>     u32 tmp;
>         ^
> drivers/gpu/drm/amd/amdgpu/dce_v8_0.c:325:6: warning: variable 'tmp' set =
but
> not used [-Wunused-but-set-variable]
>     u32 tmp;
>         ^
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 4 +---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index b90bc2adf778..2c61f0c2e709 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -328,7 +328,6 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *a=
dev)
>         struct drm_device *dev =3D adev_to_drm(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
> -       u32 tmp;
>
>         drm_connector_list_iter_begin(dev, &iter);
>         drm_for_each_connector_iter(connector, &iter) {
> @@ -337,8 +336,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *a=
dev)
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
>                         continue;
>
> -               tmp =3D RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_con=
nector->hpd.hpd]);
> -               tmp &=3D ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
> +               RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd]);
>                 WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], 0);

We should be writing tmp out here rather than 0.

>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index 7c1379b02f94..c5e9c5dbd165 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -322,7 +322,6 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *a=
dev)
>         struct drm_device *dev =3D adev_to_drm(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
> -       u32 tmp;
>
>         drm_connector_list_iter_begin(dev, &iter);
>         drm_for_each_connector_iter(connector, &iter) {
> @@ -331,8 +330,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *a=
dev)
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
>                         continue;
>
> -               tmp =3D RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_con=
nector->hpd.hpd]);
> -               tmp &=3D ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
> +               RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd]);
>                 WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], 0);

Same here.  Care to send a patch to fix this up?

Thanks,

Alex

>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
> --
> 2.35.1
>
