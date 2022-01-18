Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611DE492638
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiARM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbiARM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:57:17 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:57:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o12so53574886lfu.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIJQB6iiH94SHT4Z8V/XpGAWSENyBxcySp/zS4+LqzU=;
        b=hA4vkRueMtlbTSLWqs+cHVa6rkQLACccGzKnNIrI2BFv4/+sT9Zyo6AOcOUujCa4A2
         mmI0tgx5iBCPGGItYEkrKfcdwT4juMHTwxKf/8KTOUt0JaHstd+Ok+qh1l85/5E09H9X
         5n1Sy7/BR/M3MMsweezND2mlsT9Pm132C35O42c9S/wee081/PE4v1qQyw2QPfO1LHa/
         7/a37IcfH8aX7CtbFnqkWddUQXR8TODAlxOluq7yvOPMDBQ4zgUpHi+Z5kgDrSUcGm7j
         am0DSC5YfW6OHuv6SRTq3yBsSplspWxdMd88/dm7KGsJ+W2j/uNNVjIvsAJaZ9zB/fC3
         Uo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIJQB6iiH94SHT4Z8V/XpGAWSENyBxcySp/zS4+LqzU=;
        b=L2tSZItcG8gGDsw0FoqvMGUzhYSPJkRNOMb8WSsIYgvBFyg8jWeyHfmO+jIl6tgB7q
         azNLUqweOaHG2Ek1FhJuRqprC+r1WjrV6Jcrq2EFDMjJmVNkZ6rN09hwMRIuSpl+b3yP
         hqlEbX4a4sm93KOYFCu7P3Q+QMwjXIOruGfy0t5fx7mb8Rsekkb012TGeTtSeX3OaSfF
         8eSlT6NV9+yJLE0UTbhcnU0EzxgS8RpS3fqx/rIAAqxTgZjPVBzGU/POTRe4BO/PstDZ
         y4dt8iMbqkQLD5xuEQJGsuQuPgCs862zXE/Lr+n4QWRKyw1ln72fiLKvlUg5NK6ye9Pe
         UbIg==
X-Gm-Message-State: AOAM530OgoMO7WqliwxZiJKBed23PdfPtKOzpDWx/nr+x8O84enSd7sj
        v6A6kJoA5rv3WQhV1UHRiwETcgKcOBK1CQgaaFBmvb6JUlZsLg==
X-Google-Smtp-Source: ABdhPJxIv9aTTkEkvRt+fMx7CJLSqJsLB6zwooZPv5jEwPy/vkNLHuivaxNqVey8ak0Y3mBYgTHf72kc2P3Tw0T4NPY=
X-Received: by 2002:a05:6512:3298:: with SMTP id p24mr20981304lfe.513.1642510635135;
 Tue, 18 Jan 2022 04:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org> <20220114150824.3578829-3-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-3-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 18 Jan 2022 18:27:03 +0530
Message-ID: <CAFA6WYMKyr-PxhHNLt8H-1xFg34H9A=cYMXZeswDqDRidk7XBg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] tee: remove unused tee_shm_pool_alloc_res_mem()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> None of the drivers in the TEE subsystem uses
> tee_shm_pool_alloc_res_mem() so remove the function.
>

It looks like originally it was used by the OP-TEE driver that
switched directly to use tee_shm_pool_mgr_alloc_res_mem() after commit
f58e236c9d665 ("tee: optee: enable dynamic SHM support").

> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm_pool.c | 56 --------------------------------------
>  include/linux/tee_drv.h    | 30 --------------------
>  2 files changed, 86 deletions(-)
>

FWIW,

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> index fcbb461fc59c..a9f9d50fd181 100644
> --- a/drivers/tee/tee_shm_pool.c
> +++ b/drivers/tee/tee_shm_pool.c
> @@ -47,62 +47,6 @@ static const struct tee_shm_pool_mgr_ops pool_ops_generic = {
>         .destroy_poolmgr = pool_op_gen_destroy_poolmgr,
>  };
>
> -/**
> - * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
> - * memory range
> - * @priv_info: Information for driver private shared memory pool
> - * @dmabuf_info: Information for dma-buf shared memory pool
> - *
> - * Start and end of pools will must be page aligned.
> - *
> - * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
> - * in @dmabuf, others will use the range provided by @priv.
> - *
> - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> - */
> -struct tee_shm_pool *
> -tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
> -                          struct tee_shm_pool_mem_info *dmabuf_info)
> -{
> -       struct tee_shm_pool_mgr *priv_mgr;
> -       struct tee_shm_pool_mgr *dmabuf_mgr;
> -       void *rc;
> -
> -       /*
> -        * Create the pool for driver private shared memory
> -        */
> -       rc = tee_shm_pool_mgr_alloc_res_mem(priv_info->vaddr, priv_info->paddr,
> -                                           priv_info->size,
> -                                           3 /* 8 byte aligned */);
> -       if (IS_ERR(rc))
> -               return rc;
> -       priv_mgr = rc;
> -
> -       /*
> -        * Create the pool for dma_buf shared memory
> -        */
> -       rc = tee_shm_pool_mgr_alloc_res_mem(dmabuf_info->vaddr,
> -                                           dmabuf_info->paddr,
> -                                           dmabuf_info->size, PAGE_SHIFT);
> -       if (IS_ERR(rc))
> -               goto err_free_priv_mgr;
> -       dmabuf_mgr = rc;
> -
> -       rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> -       if (IS_ERR(rc))
> -               goto err_free_dmabuf_mgr;
> -
> -       return rc;
> -
> -err_free_dmabuf_mgr:
> -       tee_shm_pool_mgr_destroy(dmabuf_mgr);
> -err_free_priv_mgr:
> -       tee_shm_pool_mgr_destroy(priv_mgr);
> -
> -       return rc;
> -}
> -EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
> -
>  struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
>                                                         phys_addr_t paddr,
>                                                         size_t size,
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 5e1533ee3785..6b0f0d01ebdf 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -278,36 +278,6 @@ static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *poolm)
>         poolm->ops->destroy_poolmgr(poolm);
>  }
>
> -/**
> - * struct tee_shm_pool_mem_info - holds information needed to create a shared
> - * memory pool
> - * @vaddr:     Virtual address of start of pool
> - * @paddr:     Physical address of start of pool
> - * @size:      Size in bytes of the pool
> - */
> -struct tee_shm_pool_mem_info {
> -       unsigned long vaddr;
> -       phys_addr_t paddr;
> -       size_t size;
> -};
> -
> -/**
> - * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
> - * memory range
> - * @priv_info:  Information for driver private shared memory pool
> - * @dmabuf_info: Information for dma-buf shared memory pool
> - *
> - * Start and end of pools will must be page aligned.
> - *
> - * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
> - * in @dmabuf, others will use the range provided by @priv.
> - *
> - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> - */
> -struct tee_shm_pool *
> -tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
> -                          struct tee_shm_pool_mem_info *dmabuf_info);
> -
>  /**
>   * tee_shm_pool_free() - Free a shared memory pool
>   * @pool:      The shared memory pool to free
> --
> 2.31.1
>
