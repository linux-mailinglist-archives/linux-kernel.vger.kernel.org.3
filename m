Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3148B4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbiAKSEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiAKSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:03:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7B0C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:03:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1553B81C04
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 593B7C36AE3;
        Tue, 11 Jan 2022 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641924216;
        bh=u7ZHUdJCKySxUyXzQ75radbM/RCwTsoT81xt1C6H/4U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sduwYHj4t+mEugkjcm2GSsLiPHgn5slx8wGXUe9wmEb3GenMvnXZIleJviJbcWwiT
         qBAs/Pjs6hRDPM0/quIAuFKc0F1Bwh53Xz/AGkQqNp656uGYYFI8PX05XkfUZCU29/
         8eoGDrEEhf3icKU45fC6KCvjoS26PdiE2Ffrwl05V4gB/2/YzxsMTZKdVwskrJGoB5
         1KPtfFVZ2+fYAl0MZXC4MOz1rDU7aFoWILRw0r23VMRCkq0mU5YQbjnvZ9OvHt4EbP
         k65EpvlQuYSq35uiN/7z9PL2GUwH3rC0vko3rCxEaN4LSfc++vsEHlx2io4r0cS/TZ
         dkyeM2IFrmHwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43CBAF6078A;
        Tue, 11 Jan 2022 18:03:36 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdxDzgijikydIwOP@alley>
References: <YdxDzgijikydIwOP@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdxDzgijikydIwOP@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.17
X-PR-Tracked-Commit-Id: d12013c80e1524e3e85c01d50adcefd70b1a8b6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a229327733b86aa585effdb0d27a87b12aa51597
Message-Id: <164192421627.4972.5614920480911998547.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 18:03:36 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 15:33:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a229327733b86aa585effdb0d27a87b12aa51597

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
