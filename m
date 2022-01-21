Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724A495A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378946AbiAUHXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343489AbiAUHXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:23:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C299C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:23:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso20301111wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKt/iYJmxOC4PShz3FrQ/2I7eo98EfduwTWA0w5TmN4=;
        b=oNQn3P8VqWn/iW+rHMEaJ8CY9r0wgChqGQfWOp3YwBbRP6nxacY166rsHbBXOc0dIy
         6oe4CFzpyn14XKrZqk/q34heLwuBfbj1UY0a7Y+1ULMwy7Ksv97p9mPoKMiQcL5/XN/X
         6z22qvERnUwNi/pXDeaHbsgncegHOUBbMSXTgmQUDv2SReoMQ7zP5ao3Li/7sFOOssEb
         fmsXleIEdTJ9n8GWPqqvUBpYNLu/1oUi18LXF4ihlnxZW4D8N5Ejrp65Ha8MhpxjfMWI
         thhAF+NBP4vDxWVLTsk85I9uGakII1ez9rh9tn6Fp7H8OloZIUuhHhQR+63rCYb9jJsM
         hlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKt/iYJmxOC4PShz3FrQ/2I7eo98EfduwTWA0w5TmN4=;
        b=uOmABWOmotEm2VsdVzJ5I+wO0CpSY7hCdaHRta6E4JHWgn/z57RCHng8ZXke1jXwgy
         BATSib5H88C5z1NVFzr1q82BSas8D5Eng9aBqnjcsRGQV/YUJLSCekHI3KyH7YiJg2e7
         WLKDXiZumf1Y2C6qC/F5PTcO7A35ZV4+mzJ6RqOJFqLw929al1S7kAdg6F5XpWUwDn4O
         0zvXtabUCXbJnSFh7HUsGG99qSxz2jNRH5upK3Dlo1CizlYt6AS/3CPPiIPwoezuynGP
         kso98mJUHa+rsGzDTxhqKDTowJiEgCA1m2GBA7SlbmFXOw+jQ+XHF/IhsqQy83W9cuJC
         0jNw==
X-Gm-Message-State: AOAM532rrVaexDOCusKR6K0r0X2S7iepULCuimH3nz1bX0jPBiqAa7jK
        QjcVYRCfMHL+ajJL3Cc8oMASHHJUPAm/wLhiwJVfMg==
X-Google-Smtp-Source: ABdhPJyBaC2gx2dJRauhkBdcQIz/3a8RmI/vfyqj8UY3XEq7rLJhAxdU7p4nNTPbYx2DDLIdUASljN4P9f5PtapEsyo=
X-Received: by 2002:a5d:574c:: with SMTP id q12mr1403139wrw.64.1642749811551;
 Thu, 20 Jan 2022 23:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
 <20220114150824.3578829-13-jens.wiklander@linaro.org> <CAFA6WYOvsBZk17mPG9d79wQFNvQwv1deCm5ocs3qyBa8W0hvNQ@mail.gmail.com>
In-Reply-To: <CAFA6WYOvsBZk17mPG9d79wQFNvQwv1deCm5ocs3qyBa8W0hvNQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 21 Jan 2022 08:23:20 +0100
Message-ID: <CAHUa44Hz=7L1odx746sCRuts3Xhr=ve1oU8CZ7-2+UuHyCr9pQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] tee: refactor TEE_SHM_* flags
To:     Sumit Garg <sumit.garg@linaro.org>
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

