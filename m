Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578955789D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiGRSyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGRSyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:54:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CB32E9C9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:54:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id z23so22986396eju.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oGwjE6MIwO4ucRosF+8m5EnWnpdyb5yp48oQst1QNMs=;
        b=Hw/cn955r/+L1mdh7/c5e/DT+5UqIfu0y3ea6tKR6CyaJ9S5iNsdwx+JFPhDHvAMAi
         pBAtYPvKlwTL6EJKbCJontOplOeipTpHFNlHopuvVaRAwz9lSjChwOl/kcmP13Yf/wAF
         4Xf+Io0yb+Pn6H09XEqRRqTQXauDq88ix8d0WmnbxD30Lxh2Cn1dVUjLewfzlKy/ajKO
         /5xNRs+yZo33NRk400jh1IRcY1ijRv1opDzReGVUQxM3+aOWGEjTdYESbKBFrrHk5hMa
         0YqwT4Gg4qmh6iYJSXxFfbJZLpZOBUiWXCw9SipgMxMF6fRi0uoR679GUzZfYRA+/B64
         4IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oGwjE6MIwO4ucRosF+8m5EnWnpdyb5yp48oQst1QNMs=;
        b=XpEl7Db6e82puhcQEmZBNFrfREsiYrls9A9J945JAg7TkXXHAVYkIW7EkQBMFCmC3u
         OH0dS87Zm11Mt0MugqVvCu4lhS8OrdBNR3GMgPZ9HuxLXFIW1XADZrrsW+dqDXwEvdTL
         MSsqsUU0lGhllVH6q+WKYtK5s9PAXRVOtVILVLuqdhPLInX/5/hYofBSpJ7cpDMmCTxY
         3SOUK0lh6AZszrEDtEPWrV0Ca7ylKMOJuJF01bsQ6gznkepkexT/s9aLIPNmE5Gz82K8
         KTiizzfUWGgS2onDLSMjDiacFXS9xEuiped+Qm++KPIKOBHqstO+NuEJPFtXTLLhy6+7
         ph6A==
X-Gm-Message-State: AJIora/qZ5i7fiu57vMT9hcDsK1UV/7ilnT79cMkG/DYqLW75atfGlrV
        3vUdllfpzkj7PmgY7hvMuHpKjFaAWVgO9kd59K4=
X-Google-Smtp-Source: AGRyM1tIqrsFMSjGxNxpvTlCjK1sMKGBOFkixBpGEmhMeK/QEH2R/OkK4amX3VBUABiVM3Ewf6/2CQZUDdUFIu/lTms=
X-Received: by 2002:a17:906:58d5:b0:72f:2b21:eb20 with SMTP id
 e21-20020a17090658d500b0072f2b21eb20mr6790627ejs.508.1658170476337; Mon, 18
 Jul 2022 11:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-4-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-4-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 14:54:24 -0400
Message-ID: <CADnq5_M5UjWbN2N=zr-BGRcha-2Q+jSC5MXScU+nt6LD=_fs8w@mail.gmail.com>
Subject: Re: [PATCH 04/12] drm/amd/display: Remove unused dml32_CalculatedoublePipeDPPCLKAndSCLThroughput
 function
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

On Thu, Jul 14, 2022 at 12:45 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove dml32_CalculatedoublePipeDPPCLKAndSCLThroughput function, which is=
 not used in
> the codebase.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_=
32.c:393:6:
> warning: no previous prototype for function
> 'dml32_CalculatedoublePipeDPPCLKAndSCLThroughput' [-Wmissing-prototypes]
> void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
>      ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_=
32.c:393:1:
> note: declare 'static' if the function is not intended to be used outside=
 of
