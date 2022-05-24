Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A35331FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiEXTxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbiEXTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5480F79391
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E599E616F3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58985C34100;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653422006;
        bh=Zv0X2xL4Ek62RYEFCF0TfB7RwB2WFZgRg+8fTL0PvZU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t6lBhoRVEF2cZCSPSjMZRNQUcTxcGTY4S9gZ0sK0xRamRt0oSs550U/xUuc+AVYFN
         /y+maBclQx7smoCnbk0tpjfBcfXSAA+gVBTA7KfhRVwN/m1MrEpfwkkK+OV6MhJ4J9
         FHTeR2hvM8En6UMC9+lu0X/wBPBl3oHw/a/9JURYtHE6qps4o93w9ybTjhQqoCiIdo
         GVsNDRo/k0WNBf1lSvWUhb+u9vv2sxvFGfKtZdiZT+54ahDHZxfuW5MZ7aKcupjnk+
         lJnqradbqHBsiPUYNLEg37bOdnnHqBzwXFrb9JQyl+DwCmig7owruiWCe6fVvhNpvs
         oXM9eA64yzuTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 446B8F03938;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YouzmQ23tV62Ni+F@gmail.com>
References: <YouzmQ23tV62Ni+F@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YouzmQ23tV62Ni+F@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-05-23
X-PR-Tracked-Commit-Id: 8491d1bdf5de152f27fc941e2dcdc4e66c950542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2319be135672f6e45aa937bceaae6c2668c7867c
Message-Id: <165342200627.18932.12394472963878639897.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 18:17:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2319be135672f6e45aa937bceaae6c2668c7867c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
