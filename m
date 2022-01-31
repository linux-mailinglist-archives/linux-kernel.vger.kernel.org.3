Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21C04A4C67
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380591AbiAaQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380586AbiAaQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:47:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0544DC061714;
        Mon, 31 Jan 2022 08:47:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C2E460AF5;
        Mon, 31 Jan 2022 16:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B75C340E8;
        Mon, 31 Jan 2022 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643647667;
        bh=ihC7CKxsu5UE3SaXojecPLPQFwujiHzaZSVm3or2b4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7DzlGSirhJjYDNfrh2yEgqwSBG2W5ZcYdzZ+/JepOKBesYeqXwtbJojEIR04YRrq
         b8D38BY+rDj8n9clnH+zPH4UNHe+lrUHOExgtZTQO9m2faeuLpM89C4l6KTtOVkGE2
         FqPT2WpfuuP9pEnChEsDUrjqMCJ24R9LrZLNy/xf820stV5386LV3kn6m8gB3wuAuX
         eJbqoWpNoJeofTGuFPKtHMYGwKsF3Gp9q4vXtWgWXypDvaLnAlcWpdAV8zzQeEi66+
         CPSj/bVm+gLWOFkizAsAiJkq6PAH27AWK/ZJD9bfjloXw9uc5G074qsyaVXmtWfjJm
         tjAIQbsFrHarQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nEZq0-0008Cx-Cr; Mon, 31 Jan 2022 17:47:33 +0100
Date:   Mon, 31 Jan 2022 17:47:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <YfgSpArfoL9LUaBO@hovoldconsulting.com>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
 <YfPzNNvK8Sy8YmGW@casper.infradead.org>
 <Yff9xoh873aEikY4@hovoldconsulting.com>
 <YfgBi9dn8LI8d/bo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfgBi9dn8LI8d/bo@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:34:35PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 04:18:30PM +0100, Johan Hovold wrote:
> > On Fri, Jan 28, 2022 at 01:44:20PM +0000, Matthew Wilcox wrote:

> > > I think this misunderstands the problem that Andy is trying to fix.
> > > 
> > > The situation: I write a patch.  I post it for review.  A bot does
> > > something and finds a bug (could be compile-error, could be boot
> > > problem).  That bot sends a bug report with a suggestion to add
> > > Reported-by:.  That suggestion is inappropriate because the bug never
> > > made it upstream, so it looks like the bot reported the "problem"
> > > that the patch "fixes".
> > > 
> > > It's not unique to "new feature" patches.  If I'm fixing a bug and
> > > my fix also contains a bug spotted by a bot, adding Reported-by
> > > makes it look like the bot spotted the original bug, rather than
> > > spotting a bug in the fix.
> > > 
> > > The best thing to do in this case is nothing.  Do not credit the bot.
> > > Maybe add a Checked-by:, but that would be a new trailer and I really
> > > don't think we need a new kind of trailer to get wrong.
> > 
> > It seems like the only way to fix this is to fix the bots. Adding more
> > documentation is unlikely to help in this case.
> 
> Links to the documentation at least may clarify the point in case of a
> review.

Sure.

> > Can't we file a bug to whoever is running the bots (Intel?) and ask them
> > to remove the suggestion to add a Reported-by when the bot is testing a
> > patch (as opposed to mainline or even -next)?
> 
> The granularity here is not a repo. It's a code itself and in some cases
> it might be easy to distinguish new feature from the code modifications,
> but when code is already there and feature is just an extension of the
> existing file(s), it's hard to tell. And it might be true or not.

Not sure I understand what you're saying here. Perhaps you and Matthew
are talking about different things after all.

But for Matthew's issue, the case where the bots are testing posted
patches ("Thank you for the patch! Yet something to improve:) should be
easy to fix by simply dropping or rephrasing the "kindly add following
tag as appropriate" suggestion.

When testing merged code, it may be harder to tell whether the branch in
question can be rebased or not (and an incremental fix with a
reported-by tag is warranted).

Johan
