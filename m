Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46E5871D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiHATzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiHATzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31561C1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5502461346
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2BD3C43470;
        Mon,  1 Aug 2022 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659383717;
        bh=l4iYKmv0IAs6dTjfZLrYcuoJhZNn3gDmiE98UoVdYhw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O2jLCSJYNlUVmUiB3T+YYLKek28PSYjJ8G8LZ3dI+o9a7I9Zi0FvioBKwpjn6GDys
         jkJ1nwfaS2MEwaZYv09HgcyH++X4PDsCJJMjQv5fvhn+DlAdC/uQF09ct2eoBoJeX5
         GNYJy1CK6Qg3ONSI1McrgTyFhEY9blw9LmzprFVmnFh+FN8tLMA22vdj6U4wHPrjpU
         RiZh8QY4t8LDlrCzccpi5iEfo55b/1n5rgFBaQxSoeAoXTlFJeVwwSTsj86I1lNFXV
         FOItwh9UZkHIdOnHk2JKWqqbUwmFtK/m0VSAxSc4J4btzeR3Ye/+orUoJYcC4purVe
         sVSnAzfbSpeTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A316CC43142;
        Mon,  1 Aug 2022 19:55:17 +0000 (UTC)
Subject: Re: [GIT PULL] Locking updates for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yufe/3UMD2f4WFZK@gmail.com>
References: <Yufe/3UMD2f4WFZK@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yufe/3UMD2f4WFZK@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-08-01
X-PR-Tracked-Commit-Id: eae6d58d67d9739be5f7ae2dbead1d0ef6528243
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22a39c3d8693001c301d070366435edb04d0778c
Message-Id: <165938371766.14399.17495157865403499582.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 19:55:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 16:11:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22a39c3d8693001c301d070366435edb04d0778c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
