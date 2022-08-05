Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DAC58AF05
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbiHERmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbiHERmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9C6E8BB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CFB861806
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 17:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F4F0C43142;
        Fri,  5 Aug 2022 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659721355;
        bh=/gPgfnZgwkcCQqNDClgGNDe1+fJwyJWEZR5QUqles5Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NRAJSHUoLa7h5Y+oDYbcVR6B0uVzAOxWQdfrUgJkMAxLWGNwT02Od+RXg90Lx7aYe
         DKcOtNlnzPyx+7+fXFxC9aon+c9K4BB4k89SS5Upyr8+9UZGlOikpSLQx2R4pBZQXw
         2vDexn6YlG4upXjWIvdqqchoeTWlValdllFAA5beUNsbpXWY4YAyAu9goZO/cuhXxg
         annIbVW31cVnePQ/sMAqr5h0fMO1XUVWrL9jSjHuVFQDNhaxSacxSPKQ1HYCrufazP
         oze8yEy6NeF+1ny5sBMgsvsxvBWfDZXl6YppX0atEcu2ixSQifi60HNXYczqNkhcH6
         BEH8Xb2nXamwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F2AFC43142;
        Fri,  5 Aug 2022 17:42:35 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.20 (sane changes)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuuoT1n6cosaVoiF@alley>
References: <YuuoT1n6cosaVoiF@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuuoT1n6cosaVoiF@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.20-sane
X-PR-Tracked-Commit-Id: 96dd9a2f958be4781d8d01ed881a46864bf458aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1b02751d6ec21ec1b9c7c6826fc896ffde1c33d
Message-Id: <165972135551.14838.12165895072124799610.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 17:42:35 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
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

The pull request you sent on Thu, 4 Aug 2022 13:06:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.20-sane

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1b02751d6ec21ec1b9c7c6826fc896ffde1c33d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
