Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC1586F86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiHAR12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiHAR1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ABD13CFD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AEC5B815A0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF231C43141;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374827;
        bh=WHzW0vmhsfb4dddbJZUNzpTLCS/d/IT8jViKg/hTlHM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aYYcEEaa4ksrCOONymTC+T23wgXiwVK8fJlbMjRAGAb3wT6KSXN2ff7iSPW8rAaYr
         inXZakRP7lrE2YJpQljr891hC0mG6EVSFehw+TFh7rKShL6Ls4lkzeo0lNCTUA4cGB
         x9/cNxhR2fcdNE3mNcB5Kb4R9Bx1ECTL2e+UpOjdh58sKh0owefA6dUWAr6PHYMcDw
         wGOPyJwpb5FyUH6MyievwU2t6mllzdcvt8cLUMVW9g/ByzAOMAoIcyGi38TlVEjhi2
         YumMjnEQxzmtQRTkHxd5mTNi4YUUna0KAH9ijKj6ZH28ky8mni/JwKVIaEC7u+bAXb
         7rDjfwaTX3W/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDF60C43142;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuebK2LYy6INgX5E@zn.tnic>
References: <YuebK2LYy6INgX5E@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuebK2LYy6INgX5E@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v6.0_rc1
X-PR-Tracked-Commit-Id: 8f1d56f64f8d6b80dea2d1978d10071132a695c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92598ae22f582547ebb060cf76f5869bc9780b80
Message-Id: <165937482690.24126.17635556927525980780.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:06 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 11:21:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92598ae22f582547ebb060cf76f5869bc9780b80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
