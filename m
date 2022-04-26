Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF79F50FB75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiDZKyU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Apr 2022 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiDZKyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:54:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE57DE0A;
        Tue, 26 Apr 2022 03:51:10 -0700 (PDT)
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mq2za-1oDSfp2LEA-00nAzi; Tue, 26 Apr 2022 12:51:07 +0200
Received: by mail-wr1-f50.google.com with SMTP id s21so10180213wrb.8;
        Tue, 26 Apr 2022 03:51:07 -0700 (PDT)
X-Gm-Message-State: AOAM530T8QT25UCgZSYY/Y2aXBOZ8NCFajEiUHhxct3hxFrnZMPYKM/6
        dsdZaFSu/EIl+xTTFcHIViFmSLpXA5sfRRt/6dY=
X-Google-Smtp-Source: ABdhPJwv3pFB8WncbOOxlmqz6E+LrLV4NkQu/Q5kzsoMl03tzrGAbxuUPuNyuSoi1V3F1hRSCNe/pbMUxDHw00bd99I=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr18372018wrp.407.1650970267164; Tue, 26
 Apr 2022 03:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220426060808.78225-1-cai.huoqing@linux.dev> <20220426060808.78225-5-cai.huoqing@linux.dev>
 <618a4f53-0998-1e6b-e32b-8bf2d3057cec@amd.com>
In-Reply-To: <618a4f53-0998-1e6b-e32b-8bf2d3057cec@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 12:50:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2w1t7Sk897u0ndD66Lwp5a4DuOqqQLN4yHSg=JmrpOHQ@mail.gmail.com>
Message-ID: <CAK8P3a2w1t7Sk897u0ndD66Lwp5a4DuOqqQLN4yHSg=JmrpOHQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v2 4/4] drm/nvdla/uapi: Add UAPI of
 NVDLA driver
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:F1aOHJMTWTP9+Ce3tVRQ0URCj8anZnnEPNCduDHWetCrI69M4+Q
 /aqR7959J8Ty3AInm9ic1+3WPJWwprJwEcbAQ/ka4U6UPJevUz7BqzE3lt6vAANEPu/zZ1+
 oQGVH0YgpLiDBofOUGeNaqaPHr00cC6uQjTK2wLDnBEaWmcxxCuKQ+zQxptjlToUBVD/ga1
 tQ3aa/wEwSUPaqdhSXhVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YPtrxqFtPlQ=:DezQpGGO/FpbKEbzxerP3n
 +aY69poODMMiTe/knwXn3jECUpM4FV/9DstFxKQpOpfoxyLAqv5LDjf653h7FO47jW6G5G/tn
 CGkDebY+fPUJMBHHKnywviLoA+1EyZsARMxK/5VicIqc4UznvupgdcVaSbjzcMAnEM9KBXQBz
 qYTwGYhI4bH7WKhV7wT+8Vd9A1sP2n07kypJ2QEDN9ahqvlsYaalR9cxnAlLmMfLxmDo2HZ0h
 4elBK69wE+Vk92dCp1Dg54AjLOij0VHhIJEfjfKgxw4hYgagX4jFU2AXAZE7ZyCrNlvSjQsh8
 wF6Gk0rUN8dc0Cnh914Xlf8XB0QK6Ig9U59dqsmhKMS0T6Xte2Nh/ELqD+bxjnTmS4MoHj6HZ
 3DSuC0ox2VheihuuQ0MTJ004yfZaUvRfoO5/j4Jid2a6P5XkTSvUWkc3AA7vUE+Vn1RJ2KZES
 0NRzdihrFywrhHPDLd+fxNRuhC16i4Ffv/ouLHZwylF4u59XRjVb7ww8nlSf1VFZc5n6tgTxi
 1OKA6S3x3CFqeDKp709JgGO8hja5EqRNhWJJnIzj/0JELuh1MINdvGteATHdRyMHsnf+9wtTk
 OvoaokXZx7vUg7LW5IQhVmxCaaEor1FSrSERIOX7JStGIW3J2w3u/y/+2WtgNf4LL4zDWQfG6
 k4ybBdRM1GrdApK/zOX5aLPjj0Ad2CMZclvq02x6D538K0+5pmO+tG+OKfo4MgBrC4H0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 8:31 AM Christian König
<christian.koenig@amd.com> wrote:
> Am 26.04.22 um 08:08 schrieb Cai Huoqing:
> > The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
> > which is integrated into NVIDIA Jetson AGX Xavier,
> > so add UAPI of this driver.
> >
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>

I saw the reply but no the original mail, so I'll comment here.

> > +
> > +#if !defined(__KERNEL__)
> > +#define __user
> > +#endif

This is done in the 'make headers_install' step, no need to define it
separately.

> > +#define NVDLA_NO_TIMEOUT    (0xffffffff)
> > +     __u32 timeout;
>
> What format does that timeout value have?
>
> In general it is best practice to have absolute 64bit nanosecond
> timeouts (to be used with ktime inside the kernel) so that restarting
> interrupted IOCTLs works smooth.

When using absolute values, one also needs to decide whether this should be
realtime, monotonic or boottime and document the decision.


> > + * struct nvdla_submit_args structure for task submit
> > + *
> > + * @tasks            pointer to array of struct nvdla_ioctl_submit_task
> > + * @num_tasks                number of entries in tasks
> > + * @flags            flags for task submit, no flags defined yet
> > + * @version          version of task structure
> > + *
> > + */
> > +struct nvdla_submit_args {
> > +     __u64 tasks;
> > +     __u16 num_tasks;
> > +#define NVDLA_MAX_TASKS_PER_SUBMIT   24
> > +#define NVDLA_SUBMIT_FLAGS_ATOMIC    (1 << 0)
>
> Well that "no flags defined yet" from the comment above is probably
> outdated :)

> > +     __u16 flags;
> > +     __u32 version;
> > +};

Versioned interfaces are usually a bad idea. If you introduce an ioctl command,
it should generally keep working. If you ever need to change the interface, just
use a new command number for the new version.

> > +/**
> > + * struct nvdla_gem_create_args for allocating DMA buffer through GEM
> > + *
> > + * @handle           handle updated by kernel after allocation
> > + * @flags            implementation specific flags
> > + * @size             size of buffer to allocate
> > + */
> > +struct nvdla_gem_create_args {
> > +     __u32 handle;
> > +     __u32 flags;
> > +     __u64 size;
> > +};
> > +
> > +/**
> > + * struct nvdla_gem_map_offset_args for mapping DMA buffer
> > + *
> > + * @handle           handle of the buffer
> > + * @reserved         reserved for padding
> > + * @offset           offset updated by kernel after mapping
> > + */
> > +struct nvdla_gem_map_offset_args {
> > +     __u32 handle;
> > +     __u32 reserved;
> > +     __u64 offset;
> > +};
> > +
> > +#define DRM_NVDLA_SUBMIT             0x00
> > +#define DRM_NVDLA_GEM_CREATE 0x01
> > +#define DRM_NVDLA_GEM_MMAP           0x02

Is this an actual mmap() call, or something that needs to be done before the
mmap()? Is the 'handle' a file descriptor or some internal number?

      Arnd
