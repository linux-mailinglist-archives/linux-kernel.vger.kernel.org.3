Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4446BC13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhLGNEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:04:31 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:55241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhLGNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:04:28 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mr9OA-1mFUWU3bgE-00oClf for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021
 14:00:56 +0100
Received: by mail-wr1-f44.google.com with SMTP id j3so29384164wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 05:00:56 -0800 (PST)
X-Gm-Message-State: AOAM531TIr7CjKAwPeQFUbNMonO4+9RVamT3Gtj6dHhUuVx774Yj9qWT
        WmJppJRbBd67Z4UPHo5dt1jDdWrKo5IXor4oTM0=
X-Google-Smtp-Source: ABdhPJxPTZb1NEgHTgiRZ5k7TV56wTLpaTAV0tigTfyAj6yjgVEdlWqbHmbxec81GQE5rsfdo8Evow6Ud4USOVQhzcM=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr50868012wrp.209.1638882056495;
 Tue, 07 Dec 2021 05:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20211207110228.698956-1-anders.roxell@linaro.org>
In-Reply-To: <20211207110228.698956-1-anders.roxell@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Dec 2021 14:00:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2xJJutbwujzh57QqEAgOUwBz5aT78ZFsSam7TfZuQ_Dg@mail.gmail.com>
Message-ID: <CAK8P3a2xJJutbwujzh57QqEAgOUwBz5aT78ZFsSam7TfZuQ_Dg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: platforms: cell: pervasive: fix clang -Wimplicit-fallthrough
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5vY9kdUQgOWVplvt9IvFwNXA/SbJmYljfOxv8HnixAPLOhRZHJ5
 eXjXSx8kPg8EYa+LdfUR3UvrPnSqJOVJBOUJNavORlIfWmIBbpLY9iweEqD2+0FYi9Balf5
 O1mGQzETEZVgCTyMKyAFQQKW4mcuZ4bMdG+FAp7/2USQ9hjdBpo+tqGKxjU7koYuB4/kzKJ
 P4DI1P2Urt5sDOwz64BTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gbn6C5V1CfI=:QEhCTrla2Ma2UZkomu7T1H
 /J7P1gyuaJoz8M8NPSfzVdR4tQzsDLX3VuTyM7AnpqaTy4Dg+FvdwtQotDFGn88V0hiSg3MiT
 HXgfApkCmYVQyMyGbuevWUydXtbfjxho7SyxQLsdLCQYacIFLkmx/3D5kJ2vY2td5pCFjIQ/Q
 UcBQgVV3Ff/Ma/F35SVS1vUGu3MB8j0FOfigEANa04MDCT55wlleiwI0NMjzXspj4xLnmyXAs
 rTFeUQzogeZiCUWML/Yp7TgikE+qkGAuqetE2r6lskxcuaKq5DErEat5o4OCT+/b1Q5YsAbS8
 +hkIxFX+AV/GXLpOipZSxoem8hK9R2mD6PCEXbkyoNa8gUOWyGzHWFVWp0VY7ZkP+OUzBjUBz
 6FHudGnayJhpPdFvXHZk5flLrp9jBMFeL85DICD7R0CR8/Aj6tnu3h+TvOillfhXEC9TpT4tt
 +mkzvsUosFZtIqpll9qwiLJMgK6RDcI5KbWc1ei3/OGp25/MO4jtZYpiCChe//U2REB4m3fQ5
 c4EgoN1Ptm4GxtoXNzekkeO8XsfSBSIyQXNc4JxaakyqQt2eSHJUWq8hs3w7T1DScg75iPLhO
 8wsSNXmK0q5lHCr3zGYp/wdemyhR88yP7CtmHydW9JzNpiw71kNO3vKT98dr+7g9AuozsZcxA
 yYmBUvM3fTYiBvDMq80+1dHv9oUE8jwp048k6V0jTBTVGuIlzHuf2h7ZOfXsXHuEEInVZfTqB
 frBky3Xva69lh7f+7QEMyRuC8kuT/w6DdqHMXX1It5F2bxWn2wWydq9S+36PN1v4rXaNThxeW
 zsfXlt/8G1fX9J4oxrxDm40LoEWy3+ijqBMktvCJ9Nk7QP/v8Y=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 12:02 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Clang warns:
>
> arch/powerpc/platforms/cell/pervasive.c:81:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>         case SRR1_WAKEEE:
>         ^
> arch/powerpc/platforms/cell/pervasive.c:81:2: note: insert 'break;' to avoid fall-through
>         case SRR1_WAKEEE:
>         ^
>         break;
> 1 error generated.
>
> Clang is more pedantic than GCC, which does not warn when failing
> through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst.
> Add athe missing break to silence the warning.
>
> Fixes: 6e83985b0f6e ("powerpc/cbe: Do not process external or decremeter interrupts from sreset")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the fix!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
