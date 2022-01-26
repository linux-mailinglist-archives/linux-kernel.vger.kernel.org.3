Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D677049C277
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiAZEGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:06:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55418 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiAZEGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:06:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34820617AA;
        Wed, 26 Jan 2022 04:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB322C340E3;
        Wed, 26 Jan 2022 04:06:46 +0000 (UTC)
Date:   Tue, 25 Jan 2022 23:06:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125230645.097dad3a@gandalf.local.home>
In-Reply-To: <20220126125252.2ef18d786cfaf4a135a2d10f@kernel.org>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
        <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
        <202201251256.CCCBE9851E@keescook>
        <20220125162326.3d1ca960@gandalf.local.home>
        <20220125162859.2b3cc8a0@gandalf.local.home>
        <202201251402.0FB08DB@keescook>
        <20220125172114.6807ed8f@gandalf.local.home>
        <20220126093538.893fb44a7cb0a7cd840c7fdb@kernel.org>
        <20220125201634.698cc777@gandalf.local.home>
        <20220126125252.2ef18d786cfaf4a135a2d10f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 12:52:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > On Wed, 26 Jan 2022 09:35:38 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > I think Kees' idea seems better. If you and Beau are good, I will update
> > > the macros for __rel_loc. (This requires to change some user-space
> > > application which Beau is making too.)  
> > 
> > If Beau is OK with it, I'm OK with it too. I need to release a new version
> > of libtraceevent anyway, and I can make the update for that too.
> > 
> > Who's adding the patch (if Beau says it's OK), you or Kees?  
> 
> This will update the __rel_loc spec, so I'll do it :)

As I replied to the other email, I don't think we want to do this.

As "rel" means relative, I think it makes more sense to keep it as is, and
not have it just be from the data section. That may be even more confusing.

But I'll wait for Beau to answer.

Note, I added both your and Kees patches to my queue and I'm currently
testing it. You can see what I'm testing here:

  https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/log/?h=ftrace/core

-- Steve
