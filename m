Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93F4CFD85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiCGMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiCGMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:00:06 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37230F48
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:59:12 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id u10so10558901ybd.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 03:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bV2e4uYZdiO2SGuK4gMWF1S9xO3ScFX3Ou1CDb8EPSo=;
        b=xeOaD4dUhFICyh8RjDwEbTz/PjWILnbN/Iu3AUt8+YD3aTq0PAQaepYXbHaKVhgtf3
         hXRGdAEk2R4u2Y6iBskaPDWPyTZzgRBuIxA+k5m3ZyL5Xo3DVp5KC69vn3V0I6YquI6k
         EBT4bzLYICbMlSrfKfcGrDMpn4P2muGOb6+sRIlwOkA/XE8pXqV2Jgh5EcMAso9j3xtQ
         qQzXytrx23RChQMGNMh1Hu2lPc1Sp7rytSdflY6S7QEE4O+H8UBKS1+whwrdw/aeuYEx
         DStLllQqsOm+Md6g/ZWKbkJZN2MtXP8WfacUWSbCekJjP89pQ9G4Qlr56yRg5LFvC+zx
         8aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bV2e4uYZdiO2SGuK4gMWF1S9xO3ScFX3Ou1CDb8EPSo=;
        b=pApqx/yc8SpwR3V6gHBBcuzGy0AxYST32eRAcGJWq7k44fAR3I6NH39uSZdkSk/PnF
         6ZQwY2EsbKC6/hX8QXHk3YB9XFWO48fSvgwcXIYmEy1W1k/YP3jJxm/3zNJfpJqn9SZ/
         q6FuJ8obOIZDsnHMUlhSjo6brUmhV4hv64qG1QslPfjuep6A78XF7mEWx7amt3CCfZdF
         s5C6BtH/DyoQZLnAOSD3w+0YZETR8660RuYUUCEv39Vq/TeeD49BULNPN3ZmL0sQk1Js
         XSp+HjeGTZ7GKWgoA/0So9i/Lg7sL1APWcJErsXNpx6zHzZwfZ+LunrHgCRwBP8cXpUN
         hhYg==
X-Gm-Message-State: AOAM530MzZOkpKH2bb9EJT4xpna2Up1UR5DTLrpcVdHY84aRS56QbeIK
        mE57l7l4uSxCVmxfqVDjizlq539NQqZeMBDvNp8nZA==
X-Google-Smtp-Source: ABdhPJwDS1OxZxxy3LaGGOOmhI6ZiC9WpyiVFwzuNygdkuxrG3moRyKMpbwH69yJp+siK+706Xvrf7ZNqM598j1KlbM=
X-Received: by 2002:a25:9d81:0:b0:622:7df3:ff6c with SMTP id
 v1-20020a259d81000000b006227df3ff6cmr7398255ybp.617.1646654351222; Mon, 07
 Mar 2022 03:59:11 -0800 (PST)
MIME-Version: 1.0
References: <YhKV55t90HWm6bhv@Red> <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red> <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red> <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com> <YiXxOqfF21q5LAxR@Red>
In-Reply-To: <YiXxOqfF21q5LAxR@Red>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 7 Mar 2022 13:59:00 +0200
Message-ID: <CAOtvUMd3=EME0S6Q1URgS5V1hSvhzLnGEwSy_im=S+1x2-koJQ@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

A bug in the DMA API it is not.

What is the call site that calls into the crypto driver in your case?
Is it the drbg like in the cryptocell case or something else?

Thanks,
Gilad

