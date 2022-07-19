Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A59057A012
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiGSNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiGSNvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:51:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540CF1112D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:03:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sz17so27021290ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KxQYN1a3ZGfB1KOqQ5k407MEFQumt7EgdtfRF8EZXWc=;
        b=h0d/jj6QF54fTlzQ2C4SclHkOfXgT+pVprPhXVapFUzBTN56U/6xdpVijg8B6pGKn1
         ZdxszDIKt6HuOtLmtxHjziCOMdDMnThWOswz6jvA5o8DmLR4DyUTeKsEJk3PD+rXUXSU
         ilvAg66Am7Ikj6/msciZJJm4j4Xl7+sQyDCqIWgpF18AHrMGFZcgaDsvCrkxPdNQTpFH
         rrp512V/CQvFgiOxzH53+VrJ1ti1ZScqfqtpMv8TE8qtWpeVO6V2dF6Cy32Kg5Nfelqw
         SjLPoci2e2nrTbqTwNk92pyJ7tzImNgfcvJXYkyiWfpJfYImygNBIGl04fdwiKL6xlxT
         r3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KxQYN1a3ZGfB1KOqQ5k407MEFQumt7EgdtfRF8EZXWc=;
        b=Sdl+YDM8HOndijfp56ejpW9yhQcRGuq4njPKNbrb/FOH8K4WYQlZLz5ZYgnVW7UgRa
         7OB4/JqU/q5YUCcjx9gqMESjIwbs3mA+CuhLyb58liqbWalGXjGFBr6JVXn9MGKzH+4Y
         1QbpNMKegcEbfW8bliTkGDJgtlHOScVX0sWG4U5Nze2pakDdnaw2UAk2z2PbcmgFx8Dg
         Lvv9cBABTXBYU/4EH9WMMyxxn4Qv1Lv0jALGzyxX3mC0wtC/kesNk8Zvyx8ilMwK4GU4
         qopdtYiaxMiOdVnhieUlxZCZSH8bti1SKYJK6AMFDSfK67EkALKBQFte6d2GgKsNhi8U
         btyg==
X-Gm-Message-State: AJIora9MAIEMaWm9jf0PGwFGm8b9sNZHMiKdTCZBXb5CL0Vasi535EzB
        jyDVDm3cMg0bnOZHEUrCq0SXRmjdwTZbNnA4r7Y=
X-Google-Smtp-Source: AGRyM1uRm9Fj0U0RWtE9K6bHZ7V4KioIK5xyrjD5MLJ3IY09CuC6+9GYnh29PUvWdMfk0Fier4w1MWixWHujw4hSHm4=
X-Received: by 2002:a17:906:9751:b0:72f:1b36:e1de with SMTP id
 o17-20020a170906975100b0072f1b36e1demr14314745ejy.451.1658235822618; Tue, 19
 Jul 2022 06:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-10-mairacanal@riseup.net> <CADnq5_Ot2ecb=D7M2fznBWuZiC-OwPPAnfPfwFXbnrWcevAtzA@mail.gmail.com>
 <fef5812c-53e9-9222-e888-3556c6a9cc7a@riseup.net>
In-Reply-To: <fef5812c-53e9-9222-e888-3556c6a9cc7a@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Jul 2022 09:03:30 -0400
Message-ID: <CADnq5_O93QfDTKCoL4scVRMqLjP2Rtm2kB4+80GeM7b_oMT_+w@mail.gmail.com>
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

On Tue, Jul 19, 2022 at 6:49 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> On 7/18/22 16:02, Alex Deucher wrote:
> > On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.ne=
t> wrote:
> >>
> >> The parameters WritebackPixelFormat and WritebackVRatio are removed as
> >> they are not used on the function dml30_CalculateWriteBackDISPCLK.
> >
> > Maybe this is done for consistency with other dml code for other DCN bl=
ocks?
> >
> > Alex
>
> This is reasonable. Anyway, the functions
> dml30_CalculateWriteBackDISPCLK and dml31_CalculateWriteBackDISPCLK are
> identical. May I send a v2 from PATCH 11/12 with the original function
> signature?

