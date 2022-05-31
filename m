Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6E539533
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbiEaRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbiEaRFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06938DDCC
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C21960B9F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3B52C3411D;
        Tue, 31 May 2022 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654016742;
        bh=geYWQQF2NYACb3iPTD3PzJTMEWfwSAAWrcsQxD9KdH8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lKLxP3glFKdN7vWQ1oIyIDYTTpcIGuVEe810ZWnLUq2GoSUbnqk/l718hHwyR7jZE
         afCjjLhIgMg1Lvra+M34ogqzfoG8R0Rpn4cS5YNXMp7vS5wxa4KULsRDc8NJJpuMgi
         kpEDw35QZm9Sz4w0RHNZIxfM0fGK1kma37cdaipAgkltYZIWdq2PnrUOyceEfHNKFK
         zp72UWpmf1RnypyEe1StVfCyoozLdgcejgIrzufQiUOH2goUYQm/GXgptjYhVZX6c1
         mFqvzREAgnLoC6RErwDSF2Szbca7ctNby1jUUCgushHxi9Qe183v5wow9cPVwgfdMK
         On0DnF29OynhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1C27F0383D;
        Tue, 31 May 2022 17:05:42 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpYMFlGhQQOt914S@8bytes.org>
References: <YpYMFlGhQQOt914S@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpYMFlGhQQOt914S@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.19
X-PR-Tracked-Commit-Id: b0dacee202efbf1a5d9f5cdfd82049e8b5b085d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1cbc3b96a9974746b2a80c3a6c8a0f7eff7b1b5
Message-Id: <165401674278.5782.17258985925276129478.pr-tracker-bot@kernel.org>
Date:   Tue, 31 May 2022 17:05:42 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 May 2022 14:37:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1cbc3b96a9974746b2a80c3a6c8a0f7eff7b1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
