Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D994E3FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiCVNk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiCVNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:40:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0F5BE12;
        Tue, 22 Mar 2022 06:38:57 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3bCH-1oEl190w43-010d2h; Tue, 22 Mar 2022 14:38:56 +0100
Received: by mail-wm1-f43.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so1756900wmp.5;
        Tue, 22 Mar 2022 06:38:56 -0700 (PDT)
X-Gm-Message-State: AOAM5324cotBQ0lfYEOmJeoFNHhV9pmsgUxLcDOixQVRl6SsmGG1y1ZR
        pTKAyKk/0AsZiNMActrT8aoJKk1mF+PY5wlh0i8=
X-Google-Smtp-Source: ABdhPJzs3QeOlZNcBzENKO3A5fNgCdfHUg3y8+9tjOUu6Mb84GKwxwBSCBHL98AVKD2sOKEDH/Q+ERdYLiTXX/5v0oE=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr22098146wrq.192.1647956335843; Tue, 22
 Mar 2022 06:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-7-sven@svenpeter.dev>
In-Reply-To: <20220321165049.35985-7-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Mar 2022 14:38:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
Message-ID: <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zenq9dNBPyR4Cpm38NfQEf+UK2FuiOPpPDempQ8AJnXebIfJXmf
 93BsvJKhF2GNjg5ntyJdNAGHx7cj0du+3Y7hr/e3IDFlMFylmv1QhGT2YmxbvCU4tYtGYom
 JF9+BKTMyIYC4Khx6AMqSme/EhlO/fkFXm/jWw+uORNzEcsGLjSpGaJeaCNcaZlWq+XfLxB
 GZTmzbNWw6iTfuX3PQF2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8SvVq9YpZvI=:5uHD4aaefb0pZ9QtPGiYX5
 eI+YnRZXpI+NVn9zCydT3pqTEEhF02jE0y8CzwtGQ4NugYNPidTta2WgifBjqM6SXjY+uS06f
 vy3OdU/Qn6iOXq3bo6Kd1o6SYTq7ejEHrkt3Pn4Xth9D44xN2w0SnCRGOpyx93eMjtqHZJe4a
 eoxHqYDnF2dn7gucqsbfZ1tuekm0s1z0oDSuhJfAvioUvbbftfQG+e/Tl8aBO9dOHCMhQOi7T
 BuCpC296aXeKjdqZExM1rzYhqsgOLV0p7K3roqWFomPEcDtf7YJE4Ml4Hn2IEFLax3U3MRB9f
 rgJOqoZEfVWHFcUIWHkaAGdjr0ZIoBFGLXjeGvoGhADRVeuzRf8h8qy0eCiIc3YIqOqO9FKvO
 RynHNQ1UpoAdYqW2QKohP7wiFI05VWqcgIdsErB7Ltux0yQslaHvaG/se0MdMagqpMQaJ6Aq5
 Ss251BH/4qn83ICK8RbltFIlD+/6mJxkup51b+LXzRb5t3jnEMPcIBuQ6lsw83XlJev0TqOri
 XyAK2ic6J0PtARB0hCt+0gslv4XyMW7yQlL2uXK8zY67iFan8W/Ho2cAvV6fYdx4yqaW0ersK
 q5uD2brLFpk5va++IBaIEW8X1yNm9ZVHgj0WU8b9uy1GUvr+YfgNF5fDM3oiWyS5kPPJeq4P6
 0bMDNysji/JwZe0eu+9x6XG757aTMzUXIuDP/pobw8t0eNA7O0Z+8KEqUySKk567elGtdIYti
 NJ8HJZogQxj0/pT2SEHL89KGJZ+LxW9P01eYTFf+jnnbxbNr/gLTlX8r+JfkWKfDlvKxBNK+x
 kfqRS7lw08u4XxdrxPt5SYeql7DmFtm9v9KLFxe3RZSf+IWcZA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:

> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
> +                                    dma_addr_t iova, size_t size)
> +{
> +       struct apple_nvme *anv = cookie;
> +       int ret;
> +
> +       if (iova)
> +               return -EINVAL;
> +
> +       bfr->buffer = dma_alloc_coherent(anv->dev, size, &iova, GFP_KERNEL);
> +       if (!bfr->buffer)
> +               return -ENOMEM;

You pass 'iova' as an argument, but then replace it with the address
returned by dma_alloc_coherent(). Can you remove the function
argument?

> +static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
> +{
> +       struct apple_nvme *anv = queue_to_apple_nvme(q);
> +
> +       writel(tag, anv->mmio_nvme + APPLE_NVMMU_TCB_INVAL);
> +       if (readl_relaxed(anv->mmio_nvme + APPLE_NVMMU_TCB_STAT))
> +               dev_warn(anv->dev, "NVMMU TCB invalidation failed\n");
> +}

I don't like to see the _relaxed() accessors used without an explanation
about why that helps. Please use the non-relaxed version, or make sure
it's obvious here why you use it.

> +bad_sgl:
> +       WARN(DO_ONCE(apple_nvme_print_sgl, iod->sg, iod->nents),
> +            "Invalid SGL for payload:%d nents:%d\n", blk_rq_payload_bytes(req),
> +            iod->nents);

I think you mean WARN_ONCE() here?

> +       writel_relaxed(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
> +       (void)readl_relaxed(anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);

What is the purpose of the readl_relaxed() here? It looks like you are
trying to flush
the write to the hardware, but then again

  a) on Apple hardware, the registers are mapped using PROT_DEVICE_nGnRnE,
      so MMIO writes are never posted

  b) the read is "_relaxed", so there is no barrier, and the result is
unused, so
      it would appear that the CPU can just keep executing code anyway.

Since this is all the initialization path, I can't imagine what the
relaxation of
the barriers helps with.

> +static int apple_nvme_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
> +{
> +       *val = readl_relaxed(ctrl_to_apple_nvme(ctrl)->mmio_nvme + off);
> +       return 0;
> +}
> +
> +static int apple_nvme_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
> +{
> +       writel_relaxed(val, ctrl_to_apple_nvme(ctrl)->mmio_nvme + off);
> +       return 0;
> +}

If you have generic register access functions, don't make them use
_relaxed internally. If there are instances that need to be _relaxed,
add another version of the accessor that spells this out in the caller.

       Arnd
