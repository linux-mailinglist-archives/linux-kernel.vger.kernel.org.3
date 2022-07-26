Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA8580B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbiGZGRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiGZGQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:16:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DEFE08B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:15:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c72so13618595edf.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxA3xPJ54KVdQddJAH2cnhPV0N5Cpc7WAM9tFNGyhi4=;
        b=JJPXnIiM4jclKt9lrN7IrlLXt2sEbnZAhTslILWhwIUJpiDD6dF5bt4u8izKRrvvLf
         iezYZ+An6AaEorWrpP/C0f9t7v9MtBXFCd85xR8oTZtUIFQKkqI7fiDqYsS9839Tt8/B
         IcH00db7MWng1iwjgR5WrPQCFriuywi1/k1IU5mIeL9GWQ/hUrkQmHDNuFXuqWByPo9C
         jHKdnSGXCZScto544zcowiPv+7hDk/uG75EqzIHeihNDPicXK/yCAe0+IlTGH0Pik0xb
         A189BB1mqb0R/ETTe1nq6iLuqyQzUfUMvf0USD11M3FMUsAnSJNC45igZKWL4R/RCqxT
         IvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxA3xPJ54KVdQddJAH2cnhPV0N5Cpc7WAM9tFNGyhi4=;
        b=D/BIoHT0Me/2/FIQLt1Tn4ZYhH+whZLlL7X0bAopgN903alPXQNAeCgC1WPYN6n3cK
         5cCxttHWXIiTHoc0sadSnwXDw5U+prq2hVxPELHCW6HQY6Sq7aUhvlrfXq3vSpF472L+
         WvBPl5+NU47zZSsMzo/hGYwTIKu5dqFGYMYsKIrva/7Lodn8b76r65mq0XZMMsgOcRBV
         9tlEZ/aHX3a04SScofUKJOjwLjrb+9m+2CFS/2EYJSTkaEq5nc9wxKoKUMMXzW39BbTF
         R+N5v3Tgg09qXHbxileQYd45HZsCXgXMjUjfZSGvouuEtGepB/P1yk0ePt08u5JxueyY
         8qzQ==
X-Gm-Message-State: AJIora9hdurQhPQGFX5yBkL2PXFWq2ToWWDMe7ziwOaTZUl9l+EzOB3e
        CQ4OFcUiXNC57JSPoST+jxJOST5NXMKjhW7L9SY=
X-Google-Smtp-Source: AGRyM1tCExlQ1iBz/nxdMY5g3ApU82Tinlh8nw9EH0DeQ90YSSAnNoTfG4lBiQ7Hf9fYqxWokeYNlYQoCpLkbFJgY5A=
X-Received: by 2002:a05:6402:254b:b0:43b:d6c3:dd96 with SMTP id
 l11-20020a056402254b00b0043bd6c3dd96mr16199608edb.406.1658816154666; Mon, 25
 Jul 2022 23:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com> <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
 <Yt7CJj8r3eo05pKd@yury-laptop> <CAHp75VcGPQkY9ApsX2fi6sK5=3U=0vKbrHZZ3x___wUtgrFRSA@mail.gmail.com>
 <Yt8oK1gUojEbO0WI@yury-laptop> <CAHp75VdJ=FVy6TXTEOci0b2kMrG3z8scDwWTjx8M6+8Y35iSXA@mail.gmail.com>
In-Reply-To: <CAHp75VdJ=FVy6TXTEOci0b2kMrG3z8scDwWTjx8M6+8Y35iSXA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 08:15:18 +0200
Message-ID: <CAHp75Vee+RB5QHKZ6DJgH-M1C9o2wJ155m4gFAK0XUERdCffQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in archrandom.h
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 8:13 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 26, 2022 at 1:35 AM Yury Norov <yury.norov@gmail.com> wrote:
> > On Mon, Jul 25, 2022 at 11:39:39PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jul 25, 2022 at 6:19 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > > On Mon, Jul 25, 2022 at 09:28:12AM +0200, Andy Shevchenko wrote:
> > > > > On Sun, Jul 24, 2022 at 12:19 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> ...
>
> > > > > >  EXPORT_SYMBOL_GPL(pm_power_off);
> > > > >
> > > > > ^^^ (Note this and read below)
> > > > >
> > > > > ...
> > > > >
> > > > > > +EXPORT_SYMBOL(arch_get_random_seed_long);
> > > > >
> > > > > It can't be like this. Brief browsing of the callees shows that.
> > > >
> > > > Is my understanding correct that you're suggesting to make it GPL?
> > > >
> > > > ppc_md is exported with EXPORT_SYMBOL(), and the function is in header,
> > > > so it's available for non-GPL code now. I don't want to change it.
> > >
> > > The symbols your function calls are GPL. As far as I understand (not a
> > > lawyer!) it logically one may not call GPL and pretend to be non-GPL.
> >
> > Can you explain what you mean in details?
> >
> > The function is:
> >         static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> >         {
> >                if (ppc_md.get_random_seed)
> >                        return ppc_md.get_random_seed(v);
> >
> >                return false;
> >         }
> >
> > ppc_md is non-GPL:
> >  77 /* The main machine-dep calls structure
> >  78  */
> >  79 struct machdep_calls ppc_md;
> >  80 EXPORT_SYMBOL(ppc_md);
>
> What a mess...
>
> > And get_random_seed is initialized in in arch/powerpc/platforms/powernv/rng.c
> > with different functions that are static and not exported at all.

To be clear, their license is defined in the file: "GPL-2.0-or-later".
But again, not a lawyer, just using my common sense.

> > I don't understand where arch_get_random_seed_long calls GPL...
>
> The ->get_random_seed() (aka "callees" in my previous mail) are all
> GPL (maybe I missed one out of five which is non-GPL, but then it's
> even more of a mess).


-- 
With Best Regards,
Andy Shevchenko
