Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E678D5789E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiGRS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:57:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F72F386
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:57:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id oy13so22961772ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WZXpZ/tYpTqlCSH3GDX1rZAVdQ9fECIobFONSn4ByKI=;
        b=g0hWCjPpda6RXQ1d9d/Ow1Oez/us8lwimWdhh3O2HaxgNvR6YKkUidnHyotu+FCVfx
         ojgJDfYXGx5UZEvIkdp15/GigFWPGigsNV1mCaqigoeEDLLCPydWA5dXa8JBVLImKpVq
         YUucsyDPBQ/MJC3E5Z3rPQ7orbszNZSobn5tt6KuG/1RwhFegbcKnzTQVlw2XgFSXxtB
         L8jtiM0m/2FxBVtqPvGVeDq+mZ5kOEtZbpez4AE0kB3p2uIdRI+27KkpFrjelcBvvFwC
         iCBZHkmF6TvX12cTL4oFO91Ttww2y0nH95W4BOgXF9h3SzQbmI95o5T8e6gG3YBh9wB1
         SUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WZXpZ/tYpTqlCSH3GDX1rZAVdQ9fECIobFONSn4ByKI=;
        b=DvFN/foXxIOaxUCFFY+t+vRGNvkH4AF1ovqXxQEKu/L4P6OojNiZsgmCp7epidgFeG
         53CxeIPwuZhvGmngReGi+Pk4Q5zvQiNnks10i5maX4w6g8YNy4FMDTHjTrCctyKK9WaJ
         ZuI3283w6q/OVfwo9tpXT8GgsQs7ncagLjt3vKgzjozp3J+vi+Z3gT8tEtABl7onJpOs
         GUTer9iwN3s/RozMN7oZgfc2gvrPjaekDhAbuWY6OlD55T+6PlH6wcG3em8tODyhsWno
         xXHOxW1OdnZIWTKOrC8cfdu1JZuHIjFmofVGFMDgOAAU3WTFrfL6eWWo2bi+dDFt50Tg
         UVsg==
X-Gm-Message-State: AJIora+j/vg14ovQEYKS0fZOqWEiawcx//Sc5Ts9UTKdoHSHZ961xkLN
        tni2sgcgAwesO1+OMYGvGWY5McqOfjq6pqA8i18=
X-Google-Smtp-Source: AGRyM1sj4G5z9Hw+W+6M+vPkPDxGGRHId03eqr1q+1C+mwNZUlZ3gCF0zqoU66jf0BAEq7YFfL5jDk/Ma7mk9Vcs1Nk=
X-Received: by 2002:a17:906:9751:b0:72f:1b36:e1de with SMTP id
 o17-20020a170906975100b0072f1b36e1demr10889601ejy.451.1658170624607; Mon, 18
 Jul 2022 11:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-6-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-6-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 14:56:53 -0400
Message-ID: <CADnq5_N8DLrfcp6xsrXT6Ch8MSfeHcPb+pgKEYYBeaXdvVTctQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] drm/amd/display: Remove unused variables from dml_rq_dlg_get_dlg_params
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
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

Applied.  Thanks!

Alex

On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove the variables dispclk_delay_subtotal and dppclk_delay_subtotal fro=
m
> the function dml_rq_dlg_get_dlg_params.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31=
.c:920:15:
> warning: variable 'dispclk_delay_subtotal' set but not used [-Wunused-but=
-set-variable]
>         unsigned int dispclk_delay_subtotal;
>                      ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31=
.c:919:15:
> warning: variable 'dppclk_delay_subtotal' set but not used [-Wunused-but-=
set-variable]
>         unsigned int dppclk_delay_subtotal;
>                      ^
> 2 warnings generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc=
_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> index c94cf6e01e25..66b82e4f05c6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> @@ -866,7 +866,6 @@ static void dml_rq_dlg_get_dlg_params(
>  {
>         const display_pipe_source_params_st *src =3D &e2e_pipe_param[pipe=
_idx].pipe.src;
>         const display_pipe_dest_params_st *dst =3D &e2e_pipe_param[pipe_i=
dx].pipe.dest;
> -       const display_output_params_st *dout =3D &e2e_pipe_param[pipe_idx=
].dout;
>         const display_clocks_and_cfg_st *clks =3D &e2e_pipe_param[pipe_id=
x].clks_cfg;
>         const scaler_ratio_depth_st *scl =3D &e2e_pipe_param[pipe_idx].pi=
pe.scale_ratio_depth;
>         const scaler_taps_st *taps =3D &e2e_pipe_param[pipe_idx].pipe.sca=
le_taps;
> @@ -916,9 +915,6 @@ static void dml_rq_dlg_get_dlg_params(
>         unsigned int vupdate_width;
>         unsigned int vready_offset;
>
> -       unsigned int dppclk_delay_subtotal;
> -       unsigned int dispclk_delay_subtotal;
> -
>         unsigned int vstartup_start;
>         unsigned int dst_x_after_scaler;
>         unsigned int dst_y_after_scaler;
> @@ -1037,21 +1033,6 @@ static void dml_rq_dlg_get_dlg_params(
>         vupdate_width =3D dst->vupdate_width;
>         vready_offset =3D dst->vready_offset;
>
> -       dppclk_delay_subtotal =3D mode_lib->ip.dppclk_delay_subtotal;
> -       dispclk_delay_subtotal =3D mode_lib->ip.dispclk_delay_subtotal;
> -
> -       if (scl_enable)
> -               dppclk_delay_subtotal +=3D mode_lib->ip.dppclk_delay_scl;
> -       else
> -               dppclk_delay_subtotal +=3D mode_lib->ip.dppclk_delay_scl_=
lb_only;
> -
> -       dppclk_delay_subtotal +=3D mode_lib->ip.dppclk_delay_cnvc_formatt=
er + src->num_cursors * mode_lib->ip.dppclk_delay_cnvc_cursor;
> -
> -       if (dout->dsc_enable) {
> -               double dsc_delay =3D get_dsc_delay(mode_lib, e2e_pipe_par=
am, num_pipes, pipe_idx); // FROM VBA
> -               dispclk_delay_subtotal +=3D dsc_delay;
> -       }
> -
>         vstartup_start =3D dst->vstartup_start;
>         if (interlaced) {
>                 if (vstartup_start / 2.0 - (double) (vready_offset + vupd=
ate_width + vupdate_offset) / htotal <=3D vblank_end / 2.0)
> --
> 2.36.1
>
