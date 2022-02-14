Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A14B57A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356858AbiBNRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:01:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356810AbiBNRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:00:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C94665166
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:00:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B511B6152F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1318C340E9;
        Mon, 14 Feb 2022 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644858049;
        bh=PI1oi4wqJp519f7VqcJNgQaXQZ5sP53GHooYRli1yx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVCFfnn+5uB5WbG+//QIsvejjCnxpXGGNv8XZ9wHR+OtGcFra+91eRvbXQUn8Duu/
         DTSD0fKrJZzx15b8GX88EA/Zytm8y+3AVfIEc0avsjrUPcPbiWGljVf/fNl6gWYoax
         jF8KSThmw4e4VMlPLYU+8UvRPNqdo9+YxtZ6Axm5BpAVE6rDL0BJwipGpe1E9tFbvY
         NoG6CaCkdazCmsc/qJKhZlVXNQoFe7fYoXQlQMj+3HMmGCQ4appzqVid4aP1YeUajW
         1v2B5dB/Wv/h/hF3IGjwtegxqdDRjNDWURcng+ScX7r6yTbg/9Z8GTWbjb8/2AoMZi
         OATPkIstL9Udw==
Date:   Mon, 14 Feb 2022 10:00:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel/trace/ftrace.c:7157:20: error: unused function
 'ftrace_startup_enable'
Message-ID: <YgqKvDM6BEuPQmKb@dev-arch.archlinux-ax161>
References: <202202132037.4aN017dU-lkp@intel.com>
 <20220214102000.1d3af66e@gandalf.local.home>
 <Ygp64CsyyKyRykqE@dev-arch.archlinux-ax161>
 <CAK7LNAQmztEn7nN_R05zhXWc-5S44Y5nGQQjzdByTPxgDH13wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQmztEn7nN_R05zhXWc-5S44Y5nGQQjzdByTPxgDH13wA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:28:53AM +0900, Masahiro Yamada wrote:
> On Tue, Feb 15, 2022 at 12:53 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Steve,
> >
> > On Mon, Feb 14, 2022 at 10:20:00AM -0500, Steven Rostedt wrote:
> > > On Sun, 13 Feb 2022 21:03:29 +0800
> > > kernel test robot <lkp@intel.com> wrote:
> > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > > >> kernel/trace/ftrace.c:7157:20: error: unused function 'ftrace_startup_enable' [-Werror,-Wunused-function]
> > > >    static inline void ftrace_startup_enable(int command) { }
> > > >                       ^
> > > >    1 error generated.
> > >
> > > Strange. I always thought that static inline functions do not cause
> > > warnings when not used? Especially, since they are often in headers when
> > > things are turned off. Or is it because this is in a C file?
> >
> > With -Wunused-function, clang will warn about unused static inline
> > functions within a .c file (but not .h), whereas GCC will not warn for
> > either. The unused attribute was added to the definition of inline to
> > make clang's behavior match GCC's.
> >
> > > Is this a new warning caused by a commit, or is it a new warning because
> > > the compiler now complains about it?
> >
> > However, in commit 6863f5643dd7 ("kbuild: allow Clang to find unused
> > static inline functions for W=1 build"), Masahiro made it so that the
> > unused attribute does not get added at W=1 so that instances of unused
> > static inline functions can be caught and eliminated (or put into use,
> > if the function should have been used), hence this report.
> 
> BTW, my hope was to move this warning to W=0 someday.
> (that is, remove __inline_maybe_unused entirely).
> 
> I do not know how many warnings are still remaining, though.
> Is it now more difficult due to CONFIG_WERROR?

I have not done an audit in quite a while and I do not remember the
results of the last one. I don't think -Werror makes it more difficult,
it is more so just finding the time to sit down and work on it :) I
agree that it would be nice to make this the default behavior for
cleaner code, perhaps we can use this as a "good first issue" for
working with clang.

Cheers,
Nathan
