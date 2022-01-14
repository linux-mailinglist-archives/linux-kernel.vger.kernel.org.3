Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126EB48E275
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbiANCQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:16:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41140 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiANCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:16:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6413B821C9;
        Fri, 14 Jan 2022 02:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347F9C36AE3;
        Fri, 14 Jan 2022 02:16:35 +0000 (UTC)
Date:   Thu, 13 Jan 2022 21:16:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220113211633.4f9bea57@gandalf.local.home>
In-Reply-To: <20220114120240.4b592480@canb.auug.org.au>
References: <20220112113103.7e03448f@canb.auug.org.au>
        <20220114120240.4b592480@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 12:02:40 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Wed, 12 Jan 2022 11:31:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the ftrace tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> > 
> > Inconsistent kallsyms data
> > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > 
> > I am not sure what caused this - maybe commit
> > 
> >   4f1f18311591 ("scripts: ftrace - move the sort-processing in ftrace_init")
> > 
> > I have used the ftrace tree from next-20220111 for today.  
> 
> I am still getting this.
> 

What compiler are you using, because I built my branch against all archs
and it didn't have an issue.

I can try to see if it is with linux-next and something my tree has with
other updates.

-- Steve
