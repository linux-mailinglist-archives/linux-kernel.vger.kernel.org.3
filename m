Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC844EE895
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbiDAGox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344079AbiDAGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:43:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05E9264F58
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:40:19 -0700 (PDT)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPXQi-1nMTYJ2eJe-00MddZ for <linux-kernel@vger.kernel.org>; Fri, 01 Apr
 2022 08:40:17 +0200
Received: by mail-wm1-f41.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so877785wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:40:17 -0700 (PDT)
X-Gm-Message-State: AOAM530l5h6/pQQT2y69dB5WcUjM7hNsiSjX0VVey5NfKjV9YgHd5CRu
        yzbW9TIgn+8LDxo5A0m8yEBF57iqtOzHrMrJvsc=
X-Google-Smtp-Source: ABdhPJwC5z+sAn17occf3Oq3+R8V9ZmDKK+Zi7YFaHXhrQtXx/QDFTl8cUyr212C+CYlcyRy40sN+7l9uq6D9gkBHEA=
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id
 g12-20020a05600c4ecc00b0038e354d0909mr7594064wmq.33.1648795217089; Thu, 31
 Mar 2022 23:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220401041615.3296387-1-jcmvbkbc@gmail.com>
In-Reply-To: <20220401041615.3296387-1-jcmvbkbc@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Apr 2022 08:40:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19-qtAg8GD8a9nG4ZPuyoDi3n39+zvHcRV-YdPJbJfKA@mail.gmail.com>
Message-ID: <CAK8P3a19-qtAg8GD8a9nG4ZPuyoDi3n39+zvHcRV-YdPJbJfKA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix build warning
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Ohad Sharabi <osharabi@habana.ai>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7/apYVceyzMHHgjhbHbSAYnE7h2T/G9qv4kwD8wrvsXM5e+LFSL
 S+EALX0C6wX+pnBlIUgazT457a+WA/Fix/gLOaODFCAOmRs20bK7ADIcuz7N9+fIwReGT8T
 bEiq2viY6ow/wjNfiTCMESnKlz1oWojzGZ8Zoq0Itm+Yqkoq03s0VpOFwjN+v2DPAjuCCY5
 oPtTyUPYv9wq//NP+AppA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yzVWTzNIuSM=:HpOTpmiDGwk6lkLB+VVzz9
 CF9Pc0gNQLlmr0cJSjeqKvctG4hZIxmvuv5locXyPvZ2FfWIUePBWRZHmG3BFdmc+Kj02QJzi
 L9tovfBMfuvAZ1zF8Ev6aZk/YXRyGFwN+i97gtpgi4xzJQg7ksGx2lmf+JfiGLPB79HWjrkrN
 QTXDdXzr9roetm/PT0yv46BJiRq/BkDZJZykAgONn0NJNAHmOsyrPTxLA/tgtB2xp2oQMVZRA
 CxlRoBC/RB9gS9SW9HNjdFSXbZdSA133O2NCbY47zEz2PCdLAdQ5jJZ7EnybqZYrB2CjaobO+
 ND8FWBYc8w+XwzvEwji4FWDQVjWc6ZSyZJLrWeHqWVrLApPS+p0MInmnk9vVEqAtkiy9koHUI
 pdeKXNlukKUmEcJqF1EjDR4O5c0Z4DxoL3e2g4zRdKsHco41pdENmF+mzyX3Q1jzdkAYgPrPH
 CXqODSNdzB1FGwmwlTcBJwRlzgOQ3CKrZZEBjKip+jlmbQkroQ8ucJmV0GBtm0iJ0V6oqlpqB
 CtgcU0EgIokGbUiRmrg/ElxYNYk7QlviBQCW0hDjy9oSzrTWxeWCHHmq3+0/5LdqeHPPxZTN6
 AgOorSvqxp9+lAAFFa5dgVjSr8R0KaRCinz0MLOfa2euzam+fVbLIzMuMQ3/0smSKqdxI7MA1
 TjELv3ZJM59t2RuDgQwwefvM6bqWzLReNqbHdAlswsoy4AUByqChrEm+dg6q1OI5a4ZMtbXQw
 7NPkw9Efyu7+YjneCW/jnddlTGYK/aWwAbDwT4zRllceY1wVdefnusfWg8n5ZD9loXugvZJyI
 h9joV5u0P1gwlXxHh4dSnxBnBrs+jUQS2kcQb8Vkp5pdaqMXQc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 6:16 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> allmodconfig build fails on ARCH=xtensa with the following message:
>
>   drivers/misc/habanalabs/common/memory.c:153:49: error: cast from pointer
>         to integer of different size [-Werror=pointer-to-int-cast]
>         (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>
> Fix it by adding intermediate conversion to uintptr_t as in other places
> in that driver.
>
> Fixes: e8458e20e0a3 ("habanalabs: make sure device mem alloc is page aligned")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  drivers/misc/habanalabs/common/memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> index e008d82e4ba3..f0d373171d2a 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -150,9 +150,9 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>                 for (i = 0 ; i < num_pgs ; i++) {
>                         if (is_power_of_2(page_size))
>                                 phys_pg_pack->pages[i] =
> -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> -                                                                               page_size, NULL,
> -                                                                               page_size);
> +                                       (u64)(uintptr_t)gen_pool_dma_alloc_align(vm->dram_pg_pool,
> +                                                                                page_size, NULL,
> +                                                                                page_size);
>                         else
>                                 phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
>                                                                                 page_size);

This addresses the warning, but I suspect there is still a problem in the code:
The description of that member lists it as '@pages: the physical page array',
but it is actually a kernel virtual address that gets passed to it. Since this
is a 'u64' member, it is hard to tell what type it actually is.

gen_pool_dma_alloc_align() returns both a virtual address and a dma (bus)
address. The dma address is ignored here, which makes me wonder why
this interface is used in the first place.

I can see four possible things that may be going on here:

- if the pages[] array is meant to be a kernel virtual address, it should be
  changed from a 'u64' to a normal pointer, with the cast removed.

- if the pages[] array is meant to be a physical address, as documented,
  it should be assigned using virt_to_phys() on the pointer, with a warning
  that this must not be used a as a dma address (which can easily get
  confused with a phys address as the binary representation is often the
  same in the absence of an iommu). In this case, it should also be
  changed to a phys_addr_t.

- if the pages[] array is meant to be a dma address, it should be changed
  to a dma_addr_t, and passed as the third argument to
  gen_pool_dma_alloc_align() in order to return the correct address.

- if there is a 'u64' member that is used for two (or all three) of the above
  depending on context, it should be replaced with either multiple
  struct members or a union.

Looking at other uses of the pages[] array, I see a dma_addr_t assigned
to it in init_phys_pg_pack_from_userptr(), but map_phys_pg_pack() and
alloc_sgt_from_device_pages appear to treat it as a cpu-physical phys_addr_t
rather than a device address again.

        Arnd
