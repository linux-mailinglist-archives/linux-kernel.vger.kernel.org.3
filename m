Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE338550900
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 08:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiFSGoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 02:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiFSGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 02:44:01 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9755E0BB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 23:44:00 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-101b4f9e825so6004908fac.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+quER5NGMegKQ2+a39UbWGtXnOF3tbSBum9vtozUG4=;
        b=kJD923+NNXgRdj9ITc6HK/8zea4glsSQJyxeZybzDnV6Fwwd/EmO1Zwt+3PDZxnWKv
         zBECdRIOXoTiRbcRPuc3wOSwJJduSkaz8AQe8cIbNYioAhorYJklD9byuNE0LIvaIAnu
         NH25uW1nEmUi/xsprhoWiuFsgmjqw49D+BZKPSA5rNRHuXS6AmYWEpkUXik23O6dyfQc
         QKqU+PO/wqAv++hB9LXcFOSZhI6HfpkDQ2pewrKOm2vbasqdJgrun9VGHr0Hrwqh3QdX
         WeoO0thiML3gwr8TDMjC/pMGW0Km6JsJlOZ5dUYARommebEhfnbaV6eA62C2Rv61Kdhr
         p3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+quER5NGMegKQ2+a39UbWGtXnOF3tbSBum9vtozUG4=;
        b=b5fAedMMVZ5YIgWNR9xqB8kM7tBkmIJNDhujo+uZy5caVhnfnWvMZWO2OOzhY0gbL4
         T2scPKXcviryWEllAFWTP1fuIx9Ue70cWWQWj7PMfw5mJoKVf/z7bWiVON3p0vxu7daE
         OsCenU5WORV35As5rIxCGF8JDHfbJqrSpIZi1WXwsJKEresG14XcU2TqtSOPI+G8Pjz2
         +deRXujmZgBPzkeIq5BOzSQHjxZueaje34fK9Z7KmdpA572yw9AJ5V1GQSKKCJ+rrnrM
         W59cuwHsxmwN5GS2qmj3v+pTtERd6PltJ5BHr/2d89LDfHxD3dc93XCjLXiayGZ/4r8c
         uluQ==
X-Gm-Message-State: AJIora855Zqqmt/tKMIUCbM88bmz6Ksy06yMMr7zuLGIR73S0RsUeENL
        JR73UGafUQXskMENYeiLSo8f9E/zSq6ljaSM6fg=
X-Google-Smtp-Source: AGRyM1trT5fOCkOF2Xj81BWd4Le2VqPCN13/dmgpGUSBE9QY+VGplhzdvJAyDeDeyBriwZHmXZd1cVKJd3KTUpMU8QI=
X-Received: by 2002:a05:6870:d582:b0:fe:4131:6dbb with SMTP id
 u2-20020a056870d58200b000fe41316dbbmr15585590oao.76.1655621040271; Sat, 18
 Jun 2022 23:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220619031114.92060-1-jrdr.linux@gmail.com> <48034eb1-3f37-f4fd-24b3-0eb7e517b35e@infradead.org>
In-Reply-To: <48034eb1-3f37-f4fd-24b3-0eb7e517b35e@infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 19 Jun 2022 12:13:47 +0530
Message-ID: <CAFqt6zYZk43k7deHth3RZHgkD48EaN-et38fCtV97b_qKpy7QA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/interrupt: Put braces around empty body in an
 'if' statement
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kernel test robot <lkp@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 11:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/18/22 20:11, Souptick Joarder wrote:
> > From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> >
> > Kernel test robot throws warning ->
> >
> > arch/powerpc/kernel/interrupt.c:
> > In function 'interrupt_exit_kernel_prepare':
> >
> >>> arch/powerpc/kernel/interrupt.c:542:55: warning: suggest
> > braces around empty body in an 'if' statement [-Wempty-body]
> >      542 |                 CT_WARN_ON(ct_state() == CONTEXT_USER);
>
> That must be when CONFIG_CONTEXT_TRACKING_USER is not set/enabled.
> Can you confirm that?

Yes, CONFIG_CONTEXT_TRACKING_USER is not set.
>
> Then the preferable fix would be in <linux/context_tracking.h>:
>
> change
> #define CT_WARN_ON(cond)
>
> to either an empty do-while loop or a static inline function.
>
> (adding Frederic to Cc:)
>
> >
> > Fix it by adding braces.
> >
> > Reported-by: Kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> > ---
> >  arch/powerpc/kernel/interrupt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> > index 784ea3289c84..b8a918bab48f 100644
> > --- a/arch/powerpc/kernel/interrupt.c
> > +++ b/arch/powerpc/kernel/interrupt.c
> > @@ -538,8 +538,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
> >        * CT_WARN_ON comes here via program_check_exception,
> >        * so avoid recursion.
> >        */
> > -     if (TRAP(regs) != INTERRUPT_PROGRAM)
> > +     if (TRAP(regs) != INTERRUPT_PROGRAM) {
> >               CT_WARN_ON(ct_state() == CONTEXT_USER);
> > +     }
> >
> >       kuap = kuap_get_and_assert_locked();
> >
>
> --
> ~Randy
