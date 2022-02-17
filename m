Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0748D4BA3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiBQPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:00:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbiBQPAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:00:23 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4563B9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:00:08 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so3867526otf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MM/QHOlU7DbqQK20LVBAm7uDj3BO+aqAJQxNjTOzdUg=;
        b=mnfgNDsECj10rcf5nLEGVYy/UUhxlCCcb1i2XqBTYEzNhFRsqRLXQrYbBVQnRl2XMZ
         arVLMKPkcKHjYa61q0J6DSVRXpVpBUQIOVCrWcZte/jo1nm3j2H06xjgfeBogzrD471N
         37F1DOtvmoKsLkK8jCg8LkvCrKX/sYRka+xnsnLXmE4EPu+KOj+DwxFh68WcemvCqwoq
         eeI7ICVHBeJr3Ot8VD6WtaFpZOynmU+fn9bR/g8RVuTwMP+Xr13So6u2TNSO4edm59fH
         7LdePAFxgi6G/KWUaiTX+yiUR4YUn6Q4NotjQU/NyWtgbtl0Snbr3w3PWagsEx7d3jcn
         6aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MM/QHOlU7DbqQK20LVBAm7uDj3BO+aqAJQxNjTOzdUg=;
        b=m+bPYf49oH6C0xtEwVtYN7/rTz38Pc99jbtEVdhD8KRZXEguNBUgNSz7luXgAo7p2L
         LBlb+lDcrJ7Vks3N7XxlyDHCL0c5Xd6GCekFmWmnOgOhyxGUBcE3DqnOTkFMkVa7pMyw
         q/MDs+FwimmhJbXMUd+H9PqudL4syGKcZ64skOKX2NKtjQ+CVXl5PtPSBAqMUqqFPVeU
         wbRp6dOHg4pz8yLqzI4UUrA9oQ+zJqDLnSDHX/MzJPs4SaHFL51TUJdO7W0MVAGXqVLe
         tgc36YJLVnC+9528Tqkn/p2ZYUB29p9BYHGfH5u0LP8ZIV6TvjY2AJEzFzW2ORab/llW
         CGDw==
X-Gm-Message-State: AOAM532ifuV60ouisI2vyJAu3RPreiMVJfGIluX+8TOwIZUUolFAc/s+
        wmWK93xbyX3xgGSdIOVtHZgVygW6o8mcYXJF3lfOSalL
X-Google-Smtp-Source: ABdhPJzyVJSfewKaWQhXyIXRiR0WdhbEoJAx4xw/ifHIEgMLYDsF4EPHdVHyvAmc8FrzZz7oR1+3b25snbXLc+Y7tXI=
X-Received: by 2002:a05:6830:54a:b0:5ac:f770:5ac5 with SMTP id
 l10-20020a056830054a00b005acf7705ac5mr986729otb.200.1645110007476; Thu, 17
 Feb 2022 07:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20220216114013.15192-1-yuehaibing@huawei.com>
In-Reply-To: <20220216114013.15192-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 17 Feb 2022 09:59:56 -0500
Message-ID: <CADnq5_MDSU2U9bSfXm4U0c5EJeb=fygC6UtAx40jqV6kpFLJRg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: Remove unused function get_umc_v6_7_channel_index()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Feb 16, 2022 at 6:58 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> This is unused after commit 37ff945f804c ("drm/amdgpu: fix convert bad page retiremt")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index f5a1ba7db75a..00f87e3c6b0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -50,13 +50,6 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
>         return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_inst;
>  }
>
> -static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
> -                                             uint32_t umc_inst,
> -                                             uint32_t ch_inst)
> -{
> -       return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
> -}
> -
>  static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
>                                                    uint32_t umc_inst, uint32_t ch_inst,
>                                                    unsigned long *error_count)
> --
> 2.17.1
>
