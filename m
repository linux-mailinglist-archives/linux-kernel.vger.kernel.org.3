Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B04664B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358330AbhLBNwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:52:00 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:55901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhLBNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:51:56 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWzXd-1n41vd1UjZ-00XK8B; Thu, 02 Dec 2021 14:48:32 +0100
Received: by mail-wm1-f49.google.com with SMTP id y196so23038888wmc.3;
        Thu, 02 Dec 2021 05:48:32 -0800 (PST)
X-Gm-Message-State: AOAM531WFus+GU0YNQXpzkBIydpLux8j5ubioOYdo8stMoYEkQvcDtD8
        rA7/1iCZN4jdICOqfBVkMGITxcPWIEktX7rosh8=
X-Google-Smtp-Source: ABdhPJz9IhZ0SVMn3gjv/EngarNH+BlhwpEhHG7fhKJMeyCvpco00ZNxUe6dzFexrgEIlOWKzQmzHfW+SeJnlSw5c/0=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr6353478wmi.173.1638452911927;
 Thu, 02 Dec 2021 05:48:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYv-os1goBNae4RSk2Gt9vdg53j3MPyAbmKPAoBdn5z7nA@mail.gmail.com>
In-Reply-To: <CA+G9fYv-os1goBNae4RSk2Gt9vdg53j3MPyAbmKPAoBdn5z7nA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Dec 2021 14:48:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1DxAhMU_LhdPE_8ndPJUoXv8a3OvDGPCuPB4w6o+rjEg@mail.gmail.com>
Message-ID: <CAK8P3a1DxAhMU_LhdPE_8ndPJUoXv8a3OvDGPCuPB4w6o+rjEg@mail.gmail.com>
Subject: Re: [Next] futex.h:89:9: error: implicit declaration of function 'arch_futex_atomic_op_inuser_local'
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FO2loLDDUaW6FSD1ht29xx61m53ACTGrYz9P8frxnAwC0tvrnCd
 PH3aWIMik6+1if7FvDcnQBCcfn2xHCrHKeMkCIn1eRbzE6LgtELYFXnfkhiVYBdVGga8ODR
 u+2018wGaXMOAFuSFxsODhW/79G0naCm2RYeX/SS0uiwSppypvRssyPykwhXAvWM9Jc1QBa
 FDChlopWoqvYh+Pnupr8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kmSZRRHABuQ=:BautNYfF9TuI4vzPQWly9z
 Gi+Kp05n+LndLe7TxozoeVlA/hrrMgdO0YvYQf9J+mITgXJ32tNuh5CXUjW5bHS13bP3rperd
 oB62Y047Qr0StqkMHYgFEnT0Ke5I4ZL10bALm5irn8W+s47/iaH/PHbzlObqmhpsFs/g1nWpE
 X/zdNV/1vgu2Fq84DkJli6CUAHrGrgXuGJfWsWo+yI+iWzCMYo6sGj1RJEo87oMAGST82qjby
 bPOq6ooSvH7oWpXGlQuIDmh6tfUWbCHXx0jK2GMx3pDtQyzdossB40Ifc3ZkKmE0/TXbQQNfC
 IQIczrSB8GmA4JqPw3Va2CWjZ50r0g91jmTwUY/W7DLrgLdmXEp+hfozqczY+g7IyUW5URpoX
 SyuYaia/kniUhWxrgU6RUGHdsXSZ5udbOOYjtwOn/KHiuqShu1LPwJutFkwRmGEME9GW9WuYP
 pOCmOo/udzTNaxRJPoHyPvKPTJW8F6n05zMdzPekyr8IG/Qp7OXGZrRp0mK7HZsq8ciqeeIum
 YAsOiJkoKyvIJoHelsiayAvcRXy92Xc3/WZ/IFX7c0Q/RwEmreK2p9t9ESBL86o46Oz9LHrYi
 guCafVlHXQN24vtas4U8AjpwpMgtLMyW7aYPma2ezJdTw2kfv/4bCr7AXHJ4B06gOzACN5ApQ
 DY8Wtd8WYt+y9P4E+7eHwle7aEPDIH6i6Ax0jbUrCQ5JPxXhZHwyuRuf0DftbEsnWrfI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 2:29 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> While building Linux next 20211202 tag for sh with gcc-10
> following warnings / errors noticed.
>
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=mips
> CROSS_COMPILE=mips-linux-gnu- 'CC=sccache mips-linux-gnu-gcc'
> 'HOSTCC=sccache gcc'
> In file included from /builds/linux/kernel/futex/futex.h:12,
>                  from /builds/linux/kernel/futex/core.c:41:
> /builds/linux/arch/mips/include/asm/futex.h: In function
> 'arch_futex_atomic_op_inuser':
> /builds/linux/arch/mips/include/asm/futex.h:89:9: error: implicit
> declaration of function 'arch_futex_atomic_op_inuser_local'; did you
> mean 'futex_atomic_op_inuser_local'?
> [-Werror=implicit-function-declaration]
>    89 |   ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Again? How many ways are there I can mess this up? It looks like
I managed to introduce a different typo here from the one I already fixed
for m68k. I'll make sure I test build all architectures before sending the
next fixup then.

        Arnd
