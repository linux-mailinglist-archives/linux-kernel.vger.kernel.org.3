Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57255570690
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiGKPF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:05:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5F57264
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:05:23 -0700 (PDT)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNtGq-1nvYug0Do8-00OCKL for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022
 17:05:22 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31d7db3e6e5so21394087b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:05:21 -0700 (PDT)
X-Gm-Message-State: AJIora/bupNDVOcYUW3XvHZ/nNzjLo71B+a0GbVamxMo4PLAU3l+kVAX
        N6W+UJyXViK2IK8xT16hUD32NsE+kRhtujIDGLU=
X-Google-Smtp-Source: AGRyM1uuR/3jowLZkJ4wNlbdpbRAfi5CN2W88/co9aQy/bRsGm6Pe6SDOiUAMoudRqc3oLXRF/2zn2EYg7LCb5Ma+f4=
X-Received: by 2002:a0d:df0f:0:b0:31b:e000:7942 with SMTP id
 i15-20020a0ddf0f000000b0031be0007942mr19298786ywe.320.1657551920821; Mon, 11
 Jul 2022 08:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu>
 <b0d982e223314ed82ab959f5d4ad2c4c00bedb99.1657549153.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b0d982e223314ed82ab959f5d4ad2c4c00bedb99.1657549153.git.christophe.leroy@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Jul 2022 17:05:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a33jf5CUpyzWmRHpoUDMWB7TqSw5afUW=rcmMVSK8BvRA@mail.gmail.com>
Message-ID: <CAK8P3a33jf5CUpyzWmRHpoUDMWB7TqSw5afUW=rcmMVSK8BvRA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] powerpc/44x: Fix build failure with GCC 12
 (unrecognized opcode: `wrteei')
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9pyF81zv4Lav/kgvY4gFtT9dHnr9vn1MUdQ/5bDFFAV2Vev7bMX
 akMTWkrMLiRBOnH7qJ8eOzru/IFUFflT9woT3XcDwM8RfLpkA/gFDfiFPyYVtEvIwGdOwen
 QoXbyoA3Ql2Soi8bq7K1JvyikolsDYfCgUt8mtIufZpt2zvxtRG14vec86GEl6hKuW3lRYp
 7obloZ+3cH+AenpCcE40g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:obUCBNVaeZQ=:TNJaDxiZTUqYH3eL4bM9Qq
 iHHThrxjU2Jv8uBEHDO7DPj/ot1yxztphcWATF/0spYTNCcEfW+OWfYC0zf+clbRcecC06fkA
 dCBpBwQvwtkFjbMFHpwnqNX2zrFBkFsUMdEfoWauJLHM3OwzF33xfNrp3zQegD3KaHZutDW8f
 +lziqZgeH+ekS9HMVqD0ShoucHmN3+Jn7sktKr+pPgD1KjuChDcJDpC1JxE53QPn6HNYBfBYH
 sGIomlUx5Uy4C4gWlJVCzKMopHSn8xhpXEr9qX6n2IUdkrduiiLFKmnNXLKfL3AtcwroduOEH
 C63nTruWT2faR1GVaY90hmeE709q9nBdQrhHza/pbdZmT0moymxxy4VOxgiTQovdS9JnZqHBj
 lGcV6n3u7q+YfykuWDO1olwIw14/ysdmKGrqgPVhMBN1zwkKeJkq2bJDz0U6fzCRQeeEp5dmG
 ZnCrlWVXytblq3bZM4lSIa8CM1tPVI4yffO1Z6fCDAbPI6OVVKysKPnmh4VwWfnD8ZuOJ7oIl
 0+Vt39atPN6ll1blObHTygi/e+UfaDYrAioWhM8p9huNOJFs2ycD1wMMN8JmH0qt0ocgJJh9C
 5muXBZq8c4tiAhigblY8b+jzF7483JWaOeWThTosGnY92/khLPZ9Y39MWvs4+zHcTTGo1SeY7
 ju26XNVy+KdInoyWdSTX6CzPmPSuok+KTwyhnFn01wZD9bxJGa6+9FkumrRzIiOVZ0NabWQrs
 UVFsSfbNKzrJI1aN+t3XKnb7EQpY2+dcfYAc3nw1XK9NZ9VLGzyz1zL6WPYKM97lzk2UlfODx
 AH6oL3R8fXu66jKaBnQ8wDZoSKGii9IzC9qN3tF3K7HkkYn8x9YyoIkWl6rcD50wHV3WsLU7e
 R3Qlq4ttj5ShCOKUIqCQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 4:19 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> @@ -183,6 +183,18 @@ config 405_CPU
>         bool "40x family"
>         depends on 40x
>
> +config 440_CPU
> +       bool "440 (44x family)"
> +       depends on 44x
> +
> +config 464_CPU
> +       bool "464 (44x family)"
> +       depends on 44x
> +
> +config 476_CPU
> +       bool "476 (47x family)"
> +       depends on PPC_47x

Is there any value in building for -mcpu=440 or -mcpu=464 when targeting a 476?
Maybe add another !PPC_47x dependency for the first two. Ideally we would also
enforce that 440/464 based boards cannot be selected together with 476, though
I guess that is a separate issue.

Is there a practical difference between 440 and 464 when building kernels?
gcc seems to treat them the same way, so maybe one option for both is enough
here.

     Arnd
