Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D135A186A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiHYSKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243149AbiHYSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:10:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2C894EC1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA7E7B82A39
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7307AC433C1;
        Thu, 25 Aug 2022 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661451003;
        bh=2EKFWggFZs2Kpes1i9OYBLNxbqMukDzNk3Y3Zrsq6JU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SNRZxjGT1nXiIwU1x8IwWKkjhiH6pwZHUNy+nAbUnpxrl7y/6JT4lD3u8DRs2RopW
         HA+G5iG+PJNfedNoQuWBBLUd/Px6eY3znQlXP9YRGuHEdIz/Cv0kJDf63VghgLrhwd
         rlF4ILGpJmJfkkFCcGdENXkeQayOWQkOmBSnVRUz+liG1zpKKsDkXZQVOwKWV5vsA1
         D7aGmxweulWgGhyiq16yCEecdYhmQ2rFpZ7+H2hvoXbDEmX4sVkqSYnbcEdnEzN3XK
         elVnCqw8EQ4j1ULD9g7VSH3sGFZ8uLW++TP1uJeSEVcaq72Tsp6sRli2Cd6vZS/hSf
         uhK0Xh26jOL7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57CC5C004EF;
        Thu, 25 Aug 2022 18:10:03 +0000 (UTC)
Subject: Re: [GIT PULL] dmi update for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220822141930.5f43b5e7@endymion.delvare>
References: <20220822141930.5f43b5e7@endymion.delvare>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220822141930.5f43b5e7@endymion.delvare>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus
X-PR-Tracked-Commit-Id: d2139dfca361a1f5bfc4d4a23455b1a409a69cd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e78bf8cbf005c3cc7dc4da55ce75152b71a1da0f
Message-Id: <166145100334.12987.8514429416899860121.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Aug 2022 18:10:03 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Aug 2022 14:19:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e78bf8cbf005c3cc7dc4da55ce75152b71a1da0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