On Thu, Jan 20, 2022 at 2:04 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Removes the redundant TEE_SHM_DMA_BUF, TEE_SHM_EXT_DMA_BUF,
> > TEE_SHM_MAPPED and TEE_SHM_KERNEL_MAPPED flags.
> >
> > Assigns new values to the remaining flags to void gaps.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_shm.c   | 21 ++++++++++-----------
> >  include/linux/tee_drv.h | 12 ++++--------
> >  2 files changed, 14 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index fe3e5977dd7c..9945bdec086b 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -139,8 +139,7 @@ static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
> >   */
> >  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
> >  {
> > -       u32 flags = TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER |
> > -                   TEE_SHM_POOL;
> > +       u32 flags = TEE_SHM_REGISTER | TEE_SHM_POOL;
> >         struct tee_device *teedev = ctx->teedev;
> >         struct tee_shm *shm;
> >         void *ret;
> > @@ -186,7 +185,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
> >   */
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
> >  {
> > -       u32 flags = TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
> > +       u32 flags = TEE_SHM_REGISTER | TEE_SHM_POOL;
> >
> >         return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
> >  }
> > @@ -211,7 +210,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> >  struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
> >                                               size_t size)
> >  {
> > -       u32 flags = TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
> > +       u32 flags = TEE_SHM_PRIV | TEE_SHM_POOL;
> >
> >         return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
> >  }
> > @@ -308,7 +307,7 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
> >  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> >                                           unsigned long addr, size_t length)
> >  {
> > -       u32 f = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
> > +       u32 f = TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
> >         struct tee_device *teedev = ctx->teedev;
> >         struct tee_shm *shm;
> >         void *ret;
> > @@ -354,7 +353,7 @@ EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
> >  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> >                                             void *addr, size_t length)
> >  {
> > -       u32 f = TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
> > +       u32 f = TEE_SHM_REGISTER;
> >
> >         return register_shm_helper(ctx, (unsigned long)addr, length, f, -1);
> >  }
> > @@ -398,7 +397,7 @@ int tee_shm_get_fd(struct tee_shm *shm)
> >  {
> >         int fd;
> >
> > -       if (!(shm->flags & TEE_SHM_DMA_BUF))
> > +       if (shm->id < 0)
> >                 return -EINVAL;
> >
> >         /* matched by tee_shm_put() in tee_shm_op_release() */
> > @@ -428,7 +427,7 @@ EXPORT_SYMBOL_GPL(tee_shm_free);
> >   */
> >  int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
> >  {
> > -       if (!(shm->flags & TEE_SHM_MAPPED))
> > +       if (!shm->kaddr)
> >                 return -EINVAL;
> >         /* Check that we're in the range of the shm */
> >         if ((char *)va < (char *)shm->kaddr)
> > @@ -450,7 +449,7 @@ EXPORT_SYMBOL_GPL(tee_shm_va2pa);
> >   */
> >  int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
> >  {
> > -       if (!(shm->flags & TEE_SHM_MAPPED))
> > +       if (!shm->kaddr)
> >                 return -EINVAL;
> >         /* Check that we're in the range of the shm */
> >         if (pa < shm->paddr)
> > @@ -478,7 +477,7 @@ EXPORT_SYMBOL_GPL(tee_shm_pa2va);
> >   */
> >  void *tee_shm_get_va(struct tee_shm *shm, size_t offs)
> >  {
> > -       if (!(shm->flags & TEE_SHM_MAPPED))
> > +       if (!shm->kaddr)
> >                 return ERR_PTR(-EINVAL);
> >         if (offs >= shm->size)
> >                 return ERR_PTR(-EINVAL);
> > @@ -553,7 +552,7 @@ void tee_shm_put(struct tee_shm *shm)
> >                  * the refcount_inc() in tee_shm_get_from_id() never starts
> >                  * from 0.
> >                  */
> > -               if (shm->flags & TEE_SHM_DMA_BUF)
> > +               if (shm->id >= 0)
> >                         idr_remove(&teedev->idr, shm->id);
> >                 do_release = true;
> >         }
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index e4f32885e273..dcc7a55e1128 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -20,14 +20,10 @@
> >   * specific TEE driver.
> >   */
> >
> > -#define TEE_SHM_MAPPED         BIT(0)  /* Memory mapped by the kernel */
> > -#define TEE_SHM_DMA_BUF                BIT(1)  /* Memory with dma-buf handle */
> > -#define TEE_SHM_EXT_DMA_BUF    BIT(2)  /* Memory with dma-buf handle */
> > -#define TEE_SHM_REGISTER       BIT(3)  /* Memory registered in secure world */
> > -#define TEE_SHM_USER_MAPPED    BIT(4)  /* Memory mapped in user space */
> > -#define TEE_SHM_POOL           BIT(5)  /* Memory allocated from pool */
> > -#define TEE_SHM_KERNEL_MAPPED  BIT(6)  /* Memory mapped in kernel space */
> > -#define TEE_SHM_PRIV           BIT(7)  /* Memory private to TEE driver */
> > +#define TEE_SHM_REGISTER       BIT(0)  /* Memory registered in secure world */
>
> TEE_SHM_REGISTER as a flag name seems ambiguous to me when it is being
> used by both types of APIs tee_shm_alloc_* and tee_shm_register_*. Can
> we rename it to TEE_SHM_DYNAMIC instead?

Sure, I'll fix that in v3.

Thanks,
Jens

>
> -Sumit
>
> > +#define TEE_SHM_USER_MAPPED    BIT(1)  /* Memory mapped in user space */
> > +#define TEE_SHM_POOL           BIT(2)  /* Memory allocated from pool */
> > +#define TEE_SHM_PRIV           BIT(3)  /* Memory private to TEE driver */
> >
> >  struct device;
> >  struct tee_device;
> > --
> > 2.31.1
> >
