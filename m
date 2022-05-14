Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA952712B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiENNPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiENNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:15:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6630D3F30E
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xFDqi/OzLt6wpNBbKiyhLI5vmjCGd4oQdhixacvO4YI=; b=WBPnire/Y1DJnC1mwQJW80nNpA
        GfFDCXFAKGCug1gYqOerDeqBtGMHT2x3sIXPe4AvQ+aFgPdkMPlKM6VaEFnm2JGGFpyaT6mIoeLst
        dM+VbbR2viPnRvdrn+xHjNUoKY8WPh+bQzAjUnimbc+b5rNDF1p/nKLJnipUtfJ2TcBjsp7GUp09W
        VIhZJJbpVJQV/rlbmauZGG1j7VSw5F4H4hYFO0fbWXrdhgJr9RG4Kdp4kJFIWwmpHcM3ILH/Bdsj5
        98KIla1SlXQKycg20ok8KfQR8sjE0ISDfGO7KxXrWW1d1enWYOLOtbjkpFZ5+fPbgpqNFDqulHExs
        SoWAyUFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nprbf-000MZM-2x; Sat, 14 May 2022 13:14:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DFA9D980BFF; Sat, 14 May 2022 15:14:48 +0200 (CEST)
Date:   Sat, 14 May 2022 15:14:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v2 2/2] kbuild: call check-atomics.sh only if
 prerequisites change
Message-ID: <20220514131448.GL76023@worktop.programming.kicks-ass.net>
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
 <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 04:01:18AM +0900, Masahiro Yamada wrote:
> I wrote a different patch.
> https://lore.kernel.org/lkml/20220513185340.239753-1-masahiroy@kernel.org/T/#u

I'm not seeing that in my inbox :-(

AFAICT this way 'make tags' will not find and index the files, which is
a total no-go.

NAK
