Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD255B32B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiFZRg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiFZRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6694DE0B6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2663BB80DFB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEC49C341CF;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264973;
        bh=c8nuLbyJ32noHL1fCGnmIXKIF1eDIKhRoZCQAUDC63M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RZSX9NqXyQ0uVqxCfiYbg6Apj2LxTWsLn5RsFZc/RqX8E85iRgCv2S6i8erMAhUD/
         fDdyqVY9RQw3/I0RMmib+Bqq0MNWgBzNh9OcbwW5pz1Q6AdzPkMGd0NRjFWJpbC7Jz
         FZUBVyQOHS5N5KEu4d/Esl425ryABdJA3g9ZKN4PYb48qtWVtbqfsLI8hGEgXCJbw1
         YO8wD8ftLsKGimbtmCUV5ZozV141VdnoAijJrh8pSqoFtTyRCgWXCpAhhmwkB4eXiu
         e/isl3b4xZMgeSKCDXYzsHGS8j8fd6fTROIwbEU9/d5uDZEXW5caQZPg7SfmeiQeXp
         pGg2N1WFjg5xA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC835E8DBEE;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yrf0ItiAJ4cVfdPf@infradead.org>
References: <Yrf0ItiAJ4cVfdPf@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yrf0ItiAJ4cVfdPf@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-26
X-PR-Tracked-Commit-Id: 3be4562584bba603f33863a00c1c32eecf772ee6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c898c67db6d7de1b1e7970cd16c45eaa46bd231b
Message-Id: <165626497383.22456.6991533634522697276.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:13 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 07:52:34 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c898c67db6d7de1b1e7970cd16c45eaa46bd231b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
