Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4704E86ED
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiC0IYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 04:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiC0IYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:24:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050512653
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 01:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tTtb6KbJIIs6dv83/WtfjGJTmfcQGIpuHTcM3lrbU64=; b=ddVnCsvASlPBLWuS3zoi+Nopf0
        yJnZ0ntNuo5RZcPMzLpO97eWbxoTRl5qBnPi5WXZzTrJVaKlnW7KTQgxyepnW6Yq7Vm3Hu2Vmzlu2
        hVVNm8QEQt/z2ZTJ8Jo3fOwI83WAwVUYFtukOgMVmzcGJp2Km06uP60rLDKLMZcWE9uKjcyyvLMrl
        cYVlNXqH7ZqM9BIUIBDlSN6YVAQ2Orrl+hwOTsz2zX+68qduBpeyjfM6EfoXNSv38sbJubQyIm8Ox
        9xd0+1Tzab/h/KXqCNbnycBZjhMqqSm/8PB4zf3o6oHH4WOYdXzRKHg6xhx0Wwl7foJ1RhNZ90y85
        tZt6mx7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYOAF-00Fu6s-EB; Sun, 27 Mar 2022 08:22:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93D40986200; Sun, 27 Mar 2022 10:22:17 +0200 (CEST)
Date:   Sun, 27 Mar 2022 10:22:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [GIT PULL] x86/core for 5.18
Message-ID: <20220327082217.GU8939@worktop.programming.kicks-ass.net>
References: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
 <CAHk-=whhG15HiqR+WM5M2mMy9F17yVdT8_M0ra0tGJS+5ibrdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whhG15HiqR+WM5M2mMy9F17yVdT8_M0ra0tGJS+5ibrdw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 02:53:07PM -0700, Linus Torvalds wrote:
> On Sat, Mar 26, 2022 at 8:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hi Linus, my first pull request in like forever, so please bear with me.
> >
> > Boris talked me through it, so hopefully it isn't entirely insane :-)
> 
> Well, it's not exactly working too well:
> 
>   fatal: couldn't find remote ref x86_core_for_5.18_rc1
> 
> there is actually a branch called "x86/core" there that has the commit
> you mention as the top commit, but I'm _hoping_ you had a signed that
> you created, and just never pushed out.
> 
> So I won't pull that branch I found, in the hope that there's a simple
> "Oh, let me push that tag out" solution that gets me the signature
> too.

Duh! I pushed the tag to the wrong repo (peterz/queue.git)... I just
pushed it out to tip/tip/git as well, so hopefully it should all work
now.

Thanks!


