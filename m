Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212D054FD75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiFQTWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbiFQTWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:22:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EEA5047A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCAA61FD0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29DD4C3411F;
        Fri, 17 Jun 2022 19:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655493744;
        bh=opHcOqY3lNA7uBWgvv4l6To4qA0BGsqWH8iI5De73cA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C5KEs/xeDPLrImeUN/7T5NWRliKrYcSoYFofHcCumBXzDyeata+yYjqXdYvZfiypX
         gcuIJ8HGZrutsKWGxwMnDEwnU+k/sKEOQJf75q/52u+4/AdwweVAmBhWqZ/N6oWypk
         3YDj3V3YiMRX4R1ixCzfn/mSDvwvkLjumwgcmX9TgEFynd55JP3Xjr/J+01lnl9uHF
         8oubV72tH58oCcSCl0/+QJqPo4xgPnBW4R3LjUuiv5zshdlFLleusAOPoGnk9LtcJO
         Dgp/eVtDlY1hIwhNwbEDYulBSMzg55qMpBhx3pWkh7SHYu1D36tabHFjZClgHpMcaB
         ZevjB339D4GEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10399FD99FF;
        Fri, 17 Jun 2022 19:22:24 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.19-rc3/rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YqzJa4UPCNQg2pAR@arm.com>
References: <YqzJa4UPCNQg2pAR@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YqzJa4UPCNQg2pAR@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: c50f11c6196f45c92ca48b16a5071615d4ae0572
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef06e68290b2b1b674950da276d6f7724e0b9874
Message-Id: <165549374406.16480.12162098435644479824.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 19:22:24 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 19:35:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef06e68290b2b1b674950da276d6f7724e0b9874

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
