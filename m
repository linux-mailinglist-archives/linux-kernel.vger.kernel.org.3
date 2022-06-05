Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DD53DD82
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351521AbiFESDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351514AbiFESDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:03:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588C1758F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 11:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3112B80DDF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 626F4C3411E;
        Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654452196;
        bh=jHPcIYIQae4fH//OspTLNHPJPfDP3372VC8ULT0tKmE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aTCqzsxi7fK5p4SlZEvZdyMr6GAfXMaw6zEbZ5gqnvq1pw5dVfuLikDMwSsJBd8xR
         CvGlxUbPf94rp7JjXAfnkdB5moeJjWbkxBZiQliASvuwOwkx6fugwqr2zhTsbfxPdy
         1QFfeNLm5UP/OHx8/5Rw+PZmp0Q5wgtOu2L1sDbqPvE3pc+Zw16ND4gJz2Y3YwUAPZ
         mwpe5qvKoiXUX2ScNp7p6dk7OuDZYi3K/L7KRDMKaFVeJbvmeUpcUQCKf4W5eOK35T
         igm0EdwkTS2CgDBT/gWSH0hiKb69bh/7HEKDm82Vlw6nbu47aWDACQ1g4Cjm067hir
         PXWH1RSu4kC3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E67FF03875;
        Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Subject: Re: [GIT pull] x86/microcode for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442137983.152751.6786767046026742462.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13> <165442137983.152751.6786767046026742462.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442137983.152751.6786767046026742462.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-2022-06-05
X-PR-Tracked-Commit-Id: 0c0fe08c76485fe0178ebb0fa1a2052c727abe94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9784edd73a08ea08d0ce5606e1f0f729df688c59
Message-Id: <165445219631.28605.11377987176080642837.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 18:03:16 +0000
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

The pull request you sent on Sun,  5 Jun 2022 11:31:01 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9784edd73a08ea08d0ce5606e1f0f729df688c59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
