Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE0567283
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiGEPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiGEPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:25:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE91183A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:25:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d2so22307014ejy.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b82nd9N2NQ5PIgXaKHihSROQIOE6Sh+xDQ2S0TRBk8o=;
        b=QmhOB4Nh/I08thTXMmIahvYtPZlpl3sQDpvQIDvcMppE6YIf1ZDa23SEh5Mk/Js6t8
         iyOmMoSFZsyBL4UOOGJmtyGzBLhXem1ZfC2npo603cyTtuj7d/N8iTsEELGP4cLuZQr5
         xMLplpUefVzxLFqSbRhAh/jdzhwFL+GlyPJlFSvSjasFypeZ8smgZ6uFxojJ7eqdFVqn
         y/4XO25HkdB2k1/dOuWmWdDF69RYJeM804d9KKvnoDkz1yOOY+teEEYOYM2F95/VpEHw
         TBG+pv7921YOYjoT+ERpwrPZe11RCkX9/1Mpqi+nf5pWlEyzgAHNgTjtQ4S6zXQM1gzT
         82vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b82nd9N2NQ5PIgXaKHihSROQIOE6Sh+xDQ2S0TRBk8o=;
        b=CjnsFo7kRXH09Vxnk1YSdwHEa2MOMWeBpCI8xqH76E/Sr9dSz27TalJ1XMz4so9Kb+
         NJQ04ktkvm4se8NFRJO9cCkq0mtc2XOw3+1hYvwwNlUCdSAk0P6lYiI+aJ/1XTMde1j+
         9dWF7VZ2d8sxsXr6q44WWWXBdbrQzsb8H2CU0lLf5UOnM0tV9yBdPqxF11dD17SV0ejJ
         L0TXmlVEq+2ovBVl0AEw4c/n2OW7o+dexVAWDh4F9Z8F3swkXKOobw/u4ny5CFyZy22w
         14v+AGlblatWSgyaF94vLNAS+8i3m008Sm1CKedNSrzNJ7TOM00MicIUROXn54HO/dSV
         Wz4w==
X-Gm-Message-State: AJIora91XZq2lOLawHOqbX7SHWXXVRwQ3ahg2LFQhK+n+Rivkjt6NdGy
        I71Bw0yGB6zI1Zl9uucYY9ks1KeTP5lcIpgIwHw=
X-Google-Smtp-Source: AGRyM1sDuL7rGLTr45iig6VwfKtGfXv+dgL+1iLmPkeblfw8W3jLfgMmEqY2MzRkHo9alDBGHRZ5z2KyuL9LZPqJ6DA=
X-Received: by 2002:a17:906:5d0b:b0:726:a043:fcb4 with SMTP id
 g11-20020a1709065d0b00b00726a043fcb4mr35115739ejt.508.1657034745783; Tue, 05
 Jul 2022 08:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220630215316.1078841-1-mairacanal@riseup.net>
