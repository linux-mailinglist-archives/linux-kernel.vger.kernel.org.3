Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76BB5789F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiGRS7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGRS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:59:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735252B267
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:59:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bp15so23029158ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=slpfovSxwH69MidbtOJcRY7uDQ6H4tBu5oDj8UdArpM=;
        b=ZBid+pAuHLootIpQ3LlrGlDWrvmgPtUN7AWBITQq4lkFGus1FxoKm70PWD/0QEEFmr
         Y1n8YB8A1dzrVRX4yR015vt3T87P20UqfcJeF4BIa0rSw5b/kYQT7GMapYpYRnqfXDWX
         frjLvOf8JgDbK1xGLbIDMVQq/gsEhmkcX9yED3NDZSHwgi5DguKXMo9suK9Dmi19G4xS
         j7OiA5YAdwQftYn5l1vv2wFBax+g8vmZzMZT0RUA2TkEX3KwDw5eSS2pazJZmCcZrDck
         MWozrVFaSRPqcsLY1IfkYS8Cqfd4aODloSdhMxWFjj79H6rTbws8y7+NxbdjeQiiuPUU
         B1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=slpfovSxwH69MidbtOJcRY7uDQ6H4tBu5oDj8UdArpM=;
        b=qNEXJ9Qfof4O6y9OyYc8fIAM3+2Dz7+uDRCq1F5ia+qQRHR6ee3HiZhSD6ewzliHVr
         f0zFjW/lZHNL7Lgh7CoTsVGCPIRlQ2g42CXA2/m8iJbmuEtJCcxRPIbefa6jZo12AEZw
         UNcaM++mUOyUPw7c2KhLfwqKZau5PZLnv1qd/UsflFlrWbNj0t+f8F9L/CvD0fTFwKhd
         Wi6hG6LSWI7Wx8Mf0GmS7+14pRsKr/g2+28/UoV+sJefLvTZGEr1OZz3qZX6WCQnW7Jv
         CTNQe0rTw7vYc4IYQLYgOL9sxGRd3/C+sRWJvEhp+hfbzwYMD8rcx9b84EZtRGMNA5Na
         Svpw==
X-Gm-Message-State: AJIora/Ep2dFKEXNdNwxWKOCXFSodmsTPDZW3L36aKtMrNt/Iq2zDjhz
        rk6F+2V1qbeBZ42nHxOKoFY8+YkpgDhK/u5QYri9jYgm
X-Google-Smtp-Source: AGRyM1uQZwoFvVHeSTMnTXBRgwIxT/NZ/PA/c59d2WUkP+agcYAww0Uht4SdtramGRzjUzzaTK8yd/mqI/nJOun+DTE=
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id
 hb35-20020a170907162300b0072b64e3878amr27789024ejc.185.1658170757048; Mon, 18
 Jul 2022 11:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-8-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-8-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 14:59:05 -0400
