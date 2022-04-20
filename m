Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830FE50848B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377007AbiDTJNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377048AbiDTJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:13:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7D28E18;
        Wed, 20 Apr 2022 02:10:25 -0700 (PDT)
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0Fl9-1nsBMN0ERL-00xJW1; Wed, 20 Apr 2022 11:10:24 +0200
Received: by mail-wr1-f46.google.com with SMTP id c10so1351772wrb.1;
        Wed, 20 Apr 2022 02:10:23 -0700 (PDT)
X-Gm-Message-State: AOAM533ri6+6sbSQsHwjA230VB/UYGyMv6gZKZgIoz6S93RTpHirDkdV
        vMzaF/OOofaBvUrnM67Tu6p2G2MtdhjSwDKO8vE=
X-Google-Smtp-Source: ABdhPJwtLOp969nuzl2HcHrjTrE/8+7taAszNCD7/wMyEv6mWoZB/KbZc5q+V3PBrcZaYVxcH5WclGOcWViagO5a7ww=
X-Received: by 2002:a5d:6389:0:b0:207:a7d8:2b64 with SMTP id
 p9-20020a5d6389000000b00207a7d82b64mr14665624wru.12.1650445823721; Wed, 20
 Apr 2022 02:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220420084249.2186634-1-arnd@kernel.org>
In-Reply-To: <20220420084249.2186634-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Apr 2022 11:10:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mBdcGxV1nP15nY7sVfjya_VEeS78M5KQHjw66Kg+=Kg@mail.gmail.com>
Message-ID: <CAK8P3a1mBdcGxV1nP15nY7sVfjya_VEeS78M5KQHjw66Kg+=Kg@mail.gmail.com>
Subject: Re: [PATCH] [v3] m68k: coldfire: drop ISA_DMA_API support
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qF8uUzsZN4LBwJDSKSRH/nzVuSsVw7fvjZm56gLdoXhtyFIOiA/
 vWqfrkUIsfiRwqfZgQVrc89fNjZdCn9Nidl3eh/Deop3xw05hp/JMIGtBHnsBmVxrwhMqVN
 PRj+JNjY6kEEGEDk5LOw6R+4YXw9Vzn28CkjvOtBzBoJBrI5VyuUaeBifBw47kHkqo+iNfO
 HffoTegv9OaoUKoMxlbNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kWQqunrDJgc=:A0Ijx97e6NH2mW7PukdQrm
 KanLPf8FjiMVs24OaVWRawRGtbfUQIMbzlX+zjfu6FZBqgE0r4yMoXf1dvD6eVIlK/0+XxtR8
 PO4mvC5DS+/pgiz2o4gv3/uyUB/x46V0IbY2hMYHWjriwP2I3FFQ56CqOXicN8PZTf2LMRlmn
 2J0XbBjNuMxUz3QfRREWOxlxd/ioemkX1nx5gfCmyRDQjeNbt5kThrTcdb1/0UA939lPxFVbD
 AyeUEmvF+QQfovy+BsgXt6FLD5CRnpwlp+aAzUD9L/owr7isyUospGX+nEuZZUykRE70CfXCA
 DdYY5U60MH70LMOuhziLfyq3gaYKlzJkzRj7SdrvkzERzyBz+bpgpAQkx/ktyoQMkEU0XbsQi
 uV3AyWXNFobcHiVrZPUWEwZYY6XjJR3UDQX6qaCqWhyWwyT9ZT/1KYjhnOc5BXj3IRFayHXqF
 ZQVspluhg9Pn+Js9VB2CsYL60bKYXwvKvCJ9gM2u4HUfh5ONLAY864JxEjY7qt+AOxYAoD91D
 fOCfJZzKuOjV7PwTQzNwls1EQ9x0RywFwTuNocS7nzxgm7DK+bmGQel26jEI9uIq7Qzm8qY9g
 kz81wMW5B4B6ncVSLYobW3BJEzXvpaJLEaxu7s0sQdiW148CJfjWBzEsVVXYpNuvuHHexoypQ
 XvbZGYApHJYRDjhEqha63zQzVEZMSaRvVGGdlSYuXT69DB8BDvJkAw3Ir2ZH+swoRpuo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:42 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> After a build regression report, I took a look at possible users of
> CONFIG_ISA_DMA_API on m68k and found none, which Greg confirmed. The
> CONFIG_GENERIC_ISA_DMA option in turn is only needed to implement
> ISA_DMA_API, and is clearly not used on the platforms with ISA support.
>
> The CONFIG_ISA support for AMIGA_PCMCIA is probably also unneeded,
> but this is less clear. Unlike other PCMCIA implementations, this one
> does not use the drivers/pcmcia subsystem at all and just supports
> the "apne" network driver. When it was first added, one could use
> ISA drivers on it as well, but this probably broke at some point.
>
> With no reason to keep this, let's just drop the corresponding files
> and prevent the remaining ISA drivers that use this from getting built.
>
> The remaining definitions in asm/dma.h are used for PCI support.
>
> Link: https://lore.kernel.org/lkml/9e5ee1c3-ca80-f343-a1f5-66f3dd1c0727@linux-m68k.org/
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nevermind, this is the same as before, I forgot the 'git add' for the trivial
Makefile change.

       Arnd
