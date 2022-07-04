Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC2565710
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiGDNYQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jul 2022 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiGDNWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:22:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D89DFB3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:22:23 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N3bnP-1nPqIQ1R6B-010h6U for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022
 15:22:21 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31c8bb90d09so28265447b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:22:21 -0700 (PDT)
X-Gm-Message-State: AJIora93epaUseXq7oTBxusWckNmDl6R0r4ZE7HzivEuxQgtpP7jjhDs
        n4ZFiWb273t9krkG/JXrpjc/ETL5H7+vKHc0tg8=
X-Google-Smtp-Source: AGRyM1vSNqE/dA73xomorsJNTCLKIKAarR3GdJzsZeQ0Unyn8Mqsmv6DIMqnbWDKeKL4LdHxnLOtas+QyAVTl9am/xA=
X-Received: by 2002:a81:1d43:0:b0:318:638d:2ca with SMTP id
 d64-20020a811d43000000b00318638d02camr34734313ywd.135.1656940940226; Mon, 04
 Jul 2022 06:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220524093939.30927-1-pali@kernel.org> <20220702094405.tp7eo4df7fjvn2ng@pali>
 <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au> <20220704103951.nm4m4kpgnus3ucqo@pali>
 <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com> <20220704131358.fy3z7tjcmk2m6pfh@pali>
In-Reply-To: <20220704131358.fy3z7tjcmk2m6pfh@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Jul 2022 15:22:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2hfnt+tHiqHrHAVyagSm73LJe4OV8ig=CKFcycfk4Zag@mail.gmail.com>
Message-ID: <CAK8P3a2hfnt+tHiqHrHAVyagSm73LJe4OV8ig=CKFcycfk4Zag@mail.gmail.com>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:shB8lUHNzKotSzWyCHtF6VwOY3xFq+hJ8KMcGCYXpezozStPft2
 KeTxiXEns3wEy0ZUD9haiKOwrATSi1X8q86Olfuv8qYnKdRJ9NA6tEZyVkDxthmpu3R0r7+
 0DDLsXF7AxFyh6grM5JwiJCSfQVRaHZEfkAJQrBHAEbYrsV1sPpnQ+TiMc5CQ5MIa0ZxHnX
 Z6k3V892Sh2Lo+wrZDR9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:odJOIFGuoNc=:t0ZnW9Iux2ZZizASvwBtOd
 M1p8rAR8JIIUX7pFzn4ftdBajqreHknDBknSgSoJE2Gh/3975x5Ylp+8KE2Mj3adXSGZExd+I
 Tz9VzxMU2mIkPNfxnncxUOXH5PhwhiqG78c5EfMHBgJBmFigHaxRezQX3ZMWK6p+8gUVbZpWm
 neuNjyQ3HlEXgG/wbkU7BHTYN+I1yNqBfg1QgEa4I274wH/ljThEbYhqmTV2RAfpy0j0dLnM0
 Pt7SSknNQPTZq8SofidMqQbqfKj3cwI+6Y4a062yw+AAZ7s+OtVEhZw4ff6uRTTDt3ptE2t0T
 P+7o30qedFv8lYHDSLGYPXgoq4BcpIgVSfpKNjLRSZ6RnK6vSBqf0WS7s2u8QsBvyz/78oIjO
 rAjqv5wYPJ8sqDhYD8nK6spbWFtxW778vyWgmjYTK/U3AUzCyLymwHEGqjEospjE1hWAKc8Os
 Ri/mjKYtTwXtOBNo7fcGBMorN61SOtwNH4+5I9DPVbsyO8Oblt0PWYQJhTjlZIqbj3P/L3jPq
 NEhVIugmTl79P/Q//rMIacy0yhky3fD54S7rZX1OOCzhHwNn88fnOJKLTOKBcHeZ8cFwUfVj7
 kuOAunIGwhkntagc6udtKtEcSx/aUIR2DKAbDmwkJVpfTOFlhRCcJjB2Z0tjeXYGsb/CauwYo
 dW0JGgeYSdAF7YeEDJyZFhIXU84ETD8jZI7Ona63dro1FUMcgTIbBh5RCUhLE3qigRfxGIYyF
 NbwW2TRU1LcOcAQRA7hWGG/DCdPF6tFXv9qR3Bq70qg7KNA3U0f2TFpU025jvk+GKZoT1Uoug
 YWQP6aF0ZrhCtt8ZIrypH0h9dyyDSRK4JNsq0ctEoQFf/rjQ+xGUr5SBRbHhf5qzx4Qq3wIst
 3ji03GvZ55K34cEDEEnd4kMUwytvfeq+xmH4FBekc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 3:13 PM Pali Rohár <pali@kernel.org> wrote:
> On Monday 04 July 2022 14:07:10 Arnd Bergmann wrote:

> > CFLAGS_CPU-$(CONFIG_PPC_BOOK3S_32) := -mcpu=powerpc
> > CFLAGS_CPU-$(CONFIG_PPC_85xx) := -mcpu=8540
> > CFLAGS_CPU-$(CONFIG_PPC8xx) := -mcpu=860
> > CFLAGS_CPU-$(CONFIG_PPC44x) := -mcpu=440
> > CFLAGS_CPU-$(CONFIG_PPC40x) := -mcpu=405
> > ifdef CONFIG_CPU_LITTLE_ENDIAN
> > CFLAGS_CPU-$(CONFIG_BOOK3S_64) := -mcpu=power8
> > else
> > CFLAGS_CPU-$(CONFIG_BOOK3S_64) := -mcpu=power5
> > endif
> > CFLAGS_CPU-$(CONFIG_BOOK3E_64) := -mcpu=powerpc64
>
> Yes, this is something I would expect that in Makefile should be.
>
> But what to do with fallback value?

Most of the fallback values can just be removed because we don't support
building with gcc versions older than 5.1.0 any more. The only one
that I think still needs a fallback is mtune=power9, which requires gcc-6.1
or higher. CONFIG_POWER9_CPU could similarly use a
"depends on GCC_VERSION > 60100".

        Arnd