In-Reply-To: <20220630215316.1078841-1-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Jul 2022 11:25:34 -0400
Message-ID: <CADnq5_NWT-sMUMkgTU4gwjk4uX15ZYgrAV1KLPJpgLY+sEqi+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused variables from vba_vars_st
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Jun 30, 2022 at 5:53 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> Some variables from the struct vba_vars_st are not referenced in any
> other place on the codebase. As they are not used, this commit removes
> those variables.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>
> Unused variables from structs are not warned by compilers, so they are a =
bit
> harder to find. In order to find these unused variables, I used git grep =
and
> checked if they were used anywhere else.
>
> Any feedback or suggestion (maybe a tool to check unused variables from s=
tructs)
> is welcomed!
>
> Best Regards,
> - Ma=C3=ADra Canal
>
> ---
>  .../drm/amd/display/dc/dml/display_mode_vba.c |  1 -
>  .../drm/amd/display/dc/dml/display_mode_vba.h | 33 -------------------
>  2 files changed, 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> index ed23c7c79d86..6b3918609d26 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> @@ -346,7 +346,6 @@ static void fetch_socbb_params(struct display_mode_li=
b *mode_lib)
>         mode_lib->vba.DRAMClockChangeRequirementFinal =3D 1;
>         mode_lib->vba.FCLKChangeRequirementFinal =3D 1;
>         mode_lib->vba.USRRetrainingRequiredFinal =3D 1;
> -       mode_lib->vba.ConfigurableDETSizeEnFinal =3D 0;
>         mode_lib->vba.AllowForPStateChangeOrStutterInVBlankFinal =3D soc-=
>allow_for_pstate_or_stutter_in_vblank_final;
>         mode_lib->vba.DRAMClockChangeLatency =3D soc->dram_clock_change_l=
atency_us;
>         mode_lib->vba.DummyPStateCheck =3D soc->dram_clock_change_latency=
_us =3D=3D soc->dummy_pstate_latency_us;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 25a9a606ab6f..e95b2199d85a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -232,7 +232,6 @@ struct vba_vars_st {
>         double DISPCLKWithRampingRoundedToDFSGranularity;
>         double DISPCLKWithoutRampingRoundedToDFSGranularity;
>         double MaxDispclkRoundedToDFSGranularity;
> -       double MaxDppclkRoundedToDFSGranularity;
>         bool DCCEnabledAnyPlane;
>         double ReturnBandwidthToDCN;
>         unsigned int TotalActiveDPP;
> @@ -249,7 +248,6 @@ struct vba_vars_st {
>         double VBlankTime;
>         double SmallestVBlank;
>         enum dm_prefetch_modes AllowForPStateChangeOrStutterInVBlankFinal=
; // Mode Support only
> -       double DCFCLKDeepSleepPerSurface[DC__NUM_DPP__MAX];
>         double DCFCLKDeepSleepPerPlane[DC__NUM_DPP__MAX];
>         double EffectiveDETPlusLBLinesLuma;
>         double EffectiveDETPlusLBLinesChroma;
> @@ -297,7 +295,6 @@ struct vba_vars_st {
>         double SMNLatency;
>         double FCLKChangeLatency;
>         unsigned int MALLAllocatedForDCNFinal;
> -       double DefaultGPUVMMinPageSizeKBytes; // Default for the project
>         double MaxAveragePercentOfIdealFabricBWDisplayCanUseInNormalSyste=
mOperation;
>         double MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemO=
perationSTROBE;
>         double PercentOfIdealDRAMBWReceivedAfterUrgLatencySTROBE;
> @@ -819,8 +816,6 @@ struct vba_vars_st {
>         double         dummy8[DC__NUM_DPP__MAX];
>         double         dummy13[DC__NUM_DPP__MAX];
>         double         dummy_double_array[2][DC__NUM_DPP__MAX];
> -       unsigned int        dummyinteger1ms[DC__NUM_DPP__MAX];
> -       double        dummyinteger2ms[DC__NUM_DPP__MAX];
>         unsigned int        dummyinteger3[DC__NUM_DPP__MAX];
>         unsigned int        dummyinteger4[DC__NUM_DPP__MAX];
>         unsigned int        dummyinteger5;
> @@ -830,16 +825,7 @@ struct vba_vars_st {
>         unsigned int        dummyinteger9;
>         unsigned int        dummyinteger10;
>         unsigned int        dummyinteger11;
> -       unsigned int        dummyinteger12;
> -       unsigned int        dummyinteger30;
> -       unsigned int        dummyinteger31;
> -       unsigned int        dummyinteger32;
> -       unsigned int        dummyintegerarr1[DC__NUM_DPP__MAX];
> -       unsigned int        dummyintegerarr2[DC__NUM_DPP__MAX];
> -       unsigned int        dummyintegerarr3[DC__NUM_DPP__MAX];
> -       unsigned int        dummyintegerarr4[DC__NUM_DPP__MAX];
>         unsigned int        dummy_integer_array[8][DC__NUM_DPP__MAX];
> -       unsigned int        dummy_integer_array22[22][DC__NUM_DPP__MAX];
>
>         bool           dummysinglestring;
>         bool           SingleDPPViewportSizeSupportPerPlane[DC__NUM_DPP__=
MAX];
> @@ -980,7 +966,6 @@ struct vba_vars_st {
>         double TimePerChromaMetaChunkFlip[DC__NUM_DPP__MAX];
>         unsigned int DCCCMaxUncompressedBlock[DC__NUM_DPP__MAX];
>         unsigned int DCCCMaxCompressedBlock[DC__NUM_DPP__MAX];
> -       unsigned int DCCCIndependent64ByteBlock[DC__NUM_DPP__MAX];
>         double VStartupMargin;
>         bool NotEnoughTimeForDynamicMetadata[DC__NUM_DPP__MAX];
>
> @@ -1085,8 +1070,6 @@ struct vba_vars_st {
>         double WritebackDelayTime[DC__NUM_DPP__MAX];
>         unsigned int DCCYIndependentBlock[DC__NUM_DPP__MAX];
>         unsigned int DCCCIndependentBlock[DC__NUM_DPP__MAX];
> -       unsigned int dummyinteger15;
> -       unsigned int dummyinteger16;
>         unsigned int dummyinteger17;
>         unsigned int dummyinteger18;
>         unsigned int dummyinteger19;
> @@ -1147,17 +1130,11 @@ struct vba_vars_st {
>         int Z8NumberOfStutterBurstsPerFrame;
>         unsigned int MaximumDSCBitsPerComponent;
>         unsigned int NotEnoughUrgentLatencyHidingA[DC__VOLTAGE_STATES][2]=
;
> -       double UrgentLatencyWithUSRRetraining;
> -       double UrgLatencyWithUSRRetraining[DC__VOLTAGE_STATES];
>         double ReadBandwidthSurfaceLuma[DC__NUM_DPP__MAX];
>         double ReadBandwidthSurfaceChroma[DC__NUM_DPP__MAX];
>         double SurfaceRequiredDISPCLKWithoutODMCombine;
>         double SurfaceRequiredDISPCLK;
> -       double SurfaceRequiredDISPCLKWithODMCombine2To1;
> -       double SurfaceRequiredDISPCLKWithODMCombine4To1;
>         double MinActiveFCLKChangeLatencySupported;
> -       double dummy14;
> -       double dummy15;
>         int MinVoltageLevel;
>         int MaxVoltageLevel;
>         unsigned int TotalNumberOfSingleDPPSurfaces[DC__VOLTAGE_STATES][2=
];
> @@ -1168,17 +1145,10 @@ struct vba_vars_st {
>         bool ExceededMALLSize;
>         bool PTE_BUFFER_MODE[DC__NUM_DPP__MAX];
>         unsigned int BIGK_FRAGMENT_SIZE[DC__NUM_DPP__MAX];
> -       unsigned int dummyinteger33;
>         unsigned int CompressedBufferSizeInkByteThisState;
>         enum dm_fclock_change_support FCLKChangeSupport[DC__VOLTAGE_STATE=
S][2];
> -       Latencies myLatency;
> -       Latencies mLatency;
> -       Watermarks DummyWatermark;
>         bool USRRetrainingSupport[DC__VOLTAGE_STATES][2];
> -       bool dummyBooleanvector1[DC__NUM_DPP__MAX];
> -       bool dummyBooleanvector2[DC__NUM_DPP__MAX];
>         enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[D=
C__NUM_DPP__MAX];
> -       bool NotEnoughUrgentLatencyHiding_dml32[DC__VOLTAGE_STATES][2];
>         bool UnboundedRequestEnabledAllStates[DC__VOLTAGE_STATES][2];
>         bool SingleDPPViewportSizeSupportPerSurface[DC__NUM_DPP__MAX];
>         enum dm_use_mall_for_static_screen_mode UseMALLForStaticScreen[DC=
__NUM_DPP__MAX];
> @@ -1186,9 +1156,6 @@ struct vba_vars_st {
>         bool DRAMClockChangeRequirementFinal;
>         bool FCLKChangeRequirementFinal;
>         bool USRRetrainingRequiredFinal;
> -       bool MALLUseFinal;
> -       bool ConfigurableDETSizeEnFinal;
> -       bool dummyboolean;
>         unsigned int DETSizeOverride[DC__NUM_DPP__MAX];
>         unsigned int nomDETInKByte;
>         enum mpc_combine_affinity  MPCCombineUse[DC__NUM_DPP__MAX];
> --
> 2.36.1
>
