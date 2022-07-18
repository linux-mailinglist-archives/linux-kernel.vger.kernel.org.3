Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D78578A41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiGRTC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGRTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:02:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497BE2B278
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:02:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tk8so11672126ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5eZUjMBlv+MHYtkWtM00Fh2DEyY+EQOvDm4200JOmkc=;
        b=QUNSfxy+Cb5amV/eOl1pSDwfWLs7tXgKRh9KTBSQ5AZzkYGjCQ0trWoeeOm+GhZFG2
         Yvpz7/c9SzxH/gtw+ckQjPwhHlPgyact+idm7tj5XUJnqHkWShCGnTgAXjxUrkI6m0Ca
         5OOcm0KMZbRafk3RUCKmf7KoQDrvxxnYl6LvGaWh5wmoLFCuYwhHqDXk6RKdLksG8KQJ
         9dTP6VARVBnWD83LHsQnizjFJQt0lJOY2FYrssWyDkLU4qWkwm+O/FIuXd6ktR8ibp10
         cZjeyZzlpWQ3fuhQz6sD90mtjLt9DsAdHAqeO9nsM0NXkRcgfT4MVHyLBHJNmmtmPiL0
         SieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5eZUjMBlv+MHYtkWtM00Fh2DEyY+EQOvDm4200JOmkc=;
        b=butTqS5Wjdg1UodVsF0ipX7bFQqp9+Jxhb4ISRkIMK2pnvfWcWbaaF1s7/heizInbk
         a3Xry5UxXULZve/hg3Wgq/vcCgSbEJtP9et8JnPzOXUMpfss+UXZ21XlBN9rkIXjJOrD
         v2HmE/MRaOC8bO7BwiMlnfNp9YfFSPLudn2chPrA+TSqJhWBh20EGMirjxYKiriaDgYi
         B/14mxrLEKJc1XGr/Cril1Iys+9TtVgLUCJ2MDDnrtC+VwxWjofc7RjD7pI4eWz0kPcR
         bUlVJnPdbhkjdKlY+aP2N/qYw/AmpkaQ13mq9v/LKLDLIc8H1BAhkjMrYkDKIJEz+qVJ
         0yrw==
X-Gm-Message-State: AJIora/GIf2IVXNEiMvVJLKnN4zf7KiJjGNUZ+2NL4pxheRXwiLRbLYC
        ACG8rxmdlLYi4KVR7d9CfA+rFVgMwUZ4bgGuHEo=
X-Google-Smtp-Source: AGRyM1vb0994V4n0N4nVQ5zZ3Q+6sY9BLaheAKz+lLSpF84KnxgMo3VEQgstLOpF3Z9pm7TKpvgWJOla7v7oPlmIhaY=
X-Received: by 2002:a17:906:9751:b0:72f:1b36:e1de with SMTP id
 o17-20020a170906975100b0072f1b36e1demr10911090ejy.451.1658170971881; Mon, 18
 Jul 2022 12:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-10-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-10-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 15:02:40 -0400
Message-ID: <CADnq5_Ot2ecb=D7M2fznBWuZiC-OwPPAnfPfwFXbnrWcevAtzA@mail.gmail.com>
Subject: Re: [PATCH 10/12] drm/amd/display: Remove parameters from dml30_CalculateWriteBackDISPCLK
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

On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> The parameters WritebackPixelFormat and WritebackVRatio are removed as
> they are not used on the function dml30_CalculateWriteBackDISPCLK.

Maybe this is done for consistency with other dml code for other DCN blocks=
?

Alex

>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c        | 2 --
>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 ------
>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h  | 2 --
>  3 files changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index a8db1306750e..746bb93ade6c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -322,10 +322,8 @@ void dcn30_fpu_populate_dml_writeback_from_context(
>                                  * parameters per pipe
>                                  */
>                                 writeback_dispclk =3D dml30_CalculateWrit=
eBackDISPCLK(
> -                                               dout_wb.wb_pixel_format,
>                                                 pipes[pipe_cnt].pipe.dest=
.pixel_rate_mhz,
>                                                 dout_wb.wb_hratio,
> -                                               dout_wb.wb_vratio,
>                                                 dout_wb.wb_htaps_luma,
>                                                 dout_wb.wb_vtaps_luma,
>                                                 dout_wb.wb_src_width,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 876b321b30ca..37049daaab4c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -1938,10 +1938,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchPa=
rametersWatermarksAndPerforman
>                 if (v->WritebackEnable[k]) {
>                         v->WritebackDISPCLK =3D dml_max(v->WritebackDISPC=
LK,
>                                 dml30_CalculateWriteBackDISPCLK(
> -                                               v->WritebackPixelFormat[k=
],
>                                                 v->PixelClock[k],
>                                                 v->WritebackHRatio[k],
> -                                               v->WritebackVRatio[k],
>                                                 v->WritebackHTaps[k],
>                                                 v->WritebackVTaps[k],
>                                                 v->WritebackSourceWidth[k=
],
> @@ -3284,10 +3282,8 @@ static double CalculateTWait(
>  }
>
>  double dml30_CalculateWriteBackDISPCLK(
> -               enum source_format_class WritebackPixelFormat,
>                 double PixelClock,
>                 double WritebackHRatio,
> -               double WritebackVRatio,
>                 unsigned int WritebackHTaps,
>                 unsigned int WritebackVTaps,
>                 long   WritebackSourceWidth,
> @@ -3794,10 +3790,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(s=
truct display_mode_lib *mode_l
>                 if (v->WritebackEnable[k] =3D=3D true) {
>                         v->WritebackRequiredDISPCLK =3D dml_max(v->Writeb=
ackRequiredDISPCLK,
>                                         dml30_CalculateWriteBackDISPCLK(
> -                                                       v->WritebackPixel=
Format[k],
>                                                         v->PixelClock[k],
>                                                         v->WritebackHRati=
o[k],
> -                                                       v->WritebackVRati=
o[k],
>                                                         v->WritebackHTaps=
[k],
>                                                         v->WritebackVTaps=
[k],
>                                                         v->WritebackSourc=
eWidth[k],
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> index daaf0883b84d..12c070434eee 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> @@ -29,10 +29,8 @@
>  void dml30_recalculate(struct display_mode_lib *mode_lib);
>  void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib=
 *mode_lib);
>  double dml30_CalculateWriteBackDISPCLK(
> -               enum source_format_class WritebackPixelFormat,
>                 double PixelClock,
>                 double WritebackHRatio,
> -               double WritebackVRatio,
>                 unsigned int WritebackHTaps,
>                 unsigned int WritebackVTaps,
>                 long   WritebackSourceWidth,
> --
> 2.36.1
>
