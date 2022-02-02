Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DEE4A69FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiBBCk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiBBCk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:40:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BF3C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 18:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zaI5vhQWWVE2GE+rss71ZZD7ibixm3ekss/HSDR7sR8=; b=WYxYr2TQKRqgj1IPtTb04wfK52
        1vd3IYqwNo6cSmFTeOG2HGbDDqrDfN2ligjDUNqsjoBDUkUqcHy62187dp0X61WQZ6ZB4JR8YIaq3
        FJpCfmS4soxRHO6xs0ZLwH+M7+6J9Kw3jVqwWk7KTy8rrJMv8DpQm8NQl0a5P77fm6pYNOdGZBbRe
        kVBR5K1a/FOq7cwug8oxRD5TnL5gFYKCKEB7rakCht+uRmu3y8CRQPF+ZLUUfGeRkSP9Ye+6SL21f
        rFcSkMlg0wHOJ78/ayhCdg6yi3HRn0OPUE1CqK5c3kRMMNdTR8y9LfaxNNsA1WZXBt7ylMmI9/xOx
        TRDpSDsw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nF5YJ-00DzlC-9e; Wed, 02 Feb 2022 02:39:23 +0000
Date:   Tue, 1 Feb 2022 18:39:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jan Kara <jack@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Antti Palosaari <crope@iki.fi>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>,
        Lukas Middendorf <kernel@tuxforce.de>,
        Mark Fasheh <mark@fasheh.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Qing Wang <wangqing@vivo.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Kitt <steve@sk2.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jani Nikula <jani.nikula@intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [ocfs2] c42ff46f97: sysctl_table_check_failed
Message-ID: <Yfnu216aFQibbZ25@bombadil.infradead.org>
References: <20220128065310.GF8421@xsang-OptiPlex-9020>
 <CAHk-=wgT6wuBB=pK2bGNQbioNCdJHT8Jnvs+4oT25jX1JFyhgg@mail.gmail.com>
 <20220128120421.kzo5iduigr7k55bs@quack3.lan>
 <87a6ffst4j.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wjzWVW1xvVLCOvw-MMoVK9kiRn5CUx2am8jPdo09mHgjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjzWVW1xvVLCOvw-MMoVK9kiRn5CUx2am8jPdo09mHgjA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 07:16:21PM +0200, Linus Torvalds wrote:
> On Fri, Jan 28, 2022 at 6:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Yes.  There is a register_sysctl_paths that can be used if you want/need
> > the embedded directories.  That probably would have been a better
> > choice for an automated conversion.
> >
> > But since this there is only the single file in a single directory
> > register_sysctl() with the full path is perfectly fine in this case.
> >
> > Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> I was doing filesystem pull requests anyway, and as a result (I tend
> to group things by topic if there's multiple things pending) I already
> committed that patch of mine based on Jan's reviewed/tested-by, so
> this reviewed-by ended up not in the tree.
> 
> But maybe somebody should check the other automated conversions for
> the same issue? Hint hint.

I just double checked and indeed, the issue was that ocfs had a path
underneath it, so indeed register_sysctl_paths() would have been better.
The other drivers which were converted do not have paths underneath so
they are safe.

> Also, I'm somewhat unhappy about the fact that apparently the kernel
> test robot already found this issue back in November of last year, yet
> it made it to mainline several months later without being fixed.
> 
> It's hard to tell from this link:
> 
>   https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/KQ2F6TPJWMDVEXJM4WTUC4DU3EH3YJVT/
> 
> but it does look like that original report only made it to that lkp
> list and not the actual people listed on the commit itself? That would
> explain why the report was overlooked.

Odd, no I got Cc'd on the email as I get 0day testing on all my branches
prior to pushing patches out. For some reason this failure fell through
the cracks. Sorry about that!

  Luis
