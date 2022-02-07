Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180354AB601
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiBGHnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbiBGHlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:41:16 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:41:15 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE68C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:41:15 -0800 (PST)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxV4T-1oERoR2dgX-00xuUO for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022
 08:36:10 +0100
Received: by mail-wr1-f41.google.com with SMTP id k18so23026610wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 23:36:10 -0800 (PST)
X-Gm-Message-State: AOAM533fNTs6O26BmQr9ZUNmT1a8aVYGD+jWt/4WWLfRL38NCWBjkfFo
        6Hbw2Ieq8LUBMJiCyCtv/4AZuW8vXKyHJrLqzMs=
X-Google-Smtp-Source: ABdhPJyVGlOIgvpJW7xM8t4FOY4J099x0i6fJeSzk3p1XheXRjJZU8gVJdRuTWL3cfoKvVb3ClydTQGTK80Ui1xm5V0=
X-Received: by 2002:a05:6000:3c6:: with SMTP id b6mr8739723wrg.12.1644219370262;
 Sun, 06 Feb 2022 23:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20220206174359.2986-1-jszhang@kernel.org>
In-Reply-To: <20220206174359.2986-1-jszhang@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Feb 2022 08:35:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Nnw5gfPAYx5UGdW8Om16GDcBi1-SS9Bs+CyLzssgVbA@mail.gmail.com>
Message-ID: <CAK8P3a3Nnw5gfPAYx5UGdW8Om16GDcBi1-SS9Bs+CyLzssgVbA@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: reduce THREAD_SIZE from 16KB to 8KB for RV64
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JzWgcJAZLzpQifXZ6IrZjmGkqczipHMBODHSZjmJwIuiC50qv8T
 Oq1rLJD1LBfZShoXB9oF8/TKe/y/UVssmYOaDTSbz5Mf/KjLAIg+Y+cimoyBQAz8YGQTBMS
 fze+xzaDXf/j1umgYMDoDX/WklmlIs5Rm2wJBcb6x7sP8s1UcEEM3gHpQV8oVLGKQBcYeAK
 7+Njg1ESloHluJfcujMEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HFJiJZDHTig=:9LfgAY6dAzYkcJCkfxIi1i
 J5BcVnIeyWZkn5X+HJhHXVS6Eirbz7yPPh/C+qvIfKLgAyx8umLEmZJTR0plAY7yaVl2wGPHZ
 ZYJ1tMZFjUHG6HNe1e2FrqXycnA0XL+rFg4Pm20i1EmU8eR7cbja0CG4PGb8zyoMYiZiGvv3F
 km9vtQ/n8wqnU3+mqJ9P/MiYyIUl9lmcnZEH0WnkNfpmHCB/N7Zz+A/RTCCG2g3l7yFFE0ZZY
 bRXgCakTPExGC6CL8eW1HpLE3jc0ASsrh8+xUVXJryOb750ubRrrsQUpH98oCH5E48wouGg1P
 G1qrKMmf1PtK4P+gcBNquvHcCdeVzosOlr0tABfSAQHpw+Ta54vPuHsTOiyBlVhB/Wci67B2g
 USNT8ZHMY10kci3sPGuaacxEf+84oYBwCWhGDw65JC6Yy8D0HNV3RaJr0IcVuREVtfgMueOfn
 Gzh+txeUETmPnLT0TKjSL11PRMLzplZAiKfhb4oIoTd8bFZyX85AwDhlbA4wEjt7o2bvAzka8
 qyeordvzukuqXDMPICHLJgZPf6eYHmdoI9BrF8iFNbGblP3/A72BfG9CifGCb6n92e7bI6LpP
 K1vYS4wx+7LdAMxdB/Yrslik+DFhKgPqAxXoUWt8iR/w/Mdzc5bcP1XpeCYqcAT77lKL/jcZr
 BCXQUbLW9TE2G+9sZmNngJNOPr1Bda73izKLZZQfUZXTB1y+r1PZ0tBvA+6wio06Xi9I=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 6:43 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> After irq stack is supported, it's possible to use small THREAD_SIZE.
> In fact, I tested this patch on a Lichee RV board, looks good so far.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

I can definitely see the value in this, in particular when you get hardware with
small RAM configurations that would run a 32-bit kernel on other architectures.

However, it's worth pointing out that all other 64-bit architectures use 16KB or
more, so it is rather dangerous to be the first architecture to try this out in
a long time. Some on-stack structures have a lot of pointers and 'unsigned long'
members, so they need twice the space, while other structures are the
same size either way.

IRQ stacks obviously help here, but I don't think the 8KB size can be made
the default without a lot of testing of some of the more rarely used code paths.

Here are a few things that would be worth doing on the way to a smaller
kernel stack:

- do more compile-time testing with a lower CONFIG_FRAME_WARN value.
  Historically, this defaults to 2048 bytes on 64-bit architectures. This is
  much higher than we really want, but it takes work to find and eliminate
  the outliers. I previously had a series to reduce the limit to 1280 bytes on
  arm64 and still build all 'randconfig' configurations.

- Use a much lower limit during regression testing. There is already a config
   option to randomize the start of the thread stack, but you can also try
   adding a configurable offset to see how far you can push it for a given
   workload before you run into the guard page.

- With vmap stacks, using 12KB may be an option as well, giving you
   three pages for the stack plus one guard page, instead of 4 pages
   stack plus four guard pages.

- If you can make a convincing case for using a lower THREAD_SIZE,
  make this a compile-time option across all 64-bit architectures that
  support both IRQ stacks and VMAP stacks. The actual frame size
  does depend on the ISA a bit, and we know that parisc and ia64 are
  particularly, possibly s390 as well, but I would expect risc-v to be
  not much different from arm64 and x86 here.

       Arnd
