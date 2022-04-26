Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3C50EF89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbiDZEKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiDZEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:09:59 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7BB167C1;
        Mon, 25 Apr 2022 21:06:51 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 23Q46Rwf023756;
        Tue, 26 Apr 2022 13:06:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 23Q46Rwf023756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650945988;
        bh=qrC2TpoXIDlISRP2dGG4wJWdMAz97YSJGHJvZ6HNt9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Opfe1I/bMtYc/WViUbkQdbx9GVBCBasltY/tw5U7VxW6ImO0/H4/hCwe1BtuCQp4w
         2Fbway0sj7oWD3SjXpDSFjzgk6bp7oAIDN8QxcZuyFd8d1xvZmGfyDJPekwMBV/zmQ
         4gJuvIjgshbmPNgkPWLigTCu53W5ZbAKj52Z2hXxJ1J/YsUGaaknCC29evBWT0/d7B
         4eoAfFJUg5BOdcDz6J+vvka0SmLSy/LlFbmaeKHOSbq043Jh1KOiTG7STSbEYFvynW
         zDNiD1Iw75jICs2KbOOx1JPuVqOMjReoRQaGr0hDl6319oqVxJqNfFI6RoZZtBHc8v
         jgV5fN+RqEBEQ==
X-Nifty-SrcIP: [209.85.214.182]
Received: by mail-pl1-f182.google.com with SMTP id d15so29060356pll.10;
        Mon, 25 Apr 2022 21:06:28 -0700 (PDT)
X-Gm-Message-State: AOAM530gp4Pj+tJsxjDJ3wBchl2Qe6XoNIsyxj/WdkLEeRgo8thMxPOy
        r09a1OjPO8+CD0XP2Y/Hh7F+whnqON+CaWeyhBo=
X-Google-Smtp-Source: ABdhPJwB3we02kFZ9CfPBVaj6tbWqZdcj5GHulST85Pa2lDSH7iho/KxZaUk3SMsns4qIcnmJsbDMdKxR1VrxJXaCh8=
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id
 j5-20020a17090a840500b001bcd521b2c9mr35376310pjn.119.1650945987044; Mon, 25
 Apr 2022 21:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-8-masahiroy@kernel.org> <CAKwvOd=2pYsUZkvK-d97xC749mCs1QUUc68BfZdTR1diz52Hww@mail.gmail.com>
In-Reply-To: <CAKwvOd=2pYsUZkvK-d97xC749mCs1QUUc68BfZdTR1diz52Hww@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Apr 2022 13:05:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATOuNJFNS_EFYXYkp73sJ4gWt0w7eaR9fDL+EhTThkNBA@mail.gmail.com>
Message-ID: <CAK7LNATOuNJFNS_EFYXYkp73sJ4gWt0w7eaR9fDL+EhTThkNBA@mail.gmail.com>
Subject: Re: [PATCH 07/27] modpost: import include/linux/list.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:42 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Import include/linux/list.h to use convenient list macros in modpost.
> >
> > I dropped kernel-space code such as {WRITE,READ}_ONCE etc. and unneeded
> > macros.
> >
> > I also imported container_of() from include/linux/container_of.h and
> > type definitions from include/linux/types.h.
>
> Is there a better way to just use the kernel headers?

Presumably no.
include/linux/list.h includes more.

Adding so many #ifdef __KERNEL__ stubs
would be really ugly.


> I kind of hate
> copy+paste since the in tree duplication will diverge over time.

I only cherry-picked some macros from include/linux/kernel.h

No need to resync.




-- 
Best Regards
Masahiro Yamada
