Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F26558111
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiFWQz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiFWQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:51:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B2619F83
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:51:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c65so6365393edf.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOox6HqgRBUv7icqURUJML9abJah70/U25bI8X8Eyc0=;
        b=kfqCOp4uGyXjRICRfEG2lcRUgea96b9kksgdi1ldi2t1fN0InFIsPiqt4nqCLdfD/p
         5BV+fuCzoVB2zfwoFAGFjymKkjfwyhmh+MmXr42ycq8dvVwWI2VXrr0EOxscM6UOmfUt
         uI/j4WGJ5wfuNByUoQrhC++RY6pXGjOgLYLNpkXoMwfbWnWuirJq0TdYdVd8FCV35/VG
         TwNAf8QZLaY3zIsBXsuJhAhs63Z/R3uwUYTtxAxLcYTV50pGABiUgGnf0cjW8ynvhaWG
         tWY+f99eYGIoXq+TBANdoWe0YoEKdd9IaE870Jpwbx4CmYDD0jzZloR8qNw2Ki+A0ef5
         HPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOox6HqgRBUv7icqURUJML9abJah70/U25bI8X8Eyc0=;
        b=SyWMNdPAjQuXd4dvcemqVjPqt6vWZYok75P2mgI65W5vL4FJB6AIHSe1LtxQDNpO0p
         ClC1yDsXbiG+iZIhW2rls8CzBB3hLGNvOA9CgujqiWletyo39nt41dRi2Ro/ixxSIu3w
         8nCvWGTbapUiSE1tvm3oAjKXWa0Jqi1ahQIGDygr8CwOeAAHiv8LKYm5laah/CCDT1Ia
         3Y/4c4JrC5U3yxUWcndyIXHgnbS+SnQOLCFRnjxN7MIObLDUp5FlHPExkTvBKMazkhqL
         gawnH4kVU7j8nLocrZV0SETwcybuGYjVFekcl2MNSTfz8GqepU7paOv6gMGA0aac6DBm
         4/0w==
X-Gm-Message-State: AJIora9kd+JTbkO862HEtSv5M/XGmKojZdqfyshKBN4PaaUBag+rhzUI
        BNzjGGYJ7RnvA5ttCd8ZneQa6RN5jn+S+pX7m3A=
X-Google-Smtp-Source: AGRyM1seSiLtqCIe8T9UCrc/sPscS+2NaSYNj41ONsIdzNTTytILIW4ECo/OCFVlLa6XL8bIlCV+qiVNMuLc7ZT3Ttw=
X-Received: by 2002:a05:6402:50ce:b0:435:9249:dfe9 with SMTP id
 h14-20020a05640250ce00b004359249dfe9mr12079163edb.310.1656003076595; Thu, 23
 Jun 2022 09:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220623101448.30188-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220623101448.30188-1-jiangjian@cdjrlc.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Jun 2022 12:51:04 -0400
Message-ID: <CADnq5_P1VQo71hENT-RZUXY1T_+46bwPzRQ+OED-mTwRG52gnA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop unexpected word 'for' in comments
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
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

On Thu, Jun 23, 2022 at 6:15 AM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> there is an unexpected word 'for' in the comments that need to be dropped
>
> file - drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> line - 245
>
>  * position and also advance the position for for Vega10
>
> changed to:
>
>  * position and also advance the position for Vega10
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index 3df146579ad9..1d5af50331e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -242,7 +242,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   * @entry: IV entry
>   *
>   * Decodes the interrupt vector at the current rptr
> - * position and also advance the position for for Vega10
> + * position and also advance the position for Vega10
>   * and later GPUs.
>   */
>  void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
> --
> 2.17.1
>
