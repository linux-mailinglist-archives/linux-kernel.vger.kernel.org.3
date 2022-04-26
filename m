Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661855100D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbiDZOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbiDZOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:48:30 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACB1DFD4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:45:20 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e68392d626so14506809fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOtL5wcXcfwJhLOAEydGIIJp5UrBXd8LJmT1yWYvkhg=;
        b=hg60SGGEIYf9LGl/ckHOj11ljvLU6FltdZryKK3hKyICRySODEM+Ts9UOEfpUno8x1
         tvi2ettjfr7e11bCDm6tI65FtAcNtbaFVNwbO4ufUhHZMKQmiAkEnKFZRgYBgqjD+s3W
         5EcsKhiMpzd+jFYCkMFa8m4BVN6JcK+yFh7S8bsW/LU3CfsV5tZhE1MxXCZ1JYxO/pdZ
         JpyqDAV4Fy5dZ0WWgpcPV1QmzKo57ASHxpcb8H+OxhJFKCHtYk65ukCsSGeH9TjPWYA5
         6abFyXwweAOLTtP4k9WW7DP67UVllayYGv132yUVtizUaJD2HR8V8sNAydzY1gxWSy7M
         P8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOtL5wcXcfwJhLOAEydGIIJp5UrBXd8LJmT1yWYvkhg=;
        b=QIW0iRXAYToZfO2L4CwchV/QjvuzhNZzXwoNVxDyrtSZ3En6Rm7LcD731SfRvIhlBz
         oIwUi2gRzJ1Q3S4iqCvnXei54fS6+SZaMNXOU8bhpacZyz/ZjGv8WV/st1J6HySQJ+mx
         NfWTtDBNyqdwYO0dYPTudfOrAyjAVIaRyPFNqiQykx5D3kPRV/RZfYggbhrP+rpys+bx
         IqrkzuAb01fbtqeDHc/ib6kfPl4B66qTL8dkYIDweOu0tj3KDNdJIXoox0uEHavW79QT
         oDyCJP5jESNZHufGPYIoP4Lu1RaLRp+CIYQO8aLQRKNmLy6YCreSPTZ/11MRDUqBSImD
         91OA==
X-Gm-Message-State: AOAM5338ExvNBdR+YyUAxLwY7v0E6bo1QBV2KYni+UuFVq9Yt5Bazn+/
        FnPsUERgjtUDUtfc+ARt6JM0ZeTSbvFQ6ebhn2A=
X-Google-Smtp-Source: ABdhPJwHcWQUioAJE5Gzf7IrAv5O02o8R34v3YhNiHp4iz5J4jxvZx1WBL8DmYQhwimHz7+UeHiJbn/2VAy9Vof7z4U=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr9872967oap.253.1650984319966; Tue, 26
 Apr 2022 07:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220426084959.3345358-1-lizhenneng@kylinos.cn>
In-Reply-To: <20220426084959.3345358-1-lizhenneng@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 26 Apr 2022 10:45:08 -0400
Message-ID: <CADnq5_MoXnchJyB+VgXnv7RihXcmSCPuNcL8nE7GVfJW9KB34Q@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/radeon: Fix typo in comments
To:     Zhenneng Li <lizhenneng@kylinos.cn>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Apr 26, 2022 at 4:50 AM Zhenneng Li <lizhenneng@kylinos.cn> wrote:
>
> Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> ---
>  drivers/gpu/drm/radeon/atombios.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
> index bd5dc09e860f..6ccc9f31689f 100644
> --- a/drivers/gpu/drm/radeon/atombios.h
> +++ b/drivers/gpu/drm/radeon/atombios.h
> @@ -3599,7 +3599,7 @@ typedef struct  _ATOM_LCD_RTS_RECORD
>    UCHAR     ucRTSValue;
>  }ATOM_LCD_RTS_RECORD;
>
> -//!! If the record below exits, it shoud always be the first record for easy use in command table!!!
> +//!! If the record below exits, it should always be the first record for easy use in command table!!!
>  // The record below is only used when LVDS_Info is present. From ATOM_LVDS_INFO_V12, use ucLCDPanel_SpecialHandlingCap instead.
>  typedef struct  _ATOM_LCD_MODE_CONTROL_CAP
>  {
> @@ -3823,7 +3823,7 @@ typedef struct _ATOM_DPCD_INFO
>  // Note1: This table is filled by SetBiosReservationStartInFB in CoreCommSubs.asm
>  //        at running time.
>  // note2: From RV770, the memory is more than 32bit addressable, so we will change
> -//        ucTableFormatRevision=1,ucTableContentRevision=4, the strcuture remains
> +//        ucTableFormatRevision=1,ucTableContentRevision=4, the structure remains
>  //        exactly same as 1.1 and 1.2 (1.3 is never in use), but ulStartAddrUsedByFirmware
>  //        (in offset to start of memory address) is KB aligned instead of byte aligend.
>  /***********************************************************************************/
> @@ -3858,7 +3858,7 @@ typedef struct _ATOM_VRAM_USAGE_BY_FIRMWARE
>    ATOM_FIRMWARE_VRAM_RESERVE_INFO      asFirmwareVramReserveInfo[ATOM_MAX_FIRMWARE_VRAM_USAGE_INFO];
>  }ATOM_VRAM_USAGE_BY_FIRMWARE;
>
> -// change verion to 1.5, when allow driver to allocate the vram area for command table access.
> +// change version to 1.5, when allow driver to allocate the vram area for command table access.
>  typedef struct _ATOM_FIRMWARE_VRAM_RESERVE_INFO_V1_5
>  {
>    ULONG   ulStartAddrUsedByFirmware;
> --
> 2.25.1
>
