Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0848B4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350139AbiAKSEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:04:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60144 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbiAKSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:03:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A9FCB81CBA;
        Tue, 11 Jan 2022 18:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E87A6C36AF3;
        Tue, 11 Jan 2022 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641924216;
        bh=a8ZdgOoVnAJg43Pu0YCO9W9SuHlRvCPzUvPjWPpw6HY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PYw4DXWE5KPyQGiJBK6auAVB6o0B+YRfxCVIt1SLuIKgR6yof//BmnnfETxHIUfU0
         UzQKcomjwGbpICgT2LSkD3yfnSHDjVGgXX/Wck5YoZdq2sdDwtfwKdOG4Z2x3beoy3
         k0V1dECDzOJHRKr9KA2NC6PbYgJUY1Tr4qTzBuvqy4mPyMbPvIvNdEb0eAjcmUBKJG
         1lCbpyZqVUME4pqHrVuzaCLW6nguhsKGtdItFOPR87IzYQRbUEYr0C0Pg256NG7B7o
         ch2xSurzumuCY0Aj21SUP9ptxRPAyJoeSQPx7Kmm+iU4MBG0ovq+8/XWiJc1do5QwP
         uupoKO8edo62w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4FAEF6078A;
        Tue, 11 Jan 2022 18:03:36 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110183529.GA1012375@paulmck-ThinkPad-P17-Gen-1>
References: <20220110183529.GA1012375@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110183529.GA1012375@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.01.09a
X-PR-Tracked-Commit-Id: f80fe66c38d561a006fb4f514b0ee5d11cbe2673
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7d38f16c20bf2a9b2502bb1d7407360d09a836a
Message-Id: <164192421686.4972.12741871143081982972.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 18:03:36 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:35:29 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.01.09a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7d38f16c20bf2a9b2502bb1d7407360d09a836a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
