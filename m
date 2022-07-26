Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCF580AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiGZGOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGZGOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:14:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBCE23154
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:14:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m8so16478571edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZbiLt6v06YsvfiDARoxK3cxvf7NmvFXziCgf+/LbTk=;
        b=RpDIX/K5q/Bl7BEGyBwELYytBgXuUGBOrA4Awf+Oe6r3Yc3oR4VHx26WYehcpeQpDZ
         t+2QevKmkXHCb/uqf1iXzZLxFWr6k1AirceB4FEsvpmsWbaeDtpbqiyk52R35dKLz2zR
         qz7UTMmRoCEv57SlBTAc+/5rUGiQGIhrDlBOA1Z+q9QEBoPpPrVAs3Fn04dabwCTLxTC
         FuNa9brZRbapRlPxWaLrSvwkns9nekcOIKR2ilIAGIDc6ElHZgTgGE2dG4F8KJV/MfEb
         AWv6mGn2+TBFRMzLQZls2LXxkOeRk3IpFj8bbpPWrc6VSuo/fYapaOOxs6Y8nBIpEqE6
         2P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZbiLt6v06YsvfiDARoxK3cxvf7NmvFXziCgf+/LbTk=;
        b=o80LUVGTvgnV5/3QbHwLLb04iq7HAwuMZalOC7nb7sN9CFpU8FioUDzBwDab5wI096
         1sUcSqq1QQxr8zKHmLa49tKc2Uoi6ZmAteJ+Wm1QfOWxse973hcRUfpUkpGSdkqEPvav
         wka1j/dknVac6oqqKW7K1gpABGR1C6CPk+MOMR7Wtd8Wwvi2WPhgZ2Y0e95v4rV1YCST
         eRRP/n3WAygW1cg9veILpLhBMwiS4sIRgoWq+oyHUoV/OP20crlETLs+AfvedoL/yAcm
         eav7HXW5Q1LVt1YvQPLESZa6T59YsjGc0HCiwxweQUoIFFkjk0FXPVvKfQGAGJR/WsIw
         DelA==
X-Gm-Message-State: AJIora+wWq8NhqOGuAhHzQFzFduHL6egh6fMTYab+t1TpmWSZAe8yDk5
        oV27zo7U9hUnGO7jfbD43dqCwE8fRDKdrvXLdWI=
X-Google-Smtp-Source: AGRyM1ulCzLFsef2K56zhTx/LQiZQ8imQKpRFEj5eB0Ji8EAHbSqFNJJK5gwMJ/Z6zyXqEt1tbNoG2FEKWeeRNKDc4E=
X-Received: by 2002:a05:6402:d53:b0:43b:a0cf:d970 with SMTP id
 ec19-20020a0564020d5300b0043ba0cfd970mr16197233edb.277.1658816053464; Mon, 25
 Jul 2022 23:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com> <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
 <Yt7CJj8r3eo05pKd@yury-laptop> <CAHp75VcGPQkY9ApsX2fi6sK5=3U=0vKbrHZZ3x___wUtgrFRSA@mail.gmail.com>
 <Yt8oK1gUojEbO0WI@yury-laptop>
In-Reply-To: <Yt8oK1gUojEbO0WI@yury-laptop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 08:13:37 +0200
Message-ID: <CAHp75VdJ=FVy6TXTEOci0b2kMrG3z8scDwWTjx8M6+8Y35iSXA@mail.gmail.com>
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

On Tue, Jul 26, 2022 at 1:35 AM Yury Norov <yury.norov@gmail.com> wrote:
> On Mon, Jul 25, 2022 at 11:39:39PM +0200, Andy Shevchenko wrote:
> > On Mon, Jul 25, 2022 at 6:19 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > On Mon, Jul 25, 2022 at 09:28:12AM +0200, Andy Shevchenko wrote:
> > > > On Sun, Jul 24, 2022 at 12:19 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> > > > >  EXPORT_SYMBOL_GPL(pm_power_off);
> > > >
> > > > ^^^ (Note this and read below)
> > > >
> > > > ...
> > > >
> > > > > +EXPORT_SYMBOL(arch_get_random_seed_long);
> > > >
> > > > It can't be like this. Brief browsing of the callees shows that.
> > >
> > > Is my understanding correct that you're suggesting to make it GPL?
> > >
> > > ppc_md is exported with EXPORT_SYMBOL(), and the function is in header,
> > > so it's available for non-GPL code now. I don't want to change it.
> >
> > The symbols your function calls are GPL. As far as I understand (not a
> > lawyer!) it logically one may not call GPL and pretend to be non-GPL.
>
> Can you explain what you mean in details?
>
> The function is:
>         static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>         {
>                if (ppc_md.get_random_seed)
>                        return ppc_md.get_random_seed(v);
>
>                return false;
>         }
>
> ppc_md is non-GPL:
>  77 /* The main machine-dep calls structure
>  78  */
>  79 struct machdep_calls ppc_md;
>  80 EXPORT_SYMBOL(ppc_md);

What a mess...

> And get_random_seed is initialized in in arch/powerpc/platforms/powernv/rng.c
> with different functions that are static and not exported at all.
>
> I don't understand where arch_get_random_seed_long calls GPL...

The ->get_random_seed() (aka "callees" in my previous mail) are all
GPL (maybe I missed one out of five which is non-GPL, but then it's
even more of a mess).

-- 
With Best Regards,
Andy Shevchenko
