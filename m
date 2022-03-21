Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7074E30B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352734AbiCUTUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352681AbiCUTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C7326F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BA0DCE1B60
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8700C340F0;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890313;
        bh=BH31Q5qi7rEG1D3pX74SsNmayWSrHXgFGJZpqcfVZn0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Se21V1n2EIaP0LpRJdxvu0lx7KC2J41ACuDhZvIkC5eVzOusp59fRao05oy0bGXP5
         rH6S9J+CCQddVNnTmqUT3m2mtkEdR8uKQr36G9Ipo9ulqHMBzIpFxdNUsoIyLrCw58
         IsXweoR7XpqYnstO8kO2MtQAlOL/aL5VgcQ1Njqj5QkZFQc7Hp+bVX5S5YvP4F52ga
         +WSuGttHCUvnFzv3MiubOTxbsJw/UDGqO44PXvYiwPUEVhoLFiILmTwPAy771UocAY
         uXNVFsYOQlSO3wlUhCFA8hiU7lyDPhD+kTdmO0SW1Yc0RpwYeoV1CEDBI64j2gTMmS
         YxgC9ziICwVPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D13FFE6D44B;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhQq9ZAfgSk3im3@zn.tnic>
References: <YjhQq9ZAfgSk3im3@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhQq9ZAfgSk3im3@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 08f253ec3767bcfafc5d32617a92cee57c63968e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d752e211146586dd654537a8b5282a6cf08a568f
Message-Id: <164789031385.24158.13819207998069296842.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:33 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:17:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d752e211146586dd654537a8b5282a6cf08a568f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
