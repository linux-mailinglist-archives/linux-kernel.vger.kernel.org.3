Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300F448E2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbiANDZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiANDZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:25:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B352C061574;
        Thu, 13 Jan 2022 19:25:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DE5BB823A8;
        Fri, 14 Jan 2022 03:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4207CC36AE9;
        Fri, 14 Jan 2022 03:25:41 +0000 (UTC)
Date:   Thu, 13 Jan 2022 22:25:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220113222539.30202e01@rorschach.local.home>
In-Reply-To: <20220114140258.2fe2f076@canb.auug.org.au>
References: <20220112113103.7e03448f@canb.auug.org.au>
        <20220114120240.4b592480@canb.auug.org.au>
        <20220113211633.4f9bea57@gandalf.local.home>
        <20220114135808.391398d0@canb.auug.org.au>
        <20220114140258.2fe2f076@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 14:02:58 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Steve,
> 
> On Fri, 14 Jan 2022 13:58:08 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Thu, 13 Jan 2022 21:16:33 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:  
> > >
> > > What compiler are you using, because I built my branch against all archs
> > > and it didn't have an issue.    
> > 
> > gcc (Debian 10.3.0-11) 10.3.0
> > GNU ld (GNU Binutils for Debian) 2.37
> > 
> > I am doing a native build on ppc64le.
> >   
> > > I can try to see if it is with linux-next and something my tree has with
> > > other updates.    
> > 
> > Thanks.  There are some changes in the kbuild tree that may interact, I
> > guess.  
> 
> It also presumably could depend on the actual kernel config being tested.
> 

I can't reproduce it, and doing searches on this error, seems that it
happens "randomly". I haven't found what can cause it yet.

I don't have a way to build nativly, but if you send me your config, I
can still try to cross compile it to see if it triggers.

Does it fail on anything else?

-- Steve
