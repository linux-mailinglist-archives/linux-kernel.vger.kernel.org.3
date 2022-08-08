Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB058CB40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbiHHPZo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Aug 2022 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbiHHPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9966013F24
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:25:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3692560FF1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05558C433D6;
        Mon,  8 Aug 2022 15:25:33 +0000 (UTC)
Date:   Mon, 8 Aug 2022 11:25:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 31/32] tracing: Convert to printbuf
Message-ID: <20220808112535.0c74afc4@gandalf.local.home>
In-Reply-To: <55e6e42f-b3ea-d9d0-4611-f13b3b88acab@gmail.com>
References: <20220808024128.3219082-1-willy@infradead.org>
        <20220808024128.3219082-32-willy@infradead.org>
        <20220807225113.6a74b481@gandalf.local.home>
        <8e1df054-062f-63c9-16b4-38143f3e7983@gmail.com>
        <20220808093750.4dd24af2@gandalf.local.home>
        <55e6e42f-b3ea-d9d0-4611-f13b3b88acab@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2022 11:15:31 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> > This change is likely to cause subtle regressions for no benefit to the
> > tracing subsystem. Hence, when it comes to risk vs reward, I see none.  
> 
> It sounds like you're saying you don't have time to maintain your 
> subsystem..? Is there anyone else actively co-maintaining tracing? Part 
> of our jobs is bringing new people in and training them (and not 
> providing a hostile work environment so they'll want to), maybe 
> something to think about.

No, it sounds like there's nothing here I need. Why do I need to review any
code that is not going to improve my subsystem?

> 
> I'm also not seeing the likelihood of subtle regressions - this isn't my 
> first kernel refactoring and not _nearly_ the biggest or the most 
> invasive. There's definitely some stuff in the tracing code code that is 
> a bit on the unorthodox side, but nothing too crazy. The code's been in 
> my tree for ages where I use tracing on a daily basis, and it passes 
> your test suite (and there was just one bug that made it through to be 
> caught by the tests, as I mentioned in the cover letter).
> 
> Anyways, if you've got specific, actionable concerns, I'll be happy to 
> take a look. Otherwise... ¯\_(ツ)_/¯

Like I said. I don't see the improvement. I hate changes for changes sake
alone. If there was a real improvement to the system, then I would make the
time to look at it. But currently, the only thing I get is that you want
this code in. And that's not a high enough bar.

As I stated before, and have given talks about. Changes are pulled into
Linux, they are never pushed.

-- Steve
