Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89514E31DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353369AbiCUUe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbiCUUe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:34:56 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4156B3A5E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:33:29 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LKXJxR008071;
        Mon, 21 Mar 2022 21:33:19 +0100
Date:   Mon, 21 Mar 2022 21:33:19 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 0/8] nolibc: small updates required for the self-tests
Message-ID: <20220321203319.GA8066@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
 <20220321202908.GI4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321202908.GI4285@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 01:29:08PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 21, 2022 at 06:33:06PM +0100, Willy Tarreau wrote:
> > Hello Paul,
> > 
> > while developing the nolibc self-tests, I naturally faced a few
> > limitations ranging from missing POLL* flags to missing strcmp() or
> > getenv(), as well as the ability for printf() to print "(null)" on
> > "%s" instead of crashing.
> > 
> > This series adds a makefile and a headers installation target that
> > creates a sysroot made of kernel headers and nolibc headers, which
> > significantly ease building programs.
> > 
> > I already have some test code with roughly 75 tests, but I find it
> > misplaced in the nolibc dir, I need to move it to testing/selftests/
> > before sending it to you.
> > 
> > This series is intended to be an add-on to what you already have in your
> > dev branch. I don't intend to send you much more stuff on top of this,
> > but I expect to see an update from Ammar's patch set (CCed). With all
> > this I think we'll have a good basis to easily add new tests.
> 
> I have pulled this series in for review and testing, thank you!
> 
> It won't go into -next until v5.18-rc1 comes out, in about two weeks,
> but it will at least be in -rcu.

Perfect, thank you!

> I removed an ostensibly extraneous blank line from the end of
> tools/include/nolibc/Makefile.  So please let me know if that blank line
> is actually necessary.

Oh I'm very sorry, that the type of thing I'm very careful about so it
has definitely escaped my checks.

Thanks,
Willy
