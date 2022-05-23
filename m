Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1B531812
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiEWURt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiEWURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:17:47 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC89AF1D0;
        Mon, 23 May 2022 13:17:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so5380763otr.3;
        Mon, 23 May 2022 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DUh6l8ZBN76lnS45q0wf6jiM8BayaXvjyPIbUUAWTA=;
        b=R/AES/FlpFR4Wmbz51yvQ/jtXB3RgnmZ9r8MHiSzVwh62L5Oj6rGCFpXrvzOZ6MUoN
         NJud8DwB0Kq3PwBJnPWnJZND/dRITJBxkz00GFyn0N6HLcOEJ9kMpvPuvXwdaLHio+U0
         7uWAN8smybjlAD4Rjju8jBi4Sn4I+S5yVIdX4l1eQ2BjJiBUkM6W2V8Pyx3Ui275KdOn
         Mb1xB9hUOzo2joQecY5CnJNDZsLwImfMrALeAr1cFQkOINceHcBqI92wD3a0D3our4UV
         qiuvDuNR5kiBFXeqFAofGUaqibsL3JzaGqNLQWzVhnyz07v8/cAKJCim+h1qvvr/0IMa
         TWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DUh6l8ZBN76lnS45q0wf6jiM8BayaXvjyPIbUUAWTA=;
        b=49VQKrrPmCMRTaYRiq8/ugLho7zveIuuK7l5cGACVh389JuEqWEadoKnssxy0y5iED
         S2y7i5hndc+eTkAbvvQ3r5MxxnXK7a8Uzw3JDM4+QDphdbjeHFNUjgra1dJH9lLq03Xv
         8GwrK/j4gF8htKGbU1kqy4cUtjuiRdhGVUxwgtwM9U/d41p4l3f8v9T3i8oUo+z2Qfnc
         C9FC04MnQ5h59J0jzL1HOYt581UgyOe8KlVZ3JNdYnU/bKpuosC7d+B7XHiA5/duDuIL
         0z+otiXuo77tRvwg+nHqurnt0dtIs5lzNIuICeIDpbzGTTuflm8LETyCfWpPLcJowiEm
         Spuw==
X-Gm-Message-State: AOAM5302qJ1oqhOQmR8YOxVSkkbDltLFNdbjbOQ2GsG6XxLOfBH5gjff
        1G+XEE2gPKXYR78bg+0jSZJ2av2qH4o2+3UBMrs=
X-Google-Smtp-Source: ABdhPJwVz/W2po1d5TwSlFiQ3ZLNrMa1hBA0NDPQZsBA4wCrc5SAYByfN9LWffY9S9XDU65c6eFAONAuiF4zTdWNZaE=
X-Received: by 2002:a9d:6543:0:b0:605:e789:271e with SMTP id
 q3-20020a9d6543000000b00605e789271emr9333863otl.200.1653337065638; Mon, 23
 May 2022 13:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220521111145.81697-74-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-74-Julia.Lawall@inria.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 23 May 2022 16:17:34 -0400
Message-ID: <CADnq5_NJq-b4UfF_PpwYc2PV8Nt++cj0RsC=yxkbCfQtJ+meJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix typo in comment
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Sat, May 21, 2022 at 7:12 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 8b5452a8d330..67abf8dcd30a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1621,7 +1621,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>
>         mutex_lock(&mem->lock);
>
> -       /* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
> +       /* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
>         if (mem->alloc_flags &
>             (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>              KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>
