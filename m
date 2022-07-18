Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DBF5789EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiGRS6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiGRS6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:58:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E77A2F398
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:58:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j22so23027573ejs.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YJp7ilSb6kT/3WBh9tR0qEa7Yi6wac44X2vJ5o/PvJA=;
        b=BJvyQLG2ET3Kz3DwNbE9PHvH1BwlyNdSGVR6u9DG5vyqZpefBKoEP+GKLU3oTZz/ob
         ggmLrDgD/Yp34B5CtnHAJcVvp6kI+oLyRnufPT/xJC+Aq78sHfhqirBZDiyKn0UXg/fC
         Be6b41LheJqU3tQxXt/XHyBatC1z8+mlVkjLg5RfzoNd4sHf5vRwuX5j1VAIFXYui3oh
         97Mf4lKvTBrqOe2VyeT6ZM330aPMc9lxFG2An9mpFIs6Ux4Yg2behw87gp6yXni2ztBh
         R6nCg+irH9j2LGj7+4k+w/UpdsxjiFFvsKwow1NO5/zWfZC5yIvcxFULTaVexZir8vPj
         EZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJp7ilSb6kT/3WBh9tR0qEa7Yi6wac44X2vJ5o/PvJA=;
        b=Ex5FSHkZYGeJQw8BNHWq80l+5a0N8W7zIaaDsRPclyUuR6cjqU1QdGlkGhHvXB7Y4r
         mKismyL/gHUG9n6yWe3ZucLzJ4KncxLvCUslIJ7Tsj2o0MuotIeX2tjege/ETQf6WThC
         vepfgu9FxWGJkAV1V+fLWYbtUKzIUz35x+/FMh7Ci+dex5VenyEi85E9bxQLJQa9OXeS
         eUK/xX4XkAuzuGaUhjeI36se8VVFiifW7w+gGPDCSN0CEi98meOf4B5q1vaW2JuVKuFH
         eyl3OMzGSP5cY3wrx7ToIZLbbSjbTwHh8Jd+cAcrisg6dgUPaw4vQ5bFLk2vNgk6lmdt
         I9Mw==
X-Gm-Message-State: AJIora8tXiNAl6pk9OFCR2QtzK8S9Zjq8SVuxql6/lhVadNK0FlteLl7
        bQ67wuHyl7mtbqlUfVi+qJVL3NafYnPwvrPfKYIz+n7P
X-Google-Smtp-Source: AGRyM1tMe/WOUToEyh8jrHhnMWm4mX9DfjEJeuooP+YpMuft7LiHvq6a31gJRHOFpv5bdvkJDOKdlVMwaR+X4lvUDKQ=
X-Received: by 2002:a17:906:4fc5:b0:72b:9943:6f10 with SMTP id
 i5-20020a1709064fc500b0072b99436f10mr27335370ejw.722.1658170693029; Mon, 18
 Jul 2022 11:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-7-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-7-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 14:58:01 -0400
Message-ID: <CADnq5_NAPXuN0isLCXn800fdSOxSHWUyL7k-3BJRiL6zV_dGNg@mail.gmail.com>
Subject: Re: [PATCH 07/12] drm/amd/display: Remove unused value0 variable
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Melissa Wen <mwen@igalia.com>,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove the variable value0 from the function
> dcn10_link_encoder_update_mst_stream_allocation_table.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:1223:=
11:
> warning: variable 'value0' set but not used [-Wunused-but-set-variable]
>         uint32_t value0 =3D 0;
>                  ^
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> index fbccb7263ad2..ea7d89bc293f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> @@ -1220,7 +1220,6 @@ void dcn10_link_encoder_update_mst_stream_allocatio=
n_table(
>         const struct link_mst_stream_allocation_table *table)
>  {
>         struct dcn10_link_encoder *enc10 =3D TO_DCN10_LINK_ENC(enc);
> -       uint32_t value0 =3D 0;
>         uint32_t value1 =3D 0;
>         uint32_t value2 =3D 0;
>         uint32_t slots =3D 0;
> @@ -1322,8 +1321,6 @@ void dcn10_link_encoder_update_mst_stream_allocatio=
n_table(
>         do {
>                 udelay(10);
>
> -               value0 =3D REG_READ(DP_MSE_SAT_UPDATE);
> -

There may be a reason to actually read the register here.  @Wentland, Harry=
?

>                 REG_GET(DP_MSE_SAT_UPDATE,
>                                 DP_MSE_SAT_UPDATE, &value1);
>
> --
> 2.36.1
>
