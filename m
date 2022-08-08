Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7295A58C994
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiHHNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiHHNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69482BC36
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06A2F61234
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7B0C433C1;
        Mon,  8 Aug 2022 13:37:48 +0000 (UTC)
Date:   Mon, 8 Aug 2022 09:37:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 31/32] tracing: Convert to printbuf
Message-ID: <20220808093750.4dd24af2@gandalf.local.home>
In-Reply-To: <8e1df054-062f-63c9-16b4-38143f3e7983@gmail.com>
References: <20220808024128.3219082-1-willy@infradead.org>
        <20220808024128.3219082-32-willy@infradead.org>
        <20220807225113.6a74b481@gandalf.local.home>
        <8e1df054-062f-63c9-16b4-38143f3e7983@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2022 23:32:01 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> > Please remove the two tracing patches and the deletion of the seq_buf from
> > the series.  
> 
> Well, that's not really an option, as Christoph already (rightly) 
> pointed out.

These are the last patches of the series. There's no dependency on them.
You should be able to simply drop them. If others find that these patches
are worth their while then by all means, let them have them.

> 
> If you've got actual engineering concerns that you'd care to articulate 
> I'd (still) like to try to work with you - otherwise, I don't think this 
> is something I can accommodate you on.

Here's my technical reason. These are non trivial changes that are replacing
code that has been stable for 8 years that the tracing infrastructure
highly depends on. I do not have the time to sit down and review this code
as it is not a priority. My time is extremely limited (as my wife keeps
complaining to me about, as I'm not spending enough time with the family).

This change is likely to cause subtle regressions for no benefit to the
tracing subsystem. Hence, when it comes to risk vs reward, I see none.

I'm not NACKing the series, just the changes to the tracing subsystem.

When this code is mature enough, I may reconsider my stance on this.

-- Steve
