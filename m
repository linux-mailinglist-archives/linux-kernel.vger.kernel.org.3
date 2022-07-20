Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFFE57AB80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiGTBMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbiGTBM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:12:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C865548
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C389B81DE3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E463DC341CA;
        Wed, 20 Jul 2022 01:11:58 +0000 (UTC)
Date:   Tue, 19 Jul 2022 21:11:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <20220719211156.75ea9255@rorschach.local.home>
In-Reply-To: <a674920f-68b0-0b72-5375-da7c062543cc@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
        <20220719191522.4002a5fb@gandalf.local.home>
        <7462e934-f746-eef7-ff92-0eeb8cc08b82@gmail.com>
        <20220719200507.361b06ee@rorschach.local.home>
        <a674920f-68b0-0b72-5375-da7c062543cc@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 20:17:45 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> > More specific please.  
> 
> Steve, look at the man page for snprintf if you don't see what I mean. 
> This discussion has become entirely too tedious, and your _only_ 
> contribution to the discussion on pretty-printers has been "why isn't 
> this using this thing I made?".

No, my response is, why should we replace something that is working
just fine?

The burden is on you. For this to get accepted you have to show why a
risk of regression in the Linux kernel is worth the update. We don't
just say "hey this is better, take it!". That's not how this works.
There needs to be real needs to be met.

> 
> You haven't been contributing to the discussion, you haven't been 
> helping figure out what the APIs, helpers, data structures should look 
> like, IOW _actually_ building something that could serve as a low level 
> string formatting library.

What exactly is it that is better. In stead of yelling about what I
haven't done, tell me what you plan on doing that will make *our* lives
better. Code is "pulled" not "pushed". If all you can do is push, then
you are going to end up being quite disappointed.

What exactly is the use case here?

> 
> I get that you're busy - but look, we all are, and this patch series has 
> already been set back what, a month and a half while I was waiting on you.

Sorry, but I did warn you. I did start a new job and then I had several
conferences that I was writing code to present. That is, the things I
was talking about wasn't even finished yet. So those were very *hard*
deadlines (on top of my day job). I told you upfront that it may be
months before I can look at it. I was fully transparent.

> 
> I've got the tests now, I'll CC you when v5 is posted.

And I expect you to have an explanation on why this is worth the effort.

-- Steve
