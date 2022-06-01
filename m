Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6A353AE1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiFAUpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiFAUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5491E3E0FA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 596F9B81C4A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0760FC385B8;
        Wed,  1 Jun 2022 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654112086;
        bh=UdpTW9Gy69BdEVInp3sI8aauVuoLZKYRoAEZvBK+D0o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N8waOipncG7vdnHa+5gKgOGoCY1LXayvCngfS//eSYKHWoCYC0k8bhAL6j4s+gbEY
         um8KhHpOCCeWKqTqzjmNGfHZsnc1i+eK5yTxbQGkKRKY+bez9JVDcsu11vTT9PPV6x
         PhXCNmADkQN1Q4YtL8ITSx0DjvSFVrwDKl0S+UyUmqqOp0GSzv2Yu2+snh6BO0dGff
         +h4zlVQDR+qDadTPTH1GHSYOf4GF9yzi8DBTUg1PTF4BJxsqwcxxPXg+q4lTZZv4Fb
         iX27sbdFMM149ZbavWGlvNbQN1pgO75dzVKzACIx4xKgP6xSbWcOtANbxuTSywE1fp
         MSCrz2x+1fGKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6E14F03944;
        Wed,  1 Jun 2022 19:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpebV0BiGsrl8UDQ@debian>
References: <YpebV0BiGsrl8UDQ@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpebV0BiGsrl8UDQ@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1-fixes
X-PR-Tracked-Commit-Id: 4398d3c31b582db0d640b23434bf344a6c8df57c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8171acb8bc9b33f3ed827f0615b24f7a06495cd0
Message-Id: <165411208594.25874.3614907223802868163.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 19:34:45 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jun 2022 01:01:11 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8171acb8bc9b33f3ed827f0615b24f7a06495cd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
