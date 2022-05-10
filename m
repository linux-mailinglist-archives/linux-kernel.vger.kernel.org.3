Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A52521E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiEJPYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345612AbiEJPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:22:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31D41D0CC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:08:05 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y63so18812302oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2/STjlRrDx6ZScgZXIJmZa3dRcDQ11ZaAGksLa3mPQ=;
        b=IUegFjkyZmrqC+uMH6wA/TeUemYW3STdmoenh8VxExEB4eSUV8d6QplgnV0iv1xOfD
         INjw4LkVwqX2jl1yQ3EwtopiM616cf5oT4KzU3FdKtjmVqKmFr9HBnMIs7ByALcqkiSP
         X7d2+hOB8MNFt9SYblvt86LpS3uvk0s9uXavCcDGwS/6jn+o4RK8UNmHD9blWJaRG5L3
         rUJvl/w8R2/a1zjpGCc2alz6CzJWUGTpFictIBxcG6t1CWkMGD7rqUmglOFQAHcJIoN4
         n8odWJNASIdlP9E7vgqaIniXf9U8fGVU+zmabU00Kzrsb2Onck1qko9R+fThVHJQ4aW1
         QZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2/STjlRrDx6ZScgZXIJmZa3dRcDQ11ZaAGksLa3mPQ=;
        b=YXjaLgI/e7aJfLVbdUbNc8r574LOjBMTAq8mg9a39FGg9SGZhCL6MP84BR17K61q2J
         CSWt2KqLGpGIOapJuyoLfMYYWK5A95QWIzaLlq9mtMrwaUgw3Bls7XSCQ55lXMFYP9b8
         xbVHthdrhWD9DfeKfOWw9uCCwfAWFgWmvyDfLFuANwx6esCI4/c0TtnD8ockaNE8vUTE
         +M+xv9VnzkRU/28j8IdIi1ysPZtqjNP4ofjoycQRLseYdEbipjUZFSTZeEoeoFm3AWfQ
         GFC40gYBEJ8UTz12KthP8m3NrzjthwXhnc+UAKvB15bIGzj0yBmrL5rlz7FWiJqmGvB8
         0WLg==
X-Gm-Message-State: AOAM530YMw1NTxgzhnZXXt090HstrRXgT7jpCbPNs9t4F21Gp3PzQWKM
        Evf5tiETyU1MUnGUYxo571Qei6Sidcp+jXHHwWs=
X-Google-Smtp-Source: ABdhPJxqYTUEoTP8UYYX3AkXD2AObwUepN/l2kVNI8OjNMUaCU1Hn1i+m7jFa6TsDrvmS7EEQ5v3mCvlU4hM+/f0v2k=
X-Received: by 2002:a05:6808:178d:b0:326:3fe9:7f03 with SMTP id
 bg13-20020a056808178d00b003263fe97f03mr260657oib.200.1652195285004; Tue, 10
 May 2022 08:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220510025004.2561532-1-wanjiabing@vivo.com>
In-Reply-To: <20220510025004.2561532-1-wanjiabing@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 May 2022 11:07:53 -0400
Message-ID: <CADnq5_OiFNWgwgqP12cniuFVNNRWVrfGKgBNOPAjBSu5cLsMHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove duplicated argument in vcn_v4_0
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, James Zhu <James.Zhu@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
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

Applied.  Thanks!

Alex

On Mon, May 9, 2022 at 10:50 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix following coccicheck warning:
> ./drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:724:4-36: duplicated argument to & or |
>
> Remove duplicated UVD_SUVD_CGC_GATE__SRE_H264_MASK.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/Gap/drm/amd/amdgpu/vcn_v4_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index c37dbac9d96b..9119e966ffff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -722,7 +722,6 @@ static void vcn_v4_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
>                 | UVD_SUVD_CGC_GATE__SCM_MASK
>                 | UVD_SUVD_CGC_GATE__SDB_MASK
>                 | UVD_SUVD_CGC_GATE__SRE_H264_MASK
> -               | UVD_SUVD_CGC_GATE__SRE_H264_MASK
>                 | UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
>                 | UVD_SUVD_CGC_GATE__SIT_H264_MASK
>                 | UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> --
> 2.36.0
>
