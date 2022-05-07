Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E236651E5B9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446152AbiEGIxi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 May 2022 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbiEGIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:53:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5648380
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:49:50 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1x2P-1nyiMn3Sll-012FQg for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022
 10:49:49 +0200
Received: by mail-yb1-f171.google.com with SMTP id v59so16604966ybi.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 01:49:48 -0700 (PDT)
X-Gm-Message-State: AOAM533AHtBL19lDAnzQ4HdEHZmrvoOKfl+Bbbrn4PQNG18TLNG5AO6D
        PfTJqsAoHKRnKvwcNgfcBlqfFnP0boSUODEHiYc=
X-Google-Smtp-Source: ABdhPJzU/kokkyU4Ow0IuLOE+iQhWFkk4ZE0WMAv0gv2/fvi3qr5K21WMxPcMZht90sRTBchezYcKmQ2te8bG3LT0Jg=
X-Received: by 2002:a25:cdc7:0:b0:648:f57d:c0ed with SMTP id
 d190-20020a25cdc7000000b00648f57dc0edmr5436777ybf.480.1651913387633; Sat, 07
 May 2022 01:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210825064228.70487-1-deng.changcheng@zte.com.cn>
 <8735hsvzig.fsf@mpe.ellerman.id.au> <e2310273-8bc8-deac-9a80-0d1587acecb1@csgroup.eu>
In-Reply-To: <e2310273-8bc8-deac-9a80-0d1587acecb1@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 7 May 2022 10:49:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3s8GUtUUt-7BvUEajEDDAJMH7yJNCaUF8hdhjfmf_f7Q@mail.gmail.com>
Message-ID: <CAK8P3a3s8GUtUUt-7BvUEajEDDAJMH7yJNCaUF8hdhjfmf_f7Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] power:pkeys: fix bugon.cocci warnings
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, CGEL <cgel.zte@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>,
        Jing Yangyang <jing.yangyang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:m5KnsWbbTn8ytqeWgi/KEteracuXcWaRgNz47oWWOK6K14hIVQo
 85HKcyU1o6uAPzyeayPaSPNsiLUe0fWLHGEjnKqUC6SpmU0fYRwFk0PM6l5YkmiBlZH752P
 WbYWYBcmp1Fiz7HgaHE6DsMWpRqe2BZHqbTzA6ZLZRCcON9xR/9dpAui5+68Fa6h9zew9Vk
 qU7KPBWQe6oSWQN2dZK5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d7J8S09z6YU=:1xdkjNBT+qzaWcPq8Y+dJb
 swWUQ2KTNAUUpp+QgxZOgl5KP+noiPU+tYwBnpNnEdtlMnvri3COc7lPa+ikQiXPuK9gWsFCp
 q+mnjQao1mWc0jE0ByZhPfo+eHBfYs2a1SDefKHgTtIdivyFRH6WgN4DylfGNXZ4wpjYvuHru
 UO9sm2HodAfq4Ja6tG8N9BtFGGk3leKr+OqmAKmNfqAjdOrsE/ry/X6uxRDQCrKYjqpmrp4LW
 ea5Rs7bZIJIQEvq8NWj9PXV2cfrN6Hj2PKKmm7+WcgRCPqqwHcOzYsUnFN9cyenH3bWFyES0I
 jv8J6XXoSEE/FiqP+dtuxDu/8F2S3a9SKaMNJf3X5s6C6CqBck8aK9WSNb7kJngai7JSYjvPj
 8LvJwZpENfX/p1/agVE+FKAssnzdK5T0rMeLTiEy/Qd5LkIXlE9xPfpHVI7U61pyqQIOFaikt
 APu+zY4aKc/jEXJTjgcfc7Ertg0rwvXoiVL/oOQ2bEpw9mItVkQVU10DdJPOpagiJbzJVMixY
 9WqtjwJWEIdocjN9nLHbVoPwsfj2Qomu04HEc58W1YiQBHZgaXlHEfDnVOYuVi8D7DxdgzM+N
 mYIs+ZRj2Q+yD9NN+aabLQzKJWPNheH4QxEY49sIRbmUyyH5AHvenOWmV8RsXcxlHI2WErSW4
 2Ou8H2DKbAMyDtPAm1o0u/x8Z6L1ABX/v0L63qgTBJULw6xpTdKTuglcgZMS7SngmGEtYXFsl
 KQXVJn5trNmOpnthPha+8YFf6jEiRZy8tokWrByYWv4/JNd5af7CoEyJ1bg5PduqbCDmBvdgG
 bBI0RTv4NOog1LeJZMKG957h4egW2arA0k5kdrJUWWygjmbbtg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 9:04 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 02/05/2022 à 15:24, Michael Ellerman a écrit :
