Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39845797E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiGSKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiGSKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:49:57 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8521824
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:49:56 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LnFw34t05z9sCL;
        Tue, 19 Jul 2022 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658227796; bh=Ri5omEkx4yywAb5vqBol9N6WX/R0pI30IilgPEksBS8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R4iCTQQwCkkrXuaLYhcBfpmGWcA/rVh2fkBNWldeEphZ6J9xIGykOTVgnB0X8Fc+0
         pNOO5YzgLU/xUAj5hB/+EMM6VwZdDdld0MvQDirckC9WwltHjY3YWHPILpzY36h+t/
         aaygKWGPOKx1NHtDuW16J0wXQN2+YSsY9xSVfJ44=
X-Riseup-User-ID: EEE829733DFF2080357C100C4A86768D5216BCF03DB2B109F65E97AD5C01DF6D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LnFvy0CXXz5vw2;
        Tue, 19 Jul 2022 10:49:49 +0000 (UTC)
Message-ID: <fef5812c-53e9-9222-e888-3556c6a9cc7a@riseup.net>
Date:   Tue, 19 Jul 2022 07:49:46 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 10/12] drm/amd/display: Remove parameters from
 dml30_CalculateWriteBackDISPCLK
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
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
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-10-mairacanal@riseup.net>
 <CADnq5_Ot2ecb=D7M2fznBWuZiC-OwPPAnfPfwFXbnrWcevAtzA@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <CADnq5_Ot2ecb=D7M2fznBWuZiC-OwPPAnfPfwFXbnrWcevAtzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 16:02, Alex Deucher wrote:
> On Thu, Jul 14, 2022 at 12:46 PM Maíra Canal <mairacanal@riseup.net> wrote:
>>
>> The parameters WritebackPixelFormat and WritebackVRatio are removed as
>> they are not used on the function dml30_CalculateWriteBackDISPCLK.
> 
> Maybe this is done for consistency with other dml code for other DCN blocks?
> 
> Alex

This is reasonable. Anyway, the functions
dml30_CalculateWriteBackDISPCLK and dml31_CalculateWriteBackDISPCLK are
identical. May I send a v2 from PATCH 11/12 with the original function
signature?

Best Regards,
- Maíra Canal

> 
>>
>> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
>> ---
>>  drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c        | 2 --
>>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 ------
>>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h  | 2 --
>>  3 files changed, 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
>> index a8db1306750e..746bb93ade6c 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
>> @@ -322,10 +322,8 @@ void dcn30_fpu_populate_dml_writeback_from_context(
>>                                  * parameters per pipe
>>                                  */
>>                                 writeback_dispclk = dml30_CalculateWriteBackDISPCLK(
>> -                                               dout_wb.wb_pixel_format,
>>                                                 pipes[pipe_cnt].pipe.dest.pixel_rate_mhz,
>>                                                 dout_wb.wb_hratio,
>> -                                               dout_wb.wb_vratio,
>>                                                 dout_wb.wb_htaps_luma,
>>                                                 dout_wb.wb_vtaps_luma,
>>                                                 dout_wb.wb_src_width,
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> index 876b321b30ca..37049daaab4c 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> @@ -1938,10 +1938,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>>                 if (v->WritebackEnable[k]) {
>>                         v->WritebackDISPCLK = dml_max(v->WritebackDISPCLK,
>>                                 dml30_CalculateWriteBackDISPCLK(
>> -                                               v->WritebackPixelFormat[k],
>>                                                 v->PixelClock[k],
>>                                                 v->WritebackHRatio[k],
>> -                                               v->WritebackVRatio[k],
>>                                                 v->WritebackHTaps[k],
>>                                                 v->WritebackVTaps[k],
>>                                                 v->WritebackSourceWidth[k],
>> @@ -3284,10 +3282,8 @@ static double CalculateTWait(
>>  }
>>
>>  double dml30_CalculateWriteBackDISPCLK(
>> -               enum source_format_class WritebackPixelFormat,
>>                 double PixelClock,
>>                 double WritebackHRatio,
>> -               double WritebackVRatio,
>>                 unsigned int WritebackHTaps,
>>                 unsigned int WritebackVTaps,
>>                 long   WritebackSourceWidth,
>> @@ -3794,10 +3790,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>>                 if (v->WritebackEnable[k] == true) {
>>                         v->WritebackRequiredDISPCLK = dml_max(v->WritebackRequiredDISPCLK,
>>                                         dml30_CalculateWriteBackDISPCLK(
>> -                                                       v->WritebackPixelFormat[k],
>>                                                         v->PixelClock[k],
>>                                                         v->WritebackHRatio[k],
>> -                                                       v->WritebackVRatio[k],
>>                                                         v->WritebackHTaps[k],
>>                                                         v->WritebackVTaps[k],
>>                                                         v->WritebackSourceWidth[k],
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
>> index daaf0883b84d..12c070434eee 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
>> @@ -29,10 +29,8 @@
>>  void dml30_recalculate(struct display_mode_lib *mode_lib);
>>  void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib);
>>  double dml30_CalculateWriteBackDISPCLK(
>> -               enum source_format_class WritebackPixelFormat,
>>                 double PixelClock,
>>                 double WritebackHRatio,
>> -               double WritebackVRatio,
>>                 unsigned int WritebackHTaps,
>>                 unsigned int WritebackVTaps,
>>                 long   WritebackSourceWidth,
>> --
>> 2.36.1
>>
