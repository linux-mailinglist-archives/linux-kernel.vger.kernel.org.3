Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F22849C20D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiAZD0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiAZD0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:26:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591CDC06161C;
        Tue, 25 Jan 2022 19:26:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C4461769;
        Wed, 26 Jan 2022 03:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A7C340E3;
        Wed, 26 Jan 2022 03:26:12 +0000 (UTC)
Date:   Tue, 25 Jan 2022 22:26:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125222545.353fa400@gandalf.local.home>
In-Reply-To: <202201251917.18361B4F6@keescook>
References: <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
        <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
        <202201251256.CCCBE9851E@keescook>
        <20220125162326.3d1ca960@gandalf.local.home>
        <20220125162859.2b3cc8a0@gandalf.local.home>
        <202201251402.0FB08DB@keescook>
        <20220125172114.6807ed8f@gandalf.local.home>
        <20220126093538.893fb44a7cb0a7cd840c7fdb@kernel.org>
        <20220125201634.698cc777@gandalf.local.home>
        <202201251917.18361B4F6@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 19:18:53 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Jan 25, 2022 at 08:16:34PM -0500, Steven Rostedt wrote:
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
> I don't know anything about libtraceevent, so hopefully not me! :) The
> patches Masami and I already sent fix the warning, so I leave it you
> y'all to decide if you want to make the internals a bit simpler.
> 


Thinking about this more. I may just take both your patches, and leave it
as an offset from the location of the descriptor. It's closer to the
meaning of "relative" than doing it as a fixed offset from data.

And then no other patches or user space needs to be changed.

Thanks,

-- Steve
