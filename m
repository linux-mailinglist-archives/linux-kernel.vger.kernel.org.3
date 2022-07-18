Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428275789F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiGRTAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiGRTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:00:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D722B274
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:00:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id os14so23045943ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQyoH7Iz8mEpqAOd0ZONZyEq4M37QPm603w2BBFwKM8=;
        b=Z79+e/QKWsVqEovUmcQ2HznGd9tPqIiEP5LgIpEpC7EHyvSgvZ6t5FZRTRMhZHZLGN
         M9+guF5Kv6dOe9rhbQGBtAPC63QjnJON4DrsYkf13p8b2jizjEhg9uNHyiz5gCpGKUJU
         amsxg0l8FbxjkVnVVT11Bq0lf//qNSZnSSWN8xuyppw3PXiO+g58dAUHMz2tgOpHpsAE
         lKbypVyE16N+UPos58AN9XJk/jLsIjMbkPaW4ry1F/rciHBVI9ssjViIobffSlbWiB9s
         XX1KUi6qymYRQLLM/93caMa381BoDz/bJVbGqz988oAVh8T+meqjiOu53xMkXQY6j/Pz
         N1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQyoH7Iz8mEpqAOd0ZONZyEq4M37QPm603w2BBFwKM8=;
        b=q2YR/x1QykiFgodMTe/i/f8+zRoAadYn75qZ+NAV46foTIIIAcaDpvaR//1VRB8k+c
         r3OViJDrqHeGO1Z5NWSDajCoMh5kjBcI+LmZ0y25zIDvUcDl3bg+s0RsKdZi/mDQoiVO
         UFlskVrKDMiigK5P0pSWp+AMlo8MpMIaHwkOth/hyhRRpwKBKhfUI+MWCEplftDfizR8
         ZFbRi9Poc3r9QGpVKQq2eN/+5lGWvn9ijkFsHGFXgSYhJvqm/CDi1EiK+ZeX2vSHxtK6
         q8FDHI9maM0Nnu7h8AyQ9eqgwDl+HxQ+oo5Vj4XmkzTmAEC+HCcJ4eL3/GU7QknPC1Az
         uVxg==
X-Gm-Message-State: AJIora9gTvmZPUKTwPJ6QkevIaUH4aAZnp/gNwwHG1f88+C4+7eoF3WV
        qDGCcGmoUeIkCaaiPHFfalXDwr6WrP+fAkBt48U=
X-Google-Smtp-Source: AGRyM1sAm0ceprBeNasxCBhGobuk2pQl9XbeaWeQmikg9R40pJTUHYeb+giTHB2g6CW/mQzFSVkhhZ9LsDrrgRr3LwU=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr27482559ejk.658.1658170845590; Mon, 18
 Jul 2022 12:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-9-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-9-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 15:00:34 -0400
Message-ID: <CADnq5_MYHR256zeDaGpbs9=ax9LqmThWeZ0Ld4_YUfNeDMwuqw@mail.gmail.com>
Subject: Re: [PATCH 09/12] drm/amd/display: Remove unused MaxUsedBW variable
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
> Remove the variable MaxUsedBW from the function
> DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCal=
culation.
> As a side-effect, the variables MaxPerPlaneVActiveWRBandwidth and
> WRBandwidth are also removed.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:=
3043:10:
> warning: variable 'MaxUsedBW' set but not used [-Wunused-but-set-variable=
]
>                 double MaxUsedBW =3D 0;
>                        ^
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  .../dc/dml/dcn30/display_mode_vba_30.c        | 28 -------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 842eb94ebe04..876b321b30ca 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -3037,40 +3037,12 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchP=
arametersWatermarksAndPerforman
>
>         {
>                 //Maximum Bandwidth Used
> -               double TotalWRBandwidth =3D 0;
> -               double MaxPerPlaneVActiveWRBandwidth =3D 0;
> -               double WRBandwidth =3D 0;
> -               double MaxUsedBW =3D 0;
> -               for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
> -                       if (v->WritebackEnable[k] =3D=3D true
> -                                       && v->WritebackPixelFormat[k] =3D=
=3D dm_444_32) {
> -                               WRBandwidth =3D v->WritebackDestinationWi=
dth[k] * v->WritebackDestinationHeight[k]
> -                                               / (v->HTotal[k] * v->Writ=
ebackSourceHeight[k] / v->PixelClock[k]) * 4;
> -                       } else if (v->WritebackEnable[k] =3D=3D true) {
> -                               WRBandwidth =3D v->WritebackDestinationWi=
dth[k] * v->WritebackDestinationHeight[k]
> -                                               / (v->HTotal[k] * v->Writ=
ebackSourceHeight[k] / v->PixelClock[k]) * 8;
> -                       }
> -                       TotalWRBandwidth =3D TotalWRBandwidth + WRBandwid=
th;
> -                       MaxPerPlaneVActiveWRBandwidth =3D dml_max(MaxPerP=
laneVActiveWRBandwidth, WRBandwidth);
> -               }
> -
>                 v->TotalDataReadBandwidth =3D 0;
>                 for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
>                         v->TotalDataReadBandwidth =3D v->TotalDataReadBan=
dwidth
>                                         + v->ReadBandwidthPlaneLuma[k]
>                                         + v->ReadBandwidthPlaneChroma[k];
>                 }
> -
> -               {
> -                       double MaxPerPlaneVActiveRDBandwidth =3D 0;
> -                       for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
> -                               MaxPerPlaneVActiveRDBandwidth =3D dml_max=
(MaxPerPlaneVActiveRDBandwidth,
> -                                               v->ReadBandwidthPlaneLuma=
[k] + v->ReadBandwidthPlaneChroma[k]);
> -
> -                       }
> -               }
> -
> -               MaxUsedBW =3D MaxTotalRDBandwidth + TotalWRBandwidth;
>         }
>
>         // VStartup Margin
> --
> 2.36.1
>
