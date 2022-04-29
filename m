Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE9514F38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378341AbiD2PZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378312AbiD2PZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:25:29 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34016E578
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:22:06 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id o2-20020a4ad142000000b0035e6578a91dso1455526oor.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+DTHrGocYEnsx8UpZfYt0DEA/hgChvlIlx/pAh4pkU=;
        b=KQVtVPETgJvBSDysXxszhyiXYd/K/cQ8EVxwrm8J3VbKGHlQsZR2b08U9l6ymbOL7C
         RMkxD8tL1dIO2zOexnCXA7CwqgVjaQVqDTtcsHJHw9YWXJCCs5X6L7FYOuUAXaP8+Bl6
         C8eYmizVHCJULnI8LszL5U3K2G+6EmMqUQPQ3d7QRWjdnBBDMUarfUBzkwmCMztScKu2
         bnYB4yXkUGotg+PrUiv4UqZgpqcrCq0fPJsVZkfBKhvpaS3Dp5rC8wJxtEJnVh/IlO2Y
         e0rGD6Ke3q0ZcqCNEPEcpHkjFdbuF4t3yl5NYFtxOFDKIaDYKwlhDcXvARKb+fN0Yq43
         L6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+DTHrGocYEnsx8UpZfYt0DEA/hgChvlIlx/pAh4pkU=;
        b=QOJQkC49MRzHIL0m6bpBI6nAS76Zp+ccZZik008+n8cAOe678Tpi+O83QrxQnv69nD
         6IumtHI4FLiBEpmPe5e5x0B79mOCx0NaEdhurHIkYNEWfiFKdcY4WuL3PIfQ67tgKefC
         8mJAVThPBIiieJfbis6D9Ml+Xe/5+kjkVOCnH0+VTzvRbRhaUXFVNiw/OkYAZrfhb/8b
         f/2VquLrax7vLdJiEcM0cAOo0NI7kmobDaFFb8akUEpZqWL/XhadJGAa3BodqWvThOYD
         BJYkfmKejcYXhGasapqwoHlrJvaNfDpl3+EFvmLwmZCjYWKpgc57ZqM9xuT3JSdDF6Jm
         G7nw==
X-Gm-Message-State: AOAM533qWf5dOiwE6rs/hmx4jes4Ub7wiSs8uG3qggWoQ4iLgkm3dFd3
        McpeuLSqAce4Yk1HUY/XLMwzC+lYFXX3KWpSUpc=
X-Google-Smtp-Source: ABdhPJyaaaTDzP9DdMpdCfjPvWy/5Fazu0kIMb5JMRStfSaX8RLGOvvToLXZnNaJ71B04V9OrLAGHviQK/eeA1RaMDM=
X-Received: by 2002:a4a:e2ca:0:b0:35e:b623:8799 with SMTP id
 l10-20020a4ae2ca000000b0035eb6238799mr1491020oot.68.1651245726093; Fri, 29
 Apr 2022 08:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220429015114.29795-1-pengfuyuan@kylinos.cn>
In-Reply-To: <20220429015114.29795-1-pengfuyuan@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 29 Apr 2022 11:21:55 -0400
Message-ID: <CADnq5_OvRxCdQw6LnorswgYSByGjDJAyWcX-ZvUbLHkG6Xim9Q@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/radeon: Fix spelling typo in comments
To:     pengfuyuan <pengfuyuan@kylinos.cn>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>
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

On Fri, Apr 29, 2022 at 9:04 AM pengfuyuan <pengfuyuan@kylinos.cn> wrote:
>
> Fix spelling typo in comments.
>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> ---
>  drivers/gpu/drm/radeon/atombios.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
> index bd5dc09e860f..da35a970fcc0 100644
> --- a/drivers/gpu/drm/radeon/atombios.h
> +++ b/drivers/gpu/drm/radeon/atombios.h
> @@ -3599,7 +3599,7 @@ typedef struct  _ATOM_LCD_RTS_RECORD
>    UCHAR     ucRTSValue;
>  }ATOM_LCD_RTS_RECORD;
>
> -//!! If the record below exits, it shoud always be the first record for easy use in command table!!!
> +//!! If the record below exists, it should always be the first record for easy use in command table!!!
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
> @@ -5973,7 +5973,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
>  #define CLEAR_ATOM_S7_DOS_8BIT_DAC_EN         ((ATOM_DOS_MODE_INFO_DEF << 8 )|ATOM_S7_DOS_8BIT_DAC_EN_SHIFT | ATOM_FLAG_CLEAR )
>
>  /****************************************************************************/
> -//Portion II: Definitinos only used in Driver
> +//Portion II: Definitions only used in Driver
>  /****************************************************************************/
>
>  // Macros used by driver
> @@ -7162,7 +7162,7 @@ typedef struct _DP_ENCODER_SERVICE_PARAMETERS
>
>  // ucAction
>  #define ATOM_DP_ACTION_GET_SINK_TYPE                                                   0x01
> -/* obselete */
> +/* obsolete */
>  #define ATOM_DP_ACTION_TRAINING_START                                                  0x02
>  #define ATOM_DP_ACTION_TRAINING_COMPLETE                                       0x03
>  #define ATOM_DP_ACTION_TRAINING_PATTERN_SEL                            0x04
> --
> 2.25.1
>
