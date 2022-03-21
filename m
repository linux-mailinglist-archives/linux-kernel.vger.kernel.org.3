Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CB4E3402
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiCUXAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiCUW56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C89D470749;
        Mon, 21 Mar 2022 15:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA1161573;
        Mon, 21 Mar 2022 21:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92976C340E8;
        Mon, 21 Mar 2022 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899630;
        bh=PJgFj2AnIYoRZL7nytM52mSUta6KpYwtN2tygW1V4Ik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gj0PXMlTafcpmcRkjJ5fN6CxDSHWthcUQ/X+n/rTbHSM/c9ORVBpKjkYLxzVyhpmV
         xaB2CpPY3PIXptblziAZPT0D5c8ogPnDEFFerKue9UGJPtUhfWr/VO/mF4iLZwYVYT
         Vu6spVO4vX0SXmf8m1Okz06Z7wZ36Xc3j58OKxJs5nKrrFeACgywShxbyT+KEgA3qa
         NH3ed5x1C8m7w+CLkq4MEWAzwbzKOwKzkeNctbB+WzgqzByU6dMnDoqhqP0m8tjb1f
         qvaccW2GpcBO9RyFN7Uayne0ngGCwCWN8EZ+4kSG0pMB5jOU8jmCI0Eo8EreBVIujT
         4CRkuVMbhC6/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80AC6E7BB0B;
        Mon, 21 Mar 2022 21:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220314032823.GA2593360@paulmck-ThinkPad-P17-Gen-1>
References: <20220314032823.GA2593360@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220314032823.GA2593360@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.03.13a
X-PR-Tracked-Commit-Id: d5578190bed3d110203e3b6b29c5a7a39d51c6c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35dc0352bb6cf611f01dba41b722fd2b9a819204
Message-Id: <164789963052.9856.9805368036108669149.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 21:53:50 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Mar 2022 20:28:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.03.13a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35dc0352bb6cf611f01dba41b722fd2b9a819204

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
