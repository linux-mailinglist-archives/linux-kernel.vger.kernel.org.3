Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF14C1CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbiBWUI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiBWUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:08:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103D4CD42;
        Wed, 23 Feb 2022 12:08:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFBC9B821A3;
        Wed, 23 Feb 2022 20:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 886A8C340EC;
        Wed, 23 Feb 2022 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645646896;
        bh=IPDTti9CW7/qinPXiqGFc7rs1vex161tmESDnf+9SUI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rk79jLzfRv9lvxSimmjSh0LKQxCWrCGBdo3Qb+iVSWpUUD5zrkH24KIBHbE36hQSj
         8GRWevS1FhzxlUE4T9BMG2fDjN22coYLY1X6+gtWBYhtKLOi8GmkelwdKCU9DCfQ9v
         3aHFlXJRjAos+OffeRlwWGBclaWLTpa3cp5nXZltkcQXLeQyhXLSBfDcymD6SJPsFT
         Y8Yz0wfT1Qd68REpoaZOFssjLqZu82gBfCCjFGJbT4s26qUJIJz8xCFpnnyLF1JTWP
         3bj3ImJBd9OG1QdatnTcFxh4RlFIuG1R+3UkEYLBrtH5XkEh9d4jlQXw671Fl9q4H6
         HFv+Hs3fp1g1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 762B4E5D09D;
        Wed, 23 Feb 2022 20:08:16 +0000 (UTC)
Subject: Re: [GIT PULL] parisc unaligned handler fixes for v5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhZuW0o9A4qhfdZ5@ls3530>
References: <YhZuW0o9A4qhfdZ5@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhZuW0o9A4qhfdZ5@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-4
X-PR-Tracked-Commit-Id: a97279836867b1cb50a3d4f0b1bf60e0abe6d46c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23d04328444a8fa0ca060c5e532220dac8e8bc26
Message-Id: <164564689647.4348.10892071496823188472.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Feb 2022 20:08:16 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Feb 2022 18:26:51 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23d04328444a8fa0ca060c5e532220dac8e8bc26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
