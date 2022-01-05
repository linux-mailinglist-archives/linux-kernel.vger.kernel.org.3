Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463DD485B36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiAEWCH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jan 2022 17:02:07 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:49747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244642AbiAEWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:02:02 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M7NaW-1n1uxv35XY-007hna; Wed, 05 Jan 2022 23:01:59 +0100
Received: by mail-wm1-f41.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso2736886wml.0;
        Wed, 05 Jan 2022 14:01:59 -0800 (PST)
X-Gm-Message-State: AOAM530LLCee5i1yUP9LQpNn48kA7LYt/o5hQ+6HY27z9Cr8eCAERnCi
        lc9TvKnBwLil3QOig906vnI/DaliHbD0kPVWOzQ=
X-Google-Smtp-Source: ABdhPJwWrJlXfB7Nw+0BaPIxgI7LOoxc/sQFNbwbtKTUGMDZoFcEpkmKZYZVzhQrqMDtvs9qGlRu6A0/mwiCTmf+DH0=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr4649674wmc.82.1641420119336;
 Wed, 05 Jan 2022 14:01:59 -0800 (PST)
MIME-Version: 1.0
References: <0b8bacb36e111d2621c2c0459b20b1da9f4375c0.1641137463.git.christophe.jaillet@wanadoo.fr>
 <CAK8P3a2XwFveAd8nSCexZG3_UZga2PQ+EXHxQLGaWkLjCwrBxQ@mail.gmail.com> <bc95636a-8b67-b0cd-dc18-b21ac4b83962@wanadoo.fr>
In-Reply-To: <bc95636a-8b67-b0cd-dc18-b21ac4b83962@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 5 Jan 2022 17:01:47 -0500
X-Gmail-Original-Message-ID: <CAK8P3a1g1zQtY6o1hnXGxe5moZ5-z9vR4fuN8VPtSvKipALMcw@mail.gmail.com>
Message-ID: <CAK8P3a1g1zQtY6o1hnXGxe5moZ5-z9vR4fuN8VPtSvKipALMcw@mail.gmail.com>
Subject: Re: [PATCH] alpha: Remove usage of the deprecated "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        martin.oliveira@eideticom.com, alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:rTuykiNwVBEIeSjZ1o+zSrehe1GeftgEXky0h6A5f1OgD5OzPQi
 DYeuP2goCHuxnZG0aI4pQyCOdbO9HcPNjVPsO3zKyYuzSw1ilZgmXzSTehnk05hFailBA70
 SDCFg07PN7Fi9DNmeU7RwGpX91KAN3HnbLsI5aFUILiLdp4WH58SkGJHLtZbLXIMV4J+vzn
 LG1owcs3ov5sSPZVPhtZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MzWvNzcU5G8=:IusAjEuZopj/TQAQ9S/+ay
 DVng8zjnXalssmCXVX+vZXFQOahIbxh/Nw9JghZEWn2E2hSOzjVF/BRdiEjq/4l1WYLgvBGUJ
 XRQ2DIF8v/EZm5I9a/ARVL1cQGXYNLbE8xNpAmk0iZnD3WVEL5b/vShtnfrCIFRaf6PQx0xa5
 FyTNKFU3H5jNgpzVEOrxFRwASB3D+wRH8xz1jmcYnbHe5as98WiwuiP7CHarxKwxBA6Sn5X/Z
 Ty8469UHjo+UldID2Rux6lSLiyG0uEmuaB8JqhmnvwIKOKd3GNQVQqscA3FY0K3m23vZW41PO
 Sti/clYtauf6o/hmjmXaOUc4CLA8u5OSIsOxi2KqpgyDW7o76NwxU8aOjEZNJS4OzhE4bpl9D
 qGVbicPpD4eJAQZFQnfLwZicwIDac/WtA0Dt5qa1Q6bPih3UWFzAyL0IqRbRJjBuWH6Hmq1vI
 rEi4ehBtYvvShwksM31I1C0hXPD4t6G/h8xUL7zJ/ZkmkwXPOfrMMxCL8ayqRliU1S7P+WC91
 ga6865FhFcCCvwxa/OukEej+Oy1SN3uTsWzpYM3ae3SJbrm48Er/RPrZO5H/BJRqL11+HUiwI
 QmMsFHVmQGKL3vxJ6UuFl/WMOaNONkUb/TW8RSzIAv4gCcFP2+mHS9mAhBMn0kpZKkdbwyCXd
 LQwpPlx1df9bygNcI/vS8mbPCIJ2WtyNzqKkB6d8McUPrkHjyYDKVdeZdMaXBaj9VxtQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 4:23 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 03/01/2022 à 02:51, Arnd Bergmann a écrit :
> > On Sun, Jan 2, 2022 at 10:32 AM Christophe JAILLET
> > It looks like the number of remaining files that use the old
> > interfaces has gone down
> > a lot more since you last sent these patches. I would suggest you send them as a
> > series that includes the patch to remove the header as the last change, and
> > ask Andrew to pick up the ones that remain after this resend into the -mm tree,
> > possibly after the next -rc1. How many patches do you have left?
> >
>
> This would be ~ 10 patches.
> I sent recently some missing ones because I was not aware of
> --include-headers. So .h files were missing in my previous patches.
>
>
> The main remaining issue is linked to files in message/fusion.
> The patches are big.
> They have to be looked at carefully because it touches some GFP flags
> when s/pci_alloc_consistent/dma_alloc_coherent/.
>
> My last try did not get any attention.
> Even [1] which is purely mechanical
>
> I'll try another approach without trying to turn some (hidden)
> GFP_ATOMIC into GFP_KERNEL.
> 1st patch: only mechanical changes done with coccinelle, leaving GFP_ATOMIC
> 2nd patch: add some FIXME comments explaining why some could be turned
> into GFP_KERNEL
> 3rd patch: remove the comments and update the GFP flags accordingly.
>
> So, a maintainer could either apply 1 (no risk at all, should even
> generate the same .o file), or 1+2 (only FIXME comments for future
> analysis) or 1+2+3 for full clean-up (if he trusts me and/or has time to
> check my explanations).
>
> This way, I hope that some could at least apply the first one.

If it's down to 10 patches, just send them as a series with Andrew Morton,
Christoph Hellwig and me as recipients, in addition to the respective
subsystem maintainers. Christoph and I can make sure that every
patch is reviewed and then it's either the subsystem maintainers that pick
them up, and one of us that applies all the remaining ones in the mm,
dma-mapping, or asm-generic trees.

What I've seen from your patches all looks good, and I just want
them to be done, no need to wait forever for maintainers to reply
when they have had their chance several times before.

          Arnd