Message-ID: <CADnq5_NwQWjGvMVxqPG1LcJkCV1MMJt9d25sXFkFQ8zUDw0sng@mail.gmail.com>
Subject: Re: [PATCH 08/12] drm/amd/display: Remove unused variables from dcn10_stream_encoder
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
> The variable regval from the function enc1_update_generic_info_packet
> and the variables dynamic_range_rgb and dynamic_range_ycbcr from the
> function enc1_stream_encoder_dp_set_stream_attribute are not currently
> used.
>
> This was pointed by clang with the following warnings:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_stream_encoder.c:62:=
11:
> warning: variable 'regval' set but not used [-Wunused-but-set-variable]
>         uint32_t regval;
>                  ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_stream_encoder.c:262=
:10:
> warning: variable 'dynamic_range_rgb' set but not used [-Wunused-but-set-=
variable]
>         uint8_t dynamic_range_rgb =3D 0; /*full range*/
>                 ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_stream_encoder.c:263=
:10:
> warning: variable 'dynamic_range_ycbcr' set but not used [-Wunused-but-se=
t-variable]
>         uint8_t dynamic_range_ycbcr =3D 1; /*bt709*/
>                 ^
> 3 warnings generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  .../drm/amd/display/dc/dcn10/dcn10_stream_encoder.c    | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c =
b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> index c99c6fababa9..484e7cdf00b8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> @@ -59,7 +59,6 @@ void enc1_update_generic_info_packet(
>         uint32_t packet_index,
>         const struct dc_info_packet *info_packet)
>  {
> -       uint32_t regval;
>         /* TODOFPGA Figure out a proper number for max_retries polling fo=
r lock
>          * use 50 for now.
>          */
> @@ -88,7 +87,6 @@ void enc1_update_generic_info_packet(
>         REG_UPDATE(AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_CONFLICT_CLR, 1)=
;
>
>         /* choose which generic packet to use */
> -       regval =3D REG_READ(AFMT_VBI_PACKET_CONTROL);
>         REG_UPDATE(AFMT_VBI_PACKET_CONTROL,
>                         AFMT_GENERIC_INDEX, packet_index);
>
> @@ -259,8 +257,6 @@ void enc1_stream_encoder_dp_set_stream_attribute(
>         uint32_t h_back_porch;
>         uint8_t synchronous_clock =3D 0; /* asynchronous mode */
>         uint8_t colorimetry_bpc;
> -       uint8_t dynamic_range_rgb =3D 0; /*full range*/
> -       uint8_t dynamic_range_ycbcr =3D 1; /*bt709*/
>         uint8_t dp_pixel_encoding =3D 0;
>         uint8_t dp_component_depth =3D 0;
>
> @@ -372,18 +368,15 @@ void enc1_stream_encoder_dp_set_stream_attribute(
>         switch (output_color_space) {
>         case COLOR_SPACE_SRGB:
>                 misc1 =3D misc1 & ~0x80; /* bit7 =3D 0*/
> -               dynamic_range_rgb =3D 0; /*full range*/
>                 break;
>         case COLOR_SPACE_SRGB_LIMITED:
>                 misc0 =3D misc0 | 0x8; /* bit3=3D1 */
>                 misc1 =3D misc1 & ~0x80; /* bit7 =3D 0*/
> -               dynamic_range_rgb =3D 1; /*limited range*/
>                 break;
>         case COLOR_SPACE_YCBCR601:
>         case COLOR_SPACE_YCBCR601_LIMITED:
>                 misc0 =3D misc0 | 0x8; /* bit3=3D1, bit4=3D0 */
>                 misc1 =3D misc1 & ~0x80; /* bit7 =3D 0*/
> -               dynamic_range_ycbcr =3D 0; /*bt601*/
>                 if (hw_crtc_timing.pixel_encoding =3D=3D PIXEL_ENCODING_Y=
CBCR422)
>                         misc0 =3D misc0 | 0x2; /* bit2=3D0, bit1=3D1 */
>                 else if (hw_crtc_timing.pixel_encoding =3D=3D PIXEL_ENCOD=
ING_YCBCR444)
> @@ -393,15 +386,12 @@ void enc1_stream_encoder_dp_set_stream_attribute(
>         case COLOR_SPACE_YCBCR709_LIMITED:
>                 misc0 =3D misc0 | 0x18; /* bit3=3D1, bit4=3D1 */
>                 misc1 =3D misc1 & ~0x80; /* bit7 =3D 0*/
> -               dynamic_range_ycbcr =3D 1; /*bt709*/
>                 if (hw_crtc_timing.pixel_encoding =3D=3D PIXEL_ENCODING_Y=
CBCR422)
>                         misc0 =3D misc0 | 0x2; /* bit2=3D0, bit1=3D1 */
>                 else if (hw_crtc_timing.pixel_encoding =3D=3D PIXEL_ENCOD=
ING_YCBCR444)
>                         misc0 =3D misc0 | 0x4; /* bit2=3D1, bit1=3D0 */
>                 break;
>         case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
> -               dynamic_range_rgb =3D 1; /*limited range*/
> -               break;
>         case COLOR_SPACE_2020_RGB_FULLRANGE:
>         case COLOR_SPACE_2020_YCBCR:
>         case COLOR_SPACE_XR_RGB:
> --
> 2.36.1
>
