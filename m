Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C751D513B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350709AbiD1SXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiD1SX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:23:26 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1AA626D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:20:10 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id a10so6180457oif.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSkLqqraq4ZJNQe/eZcJ3+XKx5848eMDeTMp9yd+NZM=;
        b=obYe3GbeS28Q8s3W22+uGpah48Yhjrf3iqtEBYsC2yYSMYDDkbfzvkmpRD62rdvOzG
         GoWzspgjSsB104FKymYqPB2lYKBjSDvsL02cNJC4nsbZCe8BgKv6BSdazIfFuqACk5Fp
         jYkoGdOVCyOqtTj74zy5qcochi33suJma61KdJ22oyzS7lhQRQ3iqMDPwFXFuM+eSGmj
         wvRl2NdpJImE1xNcegaHj8cAipsw0KfQJVSp3pk6ogdCMQ9xdp3VDRjo8b9JVex3Z+kF
         zLshy82k7rwKwnQwRuOysMzFy68RKxIh9AdBo0OrDZM/8E/1pw9Ko6gp53tRlehoiEWv
         LmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSkLqqraq4ZJNQe/eZcJ3+XKx5848eMDeTMp9yd+NZM=;
        b=QUtk3IbhtuSd9keOgCFLLR0bbtWon+lKQFtJ2G9e86toB8xaTrdvXZe/zHaW+uuIFq
         HMI6COL9b5PhhfAClZsD1AQCcqWat+As1dSNS/rjpxa7khOYbmWvMDfaduSf3MD2msoB
         yj5eKL+fZMdFpDakFBjc1nVAsfqu1CDeFt3ycLWyDTRA32iKNpWDMrkmIVo/sXpFzUq2
         TUdos7D36mNSoQBN8YbF1YFilINvaBqXYlHYhx6fppullsLxnHEPA8aWbyMD+q1Rj2Fs
         I8XXbZsmqYjErnJu9EYaa5p3EGT+9pAzLdnk2LXE3zxyhboA8b8u0/ipiZ4wl7XFfZQE
         q8TA==
X-Gm-Message-State: AOAM532xMnt7CisGyNkqW1GuOi7VNP0gjdVk/Son5YQ33K1rGc2FzMIP
        Vo+9pPCSbY8W0ByHzC6T1/Zs+f95yPHduzhvzE0=
X-Google-Smtp-Source: ABdhPJwshtYA+L5Ift7DeQosPnfBSDjxkl9c/30PQ8kqkkhv+1eC2bfEn00RvDYu/DdL1+5O4iX+glwTNv5FfFcl9Q0=
X-Received: by 2002:aca:3d88:0:b0:321:141:ce0b with SMTP id
 k130-20020aca3d88000000b003210141ce0bmr19523709oia.200.1651170009987; Thu, 28
 Apr 2022 11:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220428072000.6542-1-pengfuyuan@kylinos.cn>
In-Reply-To: <20220428072000.6542-1-pengfuyuan@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 28 Apr 2022 14:19:58 -0400
Message-ID: <CADnq5_P-TMs2f+9Bfd8MXZxxYcc1VPux4Ed1iQSkbXzFPdwPQw@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/radeon: Fix spelling typo in comments
To:     pengfuyuan <pengfuyuan@kylinos.cn>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
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

On Thu, Apr 28, 2022 at 3:37 AM pengfuyuan <pengfuyuan@kylinos.cn> wrote:
>
> Fix spelling typo in comments.
>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> ---
>  drivers/gpu/drm/radeon/atombios.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
> index bd5dc09e860f..e00d6adf7262 100644
> --- a/drivers/gpu/drm/radeon/atombios.h
> +++ b/drivers/gpu/drm/radeon/atombios.h
> @@ -3599,7 +3599,7 @@ typedef struct  _ATOM_LCD_RTS_RECORD
>    UCHAR     ucRTSValue;
>  }ATOM_LCD_RTS_RECORD;
>
> -//!! If the record below exits, it shoud always be the first record for easy use in command table!!!
> +//!! If the record below exits, it should always be the first record for easy use in command table!!!

s/exits/exists/

Other than that, it looks good to me.

Alex

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
