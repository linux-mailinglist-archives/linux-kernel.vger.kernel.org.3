Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF445215BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbiEJMtY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 May 2022 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiEJMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:49:21 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E239954F87;
        Tue, 10 May 2022 05:45:23 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M89XH-1njiHR09nH-005KE0; Tue, 10 May 2022 14:45:22 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso177959347b3.5;
        Tue, 10 May 2022 05:45:21 -0700 (PDT)
X-Gm-Message-State: AOAM5338C3Ge2AUp7+U50RmkC+gXi4PeMs60xRa2ido+KGU4J8YnREez
        X0kypQicSq4v+3u/0Us0Wr8CsZjzRRXP4xE4GKA=
X-Google-Smtp-Source: ABdhPJzMox01vuxEQtUfWllU9AWz/4JUx/kxnCj32RwNPwee8B5gGa7g4UyyJzXx+NUdFazIw85dXRebzWgEGBqQmRs=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr19895862ywk.209.1652186720629; Tue, 10
 May 2022 05:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220510032558.10304-1-ychuang3@nuvoton.com> <CAK8P3a1k8y8U99bBmqBYE1vYAc0q-UeaM0oLP4tTHZCpyYNOgA@mail.gmail.com>
 <d64f260d-8ee6-808a-5725-e1181f104dfe@nuvoton.com>
In-Reply-To: <d64f260d-8ee6-808a-5725-e1181f104dfe@nuvoton.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 May 2022 14:45:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3UZ_thp=CVeXYwJ57MXxsurr+Y9Ad0bv0EOi4Jn=S+eg@mail.gmail.com>
Message-ID: <CAK8P3a3UZ_thp=CVeXYwJ57MXxsurr+Y9Ad0bv0EOi4Jn=S+eg@mail.gmail.com>
Subject: Re: [PATCH V4 0/5] Add initial support for MA35D1 SoC
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ychuang570808@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>,
        cfli0@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:+XIeksmw5e2s0UWYrNzHMGgJ4tLqDH7geT0rzv8XgIckqj+rRkw
 HhNfYbvSyteExSSTeUJKTOaUCQJxhcHoB94MxMcHgydMXiDqG+/uCf/gXqtSQ17XF+Rd9gZ
 crUbHkWfSEBPJZP0dm/lkzNt0eGoRdhX6L0z5uuvzq8WOSc0K0rpnzRuA3JqOTSFxV0wlj2
 /NppZW8A9CytApq5ZFGNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bPX1W1qHsbY=:VSePpeoZseoTzfT7MYBbVc
 lhPZg3bnHkNSGkn2MW0FGEQSXma/kNNFWiX4c0ryigEhNmnvY064iWYtQLRhsEn8B3HdU4TPG
 R3kg9P/X2Lt8g3vr2LQAETzhtA/GTJ7fxxRp6uooo9zN3ESRYYHXSvAkNYdOdG75q8Vf1rVoL
 w/+129PfxO4h5qW/ux6bZXYxVHK5hteCKWv7qJkm8JldZchB9v2xtIkOwTPa4DuLAU9cbL9/1
 Fo4HjqViIejewa/ejur5XWR3MqDaBrCvdojJ6pWDGF+d95CU5XcmJT0u4dhvD/2S/naahxaGx
 pcFLz5sB6/dZoRU3Li8lzOj/lan8140BCUJ0BI550divgNG00BPW7v7dKXEJ8+DRhkdArUUP/
 yTOm9/2AIK0mgOc/riWGm4v2ZBZvPwUx/oO9xpkkfVy6r5IWo4dtq2RciNZ5qR2TYwQCwIIsN
 Ylfo7aZHF4ahM1JHlB0JGE2ZmrL0wMi99nIoRjvyEdeM+3GGYjwea69KaqfIJL71q8JJJGacO
 SgZ9QFJSBiuNNCLAvf9HGFTymDhW9501QevcmVfBFaRQ52aH0Anym/arWq8zamCMYcL0ACdaH
 faycYkjriNg63Cuqdplk8+wXZe+1r4GhzhEePssc/9ev2vbBSjx5ISEx1BWNt65eIHixbNqke
 h/YBese/6EZDxPwRaEgqTElXv3qomjS6GlRqgpN1DCsHUV73Hj/qXPJgPOXwHtcwb/uo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:40 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
> On 2022/5/10 下午 03:07, Arnd Bergmann wrote:
>
> MA35D1 is target at consumer application, while NPCM is for BMC.
> MA35D1 is equipped with ARM Coretx-A35 dual-core with the M4 co-processor.
>
> Our team has developed Linux application on MA35D1 test chip in the last
> year, and
> the mass production version is wafer-out in last month. It will be
> announced soon.
>
> We have ported TF-A, U-Boot, OP-TEE, and Linux 5.4.y to MA35D1 platform, and
> have provided Yocto and Buildroot distribution for beta site evaluation.
> All the source
> code can be found at https://github.com/OpenNuvoton/MPU-Family, include the
> Linux 5.4.y porting on MA35D1 platform.

Ok, thanks for the information, this is exactly what we need in the
changelog text for the platform, and (if you send a pull request)
in the tag description.

> Yes, we have console device driver ready. Please refer to
> https://github.com/OpenNuvoton/MA35D1_linux-5.4.y/blob/master/drivers/tty/serial/ma35d1_serial.c.
> But I think we have to fix coding style and have more review on it. Is
> the console driver must for the initial support submit, or can we submit it later?

I would prefer to have it included, but it looks like this has never been
reviewed, and I can immediately see a few things that need changes
before it can get included, so I suppose we could merge the platform
without it.

The reason I'd like to have it included is that without any I/O devices
it is obvious that the code you are sending has never been tested
on the kernel version you are sending it against, and that makes it
more likely that there are bugs.

If the platform for some reason does not make it into v5.19, I would
ask you to include the serial driver in the series so we can merge
a working initial branch for v5.20.

In the meantime, please post the driver for review to the linux-kernel
and linux-serial lists by itself, and keep me on Cc.

> And thank you to remind us to create an entry in MAINTAINERS file. I
> will add the patch in the next version.

Ok.

       Arnd
