Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D723E4BD0D5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiBTTG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:06:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbiBTTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:06:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EE34C7B4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:06:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 912A660EB7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05EDBC340EB;
        Sun, 20 Feb 2022 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645383960;
        bh=3/Uc21tqi55zXgAlHVQQtwTDFCAIegTpywFcluvyjI0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EdrfsJ2SjoFxRk+1ABbfbncEwIwAoOLU19uoh1T6elQTfJZ2cDBcNG9nqykNe5rYC
         q1jhBNgN+HBo/4RsQDx9m3BkbV19cTx5mQ/5+8dewSSDoK0x/9Hrt0gP/4Vb6TJajF
         WbVod1yGssW/ZOZBoF44PFKJsWqbxUwZyVASQwj8ohtcdQAjGfXUJ696PTLFvHwbnM
         /zHyPmfrFPV0Aw11Cg4GxVQge24P7d/W2cTXzLq0u1Mx0m4j/ktHkVWzZiTZM9SeGG
         IX5pihVKeFcie69Kft72byK9JZrrLoazcDztcX9PPzE2YMBHFVafivC0t0ddgFL4zy
         rQ/Ib4aqq42Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8D7EE6D447;
        Sun, 20 Feb 2022 19:05:59 +0000 (UTC)
Subject: Re: [GIT PULL] pidfd for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220219115050.3635237-1-brauner@kernel.org>
References: <20220219115050.3635237-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220219115050.3635237-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd.v5.17-rc4
X-PR-Tracked-Commit-Id: ddc204b517e60ae64db34f9832dc41dafa77c751
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1034d249d1453b0f4c11582515a418a5d45b570
Message-Id: <164538395994.24844.13515311408228647352.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 19:05:59 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Feb 2022 12:50:50 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd.v5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1034d249d1453b0f4c11582515a418a5d45b570

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
