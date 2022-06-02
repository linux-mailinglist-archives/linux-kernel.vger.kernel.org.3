Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49E53BC17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiFBQHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiFBQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DDD186281
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A6CEB81FE4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 16:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D51DC3411A;
        Thu,  2 Jun 2022 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654186061;
        bh=De10uTw8QFr//Bab429n4zpC03RE2MEIiqIQ3yw9zYw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d0z1LWfWza7DTi7tV5M2kynXgTpxTQF6wP3NQ/CKjo9o+O5Gn3vmDQm20sCjvUOBR
         879N03NN0JymQ7K/J81cWWPeENpjEx2chO0rFhlwX7R/Jhak+UEC2570K/4aDA/rtl
         35OuKalfGcxAWbsOxKE8L2ezvPYkuJ+GNZ8Ek03zLcAwS6Ohn4pAc4I+gt+JFNb3A6
         khJ+ApSDVnHjugEHI61OYgKYZ1d3el0e1K7a1VyVSfs9cQaBLkiuP0ep31ECTOP0LM
         OgSfq1H9L8XBQ8R3qBL9PF3KVUOrKjb2O01bBLP6YueStJZ/hnw+0TaDyuKFw3N7ND
         zq9bnWR8TwAVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37BFAF0394F;
        Thu,  2 Jun 2022 16:07:41 +0000 (UTC)
Subject: Re: [GIT PULL] printk fixup for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpiUGCdJA2UyRWYE@alley>
References: <YpiUGCdJA2UyRWYE@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpiUGCdJA2UyRWYE@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-fixup
X-PR-Tracked-Commit-Id: 809631e2bff5aba056df75cc4e43127dbd0278c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12831f6486f9db5a8f2c87129f2b8f33349b1e04
Message-Id: <165418606122.19639.12382293975586321424.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jun 2022 16:07:41 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
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

The pull request you sent on Thu, 2 Jun 2022 12:42:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12831f6486f9db5a8f2c87129f2b8f33349b1e04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
