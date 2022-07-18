Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6615789DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiGRSzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGRSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:55:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CA2F038
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:55:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b11so22957176eju.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kIztP35AVtY3Dcob7hWoCvvqV3w68ASQI2y6wb5SraQ=;
        b=RBl+Jgtzs8yMw7hGgLK07sQQzjRDR2jlkfoiPAfrQ7bdIBR5roZdVpOF6TP0JKUEgw
         D1APVjySG+bYk87HAgHZtPMwzxloM57fqDhnzbrKiIbD1fN+zr6ciE/glmOUT/V/05a0
         guvlG+o0NDHaAUycP+F/YfXDhbtsvGqUP1HVi4G/ZwyXU1MxD+zYyY+TUnpZ06fapJv0
         EcaQW5E0bLUgmikV7YvQL498m1fLwroFLJArVUqinpldJWcA8Zj2VEPI0dxLI3xD9anG
         UrFKXa4aJfR+B1CPx5avjPTvPdJgY8K6sLbYZJtj53AfRhyHfUJkCM7uLXgd4yfMsqiy
         5LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kIztP35AVtY3Dcob7hWoCvvqV3w68ASQI2y6wb5SraQ=;
        b=5IdafYY++MhkHMrrECWrph95Q14Z+o0gChX3lLTdowY3Xyjq8ygIrdSKMVo2LIDF6M
         IwfcvuyWzMFBq59uOtu+pT/O1eo17eLp2LnDJWKSMnLSVbvGktziMZ89preuoOBJV+rN
         bn0kBnF68L7L5Y+ZYq0RmyqXGLCat3J56YzPnNrcfARjfOHRp5BLn7DkHGI1j3DKJWeY
         fZXvwTP6aepZ8MBKcW/9HF4bVBXpzxy9ZbzZNHFSOyLyYYSvKmzyZVv4ezYF/Ir2Yars
         2AzWMQP7sBfYH5HowA9yjdrWI1/lGSkKdAJ0HjEt84BBLpMn4ajXXbgzZ0THvqQk8TTi
         69KA==
X-Gm-Message-State: AJIora8drq5in7Wdr6NmP51XMb6JoiJR0GsRuEDBGUy2RxLrKuzoHirh
        0L8O3X8fZ/Vh6z5NdTzmmpdLEnEOSEkwN7ncpig=
X-Google-Smtp-Source: AGRyM1vYAJVMzNxF8xuwyGfk2rC1AOsPwP3wd79f+FSLIzqPaQWQFIhAwMZ/cdRPI9PmmdhfukyY31rILgVLsvv7dgE=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr27463747ejk.658.1658170532827; Mon, 18
 Jul 2022 11:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-5-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-5-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 14:55:21 -0400
Message-ID: <CADnq5_M18H3J1dCxjMCdT6V=TuNhC+oySpidJEXJzL-d_dMg5A@mail.gmail.com>
Subject: Re: [PATCH 05/12] drm/amd/display: Remove unused NumberOfStates variable
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
> Remove the unused unsigned int NumberOfStates from the file, which was
> declared but never hooked up.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:=
33:27:
> warning: unused variable 'NumberOfStates' [-Wunused-const-variable]
> static const unsigned int NumberOfStates =3D DC__VOLTAGE_STATES;
>                           ^
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index c6c3a9e6731a..dff8f8f27de4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -30,8 +30,6 @@
>  #include "../dml_inline_defs.h"
>  #include "display_mode_vba_util_32.h"
>
> -static const unsigned int NumberOfStates =3D DC__VOLTAGE_STATES;
> -
>  void dml32_recalculate(struct display_mode_lib *mode_lib);
>  static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP=
erformanceCalculation(
>                 struct display_mode_lib *mode_lib);
> --
> 2.36.1
>
