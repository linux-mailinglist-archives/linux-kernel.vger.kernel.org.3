Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33F84AA142
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiBDUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:35:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47924 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiBDUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:34:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29193B838ED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 20:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF00FC004E1;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644006879;
        bh=0Sen2f3umn7SRfZFRSW7rfzbXRg1rWParT+di94Polo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d53Car1S2A5Y9r7m+O6RJID3QsZ48/+1qeZW5Zgomtke/xTn4fszBIPH99yQVPcy8
         H7XveJILR14bruAy3j8Hz6u49Ik3O2mtCdyPeE3VXGNeP4TIyO+NE8TeKifGXrUnSF
         vMt+zptS7ZRQiq8iwu/Vdnln9a5yEJEWbOUcRagBpN/DCmUdLpWy3HF1VoVRq7UX6d
         pTv0nStE81QrjDV9Z3I9xGrgDjF8lTQCTnC9bX1jKR+1SKKJ1nQJVFURhQPtK7bB1L
         ldaTO18b52+SlvOcYiUaFHfohJ/jl8i2FuXSNvTW5ZDDLF/DF799XnxNfogy5OWCWg
         VLsY78LWhL0lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB848C6D4EA;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220204191213.GA18192@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20220204191213.GA18192@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220204191213.GA18192@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc3-fixes
X-PR-Tracked-Commit-Id: 24331050a3e6afcd4451409831dd9ae8085a42f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0bc0cb8157d5f09493a235e1ee73e84dd182ff9
Message-Id: <164400687969.31755.10506987054248222205.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 20:34:39 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Yue Hu <zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Feb 2022 03:12:14 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0bc0cb8157d5f09493a235e1ee73e84dd182ff9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
