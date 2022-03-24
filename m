Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077614E6AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355620AbiCXXH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353518AbiCXXH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6D5BABBF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44D13616C7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2760C340EC;
        Thu, 24 Mar 2022 23:05:53 +0000 (UTC)
Date:   Thu, 24 Mar 2022 19:05:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] tracing: Updates for 5.18
Message-ID: <20220324190552.37f614c6@gandalf.local.home>
In-Reply-To: <CAHk-=wjNSrf1SWDR+cV6R-pzWOQYPa5RzAwyvgv_ixED5sRD4Q@mail.gmail.com>
References: <20220321105621.3d4a9bc6@gandalf.local.home>
        <CAHk-=wj3_p98e_oohGZzfkDPaJFLKEW8C6mS9dhuKgLN8PNitg@mail.gmail.com>
        <CAHk-=wiNzTuFN0gCitdkPna0h3MM-ScZhgS_O0NKA5=mcuZCVQ@mail.gmail.com>
        <20220323154338.200882ac@gandalf.local.home>
        <CAHk-=wjNSrf1SWDR+cV6R-pzWOQYPa5RzAwyvgv_ixED5sRD4Q@mail.gmail.com>
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

On Wed, 23 Mar 2022 12:49:08 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Mar 23, 2022 at 12:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I'll take a look at yours. I gave that branch to Stephen to help him resolve
> > it, but didn't look at what he had done to see if it was different.  
> 
> I may actually have messed up my comparison with your tree, because I
> was doing some of that while in my "test-merge" branch (which had that
> dirty state due to the merge not working). Maybe I screwed up twice.
> 
> I think the only difference I have against linux-next is because I added the
> 
>   #undef __assign_sockaddr
> ...
>   #undef __assign_rel_sockaddr
> 
> lines to stage6 to match the other pre-existing non-sockaddr cases.

Yeah, that looks correct. Looking at my merge branch, it appears I messed
it up :-p

But what is in your tree looks like what it should be.

I also should rename the files to what they are doing. The "stage1, stage2,
etc" is meaningless :-p

I think I'll go write up a patch to do that.

-- Steve
