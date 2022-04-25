Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684D150D9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiDYGuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDYGt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:49:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD566CA0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:46:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z30so6021667pfw.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CGNvLl0gt0WVOFQBgFHtaZa4OCsc1wdtBrp8cvXfWo=;
        b=emSnuyJRwDrts3lDUsJG2W6c/OolFIFLmj3pbMhpmdolE8FrDsm19AYhq2Ik5sI7LR
         qtapvYmes0pfKMA85UleteC8M7Q5evJtj3uUGSPLAnjNW98zwqNR1LkJeCfjrLRxNT34
         CqQp3DEk0vu1VB7/WT2avBQrE3dsNYS7oXwpmhhWBaPeRtvmdg0LQTIYfVyT9XjQjgey
         Qy1QOK0n9EhEdc5Ui3FeoFJzzmmpwWBYSC4D0YK0n8qO8eknLlc2baIimPZJV5tASnzv
         Y7eFoeLY+yEbX3o2BKcI+a+jEQtfazMnfdF2qHVdDG+yqj2Agy8h2NhsG+3LqMqiBXEo
         MvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CGNvLl0gt0WVOFQBgFHtaZa4OCsc1wdtBrp8cvXfWo=;
        b=J2clF3kRwLPU7YlL1JsNffNgxIgOZ8JIuuMwcWgys9iUHRHZULYAG/CCp2E95f6RCF
         eGWrlRdYVRjsZWK6+xqJJ8rW9npxi8RthtkSjIrDc2uAq2msATbcwhclinRgQ42OwfS4
         la/PMG2ywjbd0Pi4TlQ+37HRA6ZPSVI3XgLntbJo3SKkR5Ov91j292vZrNd2FMTQNy9C
         hFp0aCxanFtQ7492KkaQRugjFmsiY6Oe/41lCXa8VKRDLaMbKxbdxM8TAvKZEjtzDMaA
         N11d3Dgyb42aYnWVjM7FOTHxKrCV2pH9JrSFtf3IVzB+OYhD3c6VnUkzavz4xyPc9hPj
         tBfA==
X-Gm-Message-State: AOAM531PKAijJ9xb3DFQbTYhKZoZBhbdirSCPl5Z2nDxBwhgQ4fdpFpS
        t8MAeQDalkyMHh2Fx3xrH1WSBorwnNvgYHMFB74JAw==
X-Google-Smtp-Source: ABdhPJwMktqdLyM+dSyErvsE1i2wEbDCAo4IMIq/qag8cPcnDkEgCUK1gdZyGw/X3pQicNuGrLptAZJlosZvu2Bt6N8=
X-Received: by 2002:a05:6a00:198f:b0:50d:4279:3320 with SMTP id
 d15-20020a056a00198f00b0050d42793320mr2644770pfl.22.1650869212747; Sun, 24
 Apr 2022 23:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220422180139.13447-1-afd@ti.com> <20220422180139.13447-2-afd@ti.com>
In-Reply-To: <20220422180139.13447-2-afd@ti.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 25 Apr 2022 12:16:41 +0530
Message-ID: <CAFA6WYPK2NS08pdzqS5Ze5pdJic2iQ7hC6h0SK+JT=EbPkg+Sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF
To:     Andrew Davis <afd@ti.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 23:31, Andrew Davis <afd@ti.com> wrote:
>
> These look to be leftover from an early edition of this driver. Userspace
> does not need this information. Checking all users of this that I have
> access to I have verified no one is using them.
>
> They leak internal use flags out to userspace. Even more they are not
> correct anymore after a45ea4efa358. Lets drop these flags before
> someone does try to use them for something and they become ABI.
>

Sounds reasonable to me.

> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/tee/tee_core.c   | 1 -
>  include/uapi/linux/tee.h | 4 ----
>  2 files changed, 5 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 8aa1a4836b92f..650dd87a38e77 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -339,7 +339,6 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>                 return PTR_ERR(shm);
>
>         data.id = shm->id;
> -       data.flags = shm->flags;
>         data.length = shm->size;
>

This change is required for tee_ioctl_shm_alloc() as well.

-Sumit

>         if (copy_to_user(udata, &data, sizeof(data)))
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index 25a6c534beb1b..23e57164693c4 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -42,10 +42,6 @@
>  #define TEE_IOC_MAGIC  0xa4
>  #define TEE_IOC_BASE   0
>
> -/* Flags relating to shared memory */
> -#define TEE_IOCTL_SHM_MAPPED   0x1     /* memory mapped in normal world */
> -#define TEE_IOCTL_SHM_DMA_BUF  0x2     /* dma-buf handle on shared memory */
> -
>  #define TEE_MAX_ARG_SIZE       1024
>
>  #define TEE_GEN_CAP_GP         (1 << 0)/* GlobalPlatform compliant TEE */
> --
> 2.17.1
>
