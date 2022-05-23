Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A648531C77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiEWT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiEWT4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:56:25 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A918413CDA
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:56:21 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24NJu5ra013066;
        Mon, 23 May 2022 21:56:05 +0200
Date:   Mon, 23 May 2022 21:56:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [GIT PULL] nolibc changes for v5.19
Message-ID: <20220523195605.GA13032@1wt.eu>
References: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, May 23, 2022 at 11:42:48AM -0700, Linus Torvalds wrote:
> On Fri, May 20, 2022 at 11:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > This pull request adds a number of library functions and splits this
> > library into multiple files.
> 
> Well, this is annoying.
> 
> You add the rule to test and install this, and "make help" will list
> "nolibc" as a target, but that is not actually true at all.
> 
> So what's the appropriate way to actually test this pull somehow?
> 
> I'm guessing it's along the lines of
> 
>     make ARCH=x86 nolibc_headers
> 
> in the tools directory, but then I got bored and decided I need to
> just continue the merge window.
> 
> I've pulled this, but it all makes me go "Hmm, I'd have liked to maybe
> even build test it".

I did. I must confess I'm embarrassed now because when I added the
entries there, exactly in order to reuse what was in place, I found
it a bit tricky to launch the tests, but after that I felt OK with
it. Now it's been a quite some time now and I don't remember the exact
way to trigger the tests there, so it's likely that I didn't leave
enough info in the commit messages :-( Let me have a look and figure
again how to start the tests.

Sorry about that,
Willy
