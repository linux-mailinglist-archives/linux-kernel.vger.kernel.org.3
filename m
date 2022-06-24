Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4797655A139
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiFXSoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiFXSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:44:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D95D105
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D02C1B82B5E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 18:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90484C36AE2;
        Fri, 24 Jun 2022 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656096256;
        bh=uHMzCZdIOnv6IexIHlkVc1XA4BMiW/dZxwhA3AgDdT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A3aQ0LCdjfdAuwjRZE/g8xrW6/pZpHP/I7uM28sfLzy2gIflAobPxhoPcpRA/YddI
         FlxyopSRv3C7GcQ8Jv/YiQiMVsPQyFd7hD89DQ4fhfejzqZO/PRPs9qy8q9XC7t5SL
         tLSQmVKn2IYgyO6OCPlI9ngjLZoCTKHaaM87N7I/xVEWuxmex8CVegnhizbYNdFjet
         L3o+5dDu3BAkeHxMeQXjSapxStS7GAYnHuL3OKsBz2vKVuGhe2+5bQDc+XPaXzYSjd
         N9uGnccFf05oVwiMNr8QSsyfhOHvdH+CqmlBDH1hruygWQkfIYinPcrLJdrgChW0YK
         aPV7X5dsEsXFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C496E737F0;
        Fri, 24 Jun 2022 18:44:16 +0000 (UTC)
Subject: Re: [GIT PULL] printk fixups for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YrTLziUjfxDP/34M@alley>
References: <YrTLziUjfxDP/34M@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YrTLziUjfxDP/34M@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc4
X-PR-Tracked-Commit-Id: 51889d225ce2ce118d8413eb4282045add81a689
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d882352bac8f2ff3753d691e2dc65fcaf738729
Message-Id: <165609625650.26462.18357099446142848736.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 18:44:16 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jun 2022 22:23:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d882352bac8f2ff3753d691e2dc65fcaf738729

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
