Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6E5A54B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiH2TrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiH2TrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:47:01 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C5B73336
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:47:00 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11e9a7135easo9237261fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pIRa4AL/ga0qHuILPyN2VKLZ3Y5dcsSScu21XOurOb4=;
        b=j5xnVNrZZHkK2TQd0nhTcCbIu0g1VMB0PQ3Dpe6y36WlzfLHDhWGlLIpm45cV/cpk8
         DpBge+ai3ax905WBogMbIuFO+dGnRJx9psvQm8xHVtlT24ifwyJg48+JfYRfyKCPYRAM
         fcP6zvPrIZJ3+LdOWLxmABorbS6IbUltvkbewlFy4yw/NvBUz5yuLirVtUuL3GXXuhaS
         WKVlwORVrIfYI0tNCOghGfSe5aBhi8ukxDm2HwkquRcOleo77D/lRujK6bqMHeCXakBK
         y8SZfXc8X0DfCbDIRFCWBqaJoLLMi3NJVZ/n8a9SO0LU0uuAq8c1yoaaJN9LB30a1aDE
         PtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pIRa4AL/ga0qHuILPyN2VKLZ3Y5dcsSScu21XOurOb4=;
        b=m3lUXszKEfljruFnK0aI0NZfuuF4juxCo+8ZovlOMXcyEDlrMipibhYL0jcOzfaiA0
         QZuNUDQQx99kkV0ZqQo3ERKSVLAzNNObzINDSpo31mDgakKD//vDOEE76BFX+joVevvQ
         mw2QZdyAQmqyc6wc+iIxmXa54kAxCJ5AYR2OXfTuLPUF2/D6ynA+7hiAqsQupTi6ujSV
         Ty12qlaijhuU0FPSujxM8uqFg1Tq4/FgIMcjJW4VdbWgUpvjK5v8rZLyraoyw3GKWZ9C
         xJkQtExWFS7M43Fa7pPnYyKHqV1vxUtNBPTF1PTpanAQg3Uop7QnQ9Cp08z6y6WGQRay
         Nt9A==
X-Gm-Message-State: ACgBeo36PhKxru2sS8683hN2IjadRToo6Yjw2W0ATpUhzCjuwtET4xCR
        cVRreRoTLscaqsDnFMQP7PxolcIv3nX6R2+QEb8=
X-Google-Smtp-Source: AA6agR4RNzSmLQwqO8u3quSZyDeocAV+diVXBCD2YHvHQAbav7s7muxW4cME/KCDPiOHXY3V2Ygl2GO3qm+o0W+LD/g=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr8077995oiw.96.1661802420177; Mon, 29
 Aug 2022 12:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220829122914.268251-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220829122914.268251-1-cui.jinpeng2@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 29 Aug 2022 15:46:49 -0400
Message-ID: <CADnq5_Nk5iiKWZ0eh0GxgHVsD0bz-=SbuzAZRs=Dw6oYfpy=qA@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amdkfd: remove redundant variables err and ret
To:     cgel.zte@gmail.com
Cc:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>
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

On Mon, Aug 29, 2022 at 8:29 AM <cgel.zte@gmail.com> wrote:
>
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>
> Return value from kfd_wait_on_events() and io_remap_pfn_range() directly
> instead of taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 664e8b5d82c0..84da1a9ce37c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -876,14 +876,11 @@ static int kfd_ioctl_wait_events(struct file *filp, struct kfd_process *p,
>                                 void *data)
>  {
>         struct kfd_ioctl_wait_events_args *args = data;
> -       int err;
>
> -       err = kfd_wait_on_events(p, args->num_events,
> +       return kfd_wait_on_events(p, args->num_events,
>                         (void __user *)args->events_ptr,
>                         (args->wait_for_all != 0),
>                         &args->timeout, &args->wait_result);
> -
> -       return err;
>  }
>  static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
>                                         struct kfd_process *p, void *data)
> @@ -2860,7 +2857,6 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
>                       struct vm_area_struct *vma)
>  {
>         phys_addr_t address;
> -       int ret;
>
>         if (vma->vm_end - vma->vm_start != PAGE_SIZE)
>                 return -EINVAL;
> @@ -2880,12 +2876,11 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
>                  process->pasid, (unsigned long long) vma->vm_start,
>                  address, vma->vm_flags, PAGE_SIZE);
>
> -       ret = io_remap_pfn_range(vma,
> +       return io_remap_pfn_range(vma,
>                                 vma->vm_start,
>                                 address >> PAGE_SHIFT,
>                                 PAGE_SIZE,
>                                 vma->vm_page_prot);
> -       return ret;
>  }
>
>
> --
> 2.25.1
>
