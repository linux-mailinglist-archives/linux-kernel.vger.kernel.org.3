Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F50577720
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGQPm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGQPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EFABC9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E57666125C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52934C3411E;
        Sun, 17 Jul 2022 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658072544;
        bh=M1Jz1dR0pxQTWC3V2dV2oZ6gvLTaErQCowrpQOp9FUA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Py5TegDyTSfcVqtWVQQIawMsRtdAhGUcV+zc+xUn20QaW2QAm/zJiQ03N2N+1yV4j
         NYo+A4huIhovzGj6LJMcn34DNtX7fR78Nl9n+jZ8qTO1tGR8qDLPRWtoyOWhbcnCTx
         OIe+2T63+NcZN+CO6S7/GrKbZWDf6AJyRtNEd9t+oSfuP+9kvLyFF0Loe2K0JgGABV
         xOmwTQGPdrbwRvfADRB9ILzOkUFH481/h9+TCEO+//kZfdxy3w1XWbsGTDB/1XSqlM
         cjDCWQmJdR/NOobt0P6D7yTlabWlXPTySUAP13u1m7TPEqtx/bJoSDRCkXyHrNZugH
         K0+R8CvrrpY+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33116E4521F;
        Sun, 17 Jul 2022 15:42:24 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YtO62/Za76bfGqIm@zn.tnic>
References: <YtO62/Za76bfGqIm@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YtO62/Za76bfGqIm@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc7
X-PR-Tracked-Commit-Id: bcf163150cd37348a0cb59e95c916a83a9344b0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59c80f053d50467758c8284348b463fa820b1b1f
Message-Id: <165807254420.9863.6498605756952771877.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jul 2022 15:42:24 +0000
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

The pull request you sent on Sun, 17 Jul 2022 09:31:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59c80f053d50467758c8284348b463fa820b1b1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
