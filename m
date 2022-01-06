Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF3486E12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbiAFXw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbiAFXwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:52:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584CAC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECF6361DA3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 23:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 632B4C36AE0;
        Thu,  6 Jan 2022 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641513174;
        bh=1P9rbQ7ckjdDra6B6VUQvGOc6Qllb1PtOtTkRYELTCk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aZlrcdHkrNCAqg1fBeI3Q1Bdi1vXJDvOxo0tJ4mTpqMRn8AQrDUya8Nzi9wEdlI/y
         TM3Pp5nje+g5n+IsnBmig1T0SMTH99679Dv7wvc0YXEPFomnPPqhxSaDucrQv7j4fB
         9YXxbFhV+e5Cxrls1RtqyHojRREPHJNP7S7BIGzqn8IzFYcRTz4F8ourKlWMF4r6Ze
         i26tOwnXTJxtduVYAKPVpkDCGwtlPDazIG6bwT0D2tBCqzeHp1pyBFv5dE41UzzIZw
         CTiNPF1vBnDIv1P34cjnZ9upFPJSmVAX7xTwg/f02eMfs1B8LeqX5iYgqyZjIyXspr
         hYiM5d+maarZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52263F79403;
        Thu,  6 Jan 2022 23:52:54 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Minor fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220106155842.57b7b4f3@gandalf.local.home>
References: <20220106155842.57b7b4f3@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220106155842.57b7b4f3@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc8
X-PR-Tracked-Commit-Id: f28439db470cca8b6b082239314e9fd10bd39034
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2b436ec0205abde78ef8fd438758125ffbb0fec
Message-Id: <164151317432.22138.1760896661865573376.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jan 2022 23:52:54 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jan 2022 15:58:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2b436ec0205abde78ef8fd438758125ffbb0fec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
