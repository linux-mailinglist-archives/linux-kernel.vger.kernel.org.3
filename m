Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1653DD7C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351523AbiFESDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351450AbiFESDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3212625B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 11:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CEC96117E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C04F8C341C4;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654452195;
        bh=CsYU52VCrLXpkfxYqSStRRX52BCztFSNcRYjiDlzJP4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NT4IuTkKIzGUTPp79bMZLNsrINXWu/wAfLg3InAXSatT+t3X1CZZbQpqF99gUqea+
         XteNwkTdYJigMwBpai2UfL0A5HsxDX66+yXf83vLyJnZ0/Tp18mZ32LEzdL3GN55+9
         sWY3AexxJLfdmfinDMKpUJnvhyZZvAnKNzL34CJIHDbNJoZhY0Skq/Aib7JkhHFRR1
         SCC8H/fSfNbbOVXJCuyI4ytM2GnoXv/yHTL5C8dSAacO6jaLJm5GLiIDWBpP6mRZNa
         TrTHR141mAFW9Qf3QIYJsMiD2/8wkwafmKlJroCH81P/90gcVPEvQrUNALjgTJ0dH3
         d2PmLw1Tn4/uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0A97F03875;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442137401.152751.18098290131233756985.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13> <165442137401.152751.18098290131233756985.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442137401.152751.18098290131233756985.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-06-05
X-PR-Tracked-Commit-Id: 82f586f923e3ac6062bc7867717a7f8afc09e0ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc1e02c3e500e2eec5afd2fd3efc3b7f9637c35c
Message-Id: <165445219565.28605.15164854255863550169.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 18:03:15 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  5 Jun 2022 11:30:55 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc1e02c3e500e2eec5afd2fd3efc3b7f9637c35c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
