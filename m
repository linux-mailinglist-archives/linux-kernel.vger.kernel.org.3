Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54D34A4BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380348AbiAaQ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:28:29 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:34201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380319AbiAaQ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:27:09 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MsqMq-1mLlwK15mS-00tDJZ for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022
 17:27:08 +0100
Received: by mail-wr1-f42.google.com with SMTP id l25so26405091wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:27:08 -0800 (PST)
X-Gm-Message-State: AOAM532i9lyo2q1C+1FBLBre9OdXRyCkgjqKVneI0TXasqiwTLvhM6iY
        xoNdYQC6ziiMzdS26pP/d01y7LIEg+kpB12n3Bc=
X-Google-Smtp-Source: ABdhPJw5WXWOtEfVHwBtJr9i/bYiuCJx1Ly/hLzOudt+D8XpOUk5vJjnUBlFxn7b/sQ7ZA4Ehm2ZJbb10G4njdZxc9Q=
X-Received: by 2002:a05:6000:144f:: with SMTP id v15mr18771802wrx.407.1643646427924;
 Mon, 31 Jan 2022 08:27:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
 <YfKngOPLeI3rQOn3@casper.infradead.org> <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
 <Yfa4WMeauvmgkQ9H@kernel.org> <YfbQlMyohx31FhSW@casper.infradead.org>
 <CAK8P3a1UcY7Lkm0U5igQCq2K5kpqpjVi-sW3R=JzpciS-+c-gQ@mail.gmail.com> <Yff9r+NdshpNKRk8@kernel.org>
In-Reply-To: <Yff9r+NdshpNKRk8@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Jan 2022 17:26:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3O4gdZZA_ON1efO7hp+3KskpdX68MHW5P=6n8ZTXj0SQ@mail.gmail.com>
Message-ID: <CAK8P3a3O4gdZZA_ON1efO7hp+3KskpdX68MHW5P=6n8ZTXj0SQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fnjsJ0KQ7qVmm84wYaA3SXO/ZUdVHlY7Gb7/3605rKITL618+WW
 bAOkmJcACnYBCoTXlfUFkLp9z81HAt2RuD8BkHlnkLy7dG/tlqec7fqIplsADr1/E9seQIF
 yhfByvQ/q4616VXKc0BENJRAL/M1Cz828ZPlbkhAI9ABqAWwzB4EaBUuKQWh2NepTawgsQP
 5vYArwm2ZutjMMdQpD0nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GVRrPhEzCYM=:V6eCnHxJlPeJq83ky2++vp
 6cPwSIFadBguNUKeuWP4FS8Sw7tyA6kS5GoFtTYs9SV1Sivvtk3sx0wYT7uAyPQTb66OOMSDh
 PlkbdyYbn8vabOC+pBRv9pWYGIg5++XA24K7FLbjUBrSws2ZZQRPnwzMxyc5PerlDBbWCxEZE
 GsZDJO+n8mw30yIiMnDUyuPm4hFnvEbY2sBjeG7it8A2faX7nQGpzKxCtXCpVSC6ZXyc5pefe
 h6XNpTr41hN/axRIky19nFXTnvdmgwOqo9oABtM/eVaYjFiBAAZ+9ge4uAPObtnw8KNFAqI38
 mo2K+UzpRb/Z4HYMTH6g9IdfHpMCL9N+sZT1v8puMl4jsNSKGBdbKZe6TpnQeVOeH5XJmpEXF
 8WiVHeCj7rZCk596oVfMgNA+xnu7E1tiN3iKqdf1zDZpKztWRkDOaEPHK6xcVQlby4J85lFJM
 pokvs9nwmPQbO21XovnlREQlc8WkxxSw6N/9+9/Rutb5mcWbnJxty6P8mUSEJkomLfVsar6/s
 Utlytajgyy/v2/E3ZkUJqJ8n4jy4mw5pP/FFJOFI37t+qbl45CVCvz6dKfT/BJ3cPaI4rxagV
 ujxVmXtx1uCylDBxOgZ6mp4ZhOF5Sdx4hZ8gjPd/ilVU+JzduN5/dETdTZKZz74T3gA+H64z2
 phwNP4Weey70/4feBsYncWVYHYi/Blv09YCrRWr2sYjC5xyFvajfwFGlnSbrqWC/Aa26uc0Zj
 vs3MUbfkph8crGyLUGaN8YLyg68JS4R92VXvi6mdJGs01iKERV55q1wSiXeBJq73vYqtU8zaJ
 6omS6YMmfu1lEWxDYI2qe/Z4WHmXRaZub/7YqIu/0BI5spCslk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 4:18 PM Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Jan 31, 2022 at 02:30:32PM +0100, Arnd Bergmann wrote:
> > On Sun, Jan 30, 2022 at 6:53 PM Matthew Wilcox <willy@infradead.org> wrote:

> I actually liked m68k's name for a header with virt_to_phys/phys_to_virt
> definitions - virtconvert.h.
>
> As an experiment I pulled out address translations from
> arch/arm/include/memory.h to arch/arm/include/virtconvert.h, it wasn't that
> bad:
>
>  arch/arm/include/asm/dma-mapping.h |   2 +
>  arch/arm/include/asm/io.h          |   1 +
>  arch/arm/include/asm/memory.h      | 244 ----------------------------------
>  arch/arm/include/asm/pgtable.h     |   1 +
>  arch/arm/include/asm/virtconvert.h | 264 +++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/psci_smp.c         |   1 +
>  6 files changed, 269 insertions(+), 244 deletions(-)
>
> (https://git.kernel.org/rppt/linux/c/4c34ec16319fc85280aad89d7a74df845c1614fc)

Right, that doesn't look too bad, especially since it seems you managed to avoid
any further indirect inlcudes. Doing the same consistently for all architectures
may end up a bit harder but would be a great help.

       Arnd
