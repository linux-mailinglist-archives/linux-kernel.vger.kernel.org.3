Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C2577093
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiGPSGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGPSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:06:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFDA18B05
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F308B80B98
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 18:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15169C34114;
        Sat, 16 Jul 2022 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657994775;
        bh=OG13SM2olcWyuxnxdoFKu9rmal0vBENVDxE4dey4Y2s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=arQuJorHUo0kJ0uLHoqUat6vv6mP4E/yXow3xyOGKuFEn/l9mZc9xZmCQzvL9zUzE
         tq3kuHrkSjGTdc0CcNoh6fqKXO3VLrVJav7Fc0LqgNw53+LbhI/bO3dKbTrmrqClRy
         BGAKWJE5xtc6fWWvrtL4fB6E/pDmPbeqy15mbKDtumYuD1gIBntqr7ICxTzU8OFUOq
         14Q0kOpBn4I7eNWvynjrioxcVX4mycOPF64sk+jsUjRwVggjpYnZaHByNjiOM/AdBL
         Wm2xOzpvyKW2lakXDDgr9PBIFg5SyzEsfWG4XMCbChUKNe6Y4vMTQVsWoRef+xFa7c
         drnhgGy2FiGcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F38DFE45224;
        Sat, 16 Jul 2022 18:06:14 +0000 (UTC)
Subject: Re: [GIT PULL] printk fixup for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YtGzI9tWpB2wpioB@alley>
References: <YtGzI9tWpB2wpioB@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YtGzI9tWpB2wpioB@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc7
X-PR-Tracked-Commit-Id: 1ac8ec2731a5ae0f283d103873be7b945ba97e90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be9b7b6acfeae47778f829d9d176ab1f9269593e
Message-Id: <165799477499.6229.3810708695795755123.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 18:06:14 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 20:34:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be9b7b6acfeae47778f829d9d176ab1f9269593e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