On Mon, Mar 7, 2022 at 1:49 PM Corentin Labbe <clabbe.montjoie@gmail.com> w=
rote:
>
> Le Mon, Mar 07, 2022 at 11:14:16AM +0000, Robin Murphy a =C3=A9crit :
> > On 2022-03-07 10:48, Corentin Labbe wrote:
> > > Le Mon, Mar 07, 2022 at 09:59:29AM +0200, Gilad Ben-Yossef a =C3=AF=
=C2=BF=C2=BDcrit :
> > >> On Sun, Mar 6, 2022 at 11:49 PM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:
> > >>>
> > >>> On Fri, Mar 04, 2022 at 02:30:06PM +0100, Corentin Labbe wrote:
> > >>>>
> > >>>> Hello
> > >>>>
> > >>>> I got:
> > >>>> [   17.563793] ------------[ cut here ]------------
> > >>>> [   17.568492] DMA-API: ccree e6601000.crypto: device driver frees=
 DMA memory with different direction [device address=3D0x0000000078fe5800] =
[size=3D8 bytes] [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTION=
AL]
> > >>>
> > >>> The direction argument during unmap must match whatever direction
> > >>> you used during the original map call.
> > >>
> > >>
> > >> Yes, of course. I changed one but forgot the other.
> > >>
> > >> Corentin, could you be kind and check that this solves the original
> > >> problem and does not produce new warnings?
> > >>
> > >> diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c
> > >> b/drivers/crypto/ccree/cc_buffer_mgr.c
> > >> index 11e0278c8631..31cfe014922e 100644
> > >> --- a/drivers/crypto/ccree/cc_buffer_mgr.c
> > >> +++ b/drivers/crypto/ccree/cc_buffer_mgr.c
> > >> @@ -356,12 +356,14 @@ void cc_unmap_cipher_request(struct device *de=
v,
> > >> void *ctx,
> > >>                                req_ctx->mlli_params.mlli_dma_addr);
> > >>          }
> > >>
> > >> -       dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL)=
;
> > >> -       dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(src));
> > >> -
> > >>          if (src !=3D dst) {
> > >> -               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_BIDIR=
ECTIONAL);
> > >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_TO_DEV=
ICE);
> > >> +               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_FROM_=
DEVICE);
> > >>                  dev_dbg(dev, "Unmapped req->dst=3D%pK\n", sg_virt(d=
st));
> > >> +               dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(sr=
c));
> > >> +       } else {
> > >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRE=
CTIONAL);
> > >> +               dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(sr=
c));
> > >>          }
> > >>   }
> > >>
> > >> @@ -377,6 +379,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > >> *drvdata, void *ctx,
> > >>          u32 dummy =3D 0;
> > >>          int rc =3D 0;
> > >>          u32 mapped_nents =3D 0;
> > >> +       int src_direction =3D (src !=3D dst ? DMA_TO_DEVICE : DMA_BI=
DIRECTIONAL);
> > >>
> > >>          req_ctx->dma_buf_type =3D CC_DMA_BUF_DLLI;
> > >>          mlli_params->curr_pool =3D NULL;
> > >> @@ -399,7 +402,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > >> *drvdata, void *ctx,
> > >>          }
> > >>
> > >>          /* Map the src SGL */
> > >> -       rc =3D cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_c=
tx->in_nents,
> > >> +       rc =3D cc_map_sg(dev, src, nbytes, src_direction, &req_ctx->=
in_nents,
> > >>                         LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped=
_nents);
> > >>          if (rc)
> > >>                  goto cipher_exit;
> > >> @@ -416,7 +419,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > >> *drvdata, void *ctx,
> > >>                  }
> > >>          } else {
> > >>                  /* Map the dst sg */
> > >> -               rc =3D cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL=
,
> > >> +               rc =3D cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
> > >>                                 &req_ctx->out_nents, LLI_MAX_NUM_OF_=
DATA_ENTRIES,
> > >>                                 &dummy, &mapped_nents);
> > >>                  if (rc)
> > >>
> > >>
> > >
> > > Hello
> > >
> > > I still get the warning:
> > > [  433.406230] ------------[ cut here ]------------
> > > [  433.406326] DMA-API: ccree e6601000.crypto: cacheline tracking EEX=
IST, overlapping mappings aren't supported
> > > [  433.406386] WARNING: CPU: 7 PID: 31074 at /home/clabbe/linux-next/=
kernel/dma/debug.c:571 add_dma_entry+0x1d0/0x288
> > > [  433.406434] Modules linked in:
> > > [  433.406458] CPU: 7 PID: 31074 Comm: kcapi Not tainted 5.17.0-rc6-n=
ext-20220303-00130-g30042e47ee47-dirty #54
> > > [  433.406473] Hardware name: Renesas Salvator-X board based on r8a77=
950 (DT)
> > > [  433.406484] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> > > [  433.406498] pc : add_dma_entry+0x1d0/0x288
> > > [  433.406510] lr : add_dma_entry+0x1d0/0x288
> > > [  433.406522] sp : ffff800015da3690
> > > [  433.406531] x29: ffff800015da3690 x28: 0000000000000000 x27: 00000=
00000000000
> > > [  433.406562] x26: 0000000000000000 x25: ffff80000b4c7bc0 x24: ffff8=
0000b4c7000
> > > [  433.406593] x23: 0000000000000000 x22: 00000000ffffffef x21: ffff8=
0000a9b6000
> > > [  433.406623] x20: ffff0004c0af5c00 x19: ffff80000b420000 x18: fffff=
fffffffffff
> > > [  433.406653] x17: 6c7265766f202c54 x16: 534958454520676e x15: 00000=
0000000022e
> > > [  433.406683] x14: ffff800015da3380 x13: 00000000ffffffea x12: ffff8=
0000b4be010
> > > [  433.406713] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff8=
0000b4a6028
> > > [  433.406743] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : ffff8=
0000b4a5fd0
> > > [  433.406773] x5 : ffff0006ff795c48 x4 : 0000000000000000 x3 : 00000=
00000000027
> > > [  433.406802] x2 : 0000000000000023 x1 : 8ca4e4fbf4b87900 x0 : 00000=
00000000000
> > > [  433.406833] Call trace:
> > > [  433.406841]  add_dma_entry+0x1d0/0x288
> > > [  433.406854]  debug_dma_map_sg+0x150/0x398
> > > [  433.406869]  __dma_map_sg_attrs+0x9c/0x108
> > > [  433.406889]  dma_map_sg_attrs+0x10/0x28
> > > [  433.406904]  cc_map_sg+0x80/0x100
> > > [  433.406924]  cc_map_cipher_request+0x178/0x3c8
> > > [  433.406939]  cc_cipher_process+0x210/0xb58
> > > [  433.406953]  cc_cipher_encrypt+0x2c/0x38
> > > [  433.406967]  crypto_skcipher_encrypt+0x44/0x78
> > > [  433.406986]  skcipher_recvmsg+0x36c/0x420
> > > [  433.407003]  ____sys_recvmsg+0x90/0x280
> > > [  433.407024]  ___sys_recvmsg+0x88/0xd0
> > > [  433.407038]  __sys_recvmsg+0x6c/0xd0
> > > [  433.407049]  __arm64_sys_recvmsg+0x24/0x30
> > > [  433.407061]  invoke_syscall+0x44/0x100
> > > [  433.407082]  el0_svc_common.constprop.3+0x90/0x120
> > > [  433.407096]  do_el0_svc+0x24/0x88
> > > [  433.407110]  el0_svc+0x4c/0x100
> > > [  433.407131]  el0t_64_sync_handler+0x90/0xb8
> > > [  433.407145]  el0t_64_sync+0x170/0x174
> > > [  433.407160] irq event stamp: 5624
> > > [  433.407168] hardirqs last  enabled at (5623): [<ffff80000812f6a8>]=
 __up_console_sem+0x60/0x98
