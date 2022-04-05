Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740C24F4E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588331AbiDFAPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443467AbiDEPjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53CDD7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:56:25 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id b188so13430507oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YCAAPrKYGMpteO8HsHXIgowtM9srkXdQGvqaN8hMluo=;
        b=OnxBihp4lODvPg4Vh6Z4IKBACJYaqjE50m/IyiPn1KpCeBWtRR7gArmE1n+NVMMzGr
         BMyUcnQ7C4dOX1m1YLDqtnL3PjzqIl4PGNCGHdBcJ10LnpP3MDnrVKRQvTt65f7Yz574
         eUyH5Q1vBKrs+/fKTbicqsJnwHWgpm558b5iHzWKhiAm0XfDvGwYQxViXt7CU1Ju/ZVv
         6WPLhLk3qcfbQ6IVncp6ZAJLiJNd+IAvGGz5apzbdz1G2Q/pLAo94Su4/o7FUoyaLLBM
         AK+GeE4uPJU6RllgVZmCtCYrpWB6QcMtx3VisGFpLaIaV6J5+hFY43oBpCgdv9NtWfLZ
         Vwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YCAAPrKYGMpteO8HsHXIgowtM9srkXdQGvqaN8hMluo=;
        b=oW9TgFE+bfUeONzUJtM00rwjAWOwS+RIOzs/ZIA07uI5ghNBfKRH0ueHtVzh3gb6er
         RM2WW42b8oeMH1PyT+1jE+Mpu/LHS1/zHUPJRHpSLORxt3ubdefHw3tCbIQ0C+g5RrMQ
         ps0PAtbi0D6XYh6KjmuIfH+xpDnNXzXnoeljxAgPySyy+JMWbiYCQEG9CzJ3C+P9vU1W
         hpcryglWRFTXnlUFwQDyBkzTVO11lKQ5md0BnyUdc6rEuhZALFXO+nTU/GHOyNk2iXKD
         dTIZpY+35THfXGtWWar9EWTemtVepYGHextpg1stgv/GeIn3AN57lc0Rij6Td+guzO8O
         HkBg==
X-Gm-Message-State: AOAM531MZNNW/11+HUEkOQdGGqXrf/HRGHZhskArlwFFHygCB+q8z6BP
        aba9lajl/cmM7/GzeKT94gx6Sx1wSN8PsVvqJ4M=
X-Google-Smtp-Source: ABdhPJzH/9FaaYtXvjsgUHrM11qiKYU7i9SkABBcgqx9plkb/ib6+CEk7Fig2tnoMRBs/644ht1mIt+GM4U4kyh5SpU=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr1372936oic.200.1649166981991; Tue, 05
 Apr 2022 06:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220404233306.2207-1-h0tc0d3@gmail.com>
In-Reply-To: <20220404233306.2207-1-h0tc0d3@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Apr 2022 09:56:10 -0400
Message-ID: <CADnq5_Mf3hpqnbgywSD68CmUe3dYrwjdZpFaMDrMWazDxBFWcg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Junk code
To:     Grigory Vasilyev <h0tc0d3@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Claudio Suarez <cssk@net-c.es>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Apr 5, 2022 at 5:07 AM Grigory Vasilyev <h0tc0d3@gmail.com> wrote:
>
> Variable igp_lane_info always is 0. 0 & any value =3D 0 and false.
> In this way, all =D1=81onditional statements will false.
> Therefore, it is not clear what this code does.

It was leftover from when the code was ported from radeon.  The igp
lane info was available from the vbios on older APUs.  It's not
relevant on any asics supported by amdgpu.  I've applied the patch and
clarified the commit message.

Thanks,

Alex

>
> Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
> ---
>  .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 21 -------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu=
/drm/amd/amdgpu/atombios_encoders.c
> index 2b0cc793291c..100bad2f5901 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -769,7 +769,6 @@ amdgpu_atombios_encoder_setup_dig_transmitter(struct =
drm_encoder *encoder, int a
>         int dp_clock =3D 0;
>         int dp_lane_count =3D 0;
>         int connector_object_id =3D 0;
> -       int igp_lane_info =3D 0;
>         int dig_encoder =3D dig->dig_encoder;
>         int hpd_id =3D AMDGPU_HPD_NONE;
>
> @@ -852,26 +851,6 @@ amdgpu_atombios_encoder_setup_dig_transmitter(struct=
 drm_encoder *encoder, int a
>                         else
>                                 args.v1.ucConfig |=3D ATOM_TRANSMITTER_CO=
NFIG_DIG1_ENCODER;
>
> -                       if ((adev->flags & AMD_IS_APU) &&
> -                           (amdgpu_encoder->encoder_id =3D=3D ENCODER_OB=
JECT_ID_INTERNAL_UNIPHY)) {
> -                               if (is_dp ||
> -                                   !amdgpu_dig_monitor_is_duallink(encod=
er, amdgpu_encoder->pixel_clock)) {
> -                                       if (igp_lane_info & 0x1)
> -                                               args.v1.ucConfig |=3D ATO=
M_TRANSMITTER_CONFIG_LANE_0_3;
> -                                       else if (igp_lane_info & 0x2)
> -                                               args.v1.ucConfig |=3D ATO=
M_TRANSMITTER_CONFIG_LANE_4_7;
> -                                       else if (igp_lane_info & 0x4)
> -                                               args.v1.ucConfig |=3D ATO=
M_TRANSMITTER_CONFIG_LANE_8_11;
> -                                       else if (igp_lane_info & 0x8)
> -                                               args.v1.ucConfig |=3D ATO=
M_TRANSMITTER_CONFIG_LANE_12_15;
> -                               } else {
> -                                       if (igp_lane_info & 0x3)
> -                                               args.v1.ucConfig |=3D ATO=
M_TRANSMITTER_CONFIG_LANE_0_7;
> -                                       else if (igp_lane_info & 0xc)
> -                                               args.v1.ucConfig |=3D ATO=
M_TRANSMITTER_CONFIG_LANE_8_15;
> -                               }
> -                       }
> -
>                         if (dig->linkb)
>                                 args.v1.ucConfig |=3D ATOM_TRANSMITTER_CO=
NFIG_LINKB;
>                         else
> --
> 2.35.1
>