> this translation unit
> void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
> ^
> static
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  .../dc/dml/dcn32/display_mode_vba_util_32.c   | 54 -------------------
>  1 file changed, 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_ut=
il_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32=
.c
> index 5a701d9df0f7..4d62ab0c1a78 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -390,60 +390,6 @@ void dml32_CalculateBytePerPixelAndBlockSizes(
>  #endif
>  } // CalculateBytePerPixelAndBlockSizes
>
> -void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
> -               double HRatio,
> -               double HRatioChroma,
> -               double VRatio,
> -               double VRatioChroma,
> -               double MaxDCHUBToPSCLThroughput,
> -               double MaxPSCLToLBThroughput,
> -               double PixelClock,
> -               enum source_format_class SourcePixelFormat,
> -               unsigned int HTaps,
> -               unsigned int HTapsChroma,
> -               unsigned int VTaps,
> -               unsigned int VTapsChroma,
> -
> -               /* output */
> -               double *PSCL_THROUGHPUT,
> -               double *PSCL_THROUGHPUT_CHROMA,
> -               double *DPPCLKUsingdoubleDPP)
> -{
> -       double DPPCLKUsingdoubleDPPLuma;
> -       double DPPCLKUsingdoubleDPPChroma;
> -
> -       if (HRatio > 1) {
> -               *PSCL_THROUGHPUT =3D dml_min(MaxDCHUBToPSCLThroughput, Ma=
xPSCLToLBThroughput * HRatio /
> -                               dml_ceil((double) HTaps / 6.0, 1.0));
> -       } else {
> -               *PSCL_THROUGHPUT =3D dml_min(MaxDCHUBToPSCLThroughput, Ma=
xPSCLToLBThroughput);
> -       }
> -
> -       DPPCLKUsingdoubleDPPLuma =3D PixelClock * dml_max3(VTaps / 6 * dm=
l_min(1, HRatio), HRatio * VRatio /
> -                       *PSCL_THROUGHPUT, 1);
> -
> -       if ((HTaps > 6 || VTaps > 6) && DPPCLKUsingdoubleDPPLuma < 2 * Pi=
xelClock)
> -               DPPCLKUsingdoubleDPPLuma =3D 2 * PixelClock;
> -
> -       if ((SourcePixelFormat !=3D dm_420_8 && SourcePixelFormat !=3D dm=
_420_10 && SourcePixelFormat !=3D dm_420_12 &&
> -                       SourcePixelFormat !=3D dm_rgbe_alpha)) {
> -               *PSCL_THROUGHPUT_CHROMA =3D 0;
> -               *DPPCLKUsingdoubleDPP =3D DPPCLKUsingdoubleDPPLuma;
> -       } else {
> -               if (HRatioChroma > 1) {
> -                       *PSCL_THROUGHPUT_CHROMA =3D dml_min(MaxDCHUBToPSC=
LThroughput, MaxPSCLToLBThroughput *
> -                                       HRatioChroma / dml_ceil((double) =
HTapsChroma / 6.0, 1.0));
> -               } else {
> -                       *PSCL_THROUGHPUT_CHROMA =3D dml_min(MaxDCHUBToPSC=
LThroughput, MaxPSCLToLBThroughput);
> -               }
> -               DPPCLKUsingdoubleDPPChroma =3D PixelClock * dml_max3(VTap=
sChroma / 6 * dml_min(1, HRatioChroma),
> -                               HRatioChroma * VRatioChroma / *PSCL_THROU=
GHPUT_CHROMA, 1);
> -               if ((HTapsChroma > 6 || VTapsChroma > 6) && DPPCLKUsingdo=
ubleDPPChroma < 2 * PixelClock)
> -                       DPPCLKUsingdoubleDPPChroma =3D 2 * PixelClock;
> -               *DPPCLKUsingdoubleDPP =3D dml_max(DPPCLKUsingdoubleDPPLum=
a, DPPCLKUsingdoubleDPPChroma);
> -       }
> -}
> -
>  void dml32_CalculateSwathAndDETConfiguration(
>                 unsigned int DETSizeOverride[],
>                 enum dm_use_mall_for_pstate_change_mode UseMALLForPStateC=
hange[],
> --
> 2.36.1
>