> > > [  433.407191] hardirqs last disabled at (5624): [<ffff800009c9a060>]=
 el1_dbg+0x28/0x90
> > > [  433.407208] softirqs last  enabled at (5570): [<ffff8000097e62f8>]=
 lock_sock_nested+0x80/0xa0
> > > [  433.407226] softirqs last disabled at (5568): [<ffff8000097e62d8>]=
 lock_sock_nested+0x60/0xa0
> > > [  433.407241] ---[ end trace 0000000000000000 ]---
> > > [  433.407381] DMA-API: Mapped at:
> > > [  433.407396]  debug_dma_map_sg+0x16c/0x398
> > > [  433.407416]  __dma_map_sg_attrs+0x9c/0x108
> > > [  433.407436]  dma_map_sg_attrs+0x10/0x28
> > > [  433.407455]  cc_map_sg+0x80/0x100
> > > [  433.407475]  cc_map_cipher_request+0x178/0x3c8
> > >
> > >
> > > BUT I start to thing this is a bug in DMA-API debug.
> > >
> > >
> > > My sun8i-ss driver hit the same warning:
> > > [  142.458351] WARNING: CPU: 1 PID: 90 at kernel/dma/debug.c:597 add_=
dma_entry+0x2ec/0x4cc
> > > [  142.458429] DMA-API: sun8i-ss 1c15000.crypto: cacheline tracking E=
EXIST, overlapping mappings aren't supported
> > > [  142.458455] Modules linked in: ccm algif_aead xts cmac
> > > [  142.458563] CPU: 1 PID: 90 Comm: 1c15000.crypto- Not tainted 5.17.=
0-rc6-next-20220307-00132-g39dad568d20a-dirty #223
> > > [  142.458581] Hardware name: Allwinner A83t board
> > > [  142.458596]  unwind_backtrace from show_stack+0x10/0x14
> > > [  142.458627]  show_stack from 0xf0abdd1c
> > > [  142.458646] irq event stamp: 31747
> > > [  142.458660] hardirqs last  enabled at (31753): [<c019316c>] __up_c=
onsole_sem+0x50/0x60
> > > [  142.458688] hardirqs last disabled at (31758): [<c0193158>] __up_c=
onsole_sem+0x3c/0x60
> > > [  142.458710] softirqs last  enabled at (31600): [<c06990c8>] sun8i_=
ss_handle_cipher_request+0x300/0x8b8
> > > [  142.458738] softirqs last disabled at (31580): [<c06990c8>] sun8i_=
ss_handle_cipher_request+0x300/0x8b8
> > > [  142.458758] ---[ end trace 0000000000000000 ]---
> > > [  142.458771] DMA-API: Mapped at:
> > >
> > > Yes the mapped at is empty just after.
> > >
> > > And the sequence of DMA operations in my driver is simple, so I canno=
t see how any overlap could occur.
> >
> > The "overlap" is in the sense of having more than one mapping within th=
e
> > same cacheline:
> >
> > [  142.458120] DMA-API: add_dma_entry start P=3Dba79f200 N=3Dba79f
> > D=3Dba79f200 L=3D10 DMA_FROM_DEVICE attrs=3D0
> > [  142.458156] DMA-API: add_dma_entry start P=3D445dc010 N=3D445dc
> > D=3D445dc010 L=3D10 DMA_TO_DEVICE attrs=3D0
> > [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=3D16 bi=
=3D0
> > [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=3D16 bi=
=3D0
> > [  142.458234] DMA-API: add_dma_entry start P=3Dba79f210 N=3Dba79f
> > D=3Dba79f210 L=3D10 DMA_FROM_DEVICE attrs=3D0
> >
> > This actually illustrates exactly the reason why this is unsupportable.
> > ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mapping
> > ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the range
> > ba79f200-ba79f23f to be written back over the top of data that the
> > device has already started to write to memory. Hello data corruption.
> >
> > Separate DMA mappings should be from separate memory allocations,
> > respecting ARCH_DMA_MINALIGN.
> >
>
> Hello, thanks for the explanation.
> Does my driver can do something about it ?
> Like checking SGs respect this ARCH_DMA_MINALIGN constraints and if not f=
allback to a software implementation (as it will does non-DMA transfer).
>
> Regards



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
