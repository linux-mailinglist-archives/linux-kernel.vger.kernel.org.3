Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED74BFE93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiBVQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiBVQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:30:36 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD0166E1B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:30:10 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so18270820oop.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eSk/B5akCpkVV7QxSZtURlOxcgNjBBC3d9BzaaHV+Yo=;
        b=aXvHXnmshI/v4gnEa7KQ/u5AnLl0KUHmoodSrXYzKv/VI6xttGqGaV+7DgkVsF2+xN
         PD31tb6JFeswkMQwQg4OszytvuKhiSW5fnV3GdpOZtF6nqzB4SYhG9I358zOJyNFHV6V
         ihh/83PRWA2jMmGD2X9nszbPjUvEECJwmm0yKcuggNBXEqq57KJAiAoV6WNFMAM2Na7w
         2RPVyoNH4HBwdafAMqVmW2OAIXOUuEKjHMXvmqYUVyH56ClWtBHRx1xAFH6vCaReNfCh
         4SRf4gsX+BlxDotxPR7AHmhOmVN77mIU3kg2fUewutUQn8U4Xjkqsx0MzgyLqXaGseNU
         P3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eSk/B5akCpkVV7QxSZtURlOxcgNjBBC3d9BzaaHV+Yo=;
        b=Ge9zuMuCUIhvwEWwnSLFKmrlcVHpM2NO9OfJYHxISyMAx9VTvzXx345cL+t5wcCuaR
         zbV9/Wy/paIq0oNIiZcGhDx7IlKW9MPm5ITEhomICQIfFehfasFpZ2VR3IwK+yB+TWEP
         iRHj8hFB9a4c/Xo3P2suef6aqObNL6r3c2LK5XVOptJZTxLpPXptiyEBHTmBp8qMoDXD
         PoGxwM+DXuxn26jIQRq0UTSMtIQyurduwQDzfJe4cuJ3QncaHRq+wUZT73Q1XvWr26vX
         rFDS0lbX1xlXHgSbh+st4DZtF5kZ0hLVpGSQpvamcvvGZEcAT6ZkL7RjHK/P1WNify3+
         e4yw==
X-Gm-Message-State: AOAM532sSjILgGYQEE24RI1ZF6Xy4pPy8rxW2tWzqTVvVGGjAUW0dZkT
        3tynq9nuuvK4GdR0fXhBWVhu71xCzQbdSIlZXwM=
X-Google-Smtp-Source: ABdhPJyLdPbLN0J/R5Xdqs7KCIPSpW/mVSbPiQRj47dCrvZ67kzJey1F9VFOY8uP9l94Cb8W+OSClk6J6BJU0CtnUWk=
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id
 lk13-20020a0568703e0d00b000d3fe6d57c3mr2017599oab.225.1645547409808; Tue, 22
 Feb 2022 08:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-4-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-4-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:29:58 -0500
Message-ID: <CADnq5_OQ5s4tSHduzdVFWbGKwmH57dkxXqs6ykbTxh+BzwihPQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] drm/amdgpu: Remove unused get_umc_v8_7_channel_index
 function
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

Applied.  Thanks!

Alex

On Tue, Feb 22, 2022 at 8:17 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Remove get_umc_v8_7_channel_index function, which is not used
> in the codebase.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/umc_v8_7.c:50:24: warning: unused function
> 'get_umc_v8_7_channel_index' [-Wunused-function]
> static inline uint32_t get_umc_v8_7_channel_index(struct amdgpu_device *a=
dev,
>                        ^
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/=
amdgpu/umc_v8_7.c
> index de85a998ef99..f35253e0eaa6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> @@ -47,13 +47,6 @@ static inline uint32_t get_umc_v8_7_reg_offset(struct =
amdgpu_device *adev,
>         return adev->umc.channel_offs*ch_inst + UMC_8_INST_DIST*umc_inst;
>  }
>
> -static inline uint32_t get_umc_v8_7_channel_index(struct amdgpu_device *=
adev,
> -                                               uint32_t umc_inst,
> -                                               uint32_t ch_inst)
> -{
> -       return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_ins=
t_num + ch_inst];
> -}
> -
>  static void umc_v8_7_ecc_info_query_correctable_error_count(struct amdgp=
u_device *adev,
>                                                 uint32_t umc_inst, uint32=
_t ch_inst,
>                                                 unsigned long *error_coun=
t)
> --
> 2.35.1
>
