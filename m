Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C7C4D3D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiCIWlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiCIWlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:41:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0A120E8A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EC3DB82447
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20A4CC34102;
        Wed,  9 Mar 2022 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646865612;
        bh=oqPdEghfFwFDJ/3+gdm5lX6gFZ4BM9plbGSv4FkAVi4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o/6D5dhTtyKnQTZmCqwk4JtMQ09nMRC24sy4gOQJbQQy24kqWZmaiQqacgiYHf24A
         mKOH88XtElqapDqIPkxE7aZx1cj43CuTi/T49pTK27x5AKXyy0rIyxIJZZRxcaDnkF
         woBW6PAGp8GRvGTViquFYEHVotBjZJT2G07QXVpWMWZWE+xGxP7bMbharMJ5cgUauN
         UAO4NHlYpUqjTn4upcPD3N2JOBeTknWXKHpAgksmFUvtjwSbTm06tMhmOh8NQbp4eE
         Hd+stLHg3F3wjifqe8mz7If10twiqq/D6pdsRXgcn2iFgDtHIHeCVjmYC/skbNeVoj
         tsKh66EV94zPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE0F3E73C2D;
        Wed,  9 Mar 2022 22:40:11 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 post-Spectre BHB fix for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YikqRdJFLdl8b6HG@arm.com>
References: <YikqRdJFLdl8b6HG@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YikqRdJFLdl8b6HG@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 52c9f93a9c482251cb0d224faa602ba26d462be8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b
Message-Id: <164686561192.6479.5370604218071765332.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Mar 2022 22:40:11 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Mar 2022 22:29:25 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
