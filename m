Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A154BDB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355433AbiBUKrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355427AbiBUKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:47:03 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127A53B6A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:08:14 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d641c31776so131969707b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NcBfBvIGN108GW6jqQkaKU5JgXcj88Gw87NnerqCbbk=;
        b=U5GQR6zl+wEC+s4zqGuQ4Z/opVNdqTCgBCpxJTCXnyqOyuqKQzveaubSuCxrl+2A3i
         RxAO0Qa8+vn7ok7GQ02CVdScymbqa0/BCZ8POoqrSXbGg8MC3qls8kS+PmtccZ2nche5
         v8PRQ7U5t7qzrqYVDgG7uzboch8pq2uHY9w8xsdxwSNK0gO3BpboqOvbEDYx8Vtg+RFl
         az7pOvlBzLVs9z3Aevx2tpPKz8MHJOhrPS2CZKmFqUJdUP+7UtFS4GpmqokaDG0IQrrC
         7ROWUUNfCw7MMAmpAAzOJBGMYsAXt/zeqmKh8Q6P+lmk4YT22Msg7kOLGXauwmbypvWg
         Ip8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NcBfBvIGN108GW6jqQkaKU5JgXcj88Gw87NnerqCbbk=;
        b=luonzqHpKpzGm8LFZxJ1Cvg9JzF0zSt5vNDDYIMsjGAmc25DvjH119j/PhO2PWVTnw
         vEkB1FTTmiwHTQiI2QFy/8P6NwkAlDmT8S1+qgSmtuaobXNA5U2ecJQLeCO6A4B7ldwR
         dK2eQUr85SRClgDAzq9M7Lgm4lkJlyINjm+48jM5btjqBAlT8osHJuw1GFkTof/bm/r4
         EfNegtCUCC/tYs8ST797g9k62W3EP31ubR9Y7NYmm9GqQxyVnZYluxY5jM6CKr1s5WAG
         /79hE4IoLzII6xnZ1O3iV/txerCTAyMUqfSwDscPMmel2F2Pzw+JlZRhalg3ceCTesAN
         6C/g==
X-Gm-Message-State: AOAM531GIkbA9pMHzed8w07owWQf9SR0f8OHu2gU0CQ1CXAsxwbc7X1M
        xed6Wn6lqE3v83mmrUgZ0CTVw2ZvcLNm32OYMMDTmRxkVvI=
X-Google-Smtp-Source: ABdhPJwdtcLu9gibtfI044NAYjaGOHp5guIPKv5hfofKWIRcvH+UIjW/NYbFwolbYrIKJ1epDz+PvsCRtAOqs+ZNjwc=
X-Received: by 2002:a81:a97:0:b0:2d0:b672:5bd4 with SMTP id
 145-20020a810a97000000b002d0b6725bd4mr18539822ywk.90.1645438093649; Mon, 21
 Feb 2022 02:08:13 -0800 (PST)
MIME-Version: 1.0
References: <YgOQBNIdf0UnSH+M@Red> <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com> <YhKV55t90HWm6bhv@Red>
In-Reply-To: <YhKV55t90HWm6bhv@Red>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 21 Feb 2022 12:08:12 +0200
Message-ID: <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
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

Hi,

On Sun, Feb 20, 2022 at 9:26 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
...
>
> Hello
>
> While testing your patch for this problem, I saw another warning (unrelat=
ed with your patch):

Dear Corentin, you are a treasure trove of bug reports. I love it.
Thank you! :-)

> [   34.061953] ------------[ cut here ]------------
> [   34.066656] DMA-API: ccree e6601000.crypto: cacheline tracking EEXIST,=
 overlapping mappings aren't supported
> [   34.076555] WARNING: CPU: 3 PID: 475 at /home/clabbe/linux-next/kernel=
/dma/debug.c:571 add_dma_entry+0x1d0/0x288
> [   34.086748] Modules linked in:
> [   34.089809] CPU: 3 PID: 475 Comm: cryptomgr_test Tainted: G        W  =
       5.17.0-rc3-next-20220210-00115-g1ca9f29d9780-dirty #25
