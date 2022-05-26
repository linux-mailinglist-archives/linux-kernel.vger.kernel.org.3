Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EDE5350B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbiEZOfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbiEZOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:35:29 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE8C8BD0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:35:28 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q8so2275093oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SseFHQrYqsoiZU4lHBY7v6WlEb6Zc74S0Pekb8gbhbk=;
        b=bA/+pu+73q/F1nqqZVrKTLlDEEGliwvaphD4kjN5IussQDR1RT+LafcTtpE32pizwW
         5dPwTS970mqKljzjNAte0/NdbOea5wT+coJEFgNIKfm8TqisDBtN8JHRATwOARgUQkdb
         JiN0iQiOFrO9nw4RKVhlge/bVe9kX1M/dBkYPgC+cJYlITx5HA3WRtJx4SImqF4g0oJG
         zbiy1e/k6lQYiVqizI594lNj67E1NOcArlw0klXIhCVoEB5zvZJS4pMal3ZoQ0E9F38b
         L8FLeQcgpFxSkizkgKJmpQEUNIcYS5Mi0OCO+xg4pzrSZbGXYVPVbOPzdortLssFKDAi
         cBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SseFHQrYqsoiZU4lHBY7v6WlEb6Zc74S0Pekb8gbhbk=;
        b=XRNWAMlucAcjfnVUzDCrNmneVPnbycR6SGhM45zbIr6bmjTmWbIiAEBREG6JtN91i8
         /UaOluY3Hh0LvVDCIGBVEDj+jmW6O+sHMQbiqRJ/+BgHtWjoutyhB/WGdlv46gW+pJyM
         eBzUzDQrsAhBmF+wqmQm+Sf3kQqaUDh/A2WAWREvdAimUHqNu9wqKJ89Hi39/HZED0bG
         0Sg2N3B2aPQ4CyLh9Rb9Q5IfAp/FSxDKyx7VtFAv+bDfzkJwuQ7oR1SbkKHLz3U7WhAj
         oVK+UuY6Vdq0+VjvzXdUEeazrtAg3yOCzvfTXQY0cFp6CWC5IHAA/21KEMkgzapBd7zW
         ehdQ==
X-Gm-Message-State: AOAM530pjaOw/v0UkHFd+z4hdI3Ikmx/jkNsycx9rn2heU1U8RunkaEv
        Cepnq5Ra4Xnjm2NF1uCpHSlj51SbIQmlqxoYxPQ=
X-Google-Smtp-Source: ABdhPJzNZv+k/h0FR9Rb+y50dnXu1h+Z3Etv2f+nFqPNGtYeA35QZOEZVBaTAvm2VYa/WFQuUf4Vq48I49j3QoNdaY4=
X-Received: by 2002:a05:6808:15a7:b0:32b:aeac:84d0 with SMTP id
 t39-20020a05680815a700b0032baeac84d0mr1340522oiw.253.1653575727150; Thu, 26
 May 2022 07:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_9934C5D4CD39D3C35606F674AE61310F2007@qq.com>
In-Reply-To: <tencent_9934C5D4CD39D3C35606F674AE61310F2007@qq.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 26 May 2022 10:35:15 -0400
Message-ID: <CADnq5_Nf=qoLDci2q1MJsLrf=cSVXs8+gX_ZZgx6Ovbi3j-eJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix spelling typo in comments
To:     1064094935@qq.com
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        pengfuyuan <pengfuyuan@kylinos.cn>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        k2ci <kernel-bot@kylinos.cn>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, May 26, 2022 at 5:29 AM <1064094935@qq.com> wrote:
>
> From: pengfuyuan <pengfuyuan@kylinos.cn>
>
> Fix spelling typo in comments.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_api_def.h                  | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 2 +-
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c               | 4 ++--
>  drivers/gpu/drm/amd/display/modules/vmid/vmid.c           | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7606e3b6361e..35c303c865be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -271,7 +271,7 @@ extern int amdgpu_vcnfw_log;
>  #define CIK_CURSOR_WIDTH 128
>  #define CIK_CURSOR_HEIGHT 128
>
> -/* smasrt shift bias level limits */
> +/* smart shift bias level limits */
>  #define AMDGPU_SMARTSHIFT_MAX_BIAS (100)
>  #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_api_def.h b/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
> index 3f4fca5fd1da..c31abf554878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
> @@ -33,7 +33,7 @@
>   */
>  enum { API_FRAME_SIZE_IN_DWORDS = 64 };
>
> -/* To avoid command in scheduler context to be overwritten whenenver mutilple
> +/* To avoid command in scheduler context to be overwritten whenever multiple
>   * interrupts come in, this creates another queue.
>   */
>  enum { API_NUMBER_OF_COMMAND_MAX = 32 };
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 62139ff35476..8855a75dc75e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6705,7 +6705,7 @@ static void dm_disable_vblank(struct drm_crtc *crtc)
>         dm_set_vblank(crtc, false);
>  }
>
> -/* Implemented only the options currently availible for the driver */
> +/* Implemented only the options currently available for the driver */
>  static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
>         .reset = dm_crtc_reset_state,
>         .destroy = amdgpu_dm_crtc_destroy,
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> index 4385d19bc489..733f99a6e8e6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> @@ -619,7 +619,7 @@ static int get_max_dsc_slices(union dsc_enc_slice_caps slice_caps)
>  }
>
>
> -// Increment sice number in available sice numbers stops if possible, or just increment if not
> +// Increment slice number in available slice numbers stops if possible, or just increment if not
>  static int inc_num_slices(union dsc_enc_slice_caps slice_caps, int num_slices)
>  {
>         // Get next bigger num slices available in common caps
> @@ -650,7 +650,7 @@ static int inc_num_slices(union dsc_enc_slice_caps slice_caps, int num_slices)
>  }
>
>
> -// Decrement sice number in available sice numbers stops if possible, or just decrement if not. Stop at zero.
> +// Decrement slice number in available slice numbers stops if possible, or just decrement if not. Stop at zero.
>  static int dec_num_slices(union dsc_enc_slice_caps slice_caps, int num_slices)
>  {
>         // Get next bigger num slices available in common caps
> diff --git a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
> index 61ee4be35d27..2c40212d86da 100644
> --- a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
> +++ b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
> @@ -66,7 +66,7 @@ static void evict_vmids(struct core_vmid *core_vmid)
>         }
>  }
>
> -// Return value of -1 indicates vmid table unitialized or ptb dne in the table
> +// Return value of -1 indicates vmid table uninitialized or ptb dne in the table
>  static int get_existing_vmid_for_ptb(struct core_vmid *core_vmid, uint64_t ptb)
>  {
>         int i;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h
> index 45f5d29bc705..15b313baa0ee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h
> @@ -120,7 +120,7 @@
>  #define PPSMC_MSG_ReadSerialNumTop32            0x40
>  #define PPSMC_MSG_ReadSerialNumBottom32                 0x41
>
> -/* paramater for MSG_LightSBR
> +/* parameter for MSG_LightSBR
>   * 1 -- Enable light secondary bus reset, only do nbio respond without further handling,
>   *      leave driver to handle the real reset
>   * 0 -- Disable LightSBR, default behavior, SMU will pass the reset to PSP
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
