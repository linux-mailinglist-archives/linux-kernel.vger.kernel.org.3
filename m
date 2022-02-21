Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FECD4BED52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiBUWms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:42:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiBUWmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:42:45 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128E21A3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:42:21 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so5022734otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KCOv3IEPa+T4atHLSyX9F9YZSMAkm0uJbW+qyWXOhY=;
        b=QaUey7Incygh7qSfWMM7R3LEigTajw2Ot386xexAxmDWeE9dnrvc/SJfMD76bFTWyX
         HkutP29w+aqiv/e8GzwLVBvjfa2ReVlzbmRcOm+GNHqlyg7y6Ev9fADJXK+rwEfxnalX
         NRB/F6Ad6rnf+rfT5muNNgf28H1owIrtsKfFfn4DJiLwyJlnQeUcV5G41gtuJXI9wYIg
         WKfytkGIFLRjfTOsYj49MZdUPUxNp8+OWHwdBpf0hNtN8EkRcZInawtiCtavxKeRTimt
         qi2CI2uXgRwo3HtfEMeh3XpYG4gdTOXpIOiKFbItc7hNvnXw019A3oAsNydm2t81d3jV
         rZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KCOv3IEPa+T4atHLSyX9F9YZSMAkm0uJbW+qyWXOhY=;
        b=rINhA6t5Pr89dAaDzzs7cX+VXXHwxQPd/gkXPkCU+6COzFj482//icvNM0/QyFrpRt
         bpg6ZZ5aaT4VidJBHc/TKwi6ziJszb+QjsqB+Z1Z3IQJBXgWhBfqd4T9dyWbDZpXDMuD
         YVsIbrltC+BkAsBbH3+BMQ+oT6tSNAzqGmDbxPSlRyL4YwMc+9W8daJrpCppm/7ey2mJ
         r4nqreHCE5CMPXZWj53ClCoK+8q36BsN3krLDySC0/bE0acOYBsllzvTUkYX8Osd0j4U
         z29ZmGK4kFfFA0AmWip9sJGPVRxKAwC/t/EpIr0oGQfwetHJx/LvhlAjVoZsTzPCuQFo
         3Q4Q==
X-Gm-Message-State: AOAM532wXeSWzk0xPfqSnW1Oecz5GTrIsC+wr7oWpba4sTF6vTTE0kid
        kobg1bfjj5tShvdSdctczztgyQOmcW6HEhkN+hE=
X-Google-Smtp-Source: ABdhPJwJNVx6lk7bOd/b5bqtlSO8oe7IFdSdEEWyoCtexhjLEMwSnMGqG9ldOWZW3FTSnswg5KIucx9atziT+RVKYCE=
X-Received: by 2002:a9d:4a8:0:b0:5ad:35f8:31a6 with SMTP id
 37-20020a9d04a8000000b005ad35f831a6mr5676376otm.200.1645483341228; Mon, 21
 Feb 2022 14:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20220219045445.146570-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20220219045445.146570-1-pmenzel@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Feb 2022 17:42:09 -0500
Message-ID: <CADnq5_OStk3baHXKtejpvQR3cAMb-DknU-dqts2_eAYs3+_8Hw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix typo in *whether* in comment
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

Applied.  Thanks!

On Fri, Feb 18, 2022 at 11:56 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 63a089992645..430e56583751 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -740,7 +740,7 @@ MODULE_PARM_DESC(debug_largebar,
>   * systems with a broken CRAT table.
>   *
>   * Default is auto (according to asic type, iommu_v2, and crat table, to decide
> - * whehter use CRAT)
> + * whether use CRAT)
>   */
>  int ignore_crat;
>  module_param(ignore_crat, int, 0444);
> --
> 2.35.1
>