Sounds good.  Thanks!

Alex

>
> Best Regards,
> - Ma=C3=ADra Canal
>
> >
> >>
> >> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> >> ---
> >>  drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c        | 2 --
> >>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 -----=
-
> >>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h  | 2 --
> >>  3 files changed, 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/dr=
ivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> index a8db1306750e..746bb93ade6c 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> @@ -322,10 +322,8 @@ void dcn30_fpu_populate_dml_writeback_from_contex=
t(
> >>                                  * parameters per pipe
> >>                                  */
> >>                                 writeback_dispclk =3D dml30_CalculateW=
riteBackDISPCLK(
> >> -                                               dout_wb.wb_pixel_forma=
t,
> >>                                                 pipes[pipe_cnt].pipe.d=
est.pixel_rate_mhz,
> >>                                                 dout_wb.wb_hratio,
> >> -                                               dout_wb.wb_vratio,
> >>                                                 dout_wb.wb_htaps_luma,
> >>                                                 dout_wb.wb_vtaps_luma,
> >>                                                 dout_wb.wb_src_width,
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba=
_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> index 876b321b30ca..37049daaab4c 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> @@ -1938,10 +1938,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetc=
hParametersWatermarksAndPerforman
> >>                 if (v->WritebackEnable[k]) {
> >>                         v->WritebackDISPCLK =3D dml_max(v->WritebackDI=
SPCLK,
> >>                                 dml30_CalculateWriteBackDISPCLK(
> >> -                                               v->WritebackPixelForma=
t[k],
> >>                                                 v->PixelClock[k],
> >>                                                 v->WritebackHRatio[k],
> >> -                                               v->WritebackVRatio[k],
> >>                                                 v->WritebackHTaps[k],
> >>                                                 v->WritebackVTaps[k],
> >>                                                 v->WritebackSourceWidt=
h[k],
> >> @@ -3284,10 +3282,8 @@ static double CalculateTWait(
> >>  }
> >>
> >>  double dml30_CalculateWriteBackDISPCLK(
> >> -               enum source_format_class WritebackPixelFormat,
> >>                 double PixelClock,
> >>                 double WritebackHRatio,
> >> -               double WritebackVRatio,
> >>                 unsigned int WritebackHTaps,
> >>                 unsigned int WritebackVTaps,
> >>                 long   WritebackSourceWidth,
> >> @@ -3794,10 +3790,8 @@ void dml30_ModeSupportAndSystemConfigurationFul=
l(struct display_mode_lib *mode_l
> >>                 if (v->WritebackEnable[k] =3D=3D true) {
> >>                         v->WritebackRequiredDISPCLK =3D dml_max(v->Wri=
tebackRequiredDISPCLK,
> >>                                         dml30_CalculateWriteBackDISPCL=
K(
> >> -                                                       v->WritebackPi=
xelFormat[k],
> >>                                                         v->PixelClock[=
k],
> >>                                                         v->WritebackHR=
atio[k],
> >> -                                                       v->WritebackVR=
atio[k],
> >>                                                         v->WritebackHT=
aps[k],
> >>                                                         v->WritebackVT=
aps[k],
> >>                                                         v->WritebackSo=
urceWidth[k],
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba=
_30.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> >> index daaf0883b84d..12c070434eee 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> >> @@ -29,10 +29,8 @@
> >>  void dml30_recalculate(struct display_mode_lib *mode_lib);
> >>  void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_=
lib *mode_lib);
> >>  double dml30_CalculateWriteBackDISPCLK(
> >> -               enum source_format_class WritebackPixelFormat,
> >>                 double PixelClock,
> >>                 double WritebackHRatio,
> >> -               double WritebackVRatio,
> >>                 unsigned int WritebackHTaps,
> >>                 unsigned int WritebackVTaps,
> >>                 long   WritebackSourceWidth,
> >> --
> >> 2.36.1
> >>