> [   34.101635] Hardware name: Renesas Salvator-X board based on r8a77950 =
(DT)
> [   34.108508] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   34.115471] pc : add_dma_entry+0x1d0/0x288
> [   34.119569] lr : add_dma_entry+0x1d0/0x288
> [   34.123664] sp : ffff80000e3236f0
> [   34.126976] x29: ffff80000e3236f0 x28: 0000000000000000 x27: 000000000=
0000000
> [   34.134122] x26: 0000000000000000 x25: ffff80000b3c76c0 x24: ffff80000=
b3c7000
> [   34.141267] x23: 0000000000000000 x22: 00000000ffffffef x21: ffff80000=
a8c1000
> [   34.148410] x20: ffff0004c0b93f80 x19: ffff80000b320000 x18: fffffffff=
fffffff
> [   34.155554] x17: 6c7265766f202c54 x16: 534958454520676e x15: 000000000=
00001fa
> [   34.162697] x14: ffff80000e3233f0 x13: 00000000ffffffea x12: ffff80000=
b3bdda0
> [   34.169840] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff80000=
b3a5db8
> [   34.176984] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : ffff80000=
b3a5d60
> [   34.184126] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 00000000f=
fffefff
> [   34.191269] x2 : ffff80000b34db38 x1 : 371dfc0f85526100 x0 : 000000000=
0000000
> [   34.198411] Call trace:
> [   34.200856]  add_dma_entry+0x1d0/0x288
> [   34.204604]  debug_dma_map_sg+0x150/0x398
> [   34.208615]  __dma_map_sg_attrs+0x9c/0x108
> [   34.212717]  dma_map_sg_attrs+0x10/0x28
> [   34.216554]  cc_map_sg+0x80/0x100
> [   34.219875]  cc_map_cipher_request+0x170/0x3c8
> [   34.224319]  cc_cipher_process+0x210/0xb58
> [   34.228415]  cc_cipher_encrypt+0x2c/0x38
> [   34.232338]  crypto_skcipher_encrypt+0x44/0x78
> [   34.236786]  drbg_kcapi_sym_ctr+0xdc/0x1f8
> [   34.240887]  drbg_ctr_generate+0x5c/0x98
> [   34.244812]  drbg_kcapi_random+0xb4/0x260
> [   34.248823]  alg_test_stdrng+0xf8/0x2b0
> [   34.252661]  alg_test.part.29+0xb4/0x398
> [   34.256583]  alg_test+0x48/0x78
> [   34.259724]  cryptomgr_test+0x48/0x50
> [   34.263386]  kthread+0x11c/0x128
> [   34.266619]  ret_from_fork+0x10/0x20
> [   34.270198] irq event stamp: 318
> [   34.273424] hardirqs last  enabled at (317): [<ffff8000081300e0>] __up=
_console_sem+0x60/0x98
> [   34.281869] hardirqs last disabled at (318): [<ffff800009bfbb18>] el1_=
dbg+0x28/0x90
> [   34.289531] softirqs last  enabled at (314): [<ffff800008010550>] __do=
_softirq+0x4a8/0x5ec
> [   34.297796] softirqs last disabled at (305): [<ffff8000080ab644>] irq_=
exit_rcu+0x18c/0x1b0
> [   34.306061] ---[ end trace 0000000000000000 ]---
>

So, this is an interesting one.
What I *think* is happening is that the drbg implementation is
actually doing something naughty: it is passing the same exact memory
buffer, both as source and destination to an encryption operation to
the crypto skcipher API, BUT via two different scatter gather lists.

I'm not sure but I believe this is not a legitimate use of the API,
but before we even go into this, let's see if this little fix helps at
all and this is indeed the root cause.

Can you test this small change for me, please?

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 177983b6ae38..13824fd27627 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1851,7 +1851,7 @@ static int drbg_kcapi_sym_ctr(struct drbg_state *drbg=
,
                /* Use scratchpad for in-place operation */
                inlen =3D scratchpad_use;
                memset(drbg->outscratchpad, 0, scratchpad_use);
-               sg_set_buf(sg_in, drbg->outscratchpad, scratchpad_use);
+               sg_in =3D sg_out;
        }

        while (outlen) {


Thanks!
Gilad




--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
