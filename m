Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7D531CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiEWUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiEWUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:50:54 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB7A470930
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:50:53 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24NKohSS027055;
        Mon, 23 May 2022 22:50:43 +0200
Date:   Mon, 23 May 2022 22:50:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [GIT PULL] nolibc changes for v5.19
Message-ID: <20220523205043.GA25949@1wt.eu>
References: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
 <20220523195605.GA13032@1wt.eu>
 <20220523202336.GB13032@1wt.eu>
 <CAHk-=wiX8P8atcx9at_N=-8pjU-d5cG509E=oZHfsVb1R41RZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiX8P8atcx9at_N=-8pjU-d5cG509E=oZHfsVb1R41RZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 01:30:37PM -0700, Linus Torvalds wrote:
> On Mon, May 23, 2022 at 1:23 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > So I've figured it again. When you run:
> >
> >    make tools/help
> >
> > you get the help of tools/ commands, [..]
> 
> You speak the words, but you don't actually look at what it does.
> 
> Try it.

Why are you saying this ? I've figured the commands by trying
each of them.

> Yes,  "make tools/help" works. Yes, it lists targets, and talks about
> how you can use the "<tool>_install" target.
> 
> But none of that then matches the rest of what you write.
> 
> You talk about nolibc_headers". That's not something that is actually
> listed in the help at all.

I agree. I initially added the few of them there and figured I was
polluting the "make tools/help" output with only nolibc-specific stuff.
I had a look at other comamnds that took arguments and found some that
would also take a few arguments that were not mentioned at the top level
so I concluded that it was the "expected" way to use them there.

> So please, can you read your own email message as somebody who doesn't
> actually know the code, and try the commands you talk about, and see
> the disconnect here?

That's exactly what I'm trying to do and I'm sorry if that doesn't work.
The simple fact that it doesn't work tells me I need to revisit the
approach but I need some hints about it.  Please be more specific.  I
tried to get as close as possible to what I found in order to apply the
principle of least surprise.  Do you want me to create a "noblic_install"
target maybe, even if the equivalent one doesn't exist for half of the
other commands ? If that's it, that can be done as well.

Confused,
Willy
