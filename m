Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A249CFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbiAZQmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiAZQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:42:51 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F25C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:42:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k17so147068plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=26nuG5LfIcJuY5lnKgqDnkrN+Bi4a/GtEIReoSCalwo=;
        b=e1tCczybPYMnGteIsw/Iy4xrVvd6PUu020NPKs65UhYUYv2ezLk5aZAHpRuE/NWfcw
         oxpeDkpnn1At9Teli22xs0UrmFZ8T8XpkGsJcl79tzLlO1bj+rC1edtF22wugzrR+6Px
         8ePgTBuHRzLtN8pVAX18mlKPTysea3dzwRszk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=26nuG5LfIcJuY5lnKgqDnkrN+Bi4a/GtEIReoSCalwo=;
        b=reCnB414r7adtjdokQk2qRElocSDdGwe+WGoKiHQOwK8Mzdgj2+lkh0oWyKfz/qtcP
         dAzxk+HN3MZI7yl/J9G5i/6Qok+4xWKO8TUGlpOpJ6doaXrpVAXpGPAPsuM6oT+z+/iP
         6XmFK4oGjIYuHKORogWg6v0SD6vNGj38fAeAx0mWSnS0rHT7aDQjw5s+j9Yzhmk36jzj
         fFGki7ymRweI4gTW5t1TXfCtduJwYJX77e0lTQsBp+4gn1920mRsPIjKCvW7er9nAouh
         +h4EgSht1LmQO54UgvkevbITp4tAIW+mtgd1l9rLfhD+YsaSoJJjTK/i2wGYL6hhCDt1
         DNZg==
X-Gm-Message-State: AOAM532z0DQTcGBzXW78a7Rw8+PS2CA8EMsU471UdkiBgaNT30io/sBT
        a7DmQFNia5vrQt1370k6y9fpCg==
X-Google-Smtp-Source: ABdhPJwEaqXhBDYt8L4MmY8L3qeHkQcdYlDpnZAjA7VNfpFNDFLUz10nyaHBSrokzeXgaXk/JncLTA==
X-Received: by 2002:a17:90b:3ec4:: with SMTP id rm4mr9537219pjb.120.1643215370627;
        Wed, 26 Jan 2022 08:42:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l2sm2658185pfc.183.2022.01.26.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:42:50 -0800 (PST)
Date:   Wed, 26 Jan 2022 08:42:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yury Norov <yury.norov@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan
 25, 18:24
Message-ID: <202201260841.6C449DD63@keescook>
References: <20220125073137.1.83124@7e6451f583e7>
 <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
 <CAAH8bW93TUpyn8GaZfB83pu8Kvrsz9PHPCBHcG3+UStU7v=s=A@mail.gmail.com>
 <31219CC3-CEE4-4CFA-A416-B98F2115A527@chromium.org>
 <CAMuHMdUwd=2KGk9JkZPSZsvAWG4wddxZFxd5bFfbrtZi3JynQA@mail.gmail.com>
 <CAK8P3a0bLTWc-UG4eX14CQ=hiXms+wHx2VvaovXA-ZUQYAA1fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0bLTWc-UG4eX14CQ=hiXms+wHx2VvaovXA-ZUQYAA1fA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:25:45PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 26, 2022 at 10:16 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Jan 26, 2022 at 9:54 AM Kees Cook <keescook@chromium.org> wrote:
> > > >>
> > > >> The code that causes this is drivers/net/ipa/ipa_mem.c:ipa_mem_valid():
> > > >>
> > > >>         DECLARE_BITMAP(regions, IPA_MEM_COUNT) = { };
> > > >>         ...
> > > >>         for_each_clear_bit(mem_id, regions, IPA_MEM_COUNT) {
> > > >>                 if (ipa_mem_id_required(ipa, mem_id))
> > > >>                         dev_err(dev, "required memory region %u missing\n",
> > > >>                                 mem_id);
> > > >>         }
> > > >>
> > > >> This only happens with gcc-8, not with gcc-9, so it might be a
> > > >> compiler bug. I don't see anything wrong with c:ipa_mem_valid()
> > > >> nor with m68k's find_first_zero_bit().
> > > >
> > > >I don't see any problems about how this code uses bitmap API.
> > > >The m68k version of find_first_zero_bit() looks correct as well.
> > >
> > > The trouble is with "enum ipa_mem_id mem_id;" which is an int, and the bitmap API requires unsigned long. I tried to fix this[1] at the source, but the maintainers want each[2] call site to fix it instead. :(
> >
> > Sorry, I don't get it. "mem_id" is not used as the bitmap, "regions" is,
> > and the latter has the correct type?

Oops, sorry, this looked so much like the other bitops stuff I thought
that was the problem. You are right -- something else is going on.

> I think you are right here, and even if it was an array of 'unsigned
> int' instead
> of 'unsigned long', this should not change the size of the object on
> a 32-bit architecture.
> 
> I ran the preprocessed code through cvise[1], bisecting for a reduced
> test case that fails on gcc-8 but succeeds on gcc-9. The reduced
> case is still fairly complex, and it appears to only happen in the
> presence of an inline asm. Narrowing down the compiler versions shows
> that anything after gcc-9.2 does not warn, but 9.1 and earlier versions do,
> which is further indication that  it was probably a false-positive that got
> fixed in gcc.

Eek. Can we work around it in this code, or should -Warray-bounds have a
gcc version check?

-- 
Kees Cook
