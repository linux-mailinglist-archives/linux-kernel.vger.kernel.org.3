Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCBE486F22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbiAGAxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:53:36 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:43145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbiAGAxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:53:35 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MVeDq-1mvptp38YW-00RaD6; Fri, 07 Jan 2022 01:53:33 +0100
Received: by mail-wr1-f50.google.com with SMTP id k18so7979569wrg.11;
        Thu, 06 Jan 2022 16:53:33 -0800 (PST)
X-Gm-Message-State: AOAM531KoSNsvUmeAkyKLxAZ5inYDvi63CFJI/Q496oH1TxJd6KMGSkO
        H/j8Py2vmYMPMEK80PgwHadiGELtv0BGiXdvGjg=
X-Google-Smtp-Source: ABdhPJzDgGNNS/2+ftq7IJW57CZ4gfVas+wNR19KbZ757dVgRYx5nXrRPsR+f9zPIVKlYT9vhVR+/somYqM+zzG/2KE=
X-Received: by 2002:a05:6000:16c7:: with SMTP id h7mr5162012wrf.317.1641516813381;
 Thu, 06 Jan 2022 16:53:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr> <f865712ee4edbbf3cdd831795b7546a768d923a3.1641500561.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f865712ee4edbbf3cdd831795b7546a768d923a3.1641500561.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Jan 2022 19:53:30 -0500
X-Gmail-Original-Message-ID: <CAK8P3a1rGDZmumXNHX=RdWBebJw12pbK1WBUQYSh6mqrwi0Vtw@mail.gmail.com>
Message-ID: <CAK8P3a1rGDZmumXNHX=RdWBebJw12pbK1WBUQYSh6mqrwi0Vtw@mail.gmail.com>
Subject: Re: [PATCH 05/16] agp/intel: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:79xrko4jOHYWAEn/KMjzX1oBTTV1CMjTiFjBiPjnkOZMyDIp97f
 0MdGXZxHfKNkdvuXosk5nd0KujeQsqikl/fYYlIui5wjlX+QxoFKdeQw0daQZEOpjCW93qB
 sjDqs2tdp8irXXH5DA8h9iOkivRcQTRAlA2cf5QMtjWg5WdS0IQXiF+Vk5FhvDofX6I9kHk
 K0HSaLSc7L13/3uXfuB7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3acWCDFvt0s=:wHpKzrkVbr79dgp5j8+b8/
 nXU6/gCpetWm4sb0Vya3OJHT2Oz1t414ehJRkRfm6iZp2EBuRKWzd3z2GFpKgdafjDG9+6X1K
 rq1aLGdqRga5aY5tvfXRZB1m0OwswV1xCgDj7uIASuu/ekbpuDJPj7LGxN0FTPFHPW6Nbkov2
 hf3zgt5lQeC0ZdVPAopzVwNiexXpX6clfV/bF4RsLHn+USXJY+mwP06UIgyvIqjy3nBFksrk5
 qm9E4MixC3Q+7hciO6WA4SUKFU7DWAZdSlajAgJY3aB5xe8pRBO9JYruetdKd4qiUEI9dQ6Pb
 VcwYxw3UTETqWVEICsdenVhJM6RIOFq9d78K67Fmg8Ac+bYPLBfTh5nCiCDu/vkXbiSVSHujw
 xXErhc/XCktv/+bd5JviGJ5YxH52BO/eGMXzu7KWsGdOayVhg6b6fg5taGckir2aHnf17ikbF
 3eBKEjlsnNq5KS7n85DQeboL3ADQQp1gjFkw+28KnYOmoI1r4zaamF11OCzauy7vZBe22EySh
 +F64bl/YQTC+VcguwvRtTo597+2+gu9wsFqXR+Us47m24heq2LH0AhBPrRri4e8HhAEFSY7+u
 TNELgOJNpu/sMdtsE2busNiik+CxzoNXIS20YVsS7w/FTXskbJSVETUyLnqNa83H5rrEJRJhF
 qltIpGOs8RWSMxsBtm1144pDJPCLmGC5pQlCXVQzA4dLlU5duWdQPhG63x6/t3Ta7W2i0uf9h
 bb2eo/oa3qibsZQ1f1ehcY07b0uM2fyEKtKfmAPUqaopp12gn85B1TAK1d/J86WEhFzNC1yco
 HhBTofxx2+hSUxpkAYCMbTAsDSpPW/UuiFLXHCkEWHqsgzI9eg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:51 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
>
> A coccinelle script has been used to perform the needed transformation.
> It can be found in [3].
>
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I suppose this should just go through the drm-misc tree, the patch has no
dependencies on anything else.
