Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87120559A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiFXNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:25:20 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47E8F527EA;
        Fri, 24 Jun 2022 06:25:19 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 614A692009C; Fri, 24 Jun 2022 15:25:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 53F1E92009B;
        Fri, 24 Jun 2022 14:25:17 +0100 (BST)
Date:   Fri, 24 Jun 2022 14:25:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v6 09/17] mips: use fallback for random_get_entropy()
 instead of just c0 random
In-Reply-To: <CAHmME9r-wTkNGVj0sBOM5LVY=jdAw99gne-1g-mwjBnk3q7VqQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2206241407240.22231@angie.orcam.me.uk>
References: <20220423212623.1957011-1-Jason@zx2c4.com> <20220423212623.1957011-10-Jason@zx2c4.com> <alpine.DEB.2.21.2204250113440.9383@angie.orcam.me.uk> <YmicjVbkcppfzE1E@zx2c4.com> <CAHmME9r-wTkNGVj0sBOM5LVY=jdAw99gne-1g-mwjBnk3q7VqQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> > There is lots of optimization potential on a few fronts we've identified
> > in this thread. Let's save these for a follow-up. I'd rather this
> > initial one be at least somewhat simple, so that as it gets optimized,
> > it'll be easy to handle regressions. Also, it probably makes sense for
> > you to send the patches for these, since you have both the hardware
> > chops and the hardware itself to assess these ideas. I am interested in
> > the topic though, so please do CC me.
> 
> Everything has been upstream for a little while now, which means
> development of this can move back to the proper MIPS tree like normal.
> Did you want to submit some optimizations? Would be happy to look at
> whatever you have in mind.

 Thank you for the heads-up!

 Unfortunately I'm a little stuck at the moment, especially as one of my
main MIPS machines (a 5Kc Malta system) died mid-May while operating.  It 
seems to be a faulty CPU core card and the base board may be fine, though 
I cannot know for sure as I only have one each and I don't have a logic 
analyser or at least a JTAG probe to peek at the system and see what's 
going on inside.

 If anyone knows a source of a replacement Malta, preferably with a 5Kc 
CoreLV CPU module or another 64-bit hard core card (a number of different 
ones have been made), then I'll appreciate if you let me know.  I feel 
rather depressed knowing that many if not most hit the scrapper already 
while they could still find a good use.  Somehow it is easier to get way 
more obsolete hardware from 1980/90s just because it was general purpose 
rather than niche.

 Otherwise I'll try to get back to this stuff later in the year with 
whatever I have that still runs, but don't hold your breath.  Sorry!

  Maciej