> > CGEL <cgel.zte@gmail.com> writes:
> >> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> >>
> >> Use BUG_ON instead of a if condition followed by BUG.
> >>
> >> ./arch/powerpc/include/asm/book3s/64/pkeys.h:21:2-5:WARNING
> >> Use BUG_ON instead of if condition followed by BUG.
> >> ./arch/powerpc/include/asm/book3s/64/pkeys.h:14:2-5:WARNING
> >> Use BUG_ON instead of if condition followed by BUG.
> >>
> >> Generated by: scripts/coccinelle/misc/bugon.cocci
> >>
> >> Reported-by: Zeal Robot <zealci@zte.com.cn>
> >> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
> >> ---
> >>   arch/powerpc/include/asm/book3s/64/pkeys.h | 6 ++----
> >>   1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/book3s/64/pkeys.h b/arch/powerpc/include/asm/book3s/64/pkeys.h
> >> index 5b17813..5f74f0c 100644
> >> --- a/arch/powerpc/include/asm/book3s/64/pkeys.h
> >> +++ b/arch/powerpc/include/asm/book3s/64/pkeys.h
> >> @@ -10,15 +10,13 @@ static inline u64 vmflag_to_pte_pkey_bits(u64 vm_flags)
> >>      if (!mmu_has_feature(MMU_FTR_PKEY))
> >>              return 0x0UL;
> >>
> >> -    if (radix_enabled())
> >> -            BUG();
> >> +    BUG_ON(radix_enabled());
> >>      return hash__vmflag_to_pte_pkey_bits(vm_flags);
> >>   }
> >>
> >>   static inline u16 pte_to_pkey_bits(u64 pteflags)
> >>   {
> >> -    if (radix_enabled())
> >> -            BUG();
> >> +    BUG_ON(radix_enabled());
> >>      return hash__pte_to_pkey_bits(pteflags);
> >>   }
> >
> > Have you checked how this changes the generated code?
> >
> > radix_enabled() is a jump label, via mmu_feature().
> >
> > Possibly the compiler just works it all out and generates the same code,
> > but I'd want some evidence of that before merging this.
>
> Seems like the compiler is not that good, the generated code for test1()
> is much better than the one for test2(), see below.
>
> void test1(void)
> {
>         if (radix_enabled())
>                 BUG();
> }
>
> void test2(void)
> {
>         BUG_ON(radix_enabled());
> }
>
> 0000000000000900 <.test1>:
>   900:  60 00 00 00     nop
>   904:  0f e0 00 00     twui    r0,0
>   908:  60 00 00 00     nop
>   90c:  60 00 00 00     nop
>   910:  4e 80 00 20     blr
>   914:  60 00 00 00     nop
>   918:  60 00 00 00     nop
>   91c:  60 00 00 00     nop
>
> 0000000000000920 <.test2>:
>   920:  60 00 00 00     nop
>   924:  39 20 00 01     li      r9,1
>   928:  0b 09 00 00     tdnei   r9,0
>   92c:  4e 80 00 20     blr
>   930:  39 20 00 00     li      r9,0
>   934:  0b 09 00 00     tdnei   r9,0
>   938:  4e 80 00 20     blr
>
>
> We should keep things as they are and change the coccinelle script.

Maybe just drop the custom ppc64 BUG_ON() then if it creates worse
code? The default BUG_ON() should be equivalent to the open-coded
version.

        Arnd
